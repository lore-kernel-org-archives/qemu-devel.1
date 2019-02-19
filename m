Received: from eggs.gnu.org ([209.51.188.92]:57437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gw73J-0007QC-MO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gw73G-0005uP-LU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:11:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:42859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gw73G-0005tZ-1e
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:11:18 -0500
Date: Tue, 19 Feb 2019 16:11:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190219123052.dop3kpgowi2apitq@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1902191449400.24309@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
	<20190219123052.dop3kpgowi2apitq@sirius.home.kraxel.org>
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

On Tue, 19 Feb 2019, Gerd Hoffmann wrote:
>>> Which linux driver is this?
>>
>> Those in linux/drivers/video/fbdev/aty/. This ati-vga model defaults to Rage
>> 128 Pro (what PoweMac3,1 has, device id 0x5046) which is handled by the
>> aty128fb driver under Linux. MIPS fulong2e has Mobility Radeon M6 (RV100,
>> device id 0x5159) that you can also use as -device ati-vga,device_id=0x5159
>> which is driven by radeonfb under Linux.
>
> So it could be tested with linux guests on x86 too I guess?
> Can the radeon drm driver handle the devices too?

Yes you can try with x86 guests, I haven't tested that yet. The radeon 
driver only supports RV100 and up I think so may only work with the 0x5159 
variant not with Rage 128 Pro which had another driver r128 but not sure 
that still exists. Although these two chips are similar, Rage 128 Pro is a 
bit simpler that's why I'm targeting it first and also that's what the 
PowerMac3,1 (the ppc mac99 machine is converging to) has. The R128Pro is 
the last of the previous generation before Radeon, while RV100 is the 
stripped down simplest version of the R100 family which has some more 3D 
capability). But even if the DRM driver loads, probably only the mode 
setting part is useful at the moment as 3D is not implemented yet by this 
device model. So not sure how useful that is at the moment. (It was tested 
that MacOS X can load the low level driver probably similar to Linux DRM:
https://www.emaculation.com/forum/viewtopic.php?f=34&t=7047&sid=7daa827c3e3d44ae7927a4ef900790bd&start=2025#p62215
but the high level rendering driver does not work yet. This was with v1 of 
this patch, I've made some fixes in v2 but likely that's not enough yet.)

I haven't thought about 3D yet as it's too early for that but for planning 
I know that the Xenia XBox 360 emulator (https://xenia.jp/) has some 
emulation of the Xenos chip 
https://en.wikipedia.org/wiki/Xenos_(graphics_chip) which is like the last 
of the Radeon family started with R100 so probably has way more features 
than needed for RV100 so we could emulate that similarly or even get up to 
later Radeons based on that in the future. We may look there for 
inspiration and maybe even code (altough have to convert from C++ and it 
only seems to care about the 3D part of the chip as the legacy stuff is 
missing from or not used in the XBox). So I've worked mostly on the legacy 
part and 2D for now and left 3D for later but unlikely that I'll be able 
to do that anytime soon so if someone is interested to take that up it 
would be very welcome. This should go into the yet missing ati_3d.c.

> I'd also use model=<name> instead of device_id=... to switch between
> different devices.

The only problem with that is that there are this many versions with 
confusing names (and maybe different device ids for different versions):

https://www.x.org/wiki/RadeonFeature/#index5h2

so the only really good way to identify a chip is via device_id. This is 
not user friendly but at this stage probably will do and we can add 
alternative model property later which aliases some device ids (like it's 
done for CPU selection). Just to avoid confusion between e.g. R128, R128P, 
RV100, Radeon7000, MobilityM6, R100 some of which refer to the same and 
some are different models.

(This table above is part of the X.org ATI page that has some useful info 
and also the Arch Linux https://wiki.archlinux.org/index.php/ATI page may 
have info about Linux drivers for these cards.)

>>> You can add the driver to default_list[] in vl.c, then you don't need
>>> -vga none to remove the default vga when adding -device ati-vga.
>>
>> I could do that but since it's a bit unfinished (lacks advanced features
>> such as video overlay, 3D accel, command FIFO, etc.) and only a basic
>> implementation at the moment to work with Linux framebuffer that doesn't use
>> these features I thought it might be a godd idea to make it a bit harder to
>> access yet to avoid problem of someone trying it with a Windows guest with
>> drivers from ATI which probably will result in bad picture. But it's up to
>> you to decide if you want to add it to -vga option from the start or have it
>> as optional device and only add to -vga when it's more fully implemented and
>> tested.
>
> It's not about "-vga ati".  This is about adding ati-vga to the list of
> display devices, so qemu will not try to add a vga automatically in case
> it finds "-device ati-vga" on the command line.  That way "qemu -device
> ati-vga" will work fine, without "-vga none".
>
> Adding -vga ati indeed only makes sense once the implementation is more
> complete.

OK I thought those are related but if adding it to the default_list[] 
won't automatically add a -vga option then that's a good idea. I'll do 
that and also move the config lines to pci.mak in next version but wait 
for a few more days for more comments.

Regards,
BALATON Zoltan
