Received: from eggs.gnu.org ([209.51.188.92]:58142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gydlm-0002cY-Ue
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gydlh-0001IG-7Q
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:31:42 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gydlf-0001DM-Sm
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:31:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id g1so11186192otj.11
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 06:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20190215155919.GA10823@nyan>
	<CAFEAcA9yEBy-=-2oSDqAXLffGjU7Aa9MeVtYFCU29qxerWb23A@mail.gmail.com>
In-Reply-To: <CAFEAcA9yEBy-=-2oSDqAXLffGjU7Aa9MeVtYFCU29qxerWb23A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 14:31:16 +0000
Message-ID: <CAFEAcA8mJ=69NkrO_7_9WoCPq+GYCN9WRf6PuUtGv+4LXXDRow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [v4 PATCH] hw/arm/bcm2835_peripherals: add bcm283x
 arm timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark <alnyan@airmail.cc>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:Raspberry Pi" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Thu, 21 Feb 2019 at 11:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 15 Feb 2019 at 15:59, Mark <alnyan@airmail.cc> wrote:
> > +    s->irq = qemu_allocate_irq(bcm283x_timer_set_irq, s, 0);
>
> I know this code has come from the sp804 code, but it's
> actually wrong (and I should fix the sp804). qemu_allocate_irq()
> is for interrupt lines that come into a device, not for ones
> that go out from it, like this one. The call happens to have
> no visible bad effects because what it does will be overrriden
> later when the board code wires up the interrupt to the
> interrupt controller. (There will be a tiny memory leak.)

Looking more closely at this, my analysis here is wrong -- sorry.
For the sp804, this call is necessary, because the sp804
has a dual layer structure between the arm_timer_state
layer and the SP804State layer. It creates outbound IRQs
from the arm_timer_state with qemu_allocate_irq(), and
effectively connects them to the SP804State via the
sp804_set_irq() function (which raises the outbound IRQ from
the SP804State if either of the arm_timer_state lines is high).

In your case there is no dual-layer structure, so you don't
need to call qemu_allocate_irq() at all. (You're effectively
trying to use BCM283xTimerState as both the inner layer IRQ
and the outer layer IRQ, and it happens to work because the
setup of the outer layer happens last so the bogus inner
layer initialization is ignored.)

> You can just delete the qemu_allocate_irq() call here, and
> the bcm283x_timer_set_irq() function.

So my recommendation here was correct, but my reasoning was
not right.

thanks
-- PMM
