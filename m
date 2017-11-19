Received: from eggs.gnu.org ([2001:4830:134:3::10]:32838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eGQL6-00044E-Q9
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 09:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eGQL5-0000p4-Km
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 09:12:52 -0500
Received: from relay2-d.mail.gandi.net ([2001:4b98:c:538::194]:34707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eGQL5-0000nt-DX
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 09:12:51 -0500
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <e0721b53-fa00-55a2-b8b8-209be025611f@tribudubois.net>
Date: Sun, 19 Nov 2017 15:12:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] [SPARC] Qemu failed to display MMU mapping for non
 memory area.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

Hello,

I am using Qemu to emulate a Leon3 based board.

In the software I am running on Qemu, I configured the virtual memory 
through MMU programming.

In particular, I mapped the built-in UART to a 4K page.

To check that my MMU table was OK I switched on (at compile time) the 
DEBUG_MMU facility in the target/sparc/ldst_helper.c file.

Then anytime I changed the MMU setting (through software) I got a 
display of it. A typical debug from Qemu console is as follow:

MMU: mmu change reg[2]: 0x00000001 -> 0x00000002
Root ptr: 0000000040003000, ctx: 2
VA: 40000000, PA: 0000000040000000 PDE: 04000401
  VA: 40000000, PA: 0000000040000000 PDE: 04000421
   VA: 40000000, PA: 0000000040000000 PTE: 040000ba
   VA: 40001000, PA: 0000000040001000 PTE: 0400019a
   VA: 40002000, PA: 0000000040002000 PTE: 0400029a
   VA: 40006000, PA: 0000000040006000 PTE: 0400069e
   VA: 40007000, PA: 0000000040007000 PTE: 0400079a
   VA: 40008000, PA: 0000000040008000 PTE: 0400089e
  VA: 40800000, PA: 000000004000d000 PDE: 04000411
   VA: 40800000, PA: 000000004000d000 PTE: 04000db2
   VA: 40802000, PA: 000000004000e000 PTE: 04000e82
   VA: 40804000, PA: 0000000040013000 PTE: 04001386
   VA: 40806000, PA: 0000000040017000 PTE: 04001786
   VA: 40808000, PA: ffffffffffffffff PTE: 08000006
   VA: 4080a000, PA: 000000004001a000 PTE: 04001a82
   VA: 4080c000, PA: 0000000040019000 PTE: 04001982
   VA: 4080e000, PA: 000000004001c000 PTE: 04001c82
   VA: 40810000, PA: 000000004001b000 PTE: 04001b82

As you can see Qemu (debug) is unable to find the physical address 
associated to 0x40808000 (which should be 0x80000000 where the UART lives).

Note: This also has on impact on the ability to explore the memory 
through GDB. Trying to access 0x40808100 (mapped to 0x80000100) through 
gdb (connected to Qemu) is impossible.

(gdb) x 0x40808100
0x40808100:    Cannot access memory at address 0x40808100
(gdb)

I traced the problem down to the sparc_cpu_get_phys_page_debug() 
function in the target/sparc/mmu_helper.c file.

By commenting out the last part of the function, the MMU mapping debug 
in Qemu is functional again.

hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
{
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
     hwaddr phys_addr;
     int mmu_idx = cpu_mmu_index(env, false);
     //MemoryRegionSection section;

     if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 2, mmu_idx) != 0) {
         if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 0, mmu_idx) 
!= 0) {
             return -1;
         }
     }
     /*
     section = memory_region_find(get_system_memory(), phys_addr, 1);
     memory_region_unref(section.mr);
     if (!int128_nz(section.size)) {
         printf("%s: failed to int128_nz()\n", __func__);
         return -1;
     }
     */
     return phys_addr;
}

Root ptr: 0000000040003000, ctx: 2
VA: 40000000, PA: 0000000040000000 PDE: 04000401
  VA: 40000000, PA: 0000000040000000 PDE: 04000421
   VA: 40000000, PA: 0000000040000000 PTE: 040000ba
   VA: 40001000, PA: 0000000040001000 PTE: 0400019a
   VA: 40002000, PA: 0000000040002000 PTE: 0400029a
   VA: 40006000, PA: 0000000040006000 PTE: 0400069e
   VA: 40007000, PA: 0000000040007000 PTE: 0400079a
   VA: 40008000, PA: 0000000040008000 PTE: 0400089e
  VA: 40800000, PA: 000000004000d000 PDE: 04000411
   VA: 40800000, PA: 000000004000d000 PTE: 04000db2
   VA: 40802000, PA: 000000004000e000 PTE: 04000e82
   VA: 40804000, PA: 0000000040013000 PTE: 04001386
   VA: 40806000, PA: 0000000040017000 PTE: 04001786
   VA: 40808000, PA: 0000000080000000 PTE: 08000006
   VA: 4080a000, PA: 000000004001a000 PTE: 04001a82
   VA: 4080c000, PA: 0000000040019000 PTE: 04001982
   VA: 4080e000, PA: 000000004001c000 PTE: 04001c82
   VA: 40810000, PA: 000000004001b000 PTE: 04001b82

Moreover, the GDB memory display is also working again with this change.

(gdb) x 0x40808100
0x40808100:    0x00000000
(gdb)
0x40808104:    0x00000006
(gdb)
0x40808108:    0x00000002

I am not sure the proposed change is correct because GDB would then 
display memory result for memory area where there is no device mapped. 
For example accessing 0x40808000 would return 0 when there is no device 
mapped from 0x80000000 to 0x800000FF.

(gdb) x 0x40808000
0x40808000:    0x00000000
(gdb)
0x40808004:    0x00000000
(gdb)
0x40808008:    0x00000000

You feed back would be appreciated.

Regards.

JC
