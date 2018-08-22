Received: from eggs.gnu.org ([2001:4830:134:3::10]:55692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1fsNhF-0008PM-Cb
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1fsNhE-0000vT-Hg
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:36:53 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:38943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mkschreder.uk@googlemail.com>)
	id 1fsNhE-0000uY-91
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:36:52 -0400
Received: by mail-ua1-x943.google.com with SMTP id g18-v6so546362uam.6
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 00:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGmj6quRd4KaYJL2vqohFHuNDim+aB5OqoCAcK0HbFx7t+bfjg@mail.gmail.com>
	<CAFEAcA-MyMUyX9NWLU5OTcqMPXPsiag_awKU9_Qh-vUf2eMoPA@mail.gmail.com>
In-Reply-To: <CAFEAcA-MyMUyX9NWLU5OTcqMPXPsiag_awKU9_Qh-vUf2eMoPA@mail.gmail.com>
From: Martin Schroeder <mkschreder.uk@googlemail.com>
Date: Wed, 22 Aug 2018 09:36:40 +0200
Message-ID: <CAGmj6qvDLzdDoW7AA4189ZnGTnM0Kr=P0nY9FugWmCWNr_+uWA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Thanks Peter.

I have set it up such that master device has qemu_irq array which it
initializes using qdev_init_gpio_out with number of gpio lines going
out and slave device calls qdev_init_gpio_in with a callback that
should be called when irq is raised. Then I connect them together at
higher level using qdev_connect_gpio_out as you said. Then master
calls qemu_set_irq with 1 or 0 depending on whether the gpio is high
or low.

This works, but not as I would expect. The handler that I supply to
the init_gpio_in is only being called very infrequently - perhaps once
every 50 toggles on the gpio pin. I need to make sure that it gets
called every time master device calls qemu_set_irq.

What's the mechanism behind this behavior and how can I deliver gpio
change to the slave?
On Tue, Aug 21, 2018 at 3:57 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 21 August 2018 at 14:29, Martin Schroeder via Qemu-devel
> <qemu-devel@nongnu.org> wrote:
> > I'd like to add a virtual device that is controlled by a couple of
> > GPIO pins on my controller (cortex-m4) and a serial port. I suppose I
> > can derive it from SSISlaveClass to make the new device a serial
> > slave.
> >
> > But how do I connect GPIOs?
> >
> > I want the slave device to be notified when guest firmware toggles a
> > gpio pin through the gpio driver which is an mmio device mapped into
> > the gpio memory area. So the GPIO driver currently keeps the state of
> > the pins internal to the driver. What I would like to do is somehow,
> > without requiring that the GPIO driver knows about the connected slave
> > device, deliver the notification of a gpio pin being toggled to the
> > slave device.
>
> The GPIO device should expose its outbound GPIO lines
> as qdev gpio lines. The slave device should have a GPIO line
> which is an input qdev gpio. The board code then connects the two
> together using
>   qdev_connect_gpio_out(your_gpio_device, i,
>                         qdev_get_gpio_in(slavedevice, j));
>
> which connects the GPIO controller's output GPIO i to
> slave device's input GPIO j.
>
> There are also _named() versions of these so you can
> give GPIO lines names rather than having them be unnamed
> (which makes the code a bit easier to understand, especially
> where the device isn't a gpio controller whose outputs are
> all just "the GPIO lines").
>
> thanks
> -- PMM
