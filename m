Received: from eggs.gnu.org ([209.51.188.92]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1D4J-0004ro-TQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1D4J-0003lS-28
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:37:27 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1D4I-0003kM-D3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:37:26 -0500
Received: by mail-ot1-x342.google.com with SMTP id v62so7970794otb.3
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:37:26 -0800 (PST)
MIME-Version: 1.0
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
	<CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
In-Reply-To: <CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 16:37:13 +0000
Message-ID: <CAFEAcA_N83yo8xV3hCpVPFOhQj+R95+8fVePjEXgxKZtQPUP3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Added periodic IRQ support for
 bcm2836_control local timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Mar 2019 at 19:27, bzt <bztemail@gmail.com> wrote:
>
> On 3/4/19, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> + * The IRQ_TIMER support is still very basic, does not handle timer
> >> access,
> >> + * and such there's no point in enabling it without the interrupt flag
> >> set.
> >
> > Can you be more precise about what's missing here? I didn't
>
> The local timer (as per the referenced QA7 doc calls it, section
> 4.11), means 3 registers in the ARM Control MMIO, at addresses 0x24,
> 0x34, 0x38. Please note that I haven't named IRQ_TIMER bit in the
> irqsrc and fiqsrc fields, that was already defined. This patch
> implements that one.
>
> > see anything in the spec that looked like a register for
> > reading the current timer value (though it would certainly
> > be usual to provide one).
>
> Those are registers 0x1C and 0x20, called "Core timer access LS/MS",
> section 4.3. I'll make the comment more clear. Those are not local
> timer IRQ related, because they could use a different frequency than
> the IRQ, just happen to be enabled with a bit in the local timer's
> control register (and not in the core timer control register at 0x0),
> and on real hardware triggering an IRQ requires both the timer enable
> and interrupt enable bits to be set. The timer counter is a 64 bits
> one, while the IRQ's counter is only 28 bit wide, which cannot be
> directly read, does not use the prescaler, and it's reload value
> stored in the local timer control register itself (unusal, but that's
> how it is).

OK, so that's just an entirely separate timer whose control bit
happens to be in the same register? I'd assumed that the enable
bit here was so you could have the local timer be running but
not generate interrupts -- in which case when it expired it would
set the "interrupt flag" (and reload), but it wouldn't assert
the external interrupt line.

In fact thinking about it that does seem like the more plausible
reading of that specification:
 * bit 28 (Timer enable) enables the timer
 * when it gets to zero we set bit 31 "Interrupt flag"
 * the outbound interrupt line is the logical OR of
   bits 31 ('interrupt flag') and 29 ('interrupt enable')

Are you sure it doesn't work that way ?

I'd have thought that any enable bit for the "core timer" would
be in the core timer control register at 0x4000_0000. Since the
"core timer" is (apparently) the source of the clock for all the
per-CPU architected generic timers, it seems more likely that
it just runs constantly without an enable bit.

thanks
-- PMM
