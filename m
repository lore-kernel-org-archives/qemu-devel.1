Received: from eggs.gnu.org ([2001:4830:134:3::10]:48921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1djRyI-0007AH-AN
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 11:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1djRyE-0002sJ-Ai
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 11:17:01 -0400
References: <alpine.BSF.2.21.1708181526340.19483@zero.eik.bme.hu>
	<0e3383a1-33b5-8238-75e2-48e36b7daea4@adacore.com>
	<alpine.BSF.2.21.1708200101080.95468@zero.eik.bme.hu>
	<03c6e36f-c79d-3174-772d-5cd361703f7d@ilande.co.uk>
	<alpine.BSF.2.21.1708201455480.49986@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7f4e58b7-7e8e-4e94-8435-861af3103d1c@ilande.co.uk>
Date: Sun, 20 Aug 2017 16:16:42 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1708201455480.49986@zero.eik.bme.hu>
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

On 20/08/17 14:35, BALATON Zoltan wrote:

> Anyway, this makes more sense because if the TLB 0 entry is replaced
> like the above log shows then there will be no mapping for the ff7fd648
> address until the next map_region call maps it. On real hardware this
> seems to work but on QEMU this causes an exception. Any idea why? My
> guesses are that on real hardware either the initial TLB entries are
> different so this call does not replace the entry used to look up
> addresses needed for running this code or the TLB changes are not
> effective until the last isync is executed to flush shadow TLB regs
> which still contain mappings that allow this code to run. To confirm
> this I'd need logs from real hardware though.
> 
> Any idea how to fix this problem?

Just glancing at the code again it looks like the choice of slot is
determined by alloc_tlb(). It seems there are 64 TLB slots stored in
tlb_info as 2 x 32-bit bitmaps where a 1 bit indicates the slot is free
and a 0 bit indicates the slot is in use.

>From alloc_tlb() you can see that it uses clz (count leading zeros) in
order to locate the next free TLB slot in the bitmap, returning the slot
number as an integer (tlb) which is then passed into tlbwe.

So I'd suggest adding debugging to alloc_tlb() to find out why TLB slot
0 is being chosen again for the 0x80000000 mapping even though
free_tlb() hasn't been called for that entry.

>> And of course read the BookE specification to understand exactly what
>> types of TLB mapping are available, particularly with respect to page
>> size.
> 
> That's what I wanted to avoid and hoped someone already with this
> knowledge can spot the problem easily. I don't have much time to spend
> on learning everything about PPC features and their QEMU implementation
> so I rather asked.

Sometimes when debugging MMU issues there is no other choice :)


ATB,

Mark.
