Received: from eggs.gnu.org ([209.51.188.92]:32951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwqDv-0003g7-9F
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwqDt-0007kX-MH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:25:19 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:25812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gwqDt-0007P1-9X
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:25:17 -0500
Date: Thu, 21 Feb 2019 16:24:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190221123618.qkbn7ipfnqeplv6w@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1902211455550.11985@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
	<20190219123052.dop3kpgowi2apitq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191449400.24309@zero.eik.bme.hu>
	<20190220072928.mci7urfyfqwg55fg@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902211159500.50921@zero.eik.bme.hu>
	<20190221123618.qkbn7ipfnqeplv6w@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, 21 Feb 2019, Gerd Hoffmann wrote:
> On Thu, Feb 21, 2019 at 12:44:22PM +0100, BALATON Zoltan wrote:
>> On Wed, 20 Feb 2019, Gerd Hoffmann wrote:
>>>>> So it could be tested with linux guests on x86 too I guess?
>>>>> Can the radeon drm driver handle the devices too?
>>>>
>>>> Yes you can try with x86 guests, I haven't tested that yet. The radeon
>>>> driver only supports RV100 and up I think so may only work with the 0x5159
>>>> variant not with Rage 128 Pro which had another driver r128 but not sure
>>>> that still exists. Although these two chips are similar, Rage 128 Pro is a
>>>> bit simpler that's why I'm targeting it first and also that's what the
>>>> PowerMac3,1 (the ppc mac99 machine is converging to) has. The R128Pro is the
>>>> last of the previous generation before Radeon, while RV100 is the stripped
>>>> down simplest version of the R100 family which has some more 3D capability).
>>>> But even if the DRM driver loads, probably only the mode setting part is
>>>> useful at the moment as 3D is not implemented yet by this device model.
>>>
>>> Chances are not too bad that it'll be good enough to bring up a linux
>>> console.
>>
>> I've tried a random Fedora live CD on qemu-system-x86_64 with ati-vga and
>> with the default 0x5046 (Rage128Pro) that got me to X desktop.
>
> Wow.  Guess X11 just runs unaccelerated on some framebuffer though.

Sure, no acceleration is implemented yet apart from some simple 2D the 
Linux console and the PMON2000 firmware of the fulong2e uses (and even 
those may have bugs) so anything that tries to use more than that will 
have gfx issues for now. The Fedora image I've tried was an LXDE one I 
think so it probably does not use many advanced features and did not work 
very well in that I could not get a terminal window but there was picture 
and could get the window manager preferences at least but trying to access 
the Applications or Terminals menu got me an error so looks like it's a 
bug in the image itself. I did not try any other Gnome or KDE ones as 
those are twice the size of the simple image I've downloaded. Maybe those 
would use more acceleration and fail.

>> With 0x5159 (RV100) I don't get any picture.
>
> So maybe the drm driver tries some more advanced stuff here.

I'm not sure, haven't seen it poking the card with -trace enable=ati* so 
maybe it's missing something very early. Since I got no output even in VGA 
mode I could not find out what it's trying to do. (It may also be possible 
it's trying to access the card via a command FIFO or some other advanced 
mode which is not yet implemented. These cards have some other ways to 
send reg values than just via io and mmio and anything more advanced than 
simple drivers would probably try to use those.)

>> It looks like first problem is that the
>> vgabios in QEMU doesn't like this card.
>
> The seabios banner should show up in any case.  That is just using
> standard vga text mode without any vendor-specific extensions.

And that's not showing up with 0x5159 that's why I think vgabios has an 
issue. You can try:

qemu-system-x86_64 -device ati-vga -d trace:vga\*,trace:ati\*
and
qemu-system-x86_64 -device ati-vga,x-device-id=0x5159 -d trace:vga\*,trace:ati\*

to see what I mean. (Also just sent a v3 where device_id is now 
x-device-id and some more review changes but nothing new otherwise.)

> The PCI IDs of device and bios must match, so you need one bios per card
> version.  You can use roms/config.vga-qxl as template and replace the
> IDs there.

OK but the vgabios-std.bin seems to work with the r128p emulation but not 
with the rv100 device id. I don't have time for it now so using the 
vgabios-std is good enough for me to test the r128p with OpenBIOS (which 
just uses VBE ports to configure the device ignoring the vgabios and 
eventually should be fixed to use a PPC compatible OpenFirmware FCode ROM 
instead for MacOS). It also seems to work with x86_64 so unless you want 
to target rv100 from the beginning it could wait until r128p works. 
There's enough stuff to implement for that as well before I can get to 
rv100 so I won't try to take up vgabios development as well now.

> Maybe it makes sense to have an abstract ati-vga-base type, then create
> two (or more) types using that base type which only differ in pci id and
> vgabios (and maybe more later on when the more advanced stuff is
> implemented).

We could do that but until we only have two of these I think it's simper 
to handle them in one type then this could be split up later when it's 
clearer what're the common parts and what would go in subclasses. I'll 
think about this but for now it seems simpler to just have a single class 
with some ifs where there are differences. Later Radeon versions probably 
will have more differences so for those a subclass would make sense but 
maybe not yet.

>> There's another problem I know about with the vgabios, that it's compiled
>> with gcc that cannot compile real x86 16-bit code, only code that can be run
>> in i386 real mode as discussed here
>> https://stackoverflow.com/questions/19055647/how-to-tell-gcc-to-generate-16-bit-code-for-real-mode
>>
>> This is usually not a problem but some PPC machines e.g. the sam460ex has a
>> BIOS emulator (usually a variant of x86emu) in their firmware (and maybe
>> also X server does the same on these platforms) which runs the card's VESA
>> bios to initialise the card and set mode but this fails with QEMU's vgabios
>> due to unsupported 32bit prefixes in 16bit code.
>
> The X server does it on pretty much anything but i386.
> Specifically x86emu is also used on x86_64 (when using the vesa driver).
>
>> There's a VGA_FIXUP_ASM config option in vgabios which is supposed to
>> help with this but it doesn't.
>
> It surely helps at least with the x86emu variant used by the X server,
> even for RHEL-5 (which is more than 10 years old meanwhile).

Have you tested it recently? I've tried recompiling vgabios in QEMU with 
that but it still failed on the BIOS emulator in the firmware although 
with different error than before.

> So the sam460ex firmware must have a ancient version/fork of x86emu.
> Is it open source, so there is a chance to update it?

Yes, see qemu/roms/u-boot-sam460ex/ (mirrored from my 
github.com/zbalaton/u-boot-sam460ex.git repo for lack of better upstream 
at the moment). There's also a newer version of this firmware based on 
U-Boot 2005.a (http://www.acube-systems.biz/index.php?page=hardware&pid=5) 
to which we may be able to update instead of fixing this old version but I 
haven't tried that and I had to fix some bugs in the 2010/2011 version we 
have now too so those sources might not be working too well without some 
testing and fixes. Also I've actually found this vgabios problem with a 
different machine I'm working on and that does not have source for the 
firmware so that could not be fixed other than using bcc compiled vgabios 
which seems to work at least until a better solution can be done.

Regards,
BALATON Zoltan
