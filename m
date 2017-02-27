Received: from eggs.gnu.org ([2001:4830:134:3::10]:54410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciNDO-0000sr-Qu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciNDN-0002HS-Es
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:27:54 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciNDN-0002HK-5M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:27:53 -0500
Received: by mail-wm0-x22d.google.com with SMTP id u199so21575761wmd.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:27:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1634823730.89363.1488206109043@communicator.strato.de>
References: <492427237.68231.1488183356160@communicator.strato.de>
	<CAFEAcA-hHnOvoWZYZgBt2sWjv60fyTFv4mmGkaBbnVDwEqg31w@mail.gmail.com>
	<1634823730.89363.1488206109043@communicator.strato.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 15:27:31 +0000
Message-ID: <CAFEAcA_O2ue4wkGgcJCAXwPSZy=OajBz0nREet5Kr+h0t4o8Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Marc Bommert <marc@brightwise.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 14:35, Marc Bommert <marc@brightwise.de> wrote:
>> Peter Maydell <peter.maydell@linaro.org> hat am 27. Februar 2017 um 15:07 geschrieben:
>> Suppose that only the interrupt programmed into VECTCNTL[0]
>> and VECTADDR[0] is active. We will initially set the IRQ line
>> (since s->priority is 17 and s->prio_mask[17] is 0xffffffff).
>> However when the guest reads the VICVectAddr register we want
>> to cause the IRQ line to no longer be asserted. (The PL190 TRM
>> states this in the "Interrupt priority logic" section:
>> "The highest priority request generates an IRQ interrupt if
>> the interrupt is not currently being serviced.") In the current
>> code this works because we will set s->priority to 0, and
>> s->prio_mask[0] is 0 and so the "level & s->prio_mask[s->priority]"
>> masking in pl190_update() clears the bit and we won't assert
>> the IRQ line. With your change, s->prio_mask[0] would have the
>> bit set for the interrupt number, and so the masking would
>> leave that bit set and leave IRQ asserted.
>
> Where did you get the information that "when the guest reads
> the VICVectAddr register we want  to cause the IRQ line to
> no longer be asserted." Imho, the _write_ to vectaddr clears
> the interrupt request.

See my quote from the PL190 TRM above. Also I think it's
clear from the TRM's suggested vectored interrupt flow sequence
which is:
 1  interrupt occurs
 2  CPU takes IRQ
 3  interrupt handler reads VICVectAddr
 4  interrupt handler stacks CPU registers
 5  interrupt handler reenables IRQ interrupts
 6  do the ISR work
 7  clear peripheral interrupt signal
 8  disable ISR, restore regs
 9  write VICVectAddr to clear interrupt in the PL190
 10 return from interrupt (reenabling IRQ)

If the PL190 continues to signal IRQ for an interrupt
that has had VICVectAddr read, then this sequence will
recurse infinitely because as the CPU reenables IRQ in
step 5 we'll take the IRQ interrupt again. The logic relies
on the PL190 not signalling IRQ once it's been acknowledged
via the VICVectAddr read (unless a higher priority interrupt
arrives, which should cause IRQ to be asserted so the guest
can recursively handle it).

There's also this text in the "About the VIC" section 2.1:
"Reading from the Vector Interrupt Address Register, VICVECTADDR,
provides the address of the ISR, and updates the interrupt
priority hardware that masks out the current, and any lower
priority interrupt requests."
 -- which definitely says that the read causes the current
interrupt to be masked out.

>> It also looks to me like this change breaks the logic for
>> reading VECTADDR, because instead of the loop stopping
>> with i as the priority of the highest set not-being-serviced
>> interrupt it will stop with i being one less than that.
>> (For instance if the interrupt for priority 2 is the highest
>> set not-being-serviced interrupt then with your change
>> we'll now set s->prio_mask[2] to have the relevant bit set,
>> which means the loop will terminate with i == 1, and we return
>> the vector address for interrupt priority 1, not 2 as we should.
>
> You're right that it changes the logic here, this is the actual
> fix. I don't understand why you want to deliver the "highest set
> not-being serviced interrupt vector". In fact, you have to
> deliver the currently active IRQ vector address. The PL190 TRM
> states for the VECTADDR register:
>
> "The read/write VICVECTADDR Register, with address offset of
> 0x030, contains the Interrupt Service Routine (ISR) address
> of the currently active interrupt"

At the point where the ISR reads VECTADDR, the currently active
interrupt *is* the highest set not being serviced interrupt vector.
(If your ISR reads it twice then that's a bad idea because
the Note in the TRM says "reading [...] at other times can
cause incorrect operation", but QEMU's implementation will
return the same value again until a higher priority interrupt
comes in or the interrupt is dismissed by writing to VECTADDR,
since the 2nd read won't change s->priority and we'll just
return s->vect_addr[s->priority] again.)

>> Perhaps I'm missing something -- what's the wrong behaviour
>> that you're seeing that you're trying to fix ?
>
> I have a RTOS running which up to now only ran on real hardware.
> It performs a sequence of accesses to the PL190 as stated in
> the bug ticket. When reading back VECTADDR of the currently
> handled interrupt (interrupt source 1 mapped to vector 2),
> the PL190 emulation delivers VECTADDR3 instead and my OS fails
> to dispatch the interrupt to the proper handler, but counts
> a spurious interrupt.

Ah, I missed that the bug ticket had a sequence of actions:

 1) Write INTENCLEAR to clear all interrupt enable bits
 2) Set all 16 vector control registers to zero
 3) Set vector address #2 to value 2
 4) Set vector control #2 to 0x21 (vector_interrupt_enable(0x20) |
vector_interrupt_source(0x1) )
 5) Enable interrupt 1 by writing 0x2 to INTENABLE
 6) In interrupt handler: read VECTADDR [should read 0x2
   (active IRQs vector address as set in step 3), reads 0x0
   (active vector address index 3 instead of index 2)]

I don't see why step 6 gives you index 3, though. At that
point s->priority should be 17, s->prio_mask[0] = 0,
s->prio_mask[1] = 0, s->prio_mask[2] = 0, s->prio_mask[3] = 1 << 1,
etc. s->level is 1 << 1.
The loop
        for (i = 0; i < s->priority; i++) {
            if ((s->level | s->soft_level) & s->prio_mask[i + 1]) {
                break;
            }
        }
will terminate with i == 2 (since s->prio_mask[3] is
the first one with a set bit matching level). We then
set s->priority to 2 and return the vect_addr[2] entry.

> To be more precise, the "current priority" s->priority is not
> raised to the priority of the currently handled interrupt, but
> to the subsequent priority in the priority range.

I don't see how this happens in the code: we stop the
loop with i one less than the s->prio_mask[] array
entry we check, because of the i+1 in the array index.

If you have some guest code I could reproduce this with
that would be helpful.

thanks
-- PMM
