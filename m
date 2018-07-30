Received: from eggs.gnu.org ([2001:4830:134:3::10]:35362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkHdq-0007Vy-Qw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkHdl-0005In-Sv
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:31:54 -0400
Date: Tue, 31 Jul 2018 01:31:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1807310111280.24147@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
	<alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
	<CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 31 Jul 2018, Peter Maydell wrote:
> On 30 July 2018 at 23:37, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> QEMU's implementation of qemu_irq signal lines is that the destination
> end provides the qemu_irq, which under the hood is a pointer to a
> struct containing a pointer to the function in the destination device
> which gets called when the source end says "the line level has changed".
> This means that there won't be a compile time or runtime error if you
> pass that qemu_irq to multiple sources (ie device outputs) simultaneously.
> But the behaviour will be wrong, because the destination will see all
> the "level is 0", "level is 1" calls from all the sources intermingled, eg
>
> device A output:   ____|^^^^^^^^^^^^^|______
>
> device B output:   _______|^^^^^|___________
>
> destination sees:  ____|^^^^^^^^|___________
>
> (because the destination gets the "level now 0" call when B's output
> goes to zero). To get the desired behaviour:
>
> logical OR:        ____|^^^^^^^^^^^^^|_____
>
> you need an OR gate. (I'm assuming wired-OR because that's the
> usual thing when several devices share an interrupt.)
>
> If your testing involves a setup which doesn't happen to assert
> several of the interrupt lines simultaneously you won't notice this
> problem.

I think the testing with SATA and USB mouse on a PCI card is likely to 
assert several interrupts simultanelously (eg. when moving the mouse while 
loading stuff from disk) but the OS might have some ways to still recover 
from this so maybe we won't notice it anyway. As this is now confirmed 
that using the same irq multiple times is wrong I think we need a better 
fix.

David, can you please drop this patch, we'll come up with a different fix.

>> Probably we can just change the map function in ppc440_pcix.c to always
>> return the first line then what's specified for other lines should not
>> matter and the above problem is avoided. We could even get rid of those
>> additional irqs by changing ppc440_pcix.c to only model a single line but
>> I'd need someone with better understanding of this to confirm that I got
>> this right.
>
> I think that would also fix the bug. The logically preferable
> approach would depend rather on what the actual hardware does:
> is there a PCI controller chip with 4 interrupt outputs which
> the board wires together to a single interrupt controller line,
> or does the PCI controller chip itself have just one output
> and do the merging of the different PCI interrupts itself?

Hmm, don't really know. The PCI controller is part of the SoC but we don't 
have the manual of this SoC. The physical board itself also has a single 
PCI slot so however it's wired internally it's only using one irq for 
that. Not sure what other internal PCI devices are there. A comment in 
U-Boot sources says this (it lists PCIB twice but maybe that's meant to be 
PCID?):

// IRQ2  = PCI_INT (PCIA, PCIB, PCIC, PCIB)

So that suggests probably there are 4 PCI irqs that are wired together but 
probably this is inside the SoC. It could also be read as there's only a 
single PCI_INT that delivers all four PCI interrupts. So if we go from 
that either adding an OR gate to sam460ex.c that ORs together the PCI 
lines and connects it to uic[1][0] would work, or changing ppc440_pcix.c 
to provide a single PCI interrupt? We don't really have definitive info 
other than this comment so whatever Sebastian prefers and you approve is 
fine with me.

Thank you,
BALATON Zoltan
