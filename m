Received: from eggs.gnu.org ([209.51.188.92]:38613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1vBR-00027c-CM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1vBQ-0003vP-M2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:43:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1vBQ-0003uU-Be
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:43:44 -0500
Received: by mail-ot1-x342.google.com with SMTP id b3so14486496otp.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:43:44 -0800 (PST)
MIME-Version: 1.0
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
	<CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
	<CAFEAcA_N83yo8xV3hCpVPFOhQj+R95+8fVePjEXgxKZtQPUP3w@mail.gmail.com>
	<CADYoBw00Li2G4srfLvtG4pvBMfyEuDh0AU47wj5BcKOUkfWhKw@mail.gmail.com>
In-Reply-To: <CADYoBw00Li2G4srfLvtG4pvBMfyEuDh0AU47wj5BcKOUkfWhKw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 15:43:31 +0000
Message-ID: <CAFEAcA9Ycm43h8ekoc1uP_K7eLT98Qg+EFqE3Lvu66cjU5c5_A@mail.gmail.com>
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

On Thu, 7 Mar 2019 at 15:27, bzt <bztemail@gmail.com> wrote:
> Yes, could be. The QA7 spec is not really detailed, and calling both
> timers simply ARM timers can be misleading. But it's not relevant
> anyway from the IRQ's point of view. My latest patch checks both bits
> to be set to generate the IRQ, so it does not really matter. As I've
> said, this patch adds only the periodic IRQ, and not a full timer
> emulation.
>
> Do you want any modifications on the patch? If so, what exactly? Let
> me know and I'll update it.

I assume by "latest patch" you mean a planned v3
that you haven't sent yet?

I think it's probably best to go with my interpretation of
the specs, if you think it makes sense:
 * running and stopping the timer is controlled by the
   "timer enable" bit (and doesn't care about the
   "interrupt enable" bit)
 * the timer timing out always sets the "interrupt flag" bit
 * we set the destination core IRQ/FIQ if the "interrupt flag"
   and "interrupt enable" bits are both set (we don't care
   about whether the "timer enable" bit is set for this)

That should be only very minor changes from what you have now.

thanks
-- PMM
