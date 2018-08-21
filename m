Received: from eggs.gnu.org ([2001:4830:134:3::10]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs7Gq-0007hI-MJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs79n-00075J-Ln
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:57:16 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:40438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs79n-00074S-Dj
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:57:15 -0400
Received: by mail-oi0-x235.google.com with SMTP id w126-v6so32127007oie.7
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGmj6quRd4KaYJL2vqohFHuNDim+aB5OqoCAcK0HbFx7t+bfjg@mail.gmail.com>
References: <CAGmj6quRd4KaYJL2vqohFHuNDim+aB5OqoCAcK0HbFx7t+bfjg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 14:56:54 +0100
Message-ID: <CAFEAcA-MyMUyX9NWLU5OTcqMPXPsiag_awKU9_Qh-vUf2eMoPA@mail.gmail.com>
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

On 21 August 2018 at 14:29, Martin Schroeder via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> I'd like to add a virtual device that is controlled by a couple of
> GPIO pins on my controller (cortex-m4) and a serial port. I suppose I
> can derive it from SSISlaveClass to make the new device a serial
> slave.
>
> But how do I connect GPIOs?
>
> I want the slave device to be notified when guest firmware toggles a
> gpio pin through the gpio driver which is an mmio device mapped into
> the gpio memory area. So the GPIO driver currently keeps the state of
> the pins internal to the driver. What I would like to do is somehow,
> without requiring that the GPIO driver knows about the connected slave
> device, deliver the notification of a gpio pin being toggled to the
> slave device.

The GPIO device should expose its outbound GPIO lines
as qdev gpio lines. The slave device should have a GPIO line
which is an input qdev gpio. The board code then connects the two
together using
  qdev_connect_gpio_out(your_gpio_device, i,
                        qdev_get_gpio_in(slavedevice, j));

which connects the GPIO controller's output GPIO i to
slave device's input GPIO j.

There are also _named() versions of these so you can
give GPIO lines names rather than having them be unnamed
(which makes the code a bit easier to understand, especially
where the device isn't a gpio controller whose outputs are
all just "the GPIO lines").

thanks
-- PMM
