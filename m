Received: from eggs.gnu.org ([2001:4830:134:3::10]:39803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1ciMOS-0004x9-Ja
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1ciMOO-0000YP-L1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:35:16 -0500
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::2]:31368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marc@brightwise.de>) id 1ciMOO-0000XW-AW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:35:12 -0500
Date: Mon, 27 Feb 2017 15:35:08 +0100 (CET)
From: Marc Bommert <marc@brightwise.de>
Message-ID: <1634823730.89363.1488206109043@communicator.strato.de>
In-Reply-To: <CAFEAcA-hHnOvoWZYZgBt2sWjv60fyTFv4mmGkaBbnVDwEqg31w@mail.gmail.com>
References: <492427237.68231.1488183356160@communicator.strato.de>
	<CAFEAcA-hHnOvoWZYZgBt2sWjv60fyTFv4mmGkaBbnVDwEqg31w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pl190: Fix off-by-one error in priority
 handling when reading VECTADDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> Peter Maydell <peter.maydell@linaro.org> hat am 27. Februar 2017 um 15:07 geschrieben:
> 
> The comment in pl190_read() about VECTADDR says
> "an enabled interrupt X at priority P causes prio_mask[Y]
>  to have bit X set for all Y > P", but your patch would
> make that not be true.

Sorry, of course, the comment has to be modified: "... for all Y>=P"

> I'm not very familiar with the PL190, but looking at pl190_update()
> I think your proposed change will make us set the outbound IRQ
> line incorrectly.
> 
> Suppose that only the interrupt programmed into VECTCNTL[0]
> and VECTADDR[0] is active. We will initially set the IRQ line
> (since s->priority is 17 and s->prio_mask[17] is 0xffffffff).
> However when the guest reads the VICVectAddr register we want
> to cause the IRQ line to no longer be asserted. (The PL190 TRM
> states this in the "Interrupt priority logic" section:
> "The highest priority request generates an IRQ interrupt if
> the interrupt is not currently being serviced.") In the current
> code this works because we will set s->priority to 0, and
> s->prio_mask[0] is 0 and so the "level & s->prio_mask[s->priority]"
> masking in pl190_update() clears the bit and we won't assert
> the IRQ line. With your change, s->prio_mask[0] would have the
> bit set for the interrupt number, and so the masking would
> leave that bit set and leave IRQ asserted.

Where did you get the information that "when the guest reads the VICVectAddr register we want
to cause the IRQ line to no longer be asserted." Imho, the _write_ to vectaddr clears the interrupt request.

> It also looks to me like this change breaks the logic for
> reading VECTADDR, because instead of the loop stopping
> with i as the priority of the highest set not-being-serviced
> interrupt it will stop with i being one less than that.
> (For instance if the interrupt for priority 2 is the highest
> set not-being-serviced interrupt then with your change
> we'll now set s->prio_mask[2] to have the relevant bit set,
> which means the loop will terminate with i == 1, and we return
> the vector address for interrupt priority 1, not 2 as we should.

You're right that it changes the logic here, this is the actual fix. I don't understand why you want to deliver the "highest set not-being serviced interrupt vector". In fact, you have to deliver the currently active IRQ vector address. The PL190 TRM states for the VECTADDR register:

"The read/write VICVECTADDR Register, with address offset of 0x030, contains the Interrupt Service Routine (ISR) address of the currently active interrupt"

> Perhaps I'm missing something -- what's the wrong behaviour
> that you're seeing that you're trying to fix ?

I have a RTOS running which up to now only ran on real hardware. It performs a sequence of accesses to the PL190 as stated in the bug ticket. When reading back VECTADDR of the currently handled interrupt (interrupt source 1 mapped to vector 2), the PL190 emulation delivers VECTADDR3 instead and my OS fails to dispatch the interrupt to the proper handler, but counts a spurious interrupt.

To be more precise, the "current priority" s->priority is not raised to the priority of the currently handled interrupt, but to the subsequent priority in the priority range.

Maybe I can explain it in more detail later, I'm not at the code atm. Well, I'm quite sure about that fix, since I investigated about a day for this single line patch.

Thanks for your support.
Marc
