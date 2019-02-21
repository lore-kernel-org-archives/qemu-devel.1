Received: from eggs.gnu.org ([209.51.188.92]:43516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwmmJ-0008GU-9Q
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwmmI-0003md-7f
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:35 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:48663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gwmmH-0003ZI-Rk
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:34 -0500
Date: Thu, 21 Feb 2019 12:44:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190220072928.mci7urfyfqwg55fg@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1902211159500.50921@zero.eik.bme.hu>
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

I've tried a random Fedora live CD on qemu-system-x86_64 with ati-vga and 
with the default 0x5046 (Rage128Pro) that got me to X desktop. With 0x5159 
(RV100) I don't get any picture. It looks like first problem is that the 
vgabios in QEMU doesn't like this card. I haven't checked further from 
there. Maybe eventually we'll need a vgabios-ati.bin for this but so far 
the existing one worked enough for at least the R128P.

There's another problem I know about with the vgabios, that it's compiled 
with gcc that cannot compile real x86 16-bit code, only code that can be 
run in i386 real mode as discussed here
https://stackoverflow.com/questions/19055647/how-to-tell-gcc-to-generate-16-bit-code-for-real-mode

This is usually not a problem but some PPC machines e.g. the sam460ex has 
a BIOS emulator (usually a variant of x86emu) in their firmware (and maybe 
also X server does the same on these platforms) which runs the card's VESA 
bios to initialise the card and set mode but this fails with QEMU's 
vgabios due to unsupported 32bit prefixes in 16bit code. There's a 
VGA_FIXUP_ASM config option in vgabios which is supposed to help with this 
but it doesn't. Vgabios compiled with that option still has other opcodes 
not supported by x86emu. As a workaround I've found there are real 16-bit 
version of the Bochs vgabios compiled with bcc available here: 
http://www.nongnu.org/vgabios/ which work with x86emu and can be used via 
-device ati-vga,romfile=VGABIOS-lgpl-latest.bin but this has the same 
problem with 0x5159 as well.

Regards,
BALATON Zoltan
