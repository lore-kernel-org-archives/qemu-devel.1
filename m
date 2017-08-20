Received: from eggs.gnu.org ([2001:4830:134:3::10]:35514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djQOR-0008I2-JH
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 09:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djQOO-0003wW-EW
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 09:35:55 -0400
Date: Sun, 20 Aug 2017 15:35:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <03c6e36f-c79d-3174-772d-5cd361703f7d@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.1708201455480.49986@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1708181526340.19483@zero.eik.bme.hu>
	<0e3383a1-33b5-8238-75e2-48e36b7daea4@adacore.com>
	<alpine.BSF.2.21.1708200101080.95468@zero.eik.bme.hu>
	<03c6e36f-c79d-3174-772d-5cd361703f7d@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc]   BookE MMU question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Sun, 20 Aug 2017, Mark Cave-Ayland wrote:
> I've only spent a small amount of time in PPC MMU land via OpenBIOS but
> the obvious thing that stands out here is this:
>
> helper_440_tlbwe word 0 entry 0 value ff7f7210
> tlb_flush_nocheck: (count: 36)
> helper_440_tlbwe word 1 entry 0 value 007f7000
> tlb_flush_nocheck: (count: 37)
> helper_440_tlbwe word 2 entry 0 value 0000081b
> ppcemb_tlb_check: TLB 0 address ff7fd648 PID 0 <=> ff7f7000 fffff000 0 3b
> mmubooke_check_tlb: TLB entry not found
>
> [KRN] map_region(007f7000, ff7f7000, 00009000, 081b):
> [KRN] TLB00: 007f7000 - 007f7fff : ff7f7000 - ff7f7fff:
>
> Here you can see that map_region() in
> https://github.com/ezrec/AROS-mirror/blob/ABI_V1/AROS/arch/ppc-sam440/kernel/mmu.c
> is requesting to map a region of size 0x9000 but the size of the
> resulting TLB entry is only 0x1000 (4KB) which I believe is default PPC
> page size.
>
> So I would suggest 2 things here:
>
> 1) Confirm AROS's map_region() iterates once for the 0xff7f7000 mapping

Unfortunately I can't test what it does on real hardware, that's why I was 
asking if there's anyone with this board who can do some testing. Without 
that I'm not sure how it should work, I can only test what it does on 
QEMU.

> On the plus side, it seems that you are fortunate to be able to builg
> the AROS sources yourself. Make sure that the while (length) {} loop in

This did not need a lot of fortune. It builds with a few simple fixes and 
a lot of disk space and patience. I've tried adding more debug log to show 
what the loop has selected.

> map_region() iterates only once for the 0xff7f7000 mapping, i.e. only
> one TLB entry is expected to be created for map_region(007f7000,
> ff7f7000, 00009000, 081b).
>
> My reading of the comments in the source hints that it should be (i.e.
> references to minimising the number of TLB entries) however it's always
> worth checking to be sure.

I've tried with the additional debug and the results are a bit unexpected 
because now I get:

[KRN] lowest = 007f74e8, base = 00800000, highest = 00c08260
[...]
[KRN] TLB00: -I---rwxrwx ff000000 - ffffffff : 00000000: 0:ff000270 1:00000000 2:0000043f
[...]
[KRN] Executing at ff841690, stack at ff7fd260, bss at ff7fd848, data at ff7fffb8

ppcemb_tlb_check: TLB 0 address ff841690 PID 0 <=> ff000000 ff000000 0 7f
mmubooke_check_tlb: good TLB!
mmubooke_get_physical_address: access granted ff841690 => 0000000000841690 7 0
tlb_set_page_with_attrs: vaddr=ff841400 paddr=0x0000000000841400 prot=7 idx=1
ppcemb_tlb_check: TLB 0 address ff840c9c PID 0 <=> ff000000 ff000000 0 7f
mmubooke_check_tlb: good TLB!
mmubooke_get_physical_address: access granted ff840c9c => 0000000000840c9c 7 0
tlb_set_page_with_attrs: vaddr=ff840c00 paddr=0x0000000000840c00 prot=7 idx=1

[KRN] map_region(00800000, ff800000, 00410000, 082f):

ppcemb_tlb_check: TLB 0 address ff871b7c PID 0 <=> ff000000 ff000000 0 7f
mmubooke_check_tlb: good TLB!
mmubooke_get_physical_address: access granted ff871b7c => 0000000000871b7c 7 0
tlb_set_page_with_attrs: vaddr=ff871800 paddr=0x0000000000871800 prot=7 idx=1

[KRN] i = 2, allowable_pages[i].mask = 000fffff:

ppcemb_tlb_check: TLB 0 address ff840e0c PID 0 <=> ff000000 ff000000 0 7f
mmubooke_check_tlb: good TLB!
mmubooke_get_physical_address: access granted ff840e0c => 0000000000840e0c 7 0
tlb_set_page_with_attrs: vaddr=ff840c00 paddr=0x0000000000840c00 prot=7 idx=1
ppcemb_tlb_check: TLB 0 address ff840a18 PID 0 <=> ff000000 ff000000 0 7f
mmubooke_check_tlb: good TLB!
mmubooke_get_physical_address: access granted ff840a18 => 0000000000840a18 7 0
tlb_set_page_with_attrs: vaddr=ff840800 paddr=0x0000000000840800 prot=7 idx=1

[KRN] TLB00: 00800000 - 008fffff : ff800000 - ff8fffff:

helper_440_tlbwe word 0 entry 0 value ff800250
tlb_flush_nocheck: (count: 37)
helper_440_tlbwe word 1 entry 0 value 00800000
tlb_flush_nocheck: (count: 38)
helper_440_tlbwe word 2 entry 0 value 0000082f
ppcemb_tlb_check: TLB 0 address ff7fd648 PID 0 <=> ff800000 fff00000 0 7d
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 1 address ff7fd648 PID 0 <=> d0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 2 address ff7fd648 PID 0 <=> 80000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 3 address ff7fd648 PID 0 <=> 90000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 4 address ff7fd648 PID 0 <=> a0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 5 address ff7fd648 PID 0 <=> b0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 6 address ff7fd648 PID 0 <=> c0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 7 address ff7fd648 PID 0 <=> e0000000 ff000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 8 address ff7fd648 PID 0 <=> e1000000 ff000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 9 address ff7fd648 PID 0 <=> e3000000 fffffc00 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 10 address ff7fd648 PID 0 <=> e3001000 fffffc00 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 11 address ff7fd648 PID 0 <=> e4000000 ffffc000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 12 address ff7fd648 PID 0 <=> e5000000 fff00000 0 7f
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 13 address ff7fd648 PID 0 <=> ef000000 ff000000 0 7f
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 14 address ff7fd648 PID 0 <=> e2000000 fff00000 0 7f
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 15 address ff7fd648 PID 0 <=> 00000000 f0000000 0 7f
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
[...]
mmubooke_get_physical_address: access refused ff7fd648 => ffffffffffffffff 0 -1

The unexpected part is that now the kernel base at 00800000 is tried to be 
mapped not the data area. Actually this matches the order in mmu.c:273, so 
I'm not sure why I got the error with the data area first. Maybe because 
previously I've tried to change the order of these map_region calls to see 
if that changes anything and this may have been left in the binary somehow 
after reverting this change (although I've rebuild multiple times after 
the revert).

Anyway, this makes more sense because if the TLB 0 entry is replaced like 
the above log shows then there will be no mapping for the ff7fd648 address 
until the next map_region call maps it. On real hardware this seems to 
work but on QEMU this causes an exception. Any idea why? My guesses are 
that on real hardware either the initial TLB entries are different so this 
call does not replace the entry used to look up addresses needed for 
running this code or the TLB changes are not effective until the last 
isync is executed to flush shadow TLB regs which still contain mappings 
that allow this code to run. To confirm this I'd need logs from real 
hardware though.

Any idea how to fix this problem?

> And of course read the BookE specification to understand exactly what
> types of TLB mapping are available, particularly with respect to page size.

That's what I wanted to avoid and hoped someone already with this 
knowledge can spot the problem easily. I don't have much time to spend on 
learning everything about PPC features and their QEMU implementation so I 
rather asked.

Thank you,
BALATON Zoltan
