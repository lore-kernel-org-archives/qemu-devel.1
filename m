Received: from eggs.gnu.org ([209.51.188.92]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvZDB-00051R-Nu
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 22:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvZD7-00082N-79
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 22:03:17 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:21466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gvZD6-0007wI-Lq
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 22:03:13 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 18 Feb 2019 03:55:14 +0100
Message-Id: <20190218030257.624A7745694@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH v2] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, philmd@redhat.com

At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
guests running on these and the PMON2000 firmware of the fulong2e
expect this to be available. Fortunately these are very similar chips
so they can be mostly emulated in the same device model. This patch
adds basic emulation of these ATI VGA chips.

While this is incomplete and currently only enough to run the MIPS
firmware and get console output with Linux, it allows the fulong2e
board to work more like the real hardware and having it in QEMU in
this state provides a way to experiment with it and allows others to
contribute to improve it. It is only enabled for mips64le and ppc now
but only the fulong2e (which currently has no display output at all)
is set to use it by default (in a separate patch).

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Tested with Debian 8.11.0 powerpc on mac99 and the pmon_2e.bin
fulong2e firmware from https://mirrors.cloud.tencent.com/loongson/pmon/

v2:
- Extended debug logs
- Fix mode switching and some registers
- Fixes to 2D functions

 default-configs/mips64el-softmmu.mak |   1 +
 default-configs/ppc-softmmu.mak      |   1 +
 hw/display/Makefile.objs             |   2 +
 hw/display/ati.c                     | 638 +++++++++++++++++++++++++++++++++++
 hw/display/ati_2d.c                  |  75 ++++
 hw/display/ati_dbg.c                 | 254 ++++++++++++++
 hw/display/ati_int.h                 |  75 ++++
 hw/display/ati_regs.h                | 454 +++++++++++++++++++++++++
 hw/display/trace-events              |   4 +
 9 files changed, 1504 insertions(+)
 create mode 100644 hw/display/ati.c
 create mode 100644 hw/display/ati_2d.c
 create mode 100644 hw/display/ati_dbg.c
 create mode 100644 hw/display/ati_int.h
 create mode 100644 hw/display/ati_regs.h

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
index 9eb1208b58..231f81eca2 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -13,3 +13,4 @@ CONFIG_VT82C686=y
 CONFIG_MIPS_BOSTON=y
 CONFIG_FITLOADER=y
 CONFIG_PCI_EXPRESS_XILINX=y
+CONFIG_ATI_VGA=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 52acb7cf39..75024b298e 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -56,6 +56,7 @@ CONFIG_DEC_PCI=y
 CONFIG_IDE_MACIO=y
 CONFIG_MAC_OLDWORLD=y
 CONFIG_MAC_NEWWORLD=y
+CONFIG_ATI_VGA=y
 
 # For PReP
 CONFIG_PREP=y
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 7c4ae9a0fd..963c23f3c8 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -53,3 +53,5 @@ virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
 obj-$(CONFIG_DPCD) += dpcd.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
+
+obj-$(CONFIG_ATI_VGA) += ati.o ati_2d.o ati_dbg.o
diff --git a/hw/display/ati.c b/hw/display/ati.c
new file mode 100644
index 0000000000..2abfa732b2
--- /dev/null
+++ b/hw/display/ati.c
@@ -0,0 +1,638 @@
+/*
+ * QEMU ATI SVGA emulation
+ *
+ * Copyright (c) 2019 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ */
+
+/*
+ * WARNING:
+ * This is very incomplete and only enough to get Linux console output yet.
+ * At the moment it's little more than a frame buffer with minimal functions,
+ * other more advanced features of the hardware are yet to be implemented.
+ * We only aim for Rage 128 Pro (and some RV100) and 2D only at first,
+ * No 3D at all yet (maybe after 2D works, but feel free to improve it)
+ */
+
+#include "ati_int.h"
+#include "ati_regs.h"
+#include "vga_regs.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "ui/console.h"
+#include "trace.h"
+
+#define PCI_VENDOR_ID_ATI 0x1002
+/* Rage128 Pro GL */
+#define PCI_DEVICE_ID_ATI_RAGE128_PF 0x5046
+/* Radeon RV100 (VE) */
+#define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
+
+enum { VGA_MODE, EXT_MODE };
+
+static void ati_vga_switch_mode(ATIVGAState *s)
+{
+    DPRINTF("%d -> %d\n",
+            s->mode, !!(s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN));
+    if (s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN) {
+        /* Extended mode enabled */
+        s->mode = EXT_MODE;
+        if (s->regs.crtc_gen_cntl & CRTC2_EN) {
+            /* CRT controller enabled, use CRTC values */
+            uint32_t offs = s->regs.crtc_offset & 0x07ffffff;
+            int stride = (s->regs.crtc_pitch & 0x7ff) * 8;
+            int bpp = 0;
+            int h, v;
+
+            if (s->regs.crtc_h_total_disp == 0) {
+                s->regs.crtc_h_total_disp = ((640 / 8) - 1) << 16;
+            }
+            if (s->regs.crtc_v_total_disp == 0) {
+                s->regs.crtc_v_total_disp = (480 - 1) << 16;
+            }
+            h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
+            v = (s->regs.crtc_v_total_disp >> 16) + 1;
+            switch (s->regs.crtc_gen_cntl & CRTC_PIX_WIDTH_MASK) {
+            case CRTC_PIX_WIDTH_4BPP:
+                bpp = 4;
+                break;
+            case CRTC_PIX_WIDTH_8BPP:
+                bpp = 8;
+                break;
+            case CRTC_PIX_WIDTH_15BPP:
+                bpp = 15;
+                break;
+            case CRTC_PIX_WIDTH_16BPP:
+                bpp = 16;
+                break;
+            case CRTC_PIX_WIDTH_24BPP:
+                bpp = 24;
+                break;
+            case CRTC_PIX_WIDTH_32BPP:
+                bpp = 32;
+                break;
+            default:
+                qemu_log_mask(LOG_UNIMP, "Unsupported bpp value");
+            }
+            assert(bpp != 0);
+            DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp, offs);
+            vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
+            vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+            /* reset VBE regs then set up mode */
+            s->vga.vbe_regs[VBE_DISPI_INDEX_XRES] = h;
+            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] = v;
+            s->vga.vbe_regs[VBE_DISPI_INDEX_BPP] = bpp;
+            /* enable mode via ioport so it updates vga regs */
+            vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
+            vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_ENABLED |
+                VBE_DISPI_LFB_ENABLED | VBE_DISPI_NOCLEARMEM |
+                (s->regs.dac_cntl & DAC_8BIT_EN ? VBE_DISPI_8BIT_DAC : 0));
+            /* now set offset and stride after enable as that resets these */
+            if (stride) {
+                vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_VIRT_WIDTH);
+                vbe_ioport_write_data(&s->vga, 0, stride);
+                if (offs % stride == 0) {
+                    vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFFSET);
+                    vbe_ioport_write_data(&s->vga, 0, offs / stride);
+                } else {
+                    /* FIXME what to do with this? */
+                    error_report("VGA offset is not multiple of pitch, "
+                                 "expect bad picture");
+                }
+            }
+        }
+    } else {
+        /* VGA mode enabled */
+        s->mode = VGA_MODE;
+        vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
+        vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+    }
+}
+
+static inline uint64_t ati_reg_read_offs(uint64_t reg, int offs,
+                                         unsigned int size)
+{
+    uint64_t val = 0;
+    uint32_t mask;
+    int i;
+
+    if (offs == 0 && size == 4) {
+        return reg;
+    }
+    for (i = 0; i < size; i++) {
+        mask = 0xffUL << (offs + i) * 8;
+        val |= reg & mask;
+    }
+    val >>= offs * 8;
+    return val;
+}
+
+static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    ATIVGAState *s = opaque;
+    uint64_t val = 0;
+    int i;
+
+    switch (addr) {
+    case MM_INDEX:
+        val = s->regs.mm_index;
+        break;
+    case MM_DATA ... MM_DATA + 3:
+        /* indexed access to regs or memory */
+        if (s->regs.mm_index & 0x80000000) {
+            if (s->regs.mm_index <= s->vga.vram_size - size) {
+                int i = size - 1;
+                while (i >= 0) {
+                    val <<= 8;
+                    val |= s->vga.vram_ptr[s->regs.mm_index + i--];
+                }
+            }
+        } else {
+            val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
+        }
+        break;
+    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
+        i = (addr - BIOS_0_SCRATCH) / 4;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
+            break;
+        }
+        val = ati_reg_read_offs(s->regs.bios_scratch[i],
+                                addr - (BIOS_0_SCRATCH + i * 4), size);
+        break;
+    case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
+        val = ati_reg_read_offs(s->regs.crtc_gen_cntl,
+                                addr - CRTC_GEN_CNTL, size);
+        break;
+    case CRTC_EXT_CNTL ... CRTC_EXT_CNTL + 3:
+        val = ati_reg_read_offs(s->regs.crtc_ext_cntl,
+                                addr - CRTC_EXT_CNTL, size);
+        break;
+    case DAC_CNTL:
+        val = s->regs.dac_cntl;
+        break;
+/*    case GPIO_MONID: FIXME hook up DDC I2C here */
+    case PALETTE_INDEX:
+        /* FIXME unaligned access */
+        val = vga_ioport_read(&s->vga, VGA_PEL_IR) << 16;
+        val |= vga_ioport_read(&s->vga, VGA_PEL_IW) & 0xff;
+        break;
+    case PALETTE_DATA:
+        val = vga_ioport_read(&s->vga, VGA_PEL_D);
+        break;
+    case CNFG_MEMSIZE:
+        val = s->vga.vram_size;
+        break;
+    case MC_STATUS:
+        val = 5;
+        break;
+    case RBBM_STATUS:
+    case GUI_STAT:
+        val = 64; /* free CMDFIFO entries */
+        break;
+    case CRTC_H_TOTAL_DISP:
+        val = s->regs.crtc_h_total_disp;
+        break;
+    case CRTC_H_SYNC_STRT_WID:
+        val = s->regs.crtc_h_sync_strt_wid;
+        break;
+    case CRTC_V_TOTAL_DISP:
+        val = s->regs.crtc_v_total_disp;
+        break;
+    case CRTC_V_SYNC_STRT_WID:
+        val = s->regs.crtc_v_sync_strt_wid;
+        break;
+    case CRTC_OFFSET:
+        val = s->regs.crtc_offset;
+        break;
+    case CRTC_OFFSET_CNTL:
+        val = s->regs.crtc_offset_cntl;
+        break;
+    case CRTC_PITCH:
+        val = s->regs.crtc_pitch;
+        break;
+    case 0xf00 ... 0xfff:
+        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
+        break;
+    case DST_OFFSET:
+        val = s->regs.dst_offset;
+        break;
+    case DST_PITCH:
+        val = s->regs.dst_pitch;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            val &= s->regs.dst_tile << 16;
+        }
+        break;
+    case DST_WIDTH:
+        val = s->regs.dst_width;
+        break;
+    case DST_HEIGHT:
+        val = s->regs.dst_height;
+        break;
+    case SRC_X:
+        val = s->regs.src_x;
+        break;
+    case SRC_Y:
+        val = s->regs.src_y;
+        break;
+    case DST_X:
+        val = s->regs.dst_x;
+        break;
+    case DST_Y:
+        val = s->regs.dst_y;
+        break;
+    case DP_GUI_MASTER_CNTL:
+        val = s->regs.dp_gui_master_cntl;
+        break;
+    case DP_BRUSH_BKGD_CLR:
+        val = s->regs.dp_brush_bkgd_clr;
+        break;
+    case DP_BRUSH_FRGD_CLR:
+        val = s->regs.dp_brush_frgd_clr;
+        break;
+    case DP_SRC_FRGD_CLR:
+        val = s->regs.dp_src_frgd_clr;
+        break;
+    case DP_SRC_BKGD_CLR:
+        val = s->regs.dp_src_bkgd_clr;
+        break;
+    case DP_CNTL:
+        val = s->regs.dp_cntl;
+        break;
+    case DP_DATATYPE:
+        val = s->regs.dp_datatype;
+        break;
+    case DP_MIX:
+        val = s->regs.dp_mix;
+        break;
+    case DP_WRITE_MASK:
+        val = s->regs.dp_write_mask;
+        break;
+    case DEFAULT_OFFSET:
+        val = s->regs.default_offset;
+        break;
+    case DEFAULT_PITCH:
+        val = s->regs.default_pitch;
+        break;
+    case DEFAULT_SC_BOTTOM_RIGHT:
+        val = s->regs.default_sc_bottom_right;
+        break;
+    default:
+        break;
+    }
+    trace_ati_mm_read(size, addr, ati_reg_name(addr), val);
+
+    return val;
+}
+
+static inline void ati_reg_write_offs(uint32_t *reg, int offs,
+                                      uint64_t data, unsigned int size)
+{
+    int shift, i;
+    uint32_t mask;
+
+    if (offs == 0 && size == 4) {
+        *reg = data;
+    }
+    for (i = 0; i < size; i++) {
+        shift = (offs + i) * 8;
+        mask = 0xffUL << shift;
+        *reg &= ~mask;
+        *reg |= (data & 0xff) << shift;
+        data >>= 8;
+    }
+}
+
+static void ati_mm_write(void *opaque, hwaddr addr,
+                           uint64_t data, unsigned int size)
+{
+    ATIVGAState *s = opaque;
+    int i;
+
+    trace_ati_mm_write(size, addr, ati_reg_name(addr), data);
+    switch (addr) {
+    case MM_INDEX:
+        s->regs.mm_index = data;
+        break;
+    case MM_DATA ... MM_DATA + 3:
+        /* indexed access to regs or memory */
+        if (s->regs.mm_index & 0x80000000) {
+            if (s->regs.mm_index <= s->vga.vram_size - size) {
+                int i = 0;
+                while (i < size) {
+                    s->vga.vram_ptr[s->regs.mm_index + i] = data & 0xff;
+                    data >>= 8;
+                }
+            }
+        } else {
+            ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
+        }
+        break;
+    case BIOS_0_SCRATCH ... BUS_CNTL - 1:
+        i = (addr - BIOS_0_SCRATCH) / 4;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
+            break;
+        }
+        ati_reg_write_offs(&s->regs.bios_scratch[i],
+                           addr - (BIOS_0_SCRATCH + i * 4), data, size);
+        break;
+    case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
+        ati_reg_write_offs(&s->regs.crtc_gen_cntl,
+                           addr - CRTC_GEN_CNTL, data, size);
+        break;
+    case CRTC_EXT_CNTL ... CRTC_EXT_CNTL + 3:
+        ati_reg_write_offs(&s->regs.crtc_ext_cntl,
+                           addr - CRTC_EXT_CNTL, data, size);
+        if (s->regs.crtc_ext_cntl & CRT_CRTC_DISPLAY_DIS) {
+            DPRINTF("Display disabled\n");
+            s->vga.ar_index &= ~0x20;
+        } else {
+            DPRINTF("Display enabled\n");
+            s->vga.ar_index |= 0x20;
+            ati_vga_switch_mode(s);
+        }
+        break;
+    case DAC_CNTL:
+        s->regs.dac_cntl = data & 0xffffe3ff;
+        s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
+        break;
+/*    case GPIO_MONID: FIXME hook up DDC I2C here */
+    case PALETTE_INDEX ... PALETTE_INDEX + 3:
+        if (size == 4) {
+            vga_ioport_write(&s->vga, VGA_PEL_IR, (data >> 16) & 0xff);
+            vga_ioport_write(&s->vga, VGA_PEL_IW, data & 0xff);
+        } else {
+            if (addr == PALETTE_INDEX) {
+                vga_ioport_write(&s->vga, VGA_PEL_IW, data & 0xff);
+            } else {
+                vga_ioport_write(&s->vga, VGA_PEL_IR, data & 0xff);
+            }
+        }
+        break;
+    case PALETTE_DATA ... PALETTE_DATA + 3:
+        data <<= addr - PALETTE_DATA;
+        data = bswap32(data) >> 8;
+        vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
+        data >>= 8;
+        vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
+        data >>= 8;
+        vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
+        break;
+    case CRTC_H_TOTAL_DISP:
+        s->regs.crtc_h_total_disp = data & 0x07ff07ff;
+        break;
+    case CRTC_H_SYNC_STRT_WID:
+        s->regs.crtc_h_sync_strt_wid = data & 0x17bf1fff;
+        break;
+    case CRTC_V_TOTAL_DISP:
+        s->regs.crtc_v_total_disp = data & 0x0fff0fff;
+        break;
+    case CRTC_V_SYNC_STRT_WID:
+        s->regs.crtc_v_sync_strt_wid = data & 0x9f0fff;
+        break;
+    case CRTC_OFFSET:
+        s->regs.crtc_offset = data & 0xc7ffffff;
+        break;
+    case CRTC_OFFSET_CNTL:
+        s->regs.crtc_offset_cntl = data; /* FIXME */
+        break;
+    case CRTC_PITCH:
+        s->regs.crtc_pitch = data & 0x07ff07ff;
+        break;
+    case 0xf00 ... 0xfff:
+        /* read-only copy of PCI config space so ignore writes */
+        break;
+    case DST_OFFSET:
+        s->regs.dst_offset = data & 0xfffffc00;
+        break;
+    case DST_PITCH:
+        s->regs.dst_pitch = data & 0x3ff0;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.dst_tile = (data >> 16) & 1;
+        }
+        break;
+    case DST_TILE:
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {
+            s->regs.dst_tile = data & 3;
+        }
+        break;
+    case DST_WIDTH:
+        s->regs.dst_width = data & 0x3fff;
+        ati_2d_blit(s);
+        break;
+    case DST_HEIGHT:
+        s->regs.dst_height = data & 0x3fff;
+        break;
+    case SRC_X:
+        s->regs.src_x = data & 0x3fff;
+        break;
+    case SRC_Y:
+        s->regs.src_y = data & 0x3fff;
+        break;
+    case DST_X:
+        s->regs.dst_x = data & 0x3fff;
+        break;
+    case DST_Y:
+        s->regs.dst_y = data & 0x3fff;
+        break;
+    case SRC_PITCH_OFFSET:
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.src_offset = (data & 0x1fffe0) << 5;
+            s->regs.src_pitch = (data >> 21) & 0x3ff;
+            s->regs.src_tile = data >> 31;
+        } else {
+            s->regs.src_offset = (data & 0x3fffff) << 11;
+            s->regs.src_pitch = (data & 0x3fc00000) >> 16;
+            s->regs.src_tile = (data >> 30) & 1;
+        }
+        break;
+    case DST_PITCH_OFFSET:
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.dst_offset = (data & 0x1fffe0) << 5;
+            s->regs.dst_pitch = (data >> 21) & 0x3ff;
+            s->regs.dst_tile = data >> 31;
+        } else {
+            s->regs.dst_offset = (data & 0x3fffff) << 11;
+            s->regs.dst_pitch = (data & 0x3fc00000) >> 16;
+            s->regs.dst_tile = data >> 30;
+        }
+        break;
+    case SRC_Y_X:
+        s->regs.src_x = data & 0x3fff;
+        s->regs.src_y = (data >> 16) & 0x3fff;
+        break;
+    case DST_Y_X:
+        s->regs.dst_x = data & 0x3fff;
+        s->regs.dst_y = (data >> 16) & 0x3fff;
+        break;
+    case DST_HEIGHT_WIDTH:
+        s->regs.dst_width = data & 0x3fff;
+        s->regs.dst_height = (data >> 16) & 0x3fff;
+        ati_2d_blit(s);
+        break;
+    case DP_GUI_MASTER_CNTL:
+        s->regs.dp_gui_master_cntl = data & 0xf800000f;
+        s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
+                              (data & 0x4000) << 16;
+        s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
+        break;
+    case DST_WIDTH_X:
+        s->regs.dst_x = data & 0x3fff;
+        s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_2d_blit(s);
+        break;
+    case SRC_X_Y:
+        s->regs.src_y = data & 0x3fff;
+        s->regs.src_x = (data >> 16) & 0x3fff;
+        break;
+    case DST_X_Y:
+        s->regs.dst_y = data & 0x3fff;
+        s->regs.dst_x = (data >> 16) & 0x3fff;
+        break;
+    case DST_WIDTH_HEIGHT:
+        s->regs.dst_height = data & 0x3fff;
+        s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_2d_blit(s);
+        break;
+    case DST_HEIGHT_Y:
+        s->regs.dst_y = data & 0x3fff;
+        s->regs.dst_height = (data >> 16) & 0x3fff;
+        break;
+    case DP_BRUSH_BKGD_CLR:
+        s->regs.dp_brush_bkgd_clr = data;
+        break;
+    case DP_BRUSH_FRGD_CLR:
+        s->regs.dp_brush_frgd_clr = data;
+        break;
+    case DP_CNTL:
+        s->regs.dp_cntl = data;
+        break;
+    case DP_DATATYPE:
+        s->regs.dp_cntl = data & 0xe0070f0f;
+        break;
+    case DP_MIX:
+        s->regs.dp_mix = data & 0x00ff0700;
+        break;
+    case DP_WRITE_MASK:
+        s->regs.dp_write_mask = data;
+        break;
+    case DEFAULT_OFFSET:
+        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+                 0x03fffc00 : 0xfffffc00);
+        s->regs.default_offset = data;
+        break;
+    case DEFAULT_PITCH:
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.default_pitch = data & 0x103ff;
+        }
+        break;
+    case DEFAULT_SC_BOTTOM_RIGHT:
+        s->regs.default_sc_bottom_right = data & 0x3fff3fff;
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps ati_mm_ops = {
+    .read = ati_mm_read,
+    .write = ati_mm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ati_vga_realize(PCIDevice *dev, Error **errp)
+{
+    ATIVGAState *s = ATI_VGA(dev);
+    VGACommonState *vga = &s->vga;
+
+    if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF &&
+        s->dev_id != PCI_DEVICE_ID_ATI_RADEON_QY) {
+        error_setg(errp, "Unknown ATI VGA device id, "
+                   "only 0x5046 and 0x5159 are supported");
+        return;
+    }
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY &&
+        s->vga.vram_size_mb < 16) {
+        warn_report("Too small video memory for device id");
+        s->vga.vram_size_mb = 16;
+    }
+
+    /* init vga compat bits */
+    vga_common_init(vga, OBJECT(s));
+    vga_init(vga, OBJECT(s), pci_address_space(dev),
+             pci_address_space_io(dev), true);
+    vga->con = graphic_console_init(DEVICE(s), 0, s->vga.hw_ops, &s->vga);
+
+    /* mmio register space */
+    memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
+                          "ati.mmregs", 0x4000);
+    /* io space is alias to beginning of mmregs */
+    memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
+    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
+    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
+}
+
+static void ati_vga_reset(DeviceState *dev)
+{
+    ATIVGAState *s = ATI_VGA(dev);
+    PCIDevice *pd = PCI_DEVICE(dev);
+
+    pci_set_word(pd->config + PCI_DEVICE_ID, s->dev_id);
+    /* reset vga */
+    vga_common_reset(&s->vga);
+    s->mode = VGA_MODE;
+}
+
+static void ati_vga_exit(PCIDevice *dev)
+{
+    ATIVGAState *s = ATI_VGA(dev);
+
+    graphic_console_close(s->vga.con);
+}
+
+static Property ati_vga_properties[] = {
+    DEFINE_PROP_UINT32("vgamem_mb", ATIVGAState, vga.vram_size_mb, 16),
+    DEFINE_PROP_UINT16("device_id", ATIVGAState, dev_id,
+                       PCI_DEVICE_ID_ATI_RAGE128_PF),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void ati_vga_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    dc->reset = ati_vga_reset;
+    dc->props = ati_vga_properties;
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+
+    k->class_id = PCI_CLASS_DISPLAY_VGA;
+    k->vendor_id = PCI_VENDOR_ID_ATI;
+    k->device_id = PCI_DEVICE_ID_ATI_RAGE128_PF;
+    k->romfile = "vgabios-stdvga.bin";
+    k->realize = ati_vga_realize;
+    k->exit = ati_vga_exit;
+}
+
+static const TypeInfo ati_vga_info = {
+    .name = TYPE_ATI_VGA,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(ATIVGAState),
+    .class_init = ati_vga_class_init,
+    .interfaces = (InterfaceInfo[]) {
+          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+          { },
+    },
+};
+
+static void ati_vga_register_types(void)
+{
+    type_register_static(&ati_vga_info);
+}
+
+type_init(ati_vga_register_types)
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
new file mode 100644
index 0000000000..8ac1ea8eaa
--- /dev/null
+++ b/hw/display/ati_2d.c
@@ -0,0 +1,75 @@
+/*
+ * QEMU ATI SVGA emulation
+ * 2D engine functions
+ *
+ * Copyright (c) 2019 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ */
+
+#include "ati_int.h"
+#include "ati_regs.h"
+#include "qemu/log.h"
+
+/*
+ * NOTE:
+ * This is 2D _acceleration_ and supposed to be fast. Therefore, don't try to
+ * reinvent the wheel (unlikely to get better with a naive implementation than
+ * existing libraries) and avoid (poorly) reimplementing gfx primitives.
+ * That is unnecessary and would become a performance problem. Instead, try to
+ * map to and reuse existing optimised facilities (e.g. pixman) wherever
+ * possible.
+ */
+
+void ati_2d_blit(ATIVGAState *s)
+{
+    /* FIXME it is really much more complex than this and may need to be */
+    /* rewritten but for now as a start just to get some output: */
+    DisplaySurface *ds = qemu_console_surface(s->vga.con);
+    DPRINTF("ds: %p %d %d rop: %x\n", ds->image,
+            surface_stride(ds), surface_bits_per_pixel(ds),
+            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    DPRINTF("%d %d, %d %d, (%d,%d) -> (%d,%d) %dx%d\n", s->regs.src_offset,
+            s->regs.dst_offset, s->regs.src_pitch, s->regs.dst_pitch,
+            s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
+            s->regs.dst_width, s->regs.dst_height);
+    switch ((s->regs.dp_mix & GMC_ROP3_MASK)) {
+    case ROP3_SRCCOPY:
+    {
+        int src_stride = (s->regs.src_pitch & 0x3fff) / 4;
+        int dst_stride = (s->regs.dst_pitch & 0x3fff) / 4;
+        uint32_t *src_bits, *dst_bits;
+        src_bits = dst_bits = pixman_image_get_data(ds->image);
+        src_bits += s->regs.src_offset;
+        dst_bits += s->regs.dst_offset;
+        pixman_blt(src_bits, dst_bits, src_stride, dst_stride,
+                   surface_bits_per_pixel(ds), surface_bits_per_pixel(ds),
+                   s->regs.src_x, s->regs.src_y,
+                   s->regs.dst_x, s->regs.dst_y,
+                   s->regs.dst_width, s->regs.dst_height);
+        memory_region_set_dirty(&s->vga.vram,
+                                s->vga.vbe_start_addr + s->regs.dst_offset +
+                                s->regs.dst_y * surface_stride(ds),
+                                s->regs.dst_height * surface_stride(ds));
+        break;
+    }
+    case ROP3_PATCOPY:
+    {
+        int dst_stride = (s->regs.dst_pitch & 0x3fff) / 4;
+        uint32_t *dst_bits = pixman_image_get_data(ds->image);
+        dst_bits += s->regs.dst_offset;
+        pixman_fill(dst_bits, dst_stride, surface_bits_per_pixel(ds),
+                   s->regs.dst_x, s->regs.dst_y,
+                   s->regs.dst_width, s->regs.dst_height,
+                   s->regs.dp_brush_frgd_clr);
+        memory_region_set_dirty(&s->vga.vram,
+                                s->vga.vbe_start_addr + s->regs.dst_offset +
+                                s->regs.dst_y * surface_stride(ds),
+                                s->regs.dst_height * surface_stride(ds));
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blit op %x\n",
+                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    }
+}
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
new file mode 100644
index 0000000000..5b6fdb299d
--- /dev/null
+++ b/hw/display/ati_dbg.c
@@ -0,0 +1,254 @@
+#include "ati_int.h"
+
+#ifdef DEBUG_ATI
+struct ati_regdesc {
+    const char *name;
+    int num;
+};
+
+static struct ati_regdesc ati_reg_names[] = {
+    {"MM_INDEX", 0x0000},
+    {"MM_DATA", 0x0004},
+    {"CLOCK_CNTL_INDEX", 0x0008},
+    {"CLOCK_CNTL_DATA", 0x000c},
+    {"BIOS_0_SCRATCH", 0x0010},
+    {"BUS_CNTL", 0x0030},
+    {"BUS_CNTL1", 0x0034},
+    {"GEN_INT_CNTL", 0x0040},
+    {"CRTC_GEN_CNTL", 0x0050},
+    {"CRTC_EXT_CNTL", 0x0054},
+    {"DAC_CNTL", 0x0058},
+    {"GPIO_MONID", 0x0068},
+    {"I2C_CNTL_1", 0x0094},
+    {"PALETTE_INDEX", 0x00b0},
+    {"PALETTE_DATA", 0x00b4},
+    {"CNFG_CNTL", 0x00e0},
+    {"GEN_RESET_CNTL", 0x00f0},
+    {"CNFG_MEMSIZE", 0x00f8},
+    {"MEM_CNTL", 0x0140},
+    {"MC_FB_LOCATION", 0x0148},
+    {"MC_AGP_LOCATION", 0x014C},
+    {"MC_STATUS", 0x0150},
+    {"MEM_POWER_MISC", 0x015c},
+    {"AGP_BASE", 0x0170},
+    {"AGP_CNTL", 0x0174},
+    {"AGP_APER_OFFSET", 0x0178},
+    {"PCI_GART_PAGE", 0x017c},
+    {"PC_NGUI_MODE", 0x0180},
+    {"PC_NGUI_CTLSTAT", 0x0184},
+    {"MPP_TB_CONFIG", 0x01C0},
+    {"MPP_GP_CONFIG", 0x01C8},
+    {"VIPH_CONTROL", 0x01D0},
+    {"CRTC_H_TOTAL_DISP", 0x0200},
+    {"CRTC_H_SYNC_STRT_WID", 0x0204},
+    {"CRTC_V_TOTAL_DISP", 0x0208},
+    {"CRTC_V_SYNC_STRT_WID", 0x020c},
+    {"CRTC_VLINE_CRNT_VLINE", 0x0210},
+    {"CRTC_CRNT_FRAME", 0x0214},
+    {"CRTC_GUI_TRIG_VLINE", 0x0218},
+    {"CRTC_OFFSET", 0x0224},
+    {"CRTC_OFFSET_CNTL", 0x0228},
+    {"CRTC_PITCH", 0x022c},
+    {"OVR_CLR", 0x0230},
+    {"OVR_WID_LEFT_RIGHT", 0x0234},
+    {"OVR_WID_TOP_BOTTOM", 0x0238},
+    {"LVDS_GEN_CNTL", 0x02d0},
+    {"DDA_CONFIG", 0x02e0},
+    {"DDA_ON_OFF", 0x02e4},
+    {"VGA_DDA_CONFIG", 0x02e8},
+    {"VGA_DDA_ON_OFF", 0x02ec},
+    {"CRTC2_H_TOTAL_DISP", 0x0300},
+    {"CRTC2_H_SYNC_STRT_WID", 0x0304},
+    {"CRTC2_V_TOTAL_DISP", 0x0308},
+    {"CRTC2_V_SYNC_STRT_WID", 0x030c},
+    {"CRTC2_VLINE_CRNT_VLINE", 0x0310},
+    {"CRTC2_CRNT_FRAME", 0x0314},
+    {"CRTC2_GUI_TRIG_VLINE", 0x0318},
+    {"CRTC2_OFFSET", 0x0324},
+    {"CRTC2_OFFSET_CNTL", 0x0328},
+    {"CRTC2_PITCH", 0x032c},
+    {"DDA2_CONFIG", 0x03e0},
+    {"DDA2_ON_OFF", 0x03e4},
+    {"CRTC2_GEN_CNTL", 0x03f8},
+    {"CRTC2_STATUS", 0x03fc},
+    {"OV0_SCALE_CNTL", 0x0420},
+    {"SUBPIC_CNTL", 0x0540},
+    {"PM4_BUFFER_OFFSET", 0x0700},
+    {"PM4_BUFFER_CNTL", 0x0704},
+    {"PM4_BUFFER_WM_CNTL", 0x0708},
+    {"PM4_BUFFER_DL_RPTR_ADDR", 0x070c},
+    {"PM4_BUFFER_DL_RPTR", 0x0710},
+    {"PM4_BUFFER_DL_WPTR", 0x0714},
+    {"PM4_VC_FPU_SETUP", 0x071c},
+    {"PM4_FPU_CNTL", 0x0720},
+    {"PM4_VC_FORMAT", 0x0724},
+    {"PM4_VC_CNTL", 0x0728},
+    {"PM4_VC_I01", 0x072c},
+    {"PM4_VC_VLOFF", 0x0730},
+    {"PM4_VC_VLSIZE", 0x0734},
+    {"PM4_IW_INDOFF", 0x0738},
+    {"PM4_IW_INDSIZE", 0x073c},
+    {"PM4_FPU_FPX0", 0x0740},
+    {"PM4_FPU_FPY0", 0x0744},
+    {"PM4_FPU_FPX1", 0x0748},
+    {"PM4_FPU_FPY1", 0x074c},
+    {"PM4_FPU_FPX2", 0x0750},
+    {"PM4_FPU_FPY2", 0x0754},
+    {"PM4_FPU_FPY3", 0x0758},
+    {"PM4_FPU_FPY4", 0x075c},
+    {"PM4_FPU_FPY5", 0x0760},
+    {"PM4_FPU_FPY6", 0x0764},
+    {"PM4_FPU_FPR", 0x0768},
+    {"PM4_FPU_FPG", 0x076c},
+    {"PM4_FPU_FPB", 0x0770},
+    {"PM4_FPU_FPA", 0x0774},
+    {"PM4_FPU_INTXY0", 0x0780},
+    {"PM4_FPU_INTXY1", 0x0784},
+    {"PM4_FPU_INTXY2", 0x0788},
+    {"PM4_FPU_INTARGB", 0x078c},
+    {"PM4_FPU_FPTWICEAREA", 0x0790},
+    {"PM4_FPU_DMAJOR01", 0x0794},
+    {"PM4_FPU_DMAJOR12", 0x0798},
+    {"PM4_FPU_DMAJOR02", 0x079c},
+    {"PM4_FPU_STAT", 0x07a0},
+    {"PM4_STAT", 0x07b8},
+    {"PM4_TEST_CNTL", 0x07d0},
+    {"PM4_MICROCODE_ADDR", 0x07d4},
+    {"PM4_MICROCODE_RADDR", 0x07d8},
+    {"PM4_MICROCODE_DATAH", 0x07dc},
+    {"PM4_MICROCODE_DATAL", 0x07e0},
+    {"PM4_CMDFIFO_ADDR", 0x07e4},
+    {"PM4_CMDFIFO_DATAH", 0x07e8},
+    {"PM4_CMDFIFO_DATAL", 0x07ec},
+    {"PM4_BUFFER_ADDR", 0x07f0},
+    {"PM4_BUFFER_DATAH", 0x07f4},
+    {"PM4_BUFFER_DATAL", 0x07f8},
+    {"PM4_MICRO_CNTL", 0x07fc},
+    {"CAP0_TRIG_CNTL", 0x0950},
+    {"CAP1_TRIG_CNTL", 0x09c0},
+    {"RBBM_STATUS", 0x0e40},
+    {"PM4_FIFO_DATA_EVEN", 0x1000},
+    {"PM4_FIFO_DATA_ODD", 0x1004},
+    {"DST_OFFSET", 0x1404},
+    {"DST_PITCH", 0x1408},
+    {"DST_WIDTH", 0x140c},
+    {"DST_HEIGHT", 0x1410},
+    {"SRC_X", 0x1414},
+    {"SRC_Y", 0x1418},
+    {"DST_X", 0x141c},
+    {"DST_Y", 0x1420},
+    {"SRC_PITCH_OFFSET", 0x1428},
+    {"DST_PITCH_OFFSET", 0x142c},
+    {"SRC_Y_X", 0x1434},
+    {"DST_Y_X", 0x1438},
+    {"DST_HEIGHT_WIDTH", 0x143c},
+    {"DP_GUI_MASTER_CNTL", 0x146c},
+    {"BRUSH_SCALE", 0x1470},
+    {"BRUSH_Y_X", 0x1474},
+    {"DP_BRUSH_BKGD_CLR", 0x1478},
+    {"DP_BRUSH_FRGD_CLR", 0x147c},
+    {"DST_WIDTH_X", 0x1588},
+    {"DST_HEIGHT_WIDTH_8", 0x158c},
+    {"SRC_X_Y", 0x1590},
+    {"DST_X_Y", 0x1594},
+    {"DST_WIDTH_HEIGHT", 0x1598},
+    {"DST_WIDTH_X_INCY", 0x159c},
+    {"DST_HEIGHT_Y", 0x15a0},
+    {"DST_X_SUB", 0x15a4},
+    {"DST_Y_SUB", 0x15a8},
+    {"SRC_OFFSET", 0x15ac},
+    {"SRC_PITCH", 0x15b0},
+    {"DST_HEIGHT_WIDTH_BW", 0x15b4},
+    {"CLR_CMP_CNTL", 0x15c0},
+    {"CLR_CMP_CLR_SRC", 0x15c4},
+    {"CLR_CMP_CLR_DST", 0x15c8},
+    {"CLR_CMP_MASK", 0x15cc},
+    {"DP_SRC_FRGD_CLR", 0x15d8},
+    {"DP_SRC_BKGD_CLR", 0x15dc},
+    {"DST_BRES_ERR", 0x1628},
+    {"DST_BRES_INC", 0x162c},
+    {"DST_BRES_DEC", 0x1630},
+    {"DST_BRES_LNTH", 0x1634},
+    {"DST_BRES_LNTH_SUB", 0x1638},
+    {"SC_LEFT", 0x1640},
+    {"SC_RIGHT", 0x1644},
+    {"SC_TOP", 0x1648},
+    {"SC_BOTTOM", 0x164c},
+    {"SRC_SC_RIGHT", 0x1654},
+    {"SRC_SC_BOTTOM", 0x165c},
+    {"GUI_DEBUG0", 0x16a0},
+    {"GUI_DEBUG1", 0x16a4},
+    {"GUI_TIMEOUT", 0x16b0},
+    {"GUI_TIMEOUT0", 0x16b4},
+    {"GUI_TIMEOUT1", 0x16b8},
+    {"GUI_PROBE", 0x16bc},
+    {"DP_CNTL", 0x16c0},
+    {"DP_DATATYPE", 0x16c4},
+    {"DP_MIX", 0x16c8},
+    {"DP_WRITE_MASK", 0x16cc},
+    {"DP_CNTL_XDIR_YDIR_YMAJOR", 0x16d0},
+    {"DEFAULT_OFFSET", 0x16e0},
+    {"DEFAULT_PITCH", 0x16e4},
+    {"DEFAULT_SC_BOTTOM_RIGHT", 0x16e8},
+    {"SC_TOP_LEFT", 0x16ec},
+    {"SC_BOTTOM_RIGHT", 0x16f0},
+    {"SRC_SC_BOTTOM_RIGHT", 0x16f4},
+    {"DST_TILE", 0x1700},
+    {"WAIT_UNTIL", 0x1720},
+    {"CACHE_CNTL", 0x1724},
+    {"GUI_STAT", 0x1740},
+    {"PC_GUI_MODE", 0x1744},
+    {"PC_GUI_CTLSTAT", 0x1748},
+    {"PC_DEBUG_MODE", 0x1760},
+    {"BRES_DST_ERR_DEC", 0x1780},
+    {"TRAIL_BRES_T12_ERR_DEC", 0x1784},
+    {"TRAIL_BRES_T12_INC", 0x1788},
+    {"DP_T12_CNTL", 0x178c},
+    {"DST_BRES_T1_LNTH", 0x1790},
+    {"DST_BRES_T2_LNTH", 0x1794},
+    {"SCALE_SRC_HEIGHT_WIDTH", 0x1994},
+    {"SCALE_OFFSET_0", 0x1998},
+    {"SCALE_PITCH", 0x199c},
+    {"SCALE_X_INC", 0x19a0},
+    {"SCALE_Y_INC", 0x19a4},
+    {"SCALE_HACC", 0x19a8},
+    {"SCALE_VACC", 0x19ac},
+    {"SCALE_DST_X_Y", 0x19b0},
+    {"SCALE_DST_HEIGHT_WIDTH", 0x19b4},
+    {"SCALE_3D_CNTL", 0x1a00},
+    {"SCALE_3D_DATATYPE", 0x1a20},
+    {"SETUP_CNTL", 0x1bc4},
+    {"SOLID_COLOR", 0x1bc8},
+    {"WINDOW_XY_OFFSET", 0x1bcc},
+    {"DRAW_LINE_POINT", 0x1bd0},
+    {"SETUP_CNTL_PM4", 0x1bd4},
+    {"DST_PITCH_OFFSET_C", 0x1c80},
+    {"DP_GUI_MASTER_CNTL_C", 0x1c84},
+    {"SC_TOP_LEFT_C", 0x1c88},
+    {"SC_BOTTOM_RIGHT_C", 0x1c8c},
+    {"CLR_CMP_MASK_3D", 0x1A28},
+    {"MISC_3D_STATE_CNTL_REG", 0x1CA0},
+    {"MC_SRC1_CNTL", 0x19D8},
+    {"TEX_CNTL", 0x1800},
+    {"RAGE128_MPP_TB_CONFIG", 0x01c0},
+    {NULL, -1}
+};
+
+const char *ati_reg_name(int num)
+{
+    int i;
+
+    num &= ~3;
+    for (i = 0; ati_reg_names[i].name; i++) {
+        if (ati_reg_names[i].num == num) {
+            return ati_reg_names[i].name;
+        }
+    }
+    return "unknown";
+}
+#else
+const char *ati_reg_name(int num)
+{
+    return "";
+}
+#endif
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
new file mode 100644
index 0000000000..c443448c12
--- /dev/null
+++ b/hw/display/ati_int.h
@@ -0,0 +1,75 @@
+/*
+ * QEMU ATI SVGA emulation
+ *
+ * Copyright (c) 2019 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "vga_int.h"
+
+/*#define DEBUG_ATI*/
+
+#ifdef DEBUG_ATI
+#define DPRINTF(fmt, ...) printf("%s: " fmt, __func__, ## __VA_ARGS__)
+#else
+#define DPRINTF(fmt, ...) do {} while (0)
+#endif
+
+#define TYPE_ATI_VGA "ati-vga"
+#define ATI_VGA(obj) OBJECT_CHECK(ATIVGAState, (obj), TYPE_ATI_VGA)
+
+typedef struct ATIVGARegs {
+    uint32_t mm_index;
+    uint32_t bios_scratch[8];
+    uint32_t crtc_gen_cntl;
+    uint32_t crtc_ext_cntl;
+    uint32_t dac_cntl;
+    uint32_t crtc_h_total_disp;
+    uint32_t crtc_h_sync_strt_wid;
+    uint32_t crtc_v_total_disp;
+    uint32_t crtc_v_sync_strt_wid;
+    uint32_t crtc_offset;
+    uint32_t crtc_offset_cntl;
+    uint32_t crtc_pitch;
+    uint32_t dst_offset;
+    uint32_t dst_pitch;
+    uint32_t dst_tile;
+    uint32_t dst_width;
+    uint32_t dst_height;
+    uint32_t src_offset;
+    uint32_t src_pitch;
+    uint32_t src_tile;
+    uint32_t src_x;
+    uint32_t src_y;
+    uint32_t dst_x;
+    uint32_t dst_y;
+    uint32_t dp_gui_master_cntl;
+    uint32_t dp_brush_bkgd_clr;
+    uint32_t dp_brush_frgd_clr;
+    uint32_t dp_src_frgd_clr;
+    uint32_t dp_src_bkgd_clr;
+    uint32_t dp_cntl;
+    uint32_t dp_datatype;
+    uint32_t dp_mix;
+    uint32_t dp_write_mask;
+    uint32_t default_offset;
+    uint32_t default_pitch;
+    uint32_t default_sc_bottom_right;
+} ATIVGARegs;
+
+typedef struct ATIVGAState {
+    PCIDevice dev;
+    VGACommonState vga;
+    uint16_t dev_id;
+    uint16_t mode;
+    MemoryRegion io;
+    MemoryRegion mm;
+    ATIVGARegs regs;
+} ATIVGAState;
+
+const char *ati_reg_name(int num);
+
+void ati_2d_blit(ATIVGAState *s);
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
new file mode 100644
index 0000000000..0550637a9f
--- /dev/null
+++ b/hw/display/ati_regs.h
@@ -0,0 +1,454 @@
+/*
+ * ATI VGA register definitions
+ *
+ * based on:
+ * linux/include/video/aty128.h
+ *     Register definitions for ATI Rage128 boards
+ *     Anthony Tong <atong@uiuc.edu>, 1999
+ *     Brad Douglas <brad@neruo.com>, 2000
+ *
+ * and linux/include/video/radeon.h
+ *
+ * This work is licensed under the GNU GPL license version 2.
+ */
+
+/*
+ * Register mapping:
+ * 0x0000-0x00ff Misc regs also accessible via io and mmio space
+ * 0x0100-0x0eff Misc regs only accessible via mmio
+ * 0x0f00-0x0fff Read-only copy of PCI config regs
+ * 0x1000-0x13ff Concurrent Command Engine (CCE) regs
+ * 0x1400-0x1fff GUI (drawing engine) regs
+ */
+
+#ifndef ATI_REGS_H
+#define ATI_REGS_H
+
+#define MM_INDEX                                0x0000
+#define MM_DATA                                 0x0004
+#define CLOCK_CNTL_INDEX                        0x0008
+#define CLOCK_CNTL_DATA                         0x000c
+#define BIOS_0_SCRATCH                          0x0010
+#define BUS_CNTL                                0x0030
+#define BUS_CNTL1                               0x0034
+#define GEN_INT_CNTL                            0x0040
+#define CRTC_GEN_CNTL                           0x0050
+#define CRTC_EXT_CNTL                           0x0054
+#define DAC_CNTL                                0x0058
+#define GPIO_MONID                              0x0068
+#define I2C_CNTL_1                              0x0094
+#define PALETTE_INDEX                           0x00b0
+#define PALETTE_DATA                            0x00b4
+#define CNFG_CNTL                               0x00e0
+#define GEN_RESET_CNTL                          0x00f0
+#define CNFG_MEMSIZE                            0x00f8
+#define MEM_CNTL                                0x0140
+#define MC_FB_LOCATION                          0x0148
+#define MC_AGP_LOCATION                         0x014C
+#define MC_STATUS                               0x0150
+#define MEM_POWER_MISC                          0x015c
+#define AGP_BASE                                0x0170
+#define AGP_CNTL                                0x0174
+#define AGP_APER_OFFSET                         0x0178
+#define PCI_GART_PAGE                           0x017c
+#define PC_NGUI_MODE                            0x0180
+#define PC_NGUI_CTLSTAT                         0x0184
+#define MPP_TB_CONFIG                           0x01C0
+#define MPP_GP_CONFIG                           0x01C8
+#define VIPH_CONTROL                            0x01D0
+#define CRTC_H_TOTAL_DISP                       0x0200
+#define CRTC_H_SYNC_STRT_WID                    0x0204
+#define CRTC_V_TOTAL_DISP                       0x0208
+#define CRTC_V_SYNC_STRT_WID                    0x020c
+#define CRTC_VLINE_CRNT_VLINE                   0x0210
+#define CRTC_CRNT_FRAME                         0x0214
+#define CRTC_GUI_TRIG_VLINE                     0x0218
+#define CRTC_OFFSET                             0x0224
+#define CRTC_OFFSET_CNTL                        0x0228
+#define CRTC_PITCH                              0x022c
+#define OVR_CLR                                 0x0230
+#define OVR_WID_LEFT_RIGHT                      0x0234
+#define OVR_WID_TOP_BOTTOM                      0x0238
+#define LVDS_GEN_CNTL                           0x02d0
+#define DDA_CONFIG                              0x02e0
+#define DDA_ON_OFF                              0x02e4
+#define VGA_DDA_CONFIG                          0x02e8
+#define VGA_DDA_ON_OFF                          0x02ec
+#define CRTC2_H_TOTAL_DISP                      0x0300
+#define CRTC2_H_SYNC_STRT_WID                   0x0304
+#define CRTC2_V_TOTAL_DISP                      0x0308
+#define CRTC2_V_SYNC_STRT_WID                   0x030c
+#define CRTC2_VLINE_CRNT_VLINE                  0x0310
+#define CRTC2_CRNT_FRAME                        0x0314
+#define CRTC2_GUI_TRIG_VLINE                    0x0318
+#define CRTC2_OFFSET                            0x0324
+#define CRTC2_OFFSET_CNTL                       0x0328
+#define CRTC2_PITCH                             0x032c
+#define DDA2_CONFIG                             0x03e0
+#define DDA2_ON_OFF                             0x03e4
+#define CRTC2_GEN_CNTL                          0x03f8
+#define CRTC2_STATUS                            0x03fc
+#define OV0_SCALE_CNTL                          0x0420
+#define SUBPIC_CNTL                             0x0540
+#define PM4_BUFFER_OFFSET                       0x0700
+#define PM4_BUFFER_CNTL                         0x0704
+#define PM4_BUFFER_WM_CNTL                      0x0708
+#define PM4_BUFFER_DL_RPTR_ADDR                 0x070c
+#define PM4_BUFFER_DL_RPTR                      0x0710
+#define PM4_BUFFER_DL_WPTR                      0x0714
+#define PM4_VC_FPU_SETUP                        0x071c
+#define PM4_FPU_CNTL                            0x0720
+#define PM4_VC_FORMAT                           0x0724
+#define PM4_VC_CNTL                             0x0728
+#define PM4_VC_I01                              0x072c
+#define PM4_VC_VLOFF                            0x0730
+#define PM4_VC_VLSIZE                           0x0734
+#define PM4_IW_INDOFF                           0x0738
+#define PM4_IW_INDSIZE                          0x073c
+#define PM4_FPU_FPX0                            0x0740
+#define PM4_FPU_FPY0                            0x0744
+#define PM4_FPU_FPX1                            0x0748
+#define PM4_FPU_FPY1                            0x074c
+#define PM4_FPU_FPX2                            0x0750
+#define PM4_FPU_FPY2                            0x0754
+#define PM4_FPU_FPY3                            0x0758
+#define PM4_FPU_FPY4                            0x075c
+#define PM4_FPU_FPY5                            0x0760
+#define PM4_FPU_FPY6                            0x0764
+#define PM4_FPU_FPR                             0x0768
+#define PM4_FPU_FPG                             0x076c
+#define PM4_FPU_FPB                             0x0770
+#define PM4_FPU_FPA                             0x0774
+#define PM4_FPU_INTXY0                          0x0780
+#define PM4_FPU_INTXY1                          0x0784
+#define PM4_FPU_INTXY2                          0x0788
+#define PM4_FPU_INTARGB                         0x078c
+#define PM4_FPU_FPTWICEAREA                     0x0790
+#define PM4_FPU_DMAJOR01                        0x0794
+#define PM4_FPU_DMAJOR12                        0x0798
+#define PM4_FPU_DMAJOR02                        0x079c
+#define PM4_FPU_STAT                            0x07a0
+#define PM4_STAT                                0x07b8
+#define PM4_TEST_CNTL                           0x07d0
+#define PM4_MICROCODE_ADDR                      0x07d4
+#define PM4_MICROCODE_RADDR                     0x07d8
+#define PM4_MICROCODE_DATAH                     0x07dc
+#define PM4_MICROCODE_DATAL                     0x07e0
+#define PM4_CMDFIFO_ADDR                        0x07e4
+#define PM4_CMDFIFO_DATAH                       0x07e8
+#define PM4_CMDFIFO_DATAL                       0x07ec
+#define PM4_BUFFER_ADDR                         0x07f0
+#define PM4_BUFFER_DATAH                        0x07f4
+#define PM4_BUFFER_DATAL                        0x07f8
+#define PM4_MICRO_CNTL                          0x07fc
+#define CAP0_TRIG_CNTL                          0x0950
+#define CAP1_TRIG_CNTL                          0x09c0
+
+#define RBBM_STATUS                             0x0e40
+
+/*
+ * GUI Block Memory Mapped Registers
+ * These registers are FIFOed.
+ */
+#define PM4_FIFO_DATA_EVEN                      0x1000
+#define PM4_FIFO_DATA_ODD                       0x1004
+
+#define DST_OFFSET                              0x1404
+#define DST_PITCH                               0x1408
+#define DST_WIDTH                               0x140c
+#define DST_HEIGHT                              0x1410
+#define SRC_X                                   0x1414
+#define SRC_Y                                   0x1418
+#define DST_X                                   0x141c
+#define DST_Y                                   0x1420
+#define SRC_PITCH_OFFSET                        0x1428
+#define DST_PITCH_OFFSET                        0x142c
+#define SRC_Y_X                                 0x1434
+#define DST_Y_X                                 0x1438
+#define DST_HEIGHT_WIDTH                        0x143c
+#define DP_GUI_MASTER_CNTL                      0x146c
+#define BRUSH_SCALE                             0x1470
+#define BRUSH_Y_X                               0x1474
+#define DP_BRUSH_BKGD_CLR                       0x1478
+#define DP_BRUSH_FRGD_CLR                       0x147c
+#define DST_WIDTH_X                             0x1588
+#define DST_HEIGHT_WIDTH_8                      0x158c
+#define SRC_X_Y                                 0x1590
+#define DST_X_Y                                 0x1594
+#define DST_WIDTH_HEIGHT                        0x1598
+#define DST_WIDTH_X_INCY                        0x159c
+#define DST_HEIGHT_Y                            0x15a0
+#define DST_X_SUB                               0x15a4
+#define DST_Y_SUB                               0x15a8
+#define SRC_OFFSET                              0x15ac
+#define SRC_PITCH                               0x15b0
+#define DST_HEIGHT_WIDTH_BW                     0x15b4
+#define CLR_CMP_CNTL                            0x15c0
+#define CLR_CMP_CLR_SRC                         0x15c4
+#define CLR_CMP_CLR_DST                         0x15c8
+#define CLR_CMP_MASK                            0x15cc
+#define DP_SRC_FRGD_CLR                         0x15d8
+#define DP_SRC_BKGD_CLR                         0x15dc
+#define DST_BRES_ERR                            0x1628
+#define DST_BRES_INC                            0x162c
+#define DST_BRES_DEC                            0x1630
+#define DST_BRES_LNTH                           0x1634
+#define DST_BRES_LNTH_SUB                       0x1638
+#define SC_LEFT                                 0x1640
+#define SC_RIGHT                                0x1644
+#define SC_TOP                                  0x1648
+#define SC_BOTTOM                               0x164c
+#define SRC_SC_RIGHT                            0x1654
+#define SRC_SC_BOTTOM                           0x165c
+#define GUI_DEBUG0                              0x16a0
+#define GUI_DEBUG1                              0x16a4
+#define GUI_TIMEOUT                             0x16b0
+#define GUI_TIMEOUT0                            0x16b4
+#define GUI_TIMEOUT1                            0x16b8
+#define GUI_PROBE                               0x16bc
+#define DP_CNTL                                 0x16c0
+#define DP_DATATYPE                             0x16c4
+#define DP_MIX                                  0x16c8
+#define DP_WRITE_MASK                           0x16cc
+#define DP_CNTL_XDIR_YDIR_YMAJOR                0x16d0
+#define DEFAULT_OFFSET                          0x16e0
+#define DEFAULT_PITCH                           0x16e4
+#define DEFAULT_SC_BOTTOM_RIGHT                 0x16e8
+#define SC_TOP_LEFT                             0x16ec
+#define SC_BOTTOM_RIGHT                         0x16f0
+#define SRC_SC_BOTTOM_RIGHT                     0x16f4
+#define DST_TILE                                0x1700
+#define WAIT_UNTIL                              0x1720
+#define CACHE_CNTL                              0x1724
+#define GUI_STAT                                0x1740
+#define PC_GUI_MODE                             0x1744
+#define PC_GUI_CTLSTAT                          0x1748
+#define PC_DEBUG_MODE                           0x1760
+#define BRES_DST_ERR_DEC                        0x1780
+#define TRAIL_BRES_T12_ERR_DEC                  0x1784
+#define TRAIL_BRES_T12_INC                      0x1788
+#define DP_T12_CNTL                             0x178c
+#define DST_BRES_T1_LNTH                        0x1790
+#define DST_BRES_T2_LNTH                        0x1794
+#define SCALE_SRC_HEIGHT_WIDTH                  0x1994
+#define SCALE_OFFSET_0                          0x1998
+#define SCALE_PITCH                             0x199c
+#define SCALE_X_INC                             0x19a0
+#define SCALE_Y_INC                             0x19a4
+#define SCALE_HACC                              0x19a8
+#define SCALE_VACC                              0x19ac
+#define SCALE_DST_X_Y                           0x19b0
+#define SCALE_DST_HEIGHT_WIDTH                  0x19b4
+#define SCALE_3D_CNTL                           0x1a00
+#define SCALE_3D_DATATYPE                       0x1a20
+#define SETUP_CNTL                              0x1bc4
+#define SOLID_COLOR                             0x1bc8
+#define WINDOW_XY_OFFSET                        0x1bcc
+#define DRAW_LINE_POINT                         0x1bd0
+#define SETUP_CNTL_PM4                          0x1bd4
+#define DST_PITCH_OFFSET_C                      0x1c80
+#define DP_GUI_MASTER_CNTL_C                    0x1c84
+#define SC_TOP_LEFT_C                           0x1c88
+#define SC_BOTTOM_RIGHT_C                       0x1c8c
+
+#define CLR_CMP_MASK_3D                         0x1A28
+#define MISC_3D_STATE_CNTL_REG                  0x1CA0
+#define MC_SRC1_CNTL                            0x19D8
+#define TEX_CNTL                                0x1800
+
+/* CONSTANTS */
+#define GUI_ACTIVE                              0x80000000
+#define ENGINE_IDLE                             0x0
+
+#define PLL_WR_EN                               0x00000080
+
+#define CLK_PIN_CNTL                            0x01
+#define PPLL_CNTL                               0x02
+#define PPLL_REF_DIV                            0x03
+#define PPLL_DIV_0                              0x04
+#define PPLL_DIV_1                              0x05
+#define PPLL_DIV_2                              0x06
+#define PPLL_DIV_3                              0x07
+#define VCLK_ECP_CNTL                           0x08
+#define HTOTAL_CNTL                             0x09
+#define X_MPLL_REF_FB_DIV                       0x0a
+#define XPLL_CNTL                               0x0b
+#define XDLL_CNTL                               0x0c
+#define XCLK_CNTL                               0x0d
+#define MPLL_CNTL                               0x0e
+#define MCLK_CNTL                               0x0f
+#define AGP_PLL_CNTL                            0x10
+#define FCP_CNTL                                0x12
+#define PLL_TEST_CNTL                           0x13
+#define P2PLL_CNTL                              0x2a
+#define P2PLL_REF_DIV                           0x2b
+#define P2PLL_DIV_0                             0x2b
+#define POWER_MANAGEMENT                        0x2f
+
+#define PPLL_RESET                              0x00000001
+#define PPLL_ATOMIC_UPDATE_EN                   0x00010000
+#define PPLL_VGA_ATOMIC_UPDATE_EN               0x00020000
+#define PPLL_REF_DIV_MASK                       0x000003FF
+#define PPLL_FB3_DIV_MASK                       0x000007FF
+#define PPLL_POST3_DIV_MASK                     0x00070000
+#define PPLL_ATOMIC_UPDATE_R                    0x00008000
+#define PPLL_ATOMIC_UPDATE_W                    0x00008000
+#define MEM_CFG_TYPE_MASK                       0x00000003
+#define XCLK_SRC_SEL_MASK                       0x00000007
+#define XPLL_FB_DIV_MASK                        0x0000FF00
+#define X_MPLL_REF_DIV_MASK                     0x000000FF
+
+/* Config control values (CONFIG_CNTL) */
+#define CFG_VGA_IO_DIS                          0x00000400
+
+/* CRTC control values (CRTC_GEN_CNTL) */
+#define CRTC_CSYNC_EN                           0x00000010
+
+#define CRTC2_DBL_SCAN_EN                       0x00000001
+#define CRTC2_DISPLAY_DIS                       0x00800000
+#define CRTC2_FIFO_EXTSENSE                     0x00200000
+#define CRTC2_ICON_EN                           0x00100000
+#define CRTC2_CUR_EN                            0x00010000
+#define CRTC2_EXT_DISP_EN                       0x01000000
+#define CRTC2_EN                                0x02000000
+#define CRTC2_DISP_REQ_EN_B                     0x04000000
+
+#define CRTC_PIX_WIDTH_MASK                     0x00000700
+#define CRTC_PIX_WIDTH_4BPP                     0x00000100
+#define CRTC_PIX_WIDTH_8BPP                     0x00000200
+#define CRTC_PIX_WIDTH_15BPP                    0x00000300
+#define CRTC_PIX_WIDTH_16BPP                    0x00000400
+#define CRTC_PIX_WIDTH_24BPP                    0x00000500
+#define CRTC_PIX_WIDTH_32BPP                    0x00000600
+
+/* DAC_CNTL bit constants */
+#define DAC_8BIT_EN                             0x00000100
+#define DAC_MASK                                0xFF000000
+#define DAC_BLANKING                            0x00000004
+#define DAC_RANGE_CNTL                          0x00000003
+#define DAC_CLK_SEL                             0x00000010
+#define DAC_PALETTE_ACCESS_CNTL                 0x00000020
+#define DAC_PALETTE2_SNOOP_EN                   0x00000040
+#define DAC_PDWN                                0x00008000
+
+/* CRTC_EXT_CNTL */
+#define CRT_CRTC_DISPLAY_DIS                    0x00000400
+#define CRT_CRTC_ON                             0x00008000
+
+/* GEN_RESET_CNTL bit constants */
+#define SOFT_RESET_GUI                          0x00000001
+#define SOFT_RESET_VCLK                         0x00000100
+#define SOFT_RESET_PCLK                         0x00000200
+#define SOFT_RESET_ECP                          0x00000400
+#define SOFT_RESET_DISPENG_XCLK                 0x00000800
+
+/* PC_GUI_CTLSTAT bit constants */
+#define PC_BUSY_INIT                            0x10000000
+#define PC_BUSY_GUI                             0x20000000
+#define PC_BUSY_NGUI                            0x40000000
+#define PC_BUSY                                 0x80000000
+
+#define BUS_MASTER_DIS                          0x00000040
+#define PM4_BUFFER_CNTL_NONPM4                  0x00000000
+
+/* DP_DATATYPE bit constants */
+#define DST_8BPP                                0x00000002
+#define DST_15BPP                               0x00000003
+#define DST_16BPP                               0x00000004
+#define DST_24BPP                               0x00000005
+#define DST_32BPP                               0x00000006
+
+#define BRUSH_SOLIDCOLOR                        0x00000d00
+
+/* DP_GUI_MASTER_CNTL bit constants */
+#define GMC_SRC_PITCH_OFFSET_DEFAULT            0x00000000
+#define GMC_DST_PITCH_OFFSET_DEFAULT            0x00000000
+#define GMC_SRC_CLIP_DEFAULT                    0x00000000
+#define GMC_DST_CLIP_DEFAULT                    0x00000000
+#define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
+#define GMC_SRC_DSTCOLOR                        0x00003000
+#define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
+#define GMC_DP_SRC_RECT                         0x02000000
+#define GMC_3D_FCN_EN_CLR                       0x00000000
+#define GMC_AUX_CLIP_CLEAR                      0x20000000
+#define GMC_DST_CLR_CMP_FCN_CLEAR               0x10000000
+#define GMC_WRITE_MASK_SET                      0x40000000
+#define GMC_DP_CONVERSION_TEMP_6500             0x00000000
+
+/* DP_GUI_MASTER_CNTL ROP3 named constants */
+#define GMC_ROP3_MASK                           0x00ff0000
+#define ROP3_BLACKNESS                          0x00000000
+#define ROP3_SRCCOPY                            0x00cc0000
+#define ROP3_PATCOPY                            0x00f00000
+#define ROP3_WHITENESS                          0x00ff0000
+
+#define SRC_DSTCOLOR                            0x00030000
+
+/* DP_CNTL bit constants */
+#define DST_X_RIGHT_TO_LEFT                     0x00000000
+#define DST_X_LEFT_TO_RIGHT                     0x00000001
+#define DST_Y_BOTTOM_TO_TOP                     0x00000000
+#define DST_Y_TOP_TO_BOTTOM                     0x00000002
+#define DST_X_MAJOR                             0x00000000
+#define DST_Y_MAJOR                             0x00000004
+#define DST_X_TILE                              0x00000008
+#define DST_Y_TILE                              0x00000010
+#define DST_LAST_PEL                            0x00000020
+#define DST_TRAIL_X_RIGHT_TO_LEFT               0x00000000
+#define DST_TRAIL_X_LEFT_TO_RIGHT               0x00000040
+#define DST_TRAP_FILL_RIGHT_TO_LEFT             0x00000000
+#define DST_TRAP_FILL_LEFT_TO_RIGHT             0x00000080
+#define DST_BRES_SIGN                           0x00000100
+#define DST_HOST_BIG_ENDIAN_EN                  0x00000200
+#define DST_POLYLINE_NONLAST                    0x00008000
+#define DST_RASTER_STALL                        0x00010000
+#define DST_POLY_EDGE                           0x00040000
+
+/* DP_MIX bit constants */
+#define DP_SRC_RECT                             0x00000200
+#define DP_SRC_HOST                             0x00000300
+#define DP_SRC_HOST_BYTEALIGN                   0x00000400
+
+/* LVDS_GEN_CNTL constants */
+#define LVDS_BL_MOD_LEVEL_MASK                  0x0000ff00
+#define LVDS_BL_MOD_LEVEL_SHIFT                 8
+#define LVDS_BL_MOD_EN                          0x00010000
+#define LVDS_DIGION                             0x00040000
+#define LVDS_BLON                               0x00080000
+#define LVDS_ON                                 0x00000001
+#define LVDS_DISPLAY_DIS                        0x00000002
+#define LVDS_PANEL_TYPE_2PIX_PER_CLK            0x00000004
+#define LVDS_PANEL_24BITS_TFT                   0x00000008
+#define LVDS_FRAME_MOD_NO                       0x00000000
+#define LVDS_FRAME_MOD_2_LEVELS                 0x00000010
+#define LVDS_FRAME_MOD_4_LEVELS                 0x00000020
+#define LVDS_RST_FM                             0x00000040
+#define LVDS_EN                                 0x00000080
+
+/* CRTC2_GEN_CNTL constants */
+#define CRTC2_EN                                0x02000000
+
+/* POWER_MANAGEMENT constants */
+#define PWR_MGT_ON                              0x00000001
+#define PWR_MGT_MODE_MASK                       0x00000006
+#define PWR_MGT_MODE_PIN                        0x00000000
+#define PWR_MGT_MODE_REGISTER                   0x00000002
+#define PWR_MGT_MODE_TIMER                      0x00000004
+#define PWR_MGT_MODE_PCI                        0x00000006
+#define PWR_MGT_AUTO_PWR_UP_EN                  0x00000008
+#define PWR_MGT_ACTIVITY_PIN_ON                 0x00000010
+#define PWR_MGT_STANDBY_POL                     0x00000020
+#define PWR_MGT_SUSPEND_POL                     0x00000040
+#define PWR_MGT_SELF_REFRESH                    0x00000080
+#define PWR_MGT_ACTIVITY_PIN_EN                 0x00000100
+#define PWR_MGT_KEYBD_SNOOP                     0x00000200
+#define PWR_MGT_TRISTATE_MEM_EN                 0x00000800
+#define PWR_MGT_SELW4MS                         0x00001000
+#define PWR_MGT_SLOWDOWN_MCLK                   0x00002000
+
+#define PMI_PMSCR_REG                           0x60
+
+/* used by ATI bug fix for hardware ROM */
+#define RAGE128_MPP_TB_CONFIG                   0x01c0
+
+#endif /* ATI_REGS_H */
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 387c6b8931..27c36367a7 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -137,3 +137,7 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
 sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
 sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
 sii9022_switch_mode(const char *mode) "mode: %s"
+
+# hw/display/ati*.c
+ati_mm_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%d 0x%"HWADDR_PRIx " %s -> 0x%"PRIx64
+ati_mm_write(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%d 0x%"HWADDR_PRIx " %s <- 0x%"PRIx64
-- 
2.13.7
