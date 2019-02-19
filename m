Received: from eggs.gnu.org ([209.51.188.92]:39714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gw450-0006la-3E
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gw44m-0004pn-LN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:00:48 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gw44i-0004fV-8i
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:00:38 -0500
Date: Tue, 19 Feb 2019 13:00:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1902191234580.87875@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<20190219092223.5y2hx4m3myjkir6f@sirius.home.kraxel.org>
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

On Tue, 19 Feb 2019, Gerd Hoffmann wrote:
> On Mon, Feb 11, 2019 at 04:19:14AM +0100, BALATON Zoltan wrote:
>> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
>> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
>> guests running on these and the PMON2000 firmware of the fulong2e
>> expect this to be available. Fortunately these are very similar chips
>> so they can be mostly emulated in the same device model. This patch
>> adds basic emulation of these ATI VGA chips.
>>
>> While this is incomplete and currently only enough to run the MIPS
>> firmware and get console output with Linux,
>
> Which linux driver is this?

Those in linux/drivers/video/fbdev/aty/. This ati-vga model defaults to 
Rage 128 Pro (what PoweMac3,1 has, device id 0x5046) which is handled by 
the aty128fb driver under Linux. MIPS fulong2e has Mobility Radeon M6 
(RV100, device id 0x5159) that you can also use as -device 
ati-vga,device_id=0x5159 which is driven by radeonfb under Linux.

> If linux has a native driver it might make sense to also enable it on
> x86.  Makes testing easier.

Yes it could work on all archs under Linux but I've only enabled it on the 
two I've tried. It could be added instead to the same place where vga is 
added in pci.mak if you like.

> You can add the driver to default_list[] in vl.c, then you don't need
> -vga none to remove the default vga when adding -device ati-vga.

I could do that but since it's a bit unfinished (lacks advanced features 
such as video overlay, 3D accel, command FIFO, etc.) and only a basic 
implementation at the moment to work with Linux framebuffer that doesn't 
use these features I thought it might be a godd idea to make it a bit 
harder to access yet to avoid problem of someone trying it with a Windows 
guest with drivers from ATI which probably will result in bad picture. But 
it's up to you to decide if you want to add it to -vga option from the 
start or have it as optional device and only add to -vga when it's more 
fully implemented and tested.

Regards,
BALATON Zoltan
