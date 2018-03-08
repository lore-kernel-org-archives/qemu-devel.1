Received: from eggs.gnu.org ([2001:4830:134:3::10]:48459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1eu0Ir-0005l3-Q0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1eu0Io-00049p-KO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:30:09 -0500
Received: from mail5.windriver.com ([192.103.53.11]:55428 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Bill.Paul@windriver.com>)
	id 1eu0Io-00048K-AF
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:30:06 -0500
From: Bill Paul <wpaul@windriver.com>
Date: Thu, 8 Mar 2018 10:28:39 -0800
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA-+J7MUSssjPZ5BTNzGx_4h0YANdCegGfWNzYmoNatcqg@mail.gmail.com>
	<20180308171239.GA22206@roeck-us.net>
In-Reply-To: <20180308171239.GA22206@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <201803081028.39635.wpaul@windriver.com>
Subject: Re: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris
	Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>

Of all the gin joints in all the towns in all the world, Guenter Roeck had to 
walk into mine at 09:12 on Thursday 08 March 2018 and say:

> On Thu, Mar 08, 2018 at 02:51:04PM +0000, Peter Maydell wrote:
> > On 8 March 2018 at 14:47, Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 03/08/2018 02:50 AM, Peter Maydell wrote:
> > >> So do the works-by-accident kernels fail on QEMU because
> > >> we don't emulate some bit of the ethernet device ?
> > >> Ideally we could fix that so we could boot newer kernels
> > >> without breaking the old ones...
> > > 
> > > I don't know if a fix working for all versions of Linux is even
> > > possible. Creating both interrupts might be an option, but would
> > > likely cause other problems since some versions of Linux would handle
> > > the same interrupt twice, while others expect the second interrupt
> > > to be associated with the timer.
> > 
> > Did the older Linux kernels work on the real hardware? (I
> > would guess so, but sometimes these things only get tested
> > on emulation...) If so, then in theory "make QEMU work like
> > the hardware" should allow all the kernels to work on QEMU.
> 
> Older kernels (4.9 and earlier) register the second interrupt
> on a gpio pin.
> 
> Linux 4.1, ToT qemu with this patch applied:
> 
>  38:          0  gpio-mxc   6 Level     2188000.ethernet
> 286:          0       GIC 151 Level     2188000.ethernet
> 
> Linux 4.1, ToT qemu without this patch:
> 
>  38:          0  gpio-mxc   6 Level     2188000.ethernet
> 286:         64       GIC 151 Level     2188000.ethernet
> 
> linux 4.14, ToT qemu with this patch:
> 
>  64:         64     GIC-0 150 Level     2188000.ethernet
>  65:          0     GIC-0 151 Level     2188000.ethernet
> 
> linux 4.14, ToT qemu without this patch:
> 
>  64:          0     GIC-0 150 Level     2188000.ethernet
>  65:         64     GIC-0 151 Level     2188000.ethernet
> 
> Presumably real hardware generates interrupts on the gpio pin.
> 
> The qemu code specifically states that it won't generate
> MDIO related interrupts on gpio pins. From hw/net/imx_fec.c:
> 
> /*
>  * The MII phy could raise a GPIO to the processor which in turn
>  * could be handled as an interrpt by the OS.
>  * For now we don't handle any GPIO/interrupt line, so the OS will
>  * have to poll for the PHY status.
>  */
> 
> Linux doesn't poll the phy but expects interrupts to work. I have
> no idea what is supposed to happen with regular ethernet interrupts,
> and if those are also mapped to a gpio pin on real hardware.

The i.MX6, like a lot of ARM chips, has an internal pin/signal muxing block. 
The implementation can vary from one SoC to another. The i.MX6 calls it the 
IOMUX block.

The reason for using the GPIO pin here has to do with erratum 6687 in the 
i.MX6. The problem is this: the ENET block has several interrupt sources such 
as RX done, TX done, various errors and wakeup request. The i.MX6 also has two 
blocks to which interrupts can be routed: the GIC (Generic Interrupt 
Controller) and GPC (Generic Power Controller). The GPC is only used for power 
management: you can use it to configure what device interrupts (from internal 
SoC peripherals) can wake the system from hibernation.

The GIC receives all ENET events ORed together via vector 150.

But the GPC is only connected to the wakeup request signal.

According to the erratum 6687 documentation, this means that a normal RX or TX 
event would not wake up the system, which is suboptimal.

The workaround for this is:

- Configure the internal mux block to route the ENET interrupt line to a GPIO 
pin (as with the GIC, this also gives you all ENET events ORed together)
- Unmask the GPIO interrupt in the GPC block instead of the ENET interrupt

The erratum description recommends using GPIO6. It also says that this 
workaround was implemented in Freescale/NXP's Linux BSP for this chip. I don't 
know if it was also upstreamed to the official Linux kernel.

Note that this workaround is applied by software, and is really only needed if 
you want the ethernet controller to serve as a wakeup event source.

As far as I can tell QEMU does not support the IOMUX block, so it would never 
be possible for a kernel with this workaround in place to get interrupts via 
the GPIO6 pin.

That said, I don't think the i.MX6 ENET driver itself would need to use the 
GPIO6 interrupt. When we implemented power management support for VxWorks we 
also used this workaround, but only for the benefit of the GPC module. As far 
as I recall, the ENET driver still used GIC vector 150. This may be why this 
behavior was removed in later kernels. 

Anyway, this means that the only reason older Linux kernels worked in QEMU 
with the broken interrupt configuration is that they also registered a handler 
on vector 151 (119). Even though QEMU could not send events via GPIO6, it was 
mistakenly sending them via vector 151, so it looked like things worked. On 
real hardware, the older kernels would have gotten their interrupts via GPIO6 
and also worked. The older kernels would _not_ work if you fix QEMU because 
now they would never get interrupts on either vector, unless you fudge things 
so that the ENET module triggers both vector 150 and the vector for GPIO6 in 
the GIC or patch them to back out the erratum 6678 workaround as later kernels 
do.

Later kernels that register vectors 150 and 151 would work with both broken 
and fixed QEMU and real hardware.

But you should fix the incorrect interrupt configuration regardless. :)
 
-Bill

> Any idea how to fix this ?
> 
> Guenter
-- 
=============================================================================
-Bill Paul            (510) 749-2329 | Senior Member of Technical Staff,
                 wpaul@windriver.com | Master of Unix-Fu - Wind River Systems
=============================================================================
   "I put a dollar in a change machine. Nothing changed." - George Carlin
=============================================================================
