Received: from eggs.gnu.org ([2001:4830:134:3::10]:51379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1djZ1w-0003mi-Op
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1djZ1t-0004sI-Mg
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:49:16 -0400
References: <alpine.BSF.2.21.1708181526340.19483@zero.eik.bme.hu>
	<0e3383a1-33b5-8238-75e2-48e36b7daea4@adacore.com>
	<alpine.BSF.2.21.1708200101080.95468@zero.eik.bme.hu>
	<03c6e36f-c79d-3174-772d-5cd361703f7d@ilande.co.uk>
	<alpine.BSF.2.21.1708201455480.49986@zero.eik.bme.hu>
	<7f4e58b7-7e8e-4e94-8435-861af3103d1c@ilande.co.uk>
	<alpine.LMD.2.02.1708202333240.3635@jedlik.phy.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <24fb125a-de7e-ca18-8ca8-9ab7f2d113d1@ilande.co.uk>
Date: Sun, 20 Aug 2017 23:48:39 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.LMD.2.02.1708202333240.3635@jedlik.phy.bme.hu>
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 20/08/17 22:59, BALATON Zoltan wrote:

>> So I'd suggest adding debugging to alloc_tlb() to find out why TLB slot
>> 0 is being chosen again for the 0x80000000 mapping even though
>> free_tlb() hasn't been called for that entry.
> 
> I've tried that but it only confirmed what I thought. This is the first
> map_region call so nothing is allocated yet and it just picks the first
> slot:
> 
> [KRN] i = 2, allowable_pages[i].mask = 000fffff; tlb_info
> ffffffff:ffffffff => 7fffffff:ffffffff
> 
> (The numbers after tlb_info are bitmap[0]:bitmap[1] before and after the
> alloc_tlb() call.) So this looks OK just does not work on QEMU and I
> don't know why it works on real hardware (or if it works there at all
> but I assume it does).

I'm slightly confused here as I thought you'd said you changed the order
of the mappings? But if its the first entry then I presume you mean
we're back to this one, which is definitely the first mapping according
to the source.

ppcemb_tlb_check: TLB 0 address ff7fd648 PID 0 <=> ff7f7000 fffff000 03b
mmubooke_check_tlb: TLB entry not found

[KRN] map_region(007f7000, ff7f7000, 00009000, 081b):
[KRN] TLB00: 007f7000 - 007f7fff : ff7f7000 - ff7f7fff:

In that case the working is as follows:

- You request a region of size 0x9000
- map_region() rounds this up to the next biggest size from
  allowable_pages() which is 64KB (0xffff) with
  allowable_pages.code == 0x30
- The 0x30 code (which indicates the page size) is encoded into the
  first tlbwe instruction

The first thing I'd check is to follow through QEMU's tlbwe and make
sure that the 0x30 gets decoded correctly back to a TLB size of 0x10000
as indicated by allowable_pages - at the moment it looks as if QEMU is
interpreting the 0x30 as a page size of 0x1000 instead.


ATB,

Mark.
