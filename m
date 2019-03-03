Received: from eggs.gnu.org ([209.51.188.92]:60316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1h0TRX-0003rk-9I
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1h0TEI-00039P-Jl
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:40:49 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1h0TEI-000357-5O
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:40:42 -0500
Received: by mail-ot1-x343.google.com with SMTP id t7so2180762otk.8
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 07:40:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190303000025.3496D7456A0@zero.eik.bme.hu>
References: <20190303000025.3496D7456A0@zero.eik.bme.hu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 3 Mar 2019 16:40:39 +0100
Message-ID: <CAL1e-=iV_0Fak=_QjzxgU-eWqG6hkVYgEbwaDKc4MT3MkGu=Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@redhat.com" <philmd@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>

On Sunday, March 3, 2019, BALATON Zoltan <balaton@eik.bme.hu> wrote:

> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
> guests running on these and the PMON2000 firmware of the fulong2e
> expect this to be available. Fortunately these are very similar chips
> so they can be mostly emulated in the same device model. This patch
> adds basic emulation of these ATI VGA chips.


I am not familiar enough with display/graphics code in QEMU to give this
patch an official "reviewed-by", but from the standpoint of MIPS (Fulong 2E
is a MIPS-based board), this patch is a desirable one, and we want it, if
possible, even before March 12th (the planned soft freeze date). Though, I
am not rushing anyone in any way. So, FWIW:

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> While this is incomplete and currently only enough to run the MIPS
> firmware and get framebuffer output with Linux, it allows the fulong2e
> board to work more like the real hardware and having it in QEMU in
> this state provides a way to experiment with it and allows others to
> contribute to improve it. It is compiled for all archs but only the
> fulong2e (which currently has no display output at all) is set to use
> it by default (in a patch sent separately).
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v4:
> - fix mingw build (from Gerd)
> - set dev_id in realize to allow pci_patch_ids to change bios rom
> - add model aliases to select device variant by name instead of id
> - misc mode switch and 2d fixes (better but still not quite right)
>
> v3:
> - add to default-configs/pci.mak instead of mips64el and ppc only
> - rename device_id property to x-device-id
> - use extract32/deposit32 in *_offs functions
> - add ati-vga to vl.c default_list[]
>
> v2:
> - Extended debug logs
> - Fix mode switching and some registers
> - Fixes to 2D functions
>
>  default-configs/pci.mak  |   1 +
>  hw/display/Makefile.objs |   2 +
>  hw/display/ati.c         | 686 ++++++++++++++++++++++++++++++
> +++++++++++++++++
>  hw/display/ati_2d.c      | 134 +++++++++
>  hw/display/ati_dbg.c     | 254 ++++++++++++++++++
>  hw/display/ati_int.h     |  87 ++++++
>  hw/display/ati_regs.h    | 456 +++++++++++++++++++++++++++++++
>  hw/display/trace-events  |   4 +
>  vl.c                     |   1 +
>  9 files changed, 1625 insertions(+)
>  create mode 100644 hw/display/ati.c
>  create mode 100644 hw/display/ati_2d.c
>  create mode 100644 hw/display/ati_dbg.c
>  create mode 100644 hw/display/ati_int.h
>  create mode 100644 hw/display/ati_regs.h
>
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index 037636fa33..e59e2fa7b6 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -49,3 +49,4 @@ CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
>  CONFIG_ROCKER=y
>  CONFIG_VFIO=$(CONFIG_LINUX)
>  CONFIG_VFIO_PCI=y
> +CONFIG_ATI_VGA=y
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 7c4ae9a0fd..963c23f3c8 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -53,3 +53,5 @@ virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
>  virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
>  obj-$(CONFIG_DPCD) += dpcd.o
>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
> +
> +obj-$(CONFIG_ATI_VGA) += ati.o ati_2d.o ati_dbg.o
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> new file mode 100644
> index 0000000000..72dd9b4953
> --- /dev/null
> +++ b/hw/display/ati.c
> @@ -0,0 +1,686 @@
> +/*
> + * QEMU ATI SVGA emulation
> + *
> + * Copyright (c) 2019 BALATON Zoltan
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + */
> +
> +/*
> + * WARNING:
> + * This is very incomplete and only enough for Linux console and some
> + * unaccelerated X output at the moment.
> + * Currently it's little more than a frame buffer with minimal functions,
> + * other more advanced features of the hardware are yet to be implemented.
> + * We only aim for Rage 128 Pro (and some RV100) and 2D only at first,
> + * No 3D at all yet (maybe after 2D works, but feel free to improve it)
> + */
> +
> +#include "ati_int.h"
> +#include "ati_regs.h"
> +#include "vga_regs.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "ui/console.h"
> +#include "trace.h"
> +
> +static struct {
> +    const char *name;
> +    uint16_t dev_id;
> +} ati_model_aliases[] = {
> +    { "rage128p", PCI_DEVICE_ID_ATI_RAGE128_PF },
> +    { "rv100", PCI_DEVICE_ID_ATI_RADEON_QY },
> +};
> +
> +enum { VGA_MODE, EXT_MODE };
> +
> +static void ati_vga_switch_mode(ATIVGAState *s)
> +{
> +    DPRINTF("%d -> %d\n",
> +            s->mode, !!(s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN));
> +    if (s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN) {
> +        /* Extended mode enabled */
> +        s->mode = EXT_MODE;
> +        if (s->regs.crtc_gen_cntl & CRTC2_EN) {
> +            /* CRT controller enabled, use CRTC values */
> +            uint32_t offs = s->regs.crtc_offset & 0x07ffffff;
> +            int stride = (s->regs.crtc_pitch & 0x7ff) * 8;
> +            int bpp = 0;
> +            int h, v;
> +
> +            if (s->regs.crtc_h_total_disp == 0) {
> +                s->regs.crtc_h_total_disp = ((640 / 8) - 1) << 16;
> +            }
> +            if (s->regs.crtc_v_total_disp == 0) {
> +                s->regs.crtc_v_total_disp = (480 - 1) << 16;
> +            }
> +            h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
> +            v = (s->regs.crtc_v_total_disp >> 16) + 1;
> +            switch (s->regs.crtc_gen_cntl & CRTC_PIX_WIDTH_MASK) {
> +            case CRTC_PIX_WIDTH_4BPP:
> +                bpp = 4;
> +                break;
> +            case CRTC_PIX_WIDTH_8BPP:
> +                bpp = 8;
> +                break;
> +            case CRTC_PIX_WIDTH_15BPP:
> +                bpp = 15;
> +                break;
> +            case CRTC_PIX_WIDTH_16BPP:
> +                bpp = 16;
> +                break;
> +            case CRTC_PIX_WIDTH_24BPP:
> +                bpp = 24;
> +                break;
> +            case CRTC_PIX_WIDTH_32BPP:
> +                bpp = 32;
> +                break;
> +            default:
> +                qemu_log_mask(LOG_UNIMP, "Unsupported bpp value");
> +            }
> +            assert(bpp != 0);
> +            DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp,
> offs);
> +            vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
> +            vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
> +            /* reset VBE regs then set up mode */
> +            s->vga.vbe_regs[VBE_DISPI_INDEX_XRES] = h;
> +            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] = v;
> +            s->vga.vbe_regs[VBE_DISPI_INDEX_BPP] = bpp;
> +            /* enable mode via ioport so it updates vga regs */
> +            vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
> +            vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_ENABLED |
> +                VBE_DISPI_LFB_ENABLED | VBE_DISPI_NOCLEARMEM |
> +                (s->regs.dac_cntl & DAC_8BIT_EN ? VBE_DISPI_8BIT_DAC :
> 0));
> +            /* now set offset and stride after enable as that resets
> these */
> +            if (stride) {
> +                vbe_ioport_write_index(&s->vga, 0,
> VBE_DISPI_INDEX_VIRT_WIDTH);
> +                vbe_ioport_write_data(&s->vga, 0, stride);
> +                if (offs % stride == 0) {
> +                    vbe_ioport_write_index(&s->vga, 0,
> VBE_DISPI_INDEX_Y_OFFSET);
> +                    vbe_ioport_write_data(&s->vga, 0, offs / stride);
> +                } else {
> +                    /* FIXME what to do with this? */
> +                    error_report("VGA offset is not multiple of pitch, "
> +                                 "expect bad picture");
> +                }
> +            }
> +        }
> +    } else {
> +        /* VGA mode enabled */
> +        s->mode = VGA_MODE;
> +        vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
> +        vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
> +    }
> +}
> +
> +static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
> +                                         unsigned int size)
> +{
> +    if (offs == 0 && size == 4) {
> +        return reg;
> +    } else {
> +        return extract32(reg, offs * BITS_PER_BYTE, size * BITS_PER_BYTE);
> +    }
> +}
> +
> +static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    ATIVGAState *s = opaque;
> +    uint64_t val = 0;
> +
> +    switch (addr) {
> +    case MM_INDEX:
> +        val = s->regs.mm_index;
> +        break;
> +    case MM_DATA ... MM_DATA + 3:
> +        /* indexed access to regs or memory */
> +        if (s->regs.mm_index & 0x80000000) {
> +            if (s->regs.mm_index <= s->vga.vram_size - size) {
> +                int i = size - 1;
> +                while (i >= 0) {
> +                    val <<= 8;
> +                    val |= s->vga.vram_ptr[s->regs.mm_index + i--];
> +                }
> +            }
> +        } else {
> +            val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
> +        }
> +        break;
> +    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
> +    {
> +        int i = (addr - BIOS_0_SCRATCH) / 4;
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
> +            break;
> +        }
> +        val = ati_reg_read_offs(s->regs.bios_scratch[i],
> +                                addr - (BIOS_0_SCRATCH + i * 4), size);
> +        break;
> +    }
> +    case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
> +        val = ati_reg_read_offs(s->regs.crtc_gen_cntl,
> +                                addr - CRTC_GEN_CNTL, size);
> +        break;
> +    case CRTC_EXT_CNTL ... CRTC_EXT_CNTL + 3:
> +        val = ati_reg_read_offs(s->regs.crtc_ext_cntl,
> +                                addr - CRTC_EXT_CNTL, size);
> +        break;
> +    case DAC_CNTL:
> +        val = s->regs.dac_cntl;
> +        break;
> +/*    case GPIO_MONID: FIXME hook up DDC I2C here */
> +    case PALETTE_INDEX:
> +        /* FIXME unaligned access */
> +        val = vga_ioport_read(&s->vga, VGA_PEL_IR) << 16;
> +        val |= vga_ioport_read(&s->vga, VGA_PEL_IW) & 0xff;
> +        break;
> +    case PALETTE_DATA:
> +        val = vga_ioport_read(&s->vga, VGA_PEL_D);
> +        break;
> +    case CNFG_MEMSIZE:
> +        val = s->vga.vram_size;
> +        break;
> +    case MC_STATUS:
> +        val = 5;
> +        break;
> +    case RBBM_STATUS:
> +    case GUI_STAT:
> +        val = 64; /* free CMDFIFO entries */
> +        break;
> +    case CRTC_H_TOTAL_DISP:
> +        val = s->regs.crtc_h_total_disp;
> +        break;
> +    case CRTC_H_SYNC_STRT_WID:
> +        val = s->regs.crtc_h_sync_strt_wid;
> +        break;
> +    case CRTC_V_TOTAL_DISP:
> +        val = s->regs.crtc_v_total_disp;
> +        break;
> +    case CRTC_V_SYNC_STRT_WID:
> +        val = s->regs.crtc_v_sync_strt_wid;
> +        break;
> +    case CRTC_OFFSET:
> +        val = s->regs.crtc_offset;
> +        break;
> +    case CRTC_OFFSET_CNTL:
> +        val = s->regs.crtc_offset_cntl;
> +        break;
> +    case CRTC_PITCH:
> +        val = s->regs.crtc_pitch;
> +        break;
> +    case 0xf00 ... 0xfff:
> +        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
> +        break;
> +    case DST_OFFSET:
> +        val = s->regs.dst_offset;
> +        break;
> +    case DST_PITCH:
> +        val = s->regs.dst_pitch;
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            val &= s->regs.dst_tile << 16;
> +        }
> +        break;
> +    case DST_WIDTH:
> +        val = s->regs.dst_width;
> +        break;
> +    case DST_HEIGHT:
> +        val = s->regs.dst_height;
> +        break;
> +    case SRC_X:
> +        val = s->regs.src_x;
> +        break;
> +    case SRC_Y:
> +        val = s->regs.src_y;
> +        break;
> +    case DST_X:
> +        val = s->regs.dst_x;
> +        break;
> +    case DST_Y:
> +        val = s->regs.dst_y;
> +        break;
> +    case DP_GUI_MASTER_CNTL:
> +        val = s->regs.dp_gui_master_cntl;
> +        break;
> +    case SRC_OFFSET:
> +        val = s->regs.src_offset;
> +        break;
> +    case SRC_PITCH:
> +        val = s->regs.src_pitch;
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            val &= s->regs.src_tile << 16;
> +        }
> +        break;
> +    case DP_BRUSH_BKGD_CLR:
> +        val = s->regs.dp_brush_bkgd_clr;
> +        break;
> +    case DP_BRUSH_FRGD_CLR:
> +        val = s->regs.dp_brush_frgd_clr;
> +        break;
> +    case DP_SRC_FRGD_CLR:
> +        val = s->regs.dp_src_frgd_clr;
> +        break;
> +    case DP_SRC_BKGD_CLR:
> +        val = s->regs.dp_src_bkgd_clr;
> +        break;
> +    case DP_CNTL:
> +        val = s->regs.dp_cntl;
> +        break;
> +    case DP_DATATYPE:
> +        val = s->regs.dp_datatype;
> +        break;
> +    case DP_MIX:
> +        val = s->regs.dp_mix;
> +        break;
> +    case DP_WRITE_MASK:
> +        val = s->regs.dp_write_mask;
> +        break;
> +    case DEFAULT_OFFSET:
> +        val = s->regs.default_offset;
> +        break;
> +    case DEFAULT_PITCH:
> +        val = s->regs.default_pitch;
> +        break;
> +    case DEFAULT_SC_BOTTOM_RIGHT:
> +        val = s->regs.default_sc_bottom_right;
> +        break;
> +    default:
> +        break;
> +    }
> +    trace_ati_mm_read(size, addr, ati_reg_name(addr & ~3ULL), val);
> +
> +    return val;
> +}
> +
> +static inline void ati_reg_write_offs(uint32_t *reg, int offs,
> +                                      uint64_t data, unsigned int size)
> +{
> +    if (offs == 0 && size == 4) {
> +        *reg = data;
> +    } else {
> +        *reg = deposit32(*reg, offs * BITS_PER_BYTE, size * BITS_PER_BYTE,
> +                         data);
> +    }
> +}
> +
> +static void ati_mm_write(void *opaque, hwaddr addr,
> +                           uint64_t data, unsigned int size)
> +{
> +    ATIVGAState *s = opaque;
> +
> +    trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
> +    switch (addr) {
> +    case MM_INDEX:
> +        s->regs.mm_index = data;
> +        break;
> +    case MM_DATA ... MM_DATA + 3:
> +        /* indexed access to regs or memory */
> +        if (s->regs.mm_index & 0x80000000) {
> +            if (s->regs.mm_index <= s->vga.vram_size - size) {
> +                int i = 0;
> +                while (i < size) {
> +                    s->vga.vram_ptr[s->regs.mm_index + i] = data & 0xff;
> +                    data >>= 8;
> +                }
> +            }
> +        } else {
> +            ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data,
> size);
> +        }
> +        break;
> +    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
> +    {
> +        int i = (addr - BIOS_0_SCRATCH) / 4;
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
> +            break;
> +        }
> +        ati_reg_write_offs(&s->regs.bios_scratch[i],
> +                           addr - (BIOS_0_SCRATCH + i * 4), data, size);
> +        break;
> +    }
> +    case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
> +    {
> +        uint32_t val = s->regs.crtc_gen_cntl;
> +        ati_reg_write_offs(&s->regs.crtc_gen_cntl,
> +                           addr - CRTC_GEN_CNTL, data, size);
> +        if ((val & (CRTC2_EXT_DISP_EN | CRTC2_EN)) !=
> +            (s->regs.crtc_gen_cntl & (CRTC2_EXT_DISP_EN | CRTC2_EN))) {
> +            ati_vga_switch_mode(s);
> +        }
> +        break;
> +    }
> +    case CRTC_EXT_CNTL ... CRTC_EXT_CNTL + 3:
> +    {
> +        uint32_t val = s->regs.crtc_ext_cntl;
> +        ati_reg_write_offs(&s->regs.crtc_ext_cntl,
> +                           addr - CRTC_EXT_CNTL, data, size);
> +        if (s->regs.crtc_ext_cntl & CRT_CRTC_DISPLAY_DIS) {
> +            DPRINTF("Display disabled\n");
> +            s->vga.ar_index &= ~0x20;
> +        } else {
> +            DPRINTF("Display enabled\n");
> +            s->vga.ar_index |= 0x20;
> +            ati_vga_switch_mode(s);
> +        }
> +        if ((val & CRT_CRTC_DISPLAY_DIS) !=
> +            (s->regs.crtc_ext_cntl & CRT_CRTC_DISPLAY_DIS)) {
> +            ati_vga_switch_mode(s);
> +        }
> +        break;
> +    }
> +    case DAC_CNTL:
> +        s->regs.dac_cntl = data & 0xffffe3ff;
> +        s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
> +        break;
> +/*    case GPIO_MONID: FIXME hook up DDC I2C here */
> +    case PALETTE_INDEX ... PALETTE_INDEX + 3:
> +        if (size == 4) {
> +            vga_ioport_write(&s->vga, VGA_PEL_IR, (data >> 16) & 0xff);
> +            vga_ioport_write(&s->vga, VGA_PEL_IW, data & 0xff);
> +        } else {
> +            if (addr == PALETTE_INDEX) {
> +                vga_ioport_write(&s->vga, VGA_PEL_IW, data & 0xff);
> +            } else {
> +                vga_ioport_write(&s->vga, VGA_PEL_IR, data & 0xff);
> +            }
> +        }
> +        break;
> +    case PALETTE_DATA ... PALETTE_DATA + 3:
> +        data <<= addr - PALETTE_DATA;
> +        data = bswap32(data) >> 8;
> +        vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
> +        data >>= 8;
> +        vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
> +        data >>= 8;
> +        vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
> +        break;
> +    case CRTC_H_TOTAL_DISP:
> +        s->regs.crtc_h_total_disp = data & 0x07ff07ff;
> +        break;
> +    case CRTC_H_SYNC_STRT_WID:
> +        s->regs.crtc_h_sync_strt_wid = data & 0x17bf1fff;
> +        break;
> +    case CRTC_V_TOTAL_DISP:
> +        s->regs.crtc_v_total_disp = data & 0x0fff0fff;
> +        break;
> +    case CRTC_V_SYNC_STRT_WID:
> +        s->regs.crtc_v_sync_strt_wid = data & 0x9f0fff;
> +        break;
> +    case CRTC_OFFSET:
> +        s->regs.crtc_offset = data & 0xc7ffffff;
> +        break;
> +    case CRTC_OFFSET_CNTL:
> +        s->regs.crtc_offset_cntl = data; /* FIXME */
> +        break;
> +    case CRTC_PITCH:
> +        s->regs.crtc_pitch = data & 0x07ff07ff;
> +        break;
> +    case 0xf00 ... 0xfff:
> +        /* read-only copy of PCI config space so ignore writes */
> +        break;
> +    case DST_OFFSET:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.dst_offset = data & 0xfffffff0;
> +        } else {
> +            s->regs.dst_offset = data & 0xfffffc00;
> +        }
> +        break;
> +    case DST_PITCH:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.dst_pitch = data & 0x3fff;
> +            s->regs.dst_tile = (data >> 16) & 1;
> +        } else {
> +            s->regs.dst_pitch = data & 0x3ff0;
> +        }
> +        break;
> +    case DST_TILE:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {
> +            s->regs.dst_tile = data & 3;
> +        }
> +        break;
> +    case DST_WIDTH:
> +        s->regs.dst_width = data & 0x3fff;
> +        ati_2d_blit(s);
> +        break;
> +    case DST_HEIGHT:
> +        s->regs.dst_height = data & 0x3fff;
> +        break;
> +    case SRC_X:
> +        s->regs.src_x = data & 0x3fff;
> +        break;
> +    case SRC_Y:
> +        s->regs.src_y = data & 0x3fff;
> +        break;
> +    case DST_X:
> +        s->regs.dst_x = data & 0x3fff;
> +        break;
> +    case DST_Y:
> +        s->regs.dst_y = data & 0x3fff;
> +        break;
> +    case SRC_PITCH_OFFSET:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.src_offset = (data & 0x1fffff) << 5;
> +            s->regs.src_pitch = (data >> 21) & 0x3ff;
> +            s->regs.src_tile = data >> 31;
> +        } else {
> +            s->regs.src_offset = (data & 0x3fffff) << 11;
> +            s->regs.src_pitch = (data & 0x3fc00000) >> 16;
> +            s->regs.src_tile = (data >> 30) & 1;
> +        }
> +        break;
> +    case DST_PITCH_OFFSET:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.dst_offset = (data & 0x1fffff) << 5;
> +            s->regs.dst_pitch = (data >> 21) & 0x3ff;
> +            s->regs.dst_tile = data >> 31;
> +        } else {
> +            s->regs.dst_offset = (data & 0x3fffff) << 11;
> +            s->regs.dst_pitch = (data & 0x3fc00000) >> 16;
> +            s->regs.dst_tile = data >> 30;
> +        }
> +        break;
> +    case SRC_Y_X:
> +        s->regs.src_x = data & 0x3fff;
> +        s->regs.src_y = (data >> 16) & 0x3fff;
> +        break;
> +    case DST_Y_X:
> +        s->regs.dst_x = data & 0x3fff;
> +        s->regs.dst_y = (data >> 16) & 0x3fff;
> +        break;
> +    case DST_HEIGHT_WIDTH:
> +        s->regs.dst_width = data & 0x3fff;
> +        s->regs.dst_height = (data >> 16) & 0x3fff;
> +        ati_2d_blit(s);
> +        break;
> +    case DP_GUI_MASTER_CNTL:
> +        s->regs.dp_gui_master_cntl = data & 0xf800000f;
> +        s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4
> |
> +                              (data & 0x4000) << 16;
> +        s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >>
> 16;
> +        break;
> +    case DST_WIDTH_X:
> +        s->regs.dst_x = data & 0x3fff;
> +        s->regs.dst_width = (data >> 16) & 0x3fff;
> +        ati_2d_blit(s);
> +        break;
> +    case SRC_X_Y:
> +        s->regs.src_y = data & 0x3fff;
> +        s->regs.src_x = (data >> 16) & 0x3fff;
> +        break;
> +    case DST_X_Y:
> +        s->regs.dst_y = data & 0x3fff;
> +        s->regs.dst_x = (data >> 16) & 0x3fff;
> +        break;
> +    case DST_WIDTH_HEIGHT:
> +        s->regs.dst_height = data & 0x3fff;
> +        s->regs.dst_width = (data >> 16) & 0x3fff;
> +        ati_2d_blit(s);
> +        break;
> +    case DST_HEIGHT_Y:
> +        s->regs.dst_y = data & 0x3fff;
> +        s->regs.dst_height = (data >> 16) & 0x3fff;
> +        break;
> +    case SRC_OFFSET:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.src_offset = data & 0xfffffff0;
> +        } else {
> +            s->regs.src_offset = data & 0xfffffc00;
> +        }
> +        break;
> +    case SRC_PITCH:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.src_pitch = data & 0x3fff;
> +            s->regs.src_tile = (data >> 16) & 1;
> +        } else {
> +            s->regs.src_pitch = data & 0x3ff0;
> +        }
> +        break;
> +    case DP_BRUSH_BKGD_CLR:
> +        s->regs.dp_brush_bkgd_clr = data;
> +        break;
> +    case DP_BRUSH_FRGD_CLR:
> +        s->regs.dp_brush_frgd_clr = data;
> +        break;
> +    case DP_CNTL:
> +        s->regs.dp_cntl = data;
> +        break;
> +    case DP_DATATYPE:
> +        s->regs.dp_datatype = data & 0xe0070f0f;
> +        break;
> +    case DP_MIX:
> +        s->regs.dp_mix = data & 0x00ff0700;
> +        break;
> +    case DP_WRITE_MASK:
> +        s->regs.dp_write_mask = data;
> +        break;
> +    case DEFAULT_OFFSET:
> +        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
> +                 0x03fffc00 : 0xfffffc00);
> +        s->regs.default_offset = data;
> +        break;
> +    case DEFAULT_PITCH:
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.default_pitch = data & 0x103ff;
> +        }
> +        break;
> +    case DEFAULT_SC_BOTTOM_RIGHT:
> +        s->regs.default_sc_bottom_right = data & 0x3fff3fff;
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps ati_mm_ops = {
> +    .read = ati_mm_read,
> +    .write = ati_mm_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void ati_vga_realize(PCIDevice *dev, Error **errp)
> +{
> +    ATIVGAState *s = ATI_VGA(dev);
> +    VGACommonState *vga = &s->vga;
> +
> +    if (s->model) {
> +        int i;
> +        for (i = 0; i < ARRAY_SIZE(ati_model_aliases); i++) {
> +            if (!strcmp(s->model, ati_model_aliases[i].name)) {
> +                s->dev_id = ati_model_aliases[i].dev_id;
> +                break;
> +            }
> +        }
> +        if (i >= ARRAY_SIZE(ati_model_aliases)) {
> +            warn_report("Unknown ATI VGA model name, "
> +                        "using default rage128p");
> +        }
> +    }
> +    if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF &&
> +        s->dev_id != PCI_DEVICE_ID_ATI_RADEON_QY) {
> +        error_setg(errp, "Unknown ATI VGA device id, "
> +                   "only 0x5046 and 0x5159 are supported");
> +        return;
> +    }
> +    pci_set_word(dev->config + PCI_DEVICE_ID, s->dev_id);
> +
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY &&
> +        s->vga.vram_size_mb < 16) {
> +        warn_report("Too small video memory for device id");
> +        s->vga.vram_size_mb = 16;
> +    }
> +
> +    /* init vga compat bits */
> +    vga_common_init(vga, OBJECT(s));
> +    vga_init(vga, OBJECT(s), pci_address_space(dev),
> +             pci_address_space_io(dev), true);
> +    vga->con = graphic_console_init(DEVICE(s), 0, s->vga.hw_ops,
> &s->vga);
> +
> +    /* mmio register space */
> +    memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
> +                          "ati.mmregs", 0x4000);
> +    /* io space is alias to beginning of mmregs */
> +    memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0,
> 0x100);
> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
> +    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
> +    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
> +}
> +
> +static void ati_vga_reset(DeviceState *dev)
> +{
> +    ATIVGAState *s = ATI_VGA(dev);
> +
> +    /* reset vga */
> +    vga_common_reset(&s->vga);
> +    s->mode = VGA_MODE;
> +}
> +
> +static void ati_vga_exit(PCIDevice *dev)
> +{
> +    ATIVGAState *s = ATI_VGA(dev);
> +
> +    graphic_console_close(s->vga.con);
> +}
> +
> +static Property ati_vga_properties[] = {
> +    DEFINE_PROP_UINT32("vgamem_mb", ATIVGAState, vga.vram_size_mb, 16),
> +    DEFINE_PROP_STRING("model", ATIVGAState, model),
> +    DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
> +                       PCI_DEVICE_ID_ATI_RAGE128_PF),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void ati_vga_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    dc->reset = ati_vga_reset;
> +    dc->props = ati_vga_properties;
> +    dc->hotpluggable = false;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +
> +    k->class_id = PCI_CLASS_DISPLAY_VGA;
> +    k->vendor_id = PCI_VENDOR_ID_ATI;
> +    k->device_id = PCI_DEVICE_ID_ATI_RAGE128_PF;
> +    k->romfile = "vgabios-stdvga.bin";
> +    k->realize = ati_vga_realize;
> +    k->exit = ati_vga_exit;
> +}
> +
> +static const TypeInfo ati_vga_info = {
> +    .name = TYPE_ATI_VGA,
> +    .parent = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(ATIVGAState),
> +    .class_init = ati_vga_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +          { },
> +    },
> +};
> +
> +static void ati_vga_register_types(void)
> +{
> +    type_register_static(&ati_vga_info);
> +}
> +
> +type_init(ati_vga_register_types)
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> new file mode 100644
> index 0000000000..711c8074d3
> --- /dev/null
> +++ b/hw/display/ati_2d.c
> @@ -0,0 +1,134 @@
> +/*
> + * QEMU ATI SVGA emulation
> + * 2D engine functions
> + *
> + * Copyright (c) 2019 BALATON Zoltan
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + */
> +
> +#include "ati_int.h"
> +#include "ati_regs.h"
> +#include "qemu/log.h"
> +#include "ui/pixel_ops.h"
> +
> +/*
> + * NOTE:
> + * This is 2D _acceleration_ and supposed to be fast. Therefore, don't
> try to
> + * reinvent the wheel (unlikely to get better with a naive implementation
> than
> + * existing libraries) and avoid (poorly) reimplementing gfx primitives.
> + * That is unnecessary and would become a performance problem. Instead,
> try to
> + * map to and reuse existing optimised facilities (e.g. pixman) wherever
> + * possible.
> + */
> +
> +static int ati_bpp_from_datatype(ATIVGAState *s)
> +{
> +    switch (s->regs.dp_datatype & 0xf) {
> +    case 2:
> +        return 8;
> +    case 3:
> +    case 4:
> +        return 16;
> +    case 5:
> +        return 24;
> +    case 6:
> +        return 32;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Unknown dst datatype %d\n",
> +                      s->regs.dp_datatype & 0xf);
> +        return 0;
> +    }
> +}
> +
> +void ati_2d_blit(ATIVGAState *s)
> +{
> +    /* FIXME it is really much more complex than this and may need to be
> */
> +    /* rewritten but for now as a start just to get some output: */
> +    DisplaySurface *ds = qemu_console_surface(s->vga.con);
> +    DPRINTF("%p ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
> surface_data(ds),
> +            surface_stride(ds), surface_bits_per_pixel(ds),
> +            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> +    DPRINTF("%d %d, %d %d, (%d,%d) -> (%d,%d) %dx%d\n",
> s->regs.src_offset,
> +            s->regs.dst_offset, s->regs.src_pitch, s->regs.dst_pitch,
> +            s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
> +            s->regs.dst_width, s->regs.dst_height);
> +    switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> +    case ROP3_SRCCOPY:
> +    {
> +        uint32_t *src_bits, *dst_bits;
> +        int src_stride = s->regs.src_pitch;
> +        int dst_stride = s->regs.dst_pitch;
> +        int bpp = ati_bpp_from_datatype(s);
> +
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            src_stride *= 8;
> +            dst_stride *= 8;
> +        } else {
> +            src_stride /= sizeof(uint32_t);
> +            dst_stride /= sizeof(uint32_t);
> +        }
> +        src_bits = (uint32_t *)(s->vga.vram_ptr + s->regs.src_offset);
> +        dst_bits = (uint32_t *)(s->vga.vram_ptr + s->regs.dst_offset);
> +        DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d,
> %d)\n",
> +                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
> +                s->regs.src_x, s->regs.src_y, s->regs.dst_x,
> s->regs.dst_y,
> +                s->regs.dst_width, s->regs.dst_height);
> +        pixman_blt(src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
> +                   s->regs.src_x, s->regs.src_y, s->regs.dst_x,
> s->regs.dst_y,
> +                   s->regs.dst_width, s->regs.dst_height);
> +        memory_region_set_dirty(&s->vga.vram,
> +                                s->vga.vbe_start_addr +
> s->regs.dst_offset +
> +                                s->regs.dst_y * surface_stride(ds),
> +                                s->regs.dst_height * surface_stride(ds));
> +        break;
> +    }
> +    case ROP3_PATCOPY:
> +    case ROP3_BLACKNESS:
> +    case ROP3_WHITENESS:
> +    {
> +        uint32_t *dst_bits = (uint32_t *)(s->vga.vram_ptr +
> s->regs.dst_offset);
> +        uint32_t filler = 0;
> +        int dst_stride = s->regs.dst_pitch;
> +        int bpp = ati_bpp_from_datatype(s);
> +
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            dst_stride *= 8;
> +        } else {
> +            dst_stride /= sizeof(uint32_t);
> +        }
> +
> +        switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> +        case ROP3_PATCOPY:
> +            filler = bswap32(s->regs.dp_brush_frgd_clr);
> +            break;
> +        case ROP3_BLACKNESS:
> +            filler = rgb_to_pixel32(s->vga.palette[0], s->vga.palette[1],
> +                                    s->vga.palette[2]) << 8 | 0xff;
> +            break;
> +        case ROP3_WHITENESS:
> +            filler = rgb_to_pixel32(s->vga.palette[3], s->vga.palette[4],
> +                                    s->vga.palette[5]) << 8 | 0xff;
> +            break;
> +        }
> +
> +        DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> +                dst_bits, dst_stride, bpp,
> +                s->regs.dst_x, s->regs.dst_y,
> +                s->regs.dst_width, s->regs.dst_height,
> +                filler);
> +        pixman_fill(dst_bits, dst_stride, bpp,
> +                   s->regs.dst_x, s->regs.dst_y,
> +                   s->regs.dst_width, s->regs.dst_height,
> +                   filler);
> +        memory_region_set_dirty(&s->vga.vram,
> +                                s->vga.vbe_start_addr +
> s->regs.dst_offset +
> +                                s->regs.dst_y * surface_stride(ds),
> +                                s->regs.dst_height * surface_stride(ds));
> +        break;
> +    }
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blit op %x\n",
> +                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> +    }
> +}
> diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
> new file mode 100644
> index 0000000000..5b6fdb299d
> --- /dev/null
> +++ b/hw/display/ati_dbg.c
> @@ -0,0 +1,254 @@
> +#include "ati_int.h"
> +
> +#ifdef DEBUG_ATI
> +struct ati_regdesc {
> +    const char *name;
> +    int num;
> +};
> +
> +static struct ati_regdesc ati_reg_names[] = {
> +    {"MM_INDEX", 0x0000},
> +    {"MM_DATA", 0x0004},
> +    {"CLOCK_CNTL_INDEX", 0x0008},
> +    {"CLOCK_CNTL_DATA", 0x000c},
> +    {"BIOS_0_SCRATCH", 0x0010},
> +    {"BUS_CNTL", 0x0030},
> +    {"BUS_CNTL1", 0x0034},
> +    {"GEN_INT_CNTL", 0x0040},
> +    {"CRTC_GEN_CNTL", 0x0050},
> +    {"CRTC_EXT_CNTL", 0x0054},
> +    {"DAC_CNTL", 0x0058},
> +    {"GPIO_MONID", 0x0068},
> +    {"I2C_CNTL_1", 0x0094},
> +    {"PALETTE_INDEX", 0x00b0},
> +    {"PALETTE_DATA", 0x00b4},
> +    {"CNFG_CNTL", 0x00e0},
> +    {"GEN_RESET_CNTL", 0x00f0},
> +    {"CNFG_MEMSIZE", 0x00f8},
> +    {"MEM_CNTL", 0x0140},
> +    {"MC_FB_LOCATION", 0x0148},
> +    {"MC_AGP_LOCATION", 0x014C},
> +    {"MC_STATUS", 0x0150},
> +    {"MEM_POWER_MISC", 0x015c},
> +    {"AGP_BASE", 0x0170},
> +    {"AGP_CNTL", 0x0174},
> +    {"AGP_APER_OFFSET", 0x0178},
> +    {"PCI_GART_PAGE", 0x017c},
> +    {"PC_NGUI_MODE", 0x0180},
> +    {"PC_NGUI_CTLSTAT", 0x0184},
> +    {"MPP_TB_CONFIG", 0x01C0},
> +    {"MPP_GP_CONFIG", 0x01C8},
> +    {"VIPH_CONTROL", 0x01D0},
> +    {"CRTC_H_TOTAL_DISP", 0x0200},
> +    {"CRTC_H_SYNC_STRT_WID", 0x0204},
> +    {"CRTC_V_TOTAL_DISP", 0x0208},
> +    {"CRTC_V_SYNC_STRT_WID", 0x020c},
> +    {"CRTC_VLINE_CRNT_VLINE", 0x0210},
> +    {"CRTC_CRNT_FRAME", 0x0214},
> +    {"CRTC_GUI_TRIG_VLINE", 0x0218},
> +    {"CRTC_OFFSET", 0x0224},
> +    {"CRTC_OFFSET_CNTL", 0x0228},
> +    {"CRTC_PITCH", 0x022c},
> +    {"OVR_CLR", 0x0230},
> +    {"OVR_WID_LEFT_RIGHT", 0x0234},
> +    {"OVR_WID_TOP_BOTTOM", 0x0238},
> +    {"LVDS_GEN_CNTL", 0x02d0},
> +    {"DDA_CONFIG", 0x02e0},
> +    {"DDA_ON_OFF", 0x02e4},
> +    {"VGA_DDA_CONFIG", 0x02e8},
> +    {"VGA_DDA_ON_OFF", 0x02ec},
> +    {"CRTC2_H_TOTAL_DISP", 0x0300},
> +    {"CRTC2_H_SYNC_STRT_WID", 0x0304},
> +    {"CRTC2_V_TOTAL_DISP", 0x0308},
> +    {"CRTC2_V_SYNC_STRT_WID", 0x030c},
> +    {"CRTC2_VLINE_CRNT_VLINE", 0x0310},
> +    {"CRTC2_CRNT_FRAME", 0x0314},
> +    {"CRTC2_GUI_TRIG_VLINE", 0x0318},
> +    {"CRTC2_OFFSET", 0x0324},
> +    {"CRTC2_OFFSET_CNTL", 0x0328},
> +    {"CRTC2_PITCH", 0x032c},
> +    {"DDA2_CONFIG", 0x03e0},
> +    {"DDA2_ON_OFF", 0x03e4},
> +    {"CRTC2_GEN_CNTL", 0x03f8},
> +    {"CRTC2_STATUS", 0x03fc},
> +    {"OV0_SCALE_CNTL", 0x0420},
> +    {"SUBPIC_CNTL", 0x0540},
> +    {"PM4_BUFFER_OFFSET", 0x0700},
> +    {"PM4_BUFFER_CNTL", 0x0704},
> +    {"PM4_BUFFER_WM_CNTL", 0x0708},
> +    {"PM4_BUFFER_DL_RPTR_ADDR", 0x070c},
> +    {"PM4_BUFFER_DL_RPTR", 0x0710},
> +    {"PM4_BUFFER_DL_WPTR", 0x0714},
> +    {"PM4_VC_FPU_SETUP", 0x071c},
> +    {"PM4_FPU_CNTL", 0x0720},
> +    {"PM4_VC_FORMAT", 0x0724},
> +    {"PM4_VC_CNTL", 0x0728},
> +    {"PM4_VC_I01", 0x072c},
> +    {"PM4_VC_VLOFF", 0x0730},
> +    {"PM4_VC_VLSIZE", 0x0734},
> +    {"PM4_IW_INDOFF", 0x0738},
> +    {"PM4_IW_INDSIZE", 0x073c},
> +    {"PM4_FPU_FPX0", 0x0740},
> +    {"PM4_FPU_FPY0", 0x0744},
> +    {"PM4_FPU_FPX1", 0x0748},
> +    {"PM4_FPU_FPY1", 0x074c},
> +    {"PM4_FPU_FPX2", 0x0750},
> +    {"PM4_FPU_FPY2", 0x0754},
> +    {"PM4_FPU_FPY3", 0x0758},
> +    {"PM4_FPU_FPY4", 0x075c},
> +    {"PM4_FPU_FPY5", 0x0760},
> +    {"PM4_FPU_FPY6", 0x0764},
> +    {"PM4_FPU_FPR", 0x0768},
> +    {"PM4_FPU_FPG", 0x076c},
> +    {"PM4_FPU_FPB", 0x0770},
> +    {"PM4_FPU_FPA", 0x0774},
> +    {"PM4_FPU_INTXY0", 0x0780},
> +    {"PM4_FPU_INTXY1", 0x0784},
> +    {"PM4_FPU_INTXY2", 0x0788},
> +    {"PM4_FPU_INTARGB", 0x078c},
> +    {"PM4_FPU_FPTWICEAREA", 0x0790},
> +    {"PM4_FPU_DMAJOR01", 0x0794},
> +    {"PM4_FPU_DMAJOR12", 0x0798},
> +    {"PM4_FPU_DMAJOR02", 0x079c},
> +    {"PM4_FPU_STAT", 0x07a0},
> +    {"PM4_STAT", 0x07b8},
> +    {"PM4_TEST_CNTL", 0x07d0},
> +    {"PM4_MICROCODE_ADDR", 0x07d4},
> +    {"PM4_MICROCODE_RADDR", 0x07d8},
> +    {"PM4_MICROCODE_DATAH", 0x07dc},
> +    {"PM4_MICROCODE_DATAL", 0x07e0},
> +    {"PM4_CMDFIFO_ADDR", 0x07e4},
> +    {"PM4_CMDFIFO_DATAH", 0x07e8},
> +    {"PM4_CMDFIFO_DATAL", 0x07ec},
> +    {"PM4_BUFFER_ADDR", 0x07f0},
> +    {--
> 2.13.7
>
>
>
