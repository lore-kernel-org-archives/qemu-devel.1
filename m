Received: from eggs.gnu.org ([2001:4830:134:3::10]:36451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsRka-0003Bp-Qp
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsRkZ-0002ti-V6
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:56:36 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:40471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsRkV-0002s1-Rc
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:56:33 -0400
Received: by mail-oi0-x236.google.com with SMTP id w126-v6so2625065oie.7
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 04:56:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGmj6qvDLzdDoW7AA4189ZnGTnM0Kr=P0nY9FugWmCWNr_+uWA@mail.gmail.com>
References: <CAGmj6quRd4KaYJL2vqohFHuNDim+aB5OqoCAcK0HbFx7t+bfjg@mail.gmail.com>
	<CAFEAcA-MyMUyX9NWLU5OTcqMPXPsiag_awKU9_Qh-vUf2eMoPA@mail.gmail.com>
	<CAGmj6qvDLzdDoW7AA4189ZnGTnM0Kr=P0nY9FugWmCWNr_+uWA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Aug 2018 12:56:09 +0100
Message-ID: <CAFEAcA8-mVtidcCs8h3cRXPRsadSOkEPMB_0_PDR87HjKzWOPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Modeling a device controlled by combination of
 GPIO and UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schroeder <mkschreder.uk@googlemail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2018 at 08:36, Martin Schroeder
<mkschreder.uk@googlemail.com> wrote:
> Thanks Peter.
>
> I have set it up such that master device has qemu_irq array which it
> initializes using qdev_init_gpio_out with number of gpio lines going
> out and slave device calls qdev_init_gpio_in with a callback that
> should be called when irq is raised. Then I connect them together at
> higher level using qdev_connect_gpio_out as you said. Then master
> calls qemu_set_irq with 1 or 0 depending on whether the gpio is high
> or low.
>
> This works, but not as I would expect. The handler that I supply to
> the init_gpio_in is only being called very infrequently - perhaps once
> every 50 toggles on the gpio pin. I need to make sure that it gets
> called every time master device calls qemu_set_irq.
>
> What's the mechanism behind this behavior and how can I deliver gpio
> change to the slave?

The mechanism is pretty simple -- a qemu_irq is really a
pointer to a small struct that has a function pointer in
it. Initializing a gpio in is just setting up the struct and
function pointer. Connecting them is passing the qemu_irq
pointer to the source. Calling qemu_set_irq() simply
calls the function pointer. (You can step through in a
debugger from the qemu_set_irq call through to the target
function call if you like -- it's not very much code.)

This can fail in the sense that if you don't wire it up
right then nothing happens when you call qemu_set_irq()
(because you didn't give the source device the right
qemu_irq or you didn't give it one at all), but it
shouldn't be able to fail unreliably and only call
the destination handler some of the time.

thanks
-- PMM
