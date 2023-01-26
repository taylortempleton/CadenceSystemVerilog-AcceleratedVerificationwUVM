module top;
  
import uvm_pkg::*;

`include "uvm_macros.svh"

import yapp_pkg::*;

yapp_packet packet;
yapp_packet copy_packet;
yapp_packet clone_packet;

int ok;

initial begin
  copy_packet = new("copy_packet");
  
  for (int i=0; i<5; i++) begin
    packet = new($sformatf("packet_%0d",i));
    ok = packet.randomize();
    packet.print();
  end
  
  $display("\n ************* Printers");
  $display("\n ************* Tree Printer");
  packet.print(uvm_default_tree_printer);
  $display("\n ************* Line Printer");
  packet.print(uvm_default_line_printer);
                          
  $display("\n ************* COPY packet to copy_packect - note instance name");
  copy_packet.copy(packet);
  copy_packet.print();
  
  $display("\n ************* CLONE packet to clone_packect - note instance name");
  $cast(clone_packet, packet.clone());
  clone_packet.print();
  
  $display("\n ************* Compare 2 matching packets");
  ok = copy_packet.compare(packet);
  $display("\n ************* Compare 2 packets with multiple mismatches - note default report"); 
  ok = packet.randomize();
  ok = copy_packet.compare(packet);
end

endmodule : top