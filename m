Received: from eggs.gnu.org ([209.51.188.92]:40003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwMJx-00034D-Ip
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwMJw-0005BA-EX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:29:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwMJv-0005A9-1Y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:29:32 -0500
Date: Wed, 20 Feb 2019 08:29:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190220072928.mci7urfyfqwg55fg@sirius.home.kraxel.org>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
	<20190219123052.dop3kpgowi2apitq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191449400.24309@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1902191449400.24309@zero.eik.bme.hu>
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

> > So it could be tested with linux guests on x86 too I guess?
> > Can the radeon drm driver handle the devices too?
> 
> Yes you can try with x86 guests, I haven't tested that yet. The radeon
> driver only supports RV100 and up I think so may only work with the 0x5159
> variant not with Rage 128 Pro which had another driver r128 but not sure
> that still exists. Although these two chips are similar, Rage 128 Pro is a
> bit simpler that's why I'm targeting it first and also that's what the
> PowerMac3,1 (the ppc mac99 machine is converging to) has. The R128Pro is the
> last of the previous generation before Radeon, while RV100 is the stripped
> down simplest version of the R100 family which has some more 3D capability).
> But even if the DRM driver loads, probably only the mode setting part is
> useful at the moment as 3D is not implemented yet by this device model.

Chances are not too bad that it'll be good enough to bring up a linux
console.

> > I'd also use model=<name> instead of device_id=... to switch between
> > different devices.
> 
> The only problem with that is that there are this many versions with
> confusing names (and maybe different device ids for different versions):
> 
> https://www.x.org/wiki/RadeonFeature/#index5h2

Do we want emulate them all?
I'd guess picking a few models would be more useful ...

> so the only really good way to identify a chip is via device_id. This is not
> user friendly but at this stage probably will do and we can add alternative
> model property later which aliases some device ids (like it's done for CPU

Ok, I'd suggest to rename it to x-device-id (to indicate that it may go
away later) if you want stick with device id for now.

> OK I thought those are related but if adding it to the default_list[] won't
> automatically add a -vga option then that's a good idea. I'll do that and
> also move the config lines to pci.mak in next version but wait for a few
> more days for more comments.

One thing I've noticed is that you use the vbe registers internally.
I'd suggest to not do that, I suspect it will only get into the way
latter on.  Better register your own GraphicsHwOps, then go call the vga
ops in vga mode and your ati modesetting code in extended mode.
virtio-vga does it that way if you want look at some sample code.  Also
looking at bochs-display.c is probably more helpful than looking at
vga.c when figuring how to handle display updates.

cheers,
  Gerd
