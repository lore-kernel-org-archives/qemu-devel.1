Received: from eggs.gnu.org ([209.51.188.92]:52485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwnfC-00080F-5h
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwnaU-0006pA-U6
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:36:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwnaO-0006ho-JD
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:36:23 -0500
Date: Thu, 21 Feb 2019 13:36:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221123618.qkbn7ipfnqeplv6w@sirius.home.kraxel.org>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
	<20190219123052.dop3kpgowi2apitq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191449400.24309@zero.eik.bme.hu>
	<20190220072928.mci7urfyfqwg55fg@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902211159500.50921@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1902211159500.50921@zero.eik.bme.hu>
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

On Thu, Feb 21, 2019 at 12:44:22PM +0100, BALATON Zoltan wrote:
> On Wed, 20 Feb 2019, Gerd Hoffmann wrote:
> > > > So it could be tested with linux guests on x86 too I guess?
> > > > Can the radeon drm driver handle the devices too?
> > > 
> > > Yes you can try with x86 guests, I haven't tested that yet. The radeon
> > > driver only supports RV100 and up I think so may only work with the 0x5159
> > > variant not with Rage 128 Pro which had another driver r128 but not sure
> > > that still exists. Although these two chips are similar, Rage 128 Pro is a
> > > bit simpler that's why I'm targeting it first and also that's what the
> > > PowerMac3,1 (the ppc mac99 machine is converging to) has. The R128Pro is the
> > > last of the previous generation before Radeon, while RV100 is the stripped
> > > down simplest version of the R100 family which has some more 3D capability).
> > > But even if the DRM driver loads, probably only the mode setting part is
> > > useful at the moment as 3D is not implemented yet by this device model.
> > 
> > Chances are not too bad that it'll be good enough to bring up a linux
> > console.
> 
> I've tried a random Fedora live CD on qemu-system-x86_64 with ati-vga and
> with the default 0x5046 (Rage128Pro) that got me to X desktop.

Wow.  Guess X11 just runs unaccelerated on some framebuffer though.

> With 0x5159 (RV100) I don't get any picture.

So maybe the drm driver tries some more advanced stuff here.

> It looks like first problem is that the
> vgabios in QEMU doesn't like this card.

The seabios banner should show up in any case.  That is just using
standard vga text mode without any vendor-specific extensions.

The PCI IDs of device and bios must match, so you need one bios per card
version.  You can use roms/config.vga-qxl as template and replace the
IDs there.

Maybe it makes sense to have an abstract ati-vga-base type, then create
two (or more) types using that base type which only differ in pci id and
vgabios (and maybe more later on when the more advanced stuff is
implemented).

> There's another problem I know about with the vgabios, that it's compiled
> with gcc that cannot compile real x86 16-bit code, only code that can be run
> in i386 real mode as discussed here
> https://stackoverflow.com/questions/19055647/how-to-tell-gcc-to-generate-16-bit-code-for-real-mode
> 
> This is usually not a problem but some PPC machines e.g. the sam460ex has a
> BIOS emulator (usually a variant of x86emu) in their firmware (and maybe
> also X server does the same on these platforms) which runs the card's VESA
> bios to initialise the card and set mode but this fails with QEMU's vgabios
> due to unsupported 32bit prefixes in 16bit code.

The X server does it on pretty much anything but i386.
Specifically x86emu is also used on x86_64 (when using the vesa driver).

> There's a VGA_FIXUP_ASM config option in vgabios which is supposed to
> help with this but it doesn't.

It surely helps at least with the x86emu variant used by the X server,
even for RHEL-5 (which is more than 10 years old meanwhile).

So the sam460ex firmware must have a ancient version/fork of x86emu.
Is it open source, so there is a chance to update it?

cheers,
  Gerd
