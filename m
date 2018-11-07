Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gKSj4-0002A0-Tr
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gKSj0-000862-SK
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:38:50 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 7 Nov 2018 10:38:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181107183819.GA5468@roeck-us.net>
References: <20181029223207.31878-1-philmd@redhat.com>
	<20181029223207.31878-4-philmd@redhat.com>
	<20181030063830.edjacusffvgwvnt2@sirius.home.kraxel.org>
	<fc4b00b2-dda0-a0fb-e7b8-487065dbf6cc@redhat.com>
	<20181105081656.3u5vankppvabxmlg@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105081656.3u5vankppvabxmlg@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] arm: allwinner: Enable USB EHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Icenowy Zheng <icenowy@aosc.xyz>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>

On Mon, Nov 05, 2018 at 09:16:56AM +0100, Gerd Hoffmann wrote:
> > > > @@ -116,6 +116,8 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
> > > >       if (machine_usb(current_machine)) {
> > > >           sysbus_create_simple("sysbus-ohci", 0x01c14400, s->irq[64]);
> > > >           sysbus_create_simple("sysbus-ohci", 0x01c1c400, s->irq[65]);
> > > > +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c14000, s->irq[39]);
> > > > +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c1c000, s->irq[40]);
> > > 
> > > Hmm, is this a companion controller setup?  If so, then this is a bit
> > > more complicated  (see ehci_create_ich9_with_companions()).
> > 
> > I don't have enough USB knowledge. Can we have companion setup without PCI?
> > 
> > Per the datashit [1] p. 215 "21. USB Host Controller", each controller share
> > the same PHY. There is no mention of companion setup:
> > 
> >   The USB host controller includes the following features:
> >   ..
> >   - Complies with EHCI Specification, Version 1.0,
> >   - and  the OHCI Specification, Version 1.0a.
> >   ..
> >   - Support only 1 USB Root Port shared between EHCI and OHCI.
> 
> Looks like a companion setup.  Short introduction:
> 
> The port is shared, and ehci controls whenever the port is assigned to
> ehci or the companion (ohci in this case).  Typically the ehci driver
> sets the bit depending on usb device speed, i.e. usb2 devices are
> handled by ehci and usb1 devices are handled by ohci.
> 
> By default ohci owns the devices, so in case the OS has no ehci driver
> ohci can be used to handle usb2 devices in usb1 compat mode.  Pretty
> much moot these days.
> 
> On the qemu side you basically have to initialize ehci first (so the usb
> bus exists), then set the masterbus property to the ehci usb-bus for the
> ohci controller.
> 

I tried that; in theory it looks like it works, or at least both devices
instantiate. I took the implementation from hw/ppc/sam460ex.c as guideline.

In practice, however, it doesn't work (nor does my current code). EHCI
fails to instantiate with error -110, and OHCI fails to instantiate with
error -75.

Weird, I know I tested this when I implemented it. Nevertheless,
it doesn't work. Given that, I think the series should be dropped
for now, at least until I find the time to track down the problem.

Guenter
