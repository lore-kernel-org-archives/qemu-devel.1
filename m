Received: from eggs.gnu.org ([2001:4830:134:3::10]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1djKY3-0004VW-HW
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1djKY0-00056d-Bh
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:21:27 -0400
References: <alpine.BSF.2.21.1708181526340.19483@zero.eik.bme.hu>
	<0e3383a1-33b5-8238-75e2-48e36b7daea4@adacore.com>
	<alpine.BSF.2.21.1708200101080.95468@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <03c6e36f-c79d-3174-772d-5cd361703f7d@ilande.co.uk>
Date: Sun, 20 Aug 2017 08:20:45 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1708200101080.95468@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] BookE MMU question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 20/08/17 00:19, BALATON Zoltan wrote:

> This function is defined in AROS/arch/ppc-sam440/kernel/mmu.c:95 at the
> link below. I think it basically generates tlbwe instructions to set up
> a TLB entry to map the region to a virtual address.
> 
>> eg: what is in the MAS registers before the tlbwe
>> happen (checking field by field) and what is the tlb which is
>> created / expected.
> 
> I don't know what MAS registers are. Is that specific to BOOKE206? The
> PPC440 core in this board has POWERPC_MMU_BOOKE, not 206 but I don't
> know what's the difference between these. The TLB entries before and
> after the tlbwe instructions are logged below and I think TLB 0 should
> match the address that is tried to be accessed (ff7fd648) but it fails
> and returns refused. Does it ignore the new TLB entry just set for some
> reason?
> 
>> I got a pretty similar problem with a MAV V2 MMU and fixed size
>> tlb.. But I don't think it affects your device.. I'm not totally
>> sure though.
> 
> Do you have more info on this? Is it this patch: "booke206: fix tlbnps
> for fixed size TLB"? Unfortunately I don't understand that code well
> enough to tell if it's the same problem but your changes are specific to
> mmu_booke206 so they won't fix this problem with mmu_booke for sure.
> 
> Thanks for the suggestions but I think I need more help with this.

I've only spent a small amount of time in PPC MMU land via OpenBIOS but
the obvious thing that stands out here is this:

helper_440_tlbwe word 0 entry 0 value ff7f7210
tlb_flush_nocheck: (count: 36)
helper_440_tlbwe word 1 entry 0 value 007f7000
tlb_flush_nocheck: (count: 37)
helper_440_tlbwe word 2 entry 0 value 0000081b
ppcemb_tlb_check: TLB 0 address ff7fd648 PID 0 <=> ff7f7000 fffff000 0 3b
mmubooke_check_tlb: TLB entry not found

[KRN] map_region(007f7000, ff7f7000, 00009000, 081b):
[KRN] TLB00: 007f7000 - 007f7fff : ff7f7000 - ff7f7fff:

Here you can see that map_region() in
https://github.com/ezrec/AROS-mirror/blob/ABI_V1/AROS/arch/ppc-sam440/kernel/mmu.c
is requesting to map a region of size 0x9000 but the size of the
resulting TLB entry is only 0x1000 (4KB) which I believe is default PPC
page size.

So I would suggest 2 things here:

1) Confirm AROS's map_region() iterates once for the 0xff7f7000 mapping

On the plus side, it seems that you are fortunate to be able to builg
the AROS sources yourself. Make sure that the while (length) {} loop in
map_region() iterates only once for the 0xff7f7000 mapping, i.e. only
one TLB entry is expected to be created for map_region(007f7000,
ff7f7000, 00009000, 081b).

My reading of the comments in the source hints that it should be (i.e.
references to minimising the number of TLB entries) however it's always
worth checking to be sure.

2) Check the mask in QEMU's ppcemb_tlb_check()

If the above loop iterates only once then you'll need to figure out why
the region size in the TLB is set to 0x1000 rather than 0x9000. I see
that ppcemb_tlb_check() applies a mask to the address based upon
tlb->size, so I'd work backwards and see where that is being set.

And of course read the BookE specification to understand exactly what
types of TLB mapping are available, particularly with respect to page size.


ATB,

Mark.
