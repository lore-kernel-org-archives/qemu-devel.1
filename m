Received: from eggs.gnu.org ([2001:4830:134:3::10]:58628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkH9c-0006Qo-W9
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkH9b-0001TG-St
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:00:41 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkH9b-0001T5-NQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:00:39 -0400
Received: by mail-oi0-x244.google.com with SMTP id q11-v6so24406645oic.12
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 16:00:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
	<alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jul 2018 00:00:18 +0100
Message-ID: <CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 30 July 2018 at 23:37, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> I think the number of irq lines could be set, the functions have an nirq or
> num_irq parameters so the 4 lines is only assumed because PCI defines that
> and this is what's modelled but we could use different value here. Sam460ex
> seems to connect all four PCI irq lines to a single irq but I'm not sure
> what's the best way to model this (implementing 1 line in ppc440_pcix model
> or trying to merge these at some higher level). Using wrong irq lines is
> definitely wrong and was only left there because I had no clue about this
> when I've written that so your patch is definitely closer to what the board
> does.
>
>> As I have written in the commit log, I tested this change. I used two
>> cards, the (default) SATA and the OHCI controller and everything was working
>> nicely (contrary to the previous state where only the SATA card worked
>> because this was put into slot 1). Did you have a chance to test it
>> yourself?
>
>
> I could not test it yet, I was trying to understand the code instead to make
> sure it works than just verifying it fixes one particular problem which I
> believe you've done.

QEMU's implementation of qemu_irq signal lines is that the destination
end provides the qemu_irq, which under the hood is a pointer to a
struct containing a pointer to the function in the destination device
which gets called when the source end says "the line level has changed".
This means that there won't be a compile time or runtime error if you
pass that qemu_irq to multiple sources (ie device outputs) simultaneously.
But the behaviour will be wrong, because the destination will see all
the "level is 0", "level is 1" calls from all the sources intermingled, eg

device A output:   ____|^^^^^^^^^^^^^|______

device B output:   _______|^^^^^|___________

destination sees:  ____|^^^^^^^^|___________

(because the destination gets the "level now 0" call when B's output
goes to zero). To get the desired behaviour:

logical OR:        ____|^^^^^^^^^^^^^|_____

you need an OR gate. (I'm assuming wired-OR because that's the
usual thing when several devices share an interrupt.)

If your testing involves a setup which doesn't happen to assert
several of the interrupt lines simultaneously you won't notice this
problem.

> Probably we can just change the map function in ppc440_pcix.c to always
> return the first line then what's specified for other lines should not
> matter and the above problem is avoided. We could even get rid of those
> additional irqs by changing ppc440_pcix.c to only model a single line but
> I'd need someone with better understanding of this to confirm that I got
> this right.

I think that would also fix the bug. The logically preferable
approach would depend rather on what the actual hardware does:
is there a PCI controller chip with 4 interrupt outputs which
the board wires together to a single interrupt controller line,
or does the PCI controller chip itself have just one output
and do the merging of the different PCI interrupts itself?

thanks
-- PMM
