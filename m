Received: from eggs.gnu.org ([209.51.188.92]:53490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwUfC-0000Ai-KS
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwUfA-0008SX-00
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:24:02 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:31955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gwUf8-0008Cq-5O
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:23:59 -0500
Date: Wed, 20 Feb 2019 13:13:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190220072928.mci7urfyfqwg55fg@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1902201249150.30216@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
	<20190219123052.dop3kpgowi2apitq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191449400.24309@zero.eik.bme.hu>
	<20190220072928.mci7urfyfqwg55fg@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hello,

On Wed, 20 Feb 2019, Gerd Hoffmann wrote:
>>> So it could be tested with linux guests on x86 too I guess?
>>> Can the radeon drm driver handle the devices too?
>>
>> Yes you can try with x86 guests, I haven't tested that yet. The radeon
>> driver only supports RV100 and up I think so may only work with the 0x5159
>> variant not with Rage 128 Pro which had another driver r128 but not sure
>> that still exists. Although these two chips are similar, Rage 128 Pro is a
>> bit simpler that's why I'm targeting it first and also that's what the
>> PowerMac3,1 (the ppc mac99 machine is converging to) has. The R128Pro is the
>> last of the previous generation before Radeon, while RV100 is the stripped
>> down simplest version of the R100 family which has some more 3D capability).
>> But even if the DRM driver loads, probably only the mode setting part is
>> useful at the moment as 3D is not implemented yet by this device model.
>
> Chances are not too bad that it'll be good enough to bring up a linux
> console.

Yes, that may work but I haven't tested it. I've quickly tried booting a 
Linux install CD with 0x5159 but got no picture while the same iso got me 
output with the default r128p. The latter uses aty128fb. I haven't try to 
debug the radeon case not sure if the boot CD I've tried does not support 
that or something is missing for the Linux driver. In general I'm only 
targeting r128p now and added 0x5159 for the mips_fulong2e board and for 
later direction to develop it further but haven't tested that much yet.

>>> I'd also use model=<name> instead of device_id=... to switch between
>>> different devices.
>>
>> The only problem with that is that there are this many versions with
>> confusing names (and maybe different device ids for different versions):
>>
>> https://www.x.org/wiki/RadeonFeature/#index5h2
>
> Do we want emulate them all?
> I'd guess picking a few models would be more useful ...

Sure we don't want them all I was just trying to show that names are less 
clear than device id.

> Ok, I'd suggest to rename it to x-device-id (to indicate that it may go
> away later) if you want stick with device id for now.

That works for me as well, will do that in next version.

> One thing I've noticed is that you use the vbe registers internally.
> I'd suggest to not do that, I suspect it will only get into the way
> latter on.  Better register your own GraphicsHwOps, then go call the vga
> ops in vga mode and your ati modesetting code in extended mode.
> virtio-vga does it that way if you want look at some sample code.  Also
> looking at bochs-display.c is probably more helpful than looking at
> vga.c when figuring how to handle display updates.

Currently it's simpler for me the way I've done it so until this becomes a 
problem I don't want to add more code. Also I'm not sure how it would work 
because the hardware has both VGA engine and GUI engine (extended mode) 
working from the same memory and drivers sometimes poke VGA registers for 
example to set palette even in extended mode. So we can't avoid VGA 
altogether. Also we have no VESA BIOS and the one we have depends on VBE 
so that's also needed at the moment. This could be cleaned up later so I'd 
leave it for now and add more functionality instead.

Regards,
BALATON Zoltan
