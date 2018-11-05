Received: from eggs.gnu.org ([2001:4830:134:3::10]:39665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJa4I-00077m-IY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJa4H-0008Q5-H7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:17:06 -0500
Date: Mon, 5 Nov 2018 09:16:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181105081656.3u5vankppvabxmlg@sirius.home.kraxel.org>
References: <20181029223207.31878-1-philmd@redhat.com>
	<20181029223207.31878-4-philmd@redhat.com>
	<20181030063830.edjacusffvgwvnt2@sirius.home.kraxel.org>
	<fc4b00b2-dda0-a0fb-e7b8-487065dbf6cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc4b00b2-dda0-a0fb-e7b8-487065dbf6cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] arm: allwinner: Enable USB EHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Icenowy Zheng <icenowy@aosc.xyz>, Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>

> > > @@ -116,6 +116,8 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
> > >       if (machine_usb(current_machine)) {
> > >           sysbus_create_simple("sysbus-ohci", 0x01c14400, s->irq[64]);
> > >           sysbus_create_simple("sysbus-ohci", 0x01c1c400, s->irq[65]);
> > > +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c14000, s->irq[39]);
> > > +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c1c000, s->irq[40]);
> > 
> > Hmm, is this a companion controller setup?  If so, then this is a bit
> > more complicated  (see ehci_create_ich9_with_companions()).
> 
> I don't have enough USB knowledge. Can we have companion setup without PCI?
> 
> Per the datashit [1] p. 215 "21. USB Host Controller", each controller share
> the same PHY. There is no mention of companion setup:
> 
>   The USB host controller includes the following features:
>   ..
>   - Complies with EHCI Specification, Version 1.0,
>   - and  the OHCI Specification, Version 1.0a.
>   ..
>   - Support only 1 USB Root Port shared between EHCI and OHCI.

Looks like a companion setup.  Short introduction:

The port is shared, and ehci controls whenever the port is assigned to
ehci or the companion (ohci in this case).  Typically the ehci driver
sets the bit depending on usb device speed, i.e. usb2 devices are
handled by ehci and usb1 devices are handled by ohci.

By default ohci owns the devices, so in case the OS has no ehci driver
ohci can be used to handle usb2 devices in usb1 compat mode.  Pretty
much moot these days.

On the qemu side you basically have to initialize ehci first (so the usb
bus exists), then set the masterbus property to the ehci usb-bus for the
ohci controller.

HTH,
  Gerd
