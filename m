Received: from eggs.gnu.org ([2001:4830:134:3::10]:47311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewPf7-0001mw-05
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewPf5-0001zc-Uu
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:59:05 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:39313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewPf5-0001y4-PS
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:59:03 -0400
Received: by mail-oi0-x233.google.com with SMTP id p9so1348072oic.6
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 02:59:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGaT8w45tJ32EVj20RFjmG9=WvZBfAuF_j3BgXsFy5ZmPef-Ow@mail.gmail.com>
References: <CAGaT8w45tJ32EVj20RFjmG9=WvZBfAuF_j3BgXsFy5ZmPef-Ow@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 09:58:42 +0000
Message-ID: <CAFEAcA_BQxw-nQj8nfuLgRwx=uKg_Hvz+ku=P-Qj4oLG_FOAfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] ARM64 Interrupt handling on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijen Raval <bjraval123@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2018 at 03:07, Brijen Raval <bjraval123@gmail.com> wrote:
> I am booting up a custom kernel on QEMU ARM64, upon completion of its
> initial boot up it looks like it enters the arch_idle() state
>
> I enabled the -d int logging to understand what is going on, I see the
> following repeated many times continuosly here after
>
> Taking exception 5 [IRQ]
> ...from EL1 to EL1
> ...with ESR 0x15/0x56000000
> ...with ELR 0xffffffff0000349c
> ...to EL1 PC 0xffffffff00008280 PSTATE 0x3c5
>
> Here's the dissassembly for the relevant piece of code:
>
>  ffffffff00003498 <arch_idle>:
>  arch_idle():
>  ../../kernel/arch/arm64/arch.cpp:182
>  ffffffff00003498:       d503207f        wfi
>  ffffffff0000349c:       d65f03c0        ret
>
> I am trying to understand what exceptions are occurring exactly when kernel
> is idle (timer?). According to above ELR is pointing to arch_idle(), but I
> believe "wfi" instruction would not be an IRQ but a sync abort which is
> handle differently right?

WFI is neither an IRQ nor an abort. It's just a hint to the CPU
that it doesn't need to execute any more instructions until the
next interrupt occurs. (It's a valid implementation for it to just
be a NOP.) QEMU does implement WFI to be "don't execute more insns
until the next interrupt", which is why you're seeing the ELR for
the interrupt generally being the ret insn: if the guest is mostly
idle and its idle loop includes a WFI then almost all the time an
incoming interrupt will find that the CPU was in the WFI insn.

Correctly written software will not ever issue a WFI unless it
has some mechanism for being woken up from it, which is typically
an outstanding interrupt, perhaps timer or an interrupt for
completed disk or network operation. For an SMP kernel it could also be
some other CPU sending this CPU an inter-processor-interrupt to
wake us up). "idle" for an OS just means "nothing to do right now".

> Also from ESR, it looks like a SVC instruction but if I am not wrong for
> IRQs ESRs are not updated (considered)

QEMU's logging prints the ESR value for all exceptions, even those
where architecturally the ESR is not updated. In those cases the
printed value can be ignored.

> One more thing, is there a way in QEMU I could find out what exception 5 is
> corresponding to?

The logging tells you:
> Taking exception 5 [IRQ]

Exception 5 is IRQ. (These numbers are all internal to QEMU, and
don't have any architectural or guest-visible relevance. They're
the EXCP_* constants defined at the top of target/arm/cpu.h.)

thanks
-- PMM
