Received: from eggs.gnu.org ([209.51.188.92]:46741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw4YL-0005PS-5Q
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw4YH-0000JB-8a
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:31:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gw4YG-0000Ea-VW
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:31:09 -0500
Date: Tue, 19 Feb 2019 13:30:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190219123052.dop3kpgowi2apitq@sirius.home.kraxel.org>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

  Hi,

> > Which linux driver is this?
> 
> Those in linux/drivers/video/fbdev/aty/. This ati-vga model defaults to Rage
> 128 Pro (what PoweMac3,1 has, device id 0x5046) which is handled by the
> aty128fb driver under Linux. MIPS fulong2e has Mobility Radeon M6 (RV100,
> device id 0x5159) that you can also use as -device ati-vga,device_id=0x5159
> which is driven by radeonfb under Linux.

So it could be tested with linux guests on x86 too I guess?
Can the radeon drm driver handle the devices too?

I'd also use model=<name> instead of device_id=... to switch between
different devices.

> > If linux has a native driver it might make sense to also enable it on
> > x86.  Makes testing easier.
> 
> Yes it could work on all archs under Linux but I've only enabled it on the
> two I've tried. It could be added instead to the same place where vga is
> added in pci.mak if you like.

Makes sense IMHO.

> > You can add the driver to default_list[] in vl.c, then you don't need
> > -vga none to remove the default vga when adding -device ati-vga.
> 
> I could do that but since it's a bit unfinished (lacks advanced features
> such as video overlay, 3D accel, command FIFO, etc.) and only a basic
> implementation at the moment to work with Linux framebuffer that doesn't use
> these features I thought it might be a godd idea to make it a bit harder to
> access yet to avoid problem of someone trying it with a Windows guest with
> drivers from ATI which probably will result in bad picture. But it's up to
> you to decide if you want to add it to -vga option from the start or have it
> as optional device and only add to -vga when it's more fully implemented and
> tested.

It's not about "-vga ati".  This is about adding ati-vga to the list of
display devices, so qemu will not try to add a vga automatically in case
it finds "-device ati-vga" on the command line.  That way "qemu -device
ati-vga" will work fine, without "-vga none".

Adding -vga ati indeed only makes sense once the implementation is more
complete.

cheers,
  Gerd
