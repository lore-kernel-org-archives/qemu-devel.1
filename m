Received: from eggs.gnu.org ([209.51.188.92]:40668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2Dvz-00009I-Ld
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2Dvx-0007mC-Ax
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:45:02 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:15372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h2Dvw-0007LQ-JC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:45:01 -0500
Date: Fri, 8 Mar 2019 12:44:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1903081225050.71488@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1903081243190.71488@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1903081225050.71488@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [RFC PATCH] ati-vga: Implement DDC and EDID info
 from monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On Fri, 8 Mar 2019, BALATON Zoltan wrote:
> I was thinking about something like this for adding DDC/EDID support that
> several clients seem to expect to get modes other than default 640x480 but
> it's not working yet correctly. Problems:
>
> 1. Compilation fails during linking if I don't have CONFIG_BITBANG_I2C and
> CONFIG_DDC in top level default-configs/*.mak even if I add these to
> pci.mak that's included by these and is where CONFIG_ATI_VGA is defined.
> So probably only compiles for ppc-softmmu at the moment.
>
> 2. Something is read from EDID but probably not correct as guests don't
> like it. Need to debug and check if bits are wired up correctly
>
> 3. Want to use bitbang_i2c from outside hw/i2c but that's currently
> private to that dir. We had to move the struct definition to the public
> header before to avoid a warning (in commit 2b4c1125ac), maybe we need to
> move all of bitbanh_i2c.h to include/hw/i2c.h now or make this header
> public reverting the previous patch. Which one you prefer?
>
> I may not have time to finish this before the freeze so if anyone can fix
> it feel free to take it and continue (drop me a note if you're taking it
> so we avoid duplicate work).
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/display/ati.c     | 24 ++++++++++++++++++++++--
> hw/display/ati_int.h |  4 ++++
> 2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 8322f52aff..6ea845d550 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -24,6 +24,8 @@
> #include "qapi/error.h"
> #include "hw/hw.h"
> #include "ui/console.h"
> +#include "hw/i2c/i2c-ddc.h"
> +#include "../i2c/bitbang_i2c.h"
> #include "trace.h"
>
> #define ATI_DEBUG_HW_CURSOR 0
> @@ -267,7 +269,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>     case DAC_CNTL:
>         val = s->regs.dac_cntl;
>         break;
> -/*    case GPIO_MONID: FIXME hook up DDC I2C here */
> +    case GPIO_MONID:
> +        val = s->regs.gpio_monid;
> +        break;
>     case PALETTE_INDEX:
>         /* FIXME unaligned access */
>         val = vga_ioport_read(&s->vga, VGA_PEL_IR) << 16;
> @@ -501,7 +505,17 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         s->regs.dac_cntl = data & 0xffffe3ff;
>         s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
>         break;
> -/*    case GPIO_MONID: FIXME hook up DDC I2C here */
> +    case GPIO_MONID:
> +        s->regs.gpio_monid = data & 0x000f000f;
> +        if (data & BIT(2) << 16) {

Reviewing my own patch, I think I have a bug here, it should be:

((data & BIT(2)) << 16)

> +            s->regs.gpio_monid |= bitbang_i2c_set(s->bbi2c, BITBANG_I2C_SCL,
> +                                                  (data & BIT(2)) != 0) << 10;
> +        }
> +        if (data & BIT(1) << 16) {

same here. With that it may work better but haven't tested.

Regards,
BALATON Zoltan

> +            s->regs.gpio_monid |= bitbang_i2c_set(s->bbi2c, BITBANG_I2C_SDA,
> +                                                  (data & BIT(1)) != 0) << 9;
> +        }
> +        break;
>     case PALETTE_INDEX ... PALETTE_INDEX + 3:
>         if (size == 4) {
>             vga_ioport_write(&s->vga, VGA_PEL_IR, (data >> 16) & 0xff);
> @@ -792,6 +806,12 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>         vga->cursor_draw_line = ati_cursor_draw_line;
>     }
>
> +    /* ddc, edid */
> +    s->ddc = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
> +    s->bbi2c = bitbang_i2c_init(s->ddc);
> +    I2CDDCState *i2cddc = I2CDDC(qdev_create(BUS(s->ddc), TYPE_I2CDDC));
> +    i2c_set_slave_address(I2C_SLAVE(i2cddc), 0x50);
> +
>     /* mmio register space */
>     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
>                           "ati.mmregs", 0x4000);
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index a6f3e20e63..1636f4d710 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -11,6 +11,7 @@
>
> #include "qemu/osdep.h"
> #include "hw/pci/pci.h"
> +#include "hw/i2c/i2c.h"
> #include "vga_int.h"
>
> /*#define DEBUG_ATI*/
> @@ -36,6 +37,7 @@ typedef struct ATIVGARegs {
>     uint32_t crtc_gen_cntl;
>     uint32_t crtc_ext_cntl;
>     uint32_t dac_cntl;
> +    uint32_t gpio_monid;
>     uint32_t crtc_h_total_disp;
>     uint32_t crtc_h_sync_strt_wid;
>     uint32_t crtc_v_total_disp;
> @@ -84,6 +86,8 @@ typedef struct ATIVGAState {
>     uint16_t cursor_size;
>     uint32_t cursor_offset;
>     QEMUCursor *cursor;
> +    I2CBus *ddc;
> +    bitbang_i2c_interface *bbi2c;
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
>
