Received: from eggs.gnu.org ([209.51.188.92]:59676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h3K8c-0001ar-J3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h3K5z-0004Do-Uj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:31:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:53616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h3K5z-0004Bz-Id
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:31:55 -0400
Date: Mon, 11 Mar 2019 13:31:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190311090435.7g5womfl6habq2ql@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1903111322170.47169@zero.eik.bme.hu>
References: <20190309232719.43A8074862C@zero.eik.bme.hu>
	<20190311090435.7g5womfl6habq2ql@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] ati-vga: Implement DDC and EDID info from
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, 11 Mar 2019, Gerd Hoffmann wrote:
> On Sun, Mar 10, 2019 at 12:22:17AM +0100, BALATON Zoltan wrote:
>> This adds DDC support to ati-vga and connects i2c-ddc to provide EDID
>> info that is read by guests to find available screen modes. Not sure
>> if this is 100% correct yet but at least MorphOS is happy with it and
>> starts in a high resolution mode instead of 640x480 (although its
>> splash screen is still not correct).
>
>> Linux needs support from VESA
>> vgabios, it seems to be missing INT10 0x4F15 function (see
>> https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/vbe/vbe.c)
>> without which no DDC is available that also prevents loading the
>> accelerated X driver.
>
> radeonfb doesn't pick up the edid either.
> There seem to be four i2c busses though:
>
> void radeon_create_i2c_busses(struct radeonfb_info *rinfo)
> {
> 	rinfo->i2c[0].rinfo	= rinfo;
> 	rinfo->i2c[0].ddc_reg	= GPIO_MONID;
> #ifndef CONFIG_PPC
> 	rinfo->i2c[0].adapter.class = I2C_CLASS_HWMON;
> #endif
> 	radeon_setup_i2c_bus(&rinfo->i2c[0], "monid");
>
> 	rinfo->i2c[1].rinfo	= rinfo;
> 	rinfo->i2c[1].ddc_reg	= GPIO_DVI_DDC;
> 	radeon_setup_i2c_bus(&rinfo->i2c[1], "dvi");
>
> 	rinfo->i2c[2].rinfo	= rinfo;
> 	rinfo->i2c[2].ddc_reg	= GPIO_VGA_DDC;
> 	radeon_setup_i2c_bus(&rinfo->i2c[2], "vga");
>
> 	rinfo->i2c[3].rinfo	= rinfo;
> 	rinfo->i2c[3].ddc_reg	= GPIO_CRT2_DDC;
> 	radeon_setup_i2c_bus(&rinfo->i2c[3], "crt2");
> }
>
> aty128fb has no i2c support.

On rage128p I think there's only GPIO_MONID where there are 4 pins that 
can have 2 i2c busses. I think they are DDC for CRT and flat-panel ports 
but not sure about that. So what it's missing is i2c for hw monitoring 
which the GPIO_MONID may be used for on radeon according to the above.

The r128 xorg driver complains about missing support in VESA VBE as quoted 
above and unloads itself. I think it may work if that support is 
implemented in vgabios which I hope you can look at as I have no 
experience with vgabios.

For radeon the DDC may need to be added on the GPIO_VGA_PORT as well based 
on the above code excerpt but I haven't checked that.

>> Besides, this depends on bitbang_i2c.h which is now in hw/i2c so if
>> including it from there is not desirable that may need to be moved
>> somewhere.
>
> include/hw/i2c/ looks like a sensible location to me.

The i2c_bitbang.h could be merged with include/i2c/i2c.h where a line 
from it was already moved before or it could be moved to include/hw/i2c 
and revert previous change and adjust its users again. I'm inclined to 
just merge it with i2c.h but not sure who is to decide about this. The 
bitbang i2c does not seem to have a maintainer.

Regards,
BALATON Zoltan
