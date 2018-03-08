Received: from eggs.gnu.org ([2001:4830:134:3::10]:52510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etz5y-0003W6-VO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etz5v-0001IE-Qa
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:12:46 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:43448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1etz5v-0001Ht-IV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:12:43 -0500
Received: by mail-pg0-x243.google.com with SMTP id e9so2448263pgs.10
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 09:12:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 8 Mar 2018 09:12:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180308171239.GA22206@roeck-us.net>
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA8iFYGhzmLm6pyZi6tg=Di1P=vi_Enyw_ia1M34B3t8aw@mail.gmail.com>
	<1cb9cc42-c7c9-5124-a615-27914d23b05c@roeck-us.net>
	<CAFEAcA-+J7MUSssjPZ5BTNzGx_4h0YANdCegGfWNzYmoNatcqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-+J7MUSssjPZ5BTNzGx_4h0YANdCegGfWNzYmoNatcqg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Bill Paul <wpaul@windriver.com>

On Thu, Mar 08, 2018 at 02:51:04PM +0000, Peter Maydell wrote:
> On 8 March 2018 at 14:47, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 03/08/2018 02:50 AM, Peter Maydell wrote:
> >> So do the works-by-accident kernels fail on QEMU because
> >> we don't emulate some bit of the ethernet device ?
> >> Ideally we could fix that so we could boot newer kernels
> >> without breaking the old ones...
> 
> >
> > I don't know if a fix working for all versions of Linux is even possible.
> > Creating both interrupts might be an option, but would likely cause
> > other problems since some versions of Linux would handle the same
> > interrupt twice, while others expect the second interrupt
> > to be associated with the timer.
> 
> Did the older Linux kernels work on the real hardware? (I
> would guess so, but sometimes these things only get tested
> on emulation...) If so, then in theory "make QEMU work like
> the hardware" should allow all the kernels to work on QEMU.
> 
Older kernels (4.9 and earlier) register the second interrupt
on a gpio pin.

Linux 4.1, ToT qemu with this patch applied:

 38:          0  gpio-mxc   6 Level     2188000.ethernet
286:          0       GIC 151 Level     2188000.ethernet

Linux 4.1, ToT qemu without this patch:

 38:          0  gpio-mxc   6 Level     2188000.ethernet
286:         64       GIC 151 Level     2188000.ethernet

linux 4.14, ToT qemu with this patch:

 64:         64     GIC-0 150 Level     2188000.ethernet
 65:          0     GIC-0 151 Level     2188000.ethernet

linux 4.14, ToT qemu without this patch:

 64:          0     GIC-0 150 Level     2188000.ethernet
 65:         64     GIC-0 151 Level     2188000.ethernet

Presumably real hardware generates interrupts on the gpio pin.

The qemu code specifically states that it won't generate
MDIO related interrupts on gpio pins. From hw/net/imx_fec.c:

/*
 * The MII phy could raise a GPIO to the processor which in turn
 * could be handled as an interrpt by the OS.
 * For now we don't handle any GPIO/interrupt line, so the OS will
 * have to poll for the PHY status.
 */

Linux doesn't poll the phy but expects interrupts to work. I have
no idea what is supposed to happen with regular ethernet interrupts,
and if those are also mapped to a gpio pin on real hardware.

Any idea how to fix this ?

Guenter
