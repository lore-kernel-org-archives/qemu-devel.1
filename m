Received: from eggs.gnu.org ([2001:4830:134:3::10]:47479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@jedlik.phy.bme.hu>) id 1djYOC-0002mr-TM
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@jedlik.phy.bme.hu>) id 1djYO9-0007yO-L7
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:08:12 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@jedlik.phy.bme.hu>)
	id 1djYO9-0007yE-EE
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:08:09 -0400
Date: Sun, 20 Aug 2017 23:59:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <7f4e58b7-7e8e-4e94-8435-861af3103d1c@ilande.co.uk>
Message-ID: <alpine.LMD.2.02.1708202333240.3635@jedlik.phy.bme.hu>
References: <alpine.BSF.2.21.1708181526340.19483@zero.eik.bme.hu>
	<0e3383a1-33b5-8238-75e2-48e36b7daea4@adacore.com>
	<alpine.BSF.2.21.1708200101080.95468@zero.eik.bme.hu>
	<03c6e36f-c79d-3174-772d-5cd361703f7d@ilande.co.uk>
	<alpine.BSF.2.21.1708201455480.49986@zero.eik.bme.hu>
	<7f4e58b7-7e8e-4e94-8435-861af3103d1c@ilande.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] BookE MMU question
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
> Just glancing at the code again it looks like the choice of slot is
> determined by alloc_tlb(). It seems there are 64 TLB slots stored in
> tlb_info as 2 x 32-bit bitmaps where a 1 bit indicates the slot is free
> and a 0 bit indicates the slot is in use.
>
> From alloc_tlb() you can see that it uses clz (count leading zeros) in
> order to locate the next free TLB slot in the bitmap, returning the slot
> number as an integer (tlb) which is then passed into tlbwe.
>
> So I'd suggest adding debugging to alloc_tlb() to find out why TLB slot
> 0 is being chosen again for the 0x80000000 mapping even though
> free_tlb() hasn't been called for that entry.

I've tried that but it only confirmed what I thought. This is the first 
map_region call so nothing is allocated yet and it just picks the first 
slot:

[KRN] i = 2, allowable_pages[i].mask = 000fffff; tlb_info ffffffff:ffffffff => 7fffffff:ffffffff

(The numbers after tlb_info are bitmap[0]:bitmap[1] before and after the 
alloc_tlb() call.) So this looks OK just does not work on QEMU and I don't 
know why it works on real hardware (or if it works there at all but I 
assume it does).

I've also tried to change mmubooke_create_initial_mapping_uboot() in 
sam460ex.c to use another TLB slot than 0 for the initial mapping hoping 
it may avoid the problem but that does not work because U-Boot clears TLB 
slots 1-63 so it has to be slot 0. Because of this I think it cannot be 
another slot on real hardware either and it probably works due to caching 
TLB entries in shadow TLB until the isync call at the end of mmu_init(). 
How could that be matched in QEMU?
