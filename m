Received: from eggs.gnu.org ([209.51.188.92]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GrS-0003gt-AY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GrQ-0005vL-JP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3GrQ-0005tT-Bw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:40 -0400
Date: Mon, 11 Mar 2019 10:04:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190311090435.7g5womfl6habq2ql@sirius.home.kraxel.org>
References: <20190309232719.43A8074862C@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309232719.43A8074862C@zero.eik.bme.hu>
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

On Sun, Mar 10, 2019 at 12:22:17AM +0100, BALATON Zoltan wrote:
> This adds DDC support to ati-vga and connects i2c-ddc to provide EDID
> info that is read by guests to find available screen modes. Not sure
> if this is 100% correct yet but at least MorphOS is happy with it and
> starts in a high resolution mode instead of 640x480 (although its
> splash screen is still not correct).

> Linux needs support from VESA
> vgabios, it seems to be missing INT10 0x4F15 function (see
> https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/vbe/vbe.c)
> without which no DDC is available that also prevents loading the
> accelerated X driver.

radeonfb doesn't pick up the edid either.
There seem to be four i2c busses though:

void radeon_create_i2c_busses(struct radeonfb_info *rinfo)
{
	rinfo->i2c[0].rinfo	= rinfo;
	rinfo->i2c[0].ddc_reg	= GPIO_MONID;
#ifndef CONFIG_PPC
	rinfo->i2c[0].adapter.class = I2C_CLASS_HWMON;
#endif
	radeon_setup_i2c_bus(&rinfo->i2c[0], "monid");

	rinfo->i2c[1].rinfo	= rinfo;
	rinfo->i2c[1].ddc_reg	= GPIO_DVI_DDC;
	radeon_setup_i2c_bus(&rinfo->i2c[1], "dvi");

	rinfo->i2c[2].rinfo	= rinfo;
	rinfo->i2c[2].ddc_reg	= GPIO_VGA_DDC;
	radeon_setup_i2c_bus(&rinfo->i2c[2], "vga");

	rinfo->i2c[3].rinfo	= rinfo;
	rinfo->i2c[3].ddc_reg	= GPIO_CRT2_DDC;
	radeon_setup_i2c_bus(&rinfo->i2c[3], "crt2");
}

aty128fb has no i2c support.

> Besides, this depends on bitbang_i2c.h which is now in hw/i2c so if
> including it from there is not desirable that may need to be moved
> somewhere.

include/hw/i2c/ looks like a sensible location to me.

cheers,
  Gerd
