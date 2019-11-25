Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A04C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5274C2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5274C2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaEfK-0004vr-ED
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 02:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@localhost>) id 1iaEaz-0008IM-LP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@localhost>) id 1iaEav-0003if-2E
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:52:12 -0500
Received: from [2406:7400:73:186d:af79:94fc:29ef:77e6] (port=56108
 helo=localhost) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aaron@localhost>) id 1iaEau-0003fa-Ec
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:52:09 -0500
Received: by localhost (Postfix, from userid 1000)
 id 65741D4170E; Mon, 25 Nov 2019 19:53:35 +0530 (IST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 4/8] Got GPU init working. Stops at probing display
Date: Mon, 25 Nov 2019 19:49:10 +0530
Message-Id: <20191125141908.5441-5-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125141908.5441-1-aaron.zakhrov@gmail.com>
References: <20191125141908.5441-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2406:7400:73:186d:af79:94fc:29ef:77e6
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

---
 hw/display/ati.c  |   9 +-
 hw/display/r300.c | 571 +++++++++++++++++++++++++++++++++++++---------
 hw/display/r300.h |  77 ++++++-
 3 files changed, 544 insertions(+), 113 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index db3b254316..1d36233163 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -44,7 +44,7 @@ enum { VGA_MODE, EXT_MODE };
=20
 static void ati_vga_switch_mode(ATIVGAState *s)
 {
-    DPRINTF("%d -> %d\n",
+    qemu_log("%d -> %d\n",
             s->mode, !!(s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN));
     if (s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN) {
         /* Extended mode enabled */
@@ -88,7 +88,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
                 qemu_log_mask(LOG_UNIMP, "Unsupported bpp value\n");
             }
             assert(bpp !=3D 0);
-            DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp=
, offs);
+            qemu_log("Switching to %dx%d %d %d @ %x\n", h, v, stride, bp=
p, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
             s->vga.big_endian_fb =3D (s->regs.config_cntl & APER_0_ENDIA=
N ||
@@ -111,14 +111,14 @@ static void ati_vga_switch_mode(ATIVGAState *s)
                 vbe_ioport_write_data(&s->vga, 0, stride);
                 stride *=3D bypp;
                 if (offs % stride) {
-                    DPRINTF("CRTC offset is not multiple of pitch\n");
+                    qemu_log("CRTC offset is not multiple of pitch\n");
                     vbe_ioport_write_index(&s->vga, 0,
                                            VBE_DISPI_INDEX_X_OFFSET);
                     vbe_ioport_write_data(&s->vga, 0, offs % stride / by=
pp);
                 }
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFF=
SET);
                 vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                DPRINTF("VBE offset (%d,%d), vbe_start_addr=3D%x\n",
+                qemu_log("VBE offset (%d,%d), vbe_start_addr=3D%x\n",
                         s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
                         s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
                         s->vga.vbe_start_addr);
@@ -129,6 +129,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
         s->mode =3D VGA_MODE;
         vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
         vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+        qemu_log("VGA MODE %d \n",s->mode);
     }
 }
=20
diff --git a/hw/display/r300.c b/hw/display/r300.c
index 074dbf5b2d..5bd71142a8 100644
--- a/hw/display/r300.c
+++ b/hw/display/r300.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "r300.h"
 #include "r300_reg.h"
+#include "r100d.h"
 #include "radeon_reg.h"
 #include "vga-access.h"
 #include "hw/qdev-properties.h"
@@ -38,18 +39,20 @@ static const struct {
     uint16_t dev_id;
 } r300_model_aliases[] =3D {
     { "radeon9500", PCI_DEVICE_ID_ATI_RADEON_9500_PRO },
+    { "radeon9700", PCI_DEVICE_ID_ATI_RADEON_9700 }
 };
=20
 enum { VGA_MODE, EXT_MODE };
=20
 static void r300_vga_switch_mode(RADVGAState *s)
 {
-    DPRINTF("%d -> %d\n",
-            s->mode, !!(s->regs.crtc_gen_cntl & RADEON_CRTC_EXT_DISP_EN)=
);
-    if (s->regs.crtc_gen_cntl & RADEON_CRTC_EXT_DISP_EN) {
+    qemu_log(" R300 %d -> %d\n",
+            s->mode, !(s->regs.crtc_gen_cntl & RADEON_CRTC_EN));
+    qemu_log("R300 RADEON_CRTC_EXT_DISP_EN =3D %08x CRTC_GEN_CNTL =3D %0=
8x ",RADEON_CRTC_EN,s->regs.crtc_gen_cntl);
+    if (s->regs.crtc_gen_cntl & ~RADEON_CRTC_EN) {
         /* Extended mode enabled */
         s->mode =3D EXT_MODE;
-        if (s->regs.crtc_gen_cntl & RADEON_CRTC2_EN) {
+        if (s->regs.crtc_gen_cntl & ~RADEON_CRTC_EN) {
             /* CRT controller enabled, use CRTC values */
             /* FIXME Should these be the same as VGA CRTC regs? */
             uint32_t offs =3D s->regs.crtc_offset & 0x07ffffff;
@@ -65,32 +68,32 @@ static void r300_vga_switch_mode(RADVGAState *s)
             }
             h =3D ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
             v =3D (s->regs.crtc_v_total_disp >> 16) + 1;
-            // switch (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_MODE_MASK=
) {
-            // // case RADEON_CRTC_PIX_WIDTH_4BPP:
-            // //     bpp =3D 4;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_8BPP:
-            // //     bpp =3D 8;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_15BPP:
-            // //     bpp =3D 15;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_16BPP:
-            // //     bpp =3D 16;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_24BPP:
-            // //     bpp =3D 24;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_32BPP:
-            // //     bpp =3D 32;
-            // //     break;
-            // default:
-            //     qemu_log_mask(LOG_UNIMP, "Unsupported bpp value\n");
-            //     qemu_log_mask(LOG_UNIMP,"%d",s->regs.crtc_gen_cntl & =
RADEON_CRTC_CUR_MODE_MASK);
-            // }
-            bpp=3D 32;
+            switch (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_MODE_MASK) {
+            // case RADEON_CRTC_PIX_WIDTH_4BPP:
+            //     bpp =3D 4;
+            //     break;
+            // case RADEON_CRTC_PIX_WIDTH_8BPP:
+            //     bpp =3D 8;
+            //     break;
+            // case RADEON_CRTC_PIX_WIDTH_15BPP:
+            //     bpp =3D 15;
+            //     break;
+            // case RADEON_CRTC_PIX_WIDTH_16BPP:
+            //     bpp =3D 16;
+            //     break;
+            case RADEON_CRTC_CUR_MODE_24BPP:
+                bpp =3D 24;
+                break;
+            // case RADEON_CRTC_PIX_WIDTH_32BPP:
+            //     bpp =3D 32;
+            //     break;
+            default:
+                qemu_log_mask(LOG_UNIMP, "Unsupported bpp value\n");
+                qemu_log_mask(LOG_UNIMP,"%d \n",s->regs.crtc_gen_cntl & =
RADEON_CRTC_CUR_MODE_MASK);
+            }
+            bpp=3D 24;
             assert(bpp !=3D 0);
-            DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp=
, offs);
+            qemu_log("Switching to %dx%d %d %d @ %x\n", h, v, stride, bp=
p, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
             s->vga.big_endian_fb =3D (s->regs.config_cntl & PDP_ENDIAN |=
|
@@ -113,14 +116,14 @@ static void r300_vga_switch_mode(RADVGAState *s)
                 vbe_ioport_write_data(&s->vga, 0, stride);
                 stride *=3D bypp;
                 if (offs % stride) {
-                    DPRINTF("CRTC offset is not multiple of pitch\n");
+                    qemu_log("CRTC offset is not multiple of pitch\n");
                     vbe_ioport_write_index(&s->vga, 0,
                                            VBE_DISPI_INDEX_X_OFFSET);
                     vbe_ioport_write_data(&s->vga, 0, offs % stride / by=
pp);
                 }
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFF=
SET);
                 vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                DPRINTF("VBE offset (%d,%d), vbe_start_addr=3D%x\n",
+                qemu_log("VBE offset (%d,%d), vbe_start_addr=3D%x\n",
                         s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
                         s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
                         s->vga.vbe_start_addr);
@@ -131,6 +134,7 @@ static void r300_vga_switch_mode(RADVGAState *s)
         s->mode =3D VGA_MODE;
         vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
         vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+          qemu_log("R300 VGA MODE %d \n",s->mode);
     }
 }
=20
@@ -278,6 +282,8 @@ static uint64_t r300_mm_read(void *opaque, hwaddr add=
r, unsigned int size)
     uint64_t val =3D 0;
=20
     switch (addr) {
+      case RADEON_MCLK_CNTL:
+      val =3D RADEON_FORCEON_MCLKA;
     case RADEON_MC_STATUS:
         val =3D s->regs.mc_status;
         break;
@@ -444,9 +450,6 @@ static uint64_t r300_mm_read(void *opaque, hwaddr add=
r, unsigned int size)
         break;
     case RADEON_SRC_PITCH:
         val =3D s->regs.src_pitch;
-        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            val &=3D s->regs.src_tile << RADEON_PITCH_SHIFT;
-        }
         break;
     case RADEON_DP_BRUSH_BKGD_CLR:
         val =3D s->regs.dp_brush_bkgd_clr;
@@ -474,11 +477,6 @@ static uint64_t r300_mm_read(void *opaque, hwaddr ad=
dr, unsigned int size)
         break;
     case RADEON_DEFAULT_OFFSET:
         val =3D s->regs.default_offset;
-        if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            val >>=3D 10;
-            val |=3D s->regs.default_pitch << 16;
-            val |=3D s->regs.default_tile << 30;
-        }
         break;
     case RADEON_DEFAULT_PITCH:
         val =3D s->regs.default_pitch;
@@ -487,12 +485,182 @@ static uint64_t r300_mm_read(void *opaque, hwaddr =
addr, unsigned int size)
     case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
         val =3D s->regs.default_sc_bottom_right;
         break;
+        case R300_GB_ENABLE:
+            val =3D s->regs.r300_gb_enable;
+            break;
+        case R300_GB_TILE_CONFIG:
+                val=3D s->regs.r300_gb_tile_config;
+                break;
+        case R300_GB_FIFO_SIZE:
+                val =3Ds->regs.r300_gb_fifo_size ;
+                break;
+        case RADEON_ISYNC_CNTL:
+                val =3Ds->regs.isync_cntl;
+                break;
+      case R300_DST_PIPE_CONFIG:
+                val =3Ds->regs.r300_dst_pipe_config;
+                break;
+      case R300_RB2D_DSTCACHE_MODE:
+                val =3D s->regs.r300_rb2d_dstcache_mode;
+                break;
+      case RADEON_WAIT_UNTIL:
+                val =3D s->regs.wait_until;
+                break;
+      case R300_GB_SELECT:
+                val =3D s->regs.r300_gb_select;
+                break;
+      case R300_RB3D_DSTCACHE_CTLSTAT:
+                val =3D s->regs.r300_rb3d_dstcache_ctlstat;
+                break;
+      case R300_RB3D_ZCACHE_CTLSTAT:
+                val =3D s->regs.r300_rb3d_zcache_ctlstat;
+                break;
+      case R300_GB_AA_CONFIG:
+                val =3D s->regs.r300_gb_aa_config;
+                break;
+      case R300_RE_SCISSORS_TL:
+                val =3D s->regs.r300_re_scissors_tl;
+                break;
+
+      case R300_RE_SCISSORS_BR:
+                val =3D s->regs.r300_re_scissors_br;
+                break;
+      case RADEON_HOST_PATH_CNTL:
+                val =3D s->regs.host_path_cntl;
+                break;
+
+      case R300_GB_MSPOS0:
+                val =3D s->regs.r300_gb_mpos_0;
+                break;
+
+      case R300_GB_MSPOS1:
+                val =3D s->regs.r300_gb_mpos_1;
+                break;
+
+                case RADEON_SURFACE_CNTL:
+                          val =3D s->regs.surface_cntl;
+                          break;
+                case RADEON_SURFACE0_INFO:
+                          val =3D s->regs.surface0_info;
+                          break;
+                case RADEON_SURFACE1_INFO:
+                          val =3D s->regs.surface1_info;
+                          break;
+
+                case RADEON_SURFACE2_INFO:
+                val =3D s->regs.surface2_info;
+                break;
+                case RADEON_SURFACE3_INFO:
+                val =3D s->regs.surface3_info;
+                break;
+                case RADEON_SURFACE4_INFO:
+                val =3D s->regs.surface4_info;
+                break;
+                case RADEON_SURFACE5_INFO:
+                val =3D s->regs.surface5_info;
+                break;
+                case RADEON_SURFACE6_INFO:
+                val =3D s->regs.surface6_info;
+                break;
+                case RADEON_SURFACE7_INFO:
+                val =3D s->regs.surface7_info;
+                break;
+                case RADEON_OV0_SCALE_CNTL:
+                val =3D s->regs.ov0_scale_cntl;
+                break;
+                case RADEON_SUBPIC_CNTL:
+                val =3D s->regs.subpic_cntl;
+                break;
+                case RADEON_VIPH_CONTROL:
+                val =3D s->regs.viph_control;
+                break;
+                case RADEON_I2C_CNTL_1:
+                val =3D s->regs.i2c_cntl_1;
+                break;
+                case RADEON_DVI_I2C_CNTL_1:
+                val =3D s->regs.dvi_i2c_cntl_1;
+                break;
+                case RADEON_CAP0_TRIG_CNTL:
+                val =3D s->regs.cap0_trig_cntl;
+                break;
+                case RADEON_CAP1_TRIG_CNTL:
+                val =3D s->regs.cap1_trig_cntl;
+                break;
+                case RADEON_CUR2_OFFSET:
+                val =3D s->regs.cur2_offset;
+                break;
+                case RADEON_CRTC2_GEN_CNTL:
+                val =3D s->regs.crtc2_gen_cntl;
+                break;
+                case RADEON_MEM_INTF_CNTL:
+                val =3D s->regs.mem_intf_cntl;
+                break;
+                case RADEON_AGP_BASE_2:
+                val =3D s->regs.agp_base_2;
+                break;
+                case RADEON_AGP_BASE:
+                val =3D s->regs.agp_base;
+                break;
+                case RADEON_MEM_ADDR_CONFIG:
+                val =3D s->regs.mem_addr_config;
+                break;
+                case RADEON_DISPLAY2_BASE_ADDR:
+                val =3D s->regs.r100_display_base_addr;
+                break;
+                case RADEON_SPLL_CNTL:
+                val =3D s->regs.spll_cntl;
+                break;
+                case RADEON_VCLK_ECP_CNTL:
+                val =3D s->regs.vclk_ecp_cntl;
+                break;
+
+
+                case RADEON_GENMO_WT:
+                      qemu_log("R100 VGA RESET READ \n");
+                      val =3D C_0003C2_VGA_RAM_EN;
+                      qemu_log("R100 VGA DATA 0x%08lx \n",val);
+                      break;
+                case RADEON_CP_CSQ_CNTL:
+                    val =3D s->regs.cp_csq_cntl;
+                      break;
+                case RADEON_SCRATCH_UMSK:
+                      val =3D s->regs.scratch_umask;
+                      break;
+                case R_00000D_SCLK_CNTL:
+                        val=3D s->regs.r100_sclk_cntl;
+                        break;
+                case R_00023C_DISPLAY_BASE_ADDR:
+                        val =3D s->regs.r100_display_base_addr;
+                        break;
+                case RADEON_MEM_CNTL:
+                    val =3D R300_MEM_NUM_CHANNELS_MASK & R300_MEM_USE_CD=
_CH_ONLY;
+                    break;
+                case RADEON_CP_RB_CNTL:
+                    val =3D RADEON_RB_NO_UPDATE;
+                    break;
+
+                    case R300_CRTC_TILE_X0_Y0:
+                    val =3D s->regs.tile_x0_y0;
+
+                    break;
+                    case R300_MC_INIT_MISC_LAT_TIMER:
+                    val =3D s->regs.r300_mc_init_misc_lat_timer;
+                    break;
+
+
+
+
+
+
+
     default:
+        qemu_log("READING FROM 0x%08lx \n",addr);
         break;
     }
     if (addr < RADEON_CUR_OFFSET || addr > RADEON_CUR_CLR1 || R300_DEBUG=
_HW_CURSOR) {
         trace_ati_mm_read(size, addr, r300_reg_name(addr & ~3ULL), val);
     }
+    qemu_log("R300 MM_READ ADDRESS 0x%08lx DATA 0x%08lx \n",addr,val);
     return val;
 }
=20
@@ -512,15 +680,50 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
 {
     RADVGAState *s =3D opaque;
=20
+    qemu_log("R300 MM_WRITE ADDRESS 0x%08lx DATA 0x%08lx \n",addr,data);
+
     if (addr < RADEON_CUR_OFFSET || addr > RADEON_CUR_CLR1 || R300_DEBUG=
_HW_CURSOR) {
         trace_ati_mm_write(size, addr, r300_reg_name(addr & ~3ULL), data=
);
     }
     switch (addr) {
+      case RADEON_GENMO_WT:
+            data &=3D 0xfc080effUL;
+            qemu_log("R100 VGA RESET 0x%08lx \n",data);
+            s->regs.vga_reset =3D data ;
+            // s->regs.crtc_gen_cntl =3D 0xDEADBEEF;
+            timer_del(&s->vblank_timer);
+            r300_vga_update_irq(s);
+            r300_vga_switch_mode(s);
+
+            // r300_vga_update_irq(s);
+            // s->regs.mc_status =3D R300_MC_IDLE;
+
+
+            //
+            // /* reset vga */
+            // vga_common_reset(&s->vga);
+            // s->mode =3D VGA_MODE;
+            break;
+      case RADEON_CP_CSQ_CNTL:
+            s->regs.cp_csq_cntl =3D data;
+            break;
+      case RADEON_SCRATCH_UMSK:
+            s->regs.scratch_umask =3D data;
+            break;
+      case R_00000D_SCLK_CNTL:
+              s->regs.r100_sclk_cntl =3D data;
+              break;
+      case R_00023C_DISPLAY_BASE_ADDR:
+              s->regs.r100_display_base_addr =3D data;
+              break;
+
       case RADEON_MC_STATUS:
+        qemu_log("RADEON_WRITE_MC \n");
         s->regs.mc_status =3D R300_MC_IDLE;
         s->regs.mc_status =3D data;
         break;
       case RADEON_RBBM_STATUS:
+      qemu_log("RADEON_WRITE_RBBM \n");
         s->regs.rbbm_status =3D data|=3D RADEON_RBBM_FIFOCNT_MASK;
         break;
     case RADEON_MM_INDEX:
@@ -528,6 +731,7 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         break;
     case RADEON_MM_DATA ... RADEON_MM_DATA + 3:
         /* indexed access to regs or memory */
+        qemu_log("RADEON_WRITE_MM_DATA_VGA_STUFF\n");
         if (s->regs.mm_index & BIT(31)) {
             uint32_t idx =3D s->regs.mm_index & ~BIT(31);
             if (idx <=3D s->vga.vram_size - size) {
@@ -539,15 +743,14 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
         break;
     case RADEON_BIOS_0_SCRATCH ... RADEON_BUS_CNTL - 1:
     {
+      qemu_log("RADEON_WRITE_BIOS_SCRATCH \n");
         int i =3D (addr - RADEON_BIOS_0_SCRATCH) / 4;
-        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO && i > 3)=
 {
-            break;
-        }
         r300_reg_write_offs(&s->regs.bios_scratch[i],
                            addr - (RADEON_BIOS_0_SCRATCH + i * 4), data,=
 size);
         break;
     }
     case RADEON_GEN_INT_CNTL:
+    qemu_log("RADEON_WRITE_GEN_INT_CTL \n");
         s->regs.gen_int_cntl =3D data;
         if (data & RADEON_CRTC_VBLANK_MASK) {
             r300_vga_vblank_irq(s);
@@ -557,29 +760,33 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
         }
         break;
     case RADEON_GEN_INT_STATUS:
+    qemu_log("RADEON_WRITE_GEN_INT_STATUS \n");
         data &=3D (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO);
         s->regs.gen_int_status &=3D ~data;
         r300_vga_update_irq(s);
         break;
     case RADEON_CRTC_GEN_CNTL ... RADEON_CRTC_GEN_CNTL + 3:
     {
+      qemu_log("RADEON_WRITE_CRTC_GEN \n");
         uint32_t val =3D s->regs.crtc_gen_cntl;
         r300_reg_write_offs(&s->regs.crtc_gen_cntl,
                            addr - RADEON_CRTC_GEN_CNTL, data, size);
-        if ((val & RADEON_CRTC2_CUR_EN) !=3D (s->regs.crtc_gen_cntl & RA=
DEON_CRTC2_CUR_EN)) {
+        if ((val & RADEON_CRTC_CUR_EN) !=3D (s->regs.crtc_gen_cntl & RAD=
EON_CRTC_CUR_EN)) {
+          qemu_log("RADEON_WRITE_CRTC_GEN CURSOR \n");
             if (s->cursor_guest_mode) {
-                s->vga.force_shadow =3D !!(s->regs.crtc_gen_cntl & RADEO=
N_CRTC2_CUR_EN);
+                s->vga.force_shadow =3D !!(s->regs.crtc_gen_cntl & RADEO=
N_CRTC_CUR_EN);
             } else {
-                if (s->regs.crtc_gen_cntl & RADEON_CRTC2_CUR_EN) {
+                if (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_EN) {
                     r300_cursor_define(s);
                 }
                 dpy_mouse_set(s->vga.con, s->regs.cur_hv_pos >> 16,
                               s->regs.cur_hv_pos & 0xffff,
-                              (s->regs.crtc_gen_cntl & RADEON_CRTC2_CUR_=
EN) !=3D 0);
+                              (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_E=
N) !=3D 0);
             }
         }
-        if ((val & (RADEON_CRTC_EXT_DISP_EN | RADEON_CRTC2_EN)) !=3D
-            (s->regs.crtc_gen_cntl & (RADEON_CRTC_EXT_DISP_EN | RADEON_C=
RTC2_EN))) {
+        if ((val & (RADEON_CRTC_EXT_DISP_EN | RADEON_CRTC_EN)) !=3D
+            (s->regs.crtc_gen_cntl & (RADEON_CRTC_EXT_DISP_EN | RADEON_C=
RTC_EN))) {
+              qemu_log("RADEON_WRITE_CRTC_GEN NO_CURSOR \n");
             r300_vga_switch_mode(s);
         }
         break;
@@ -587,14 +794,14 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
     case RADEON_CRTC_EXT_CNTL ... RADEON_CRTC_EXT_CNTL + 3:
     {
         uint32_t val =3D s->regs.crtc_ext_cntl;
+        qemu_log("CRTC_EXT_CNTL 0x%08x RADEON_CRTC_DISPLAY_DIS 0x%08x \n=
",s->regs.crtc_ext_cntl,RADEON_CRTC_DISPLAY_DIS);
         r300_reg_write_offs(&s->regs.crtc_ext_cntl,
                            addr - RADEON_CRTC_EXT_CNTL, data, size);
         if (s->regs.crtc_ext_cntl & RADEON_CRTC_DISPLAY_DIS) {
-            DPRINTF("Display disabled\n");
+            qemu_log("Display disabled\n");
             s->vga.ar_index &=3D ~BIT(5);
         } else {
-            DPRINTF("Display enabled\n");
-            s->vga.ar_index |=3D BIT(5);
+            qemu_log("Display enabled\n");
             r300_vga_switch_mode(s);
         }
         if ((val & RADEON_CRTC_DISPLAY_DIS) !=3D
@@ -608,34 +815,33 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
         s->vga.dac_8bit =3D !!(data & RADEON_DAC_8BIT_EN);
         break;
     case RADEON_GPIO_VGA_DDC:
-        if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            /* FIXME: Maybe add a property to select VGA or DVI port? */
-        }
+        // if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
+        //     /* FIXME: Maybe add a property to select VGA or DVI port?=
 */
+        // }
         break;
     case RADEON_GPIO_DVI_DDC:
-        if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
             s->regs.gpio_dvi_ddc =3D r300_i2c(&s->bbi2c, data, 0);
-        }
         break;
     case RADEON_GPIO_MONID ... RADEON_GPIO_MONID + 3:
         /* FIXME What does Radeon have here? */
-        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            r300_reg_write_offs(&s->regs.gpio_monid,
-                               addr - RADEON_GPIO_MONID, data, size);
-            /*
-             * Rage128p accesses DDC used to get EDID via these bits.
-             * Because some drivers access this via multiple byte writes
-             * we have to be careful when we send bits to avoid spurious
-             * changes in bitbang_i2c state. So only do it when mask is =
set
-             * and either the enable bits are changed or output bits cha=
nged
-             * while enabled.
-             */
+        // if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
+        //     r300_reg_write_offs(&s->regs.gpio_monid,
+        //                        addr - RADEON_GPIO_MONID, data, size);
+        //     /*
+        //      * Rage128p accesses DDC used to get EDID via these bits.
+        //      * Because some drivers access this via multiple byte wri=
tes
+        //      * we have to be careful when we send bits to avoid spuri=
ous
+        //      * changes in bitbang_i2c state. So only do it when mask =
is set
+        //      * and either the enable bits are changed or output bits =
changed
+        //      * while enabled.
+        //      */
             if ((s->regs.gpio_monid & BIT(25)) &&
                 ((addr <=3D RADEON_GPIO_MONID + 2 && addr + size > RADEO=
N_GPIO_MONID + 2) ||
                  (addr =3D=3D RADEON_GPIO_MONID && (s->regs.gpio_monid &=
 0x60000)))) {
                 s->regs.gpio_monid =3D r300_i2c(&s->bbi2c, s->regs.gpio_=
monid, 1);
             }
-        }
+
+        // s->regs.gpio_monid =3D r300_i2c(&s->bbi2c, s->regs.gpio_monid=
, 1);
         break;
     case RADEON_PALETTE_INDEX ... RADEON_PALETTE_INDEX + 3:
         if (size =3D=3D 4) {
@@ -662,37 +868,37 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
         s->regs.config_cntl =3D data;
         break;
     case RADEON_CRTC_H_TOTAL_DISP:
-        s->regs.crtc_h_total_disp =3D data & 0x07ff07ff;
+        s->regs.crtc_h_total_disp =3D data & 0x07ff;
         break;
     case RADEON_CRTC_H_SYNC_STRT_WID:
-        s->regs.crtc_h_sync_strt_wid =3D data & 0x17bf1fff;
+        s->regs.crtc_h_sync_strt_wid =3D data & 0x17bf;
         break;
     case RADEON_CRTC_V_TOTAL_DISP:
-        s->regs.crtc_v_total_disp =3D data & 0x0fff0fff;
+        s->regs.crtc_v_total_disp =3D data & 0x0fff;
         break;
     case RADEON_CRTC_V_SYNC_STRT_WID:
-        s->regs.crtc_v_sync_strt_wid =3D data & 0x9f0fff;
+        s->regs.crtc_v_sync_strt_wid =3D data & 0x9f0f;
         break;
     case RADEON_CRTC_OFFSET:
-        s->regs.crtc_offset =3D data & 0xc7ffffff;
+        s->regs.crtc_offset =3D data;
         break;
     case RADEON_CRTC_OFFSET_CNTL:
         s->regs.crtc_offset_cntl =3D data; /* FIXME */
         break;
     case RADEON_CRTC_PITCH:
-        s->regs.crtc_pitch =3D data & 0x07ff07ff;
+        s->regs.crtc_pitch =3D data & 0x07ff;
         break;
     case 0xf00 ... 0xfff:
         /* read-only copy of PCI config space so ignore writes */
         break;
     case RADEON_CUR_OFFSET:
-        if (s->regs.cur_offset !=3D (data & 0x87fffff0)) {
-            s->regs.cur_offset =3D data & 0x87fffff0;
+        if (s->regs.cur_offset !=3D (data & 0x87ff)) {
+            s->regs.cur_offset =3D data & 0x87ff;
             r300_cursor_define(s);
         }
         break;
     case RADEON_CUR_HORZ_VERT_POSN:
-        s->regs.cur_hv_pos =3D data & 0x3fff0fff;
+        s->regs.cur_hv_pos =3D data & 0x3fff;
         if (data & BIT(31)) {
             s->regs.cur_offset |=3D data & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
@@ -706,7 +912,7 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case RADEON_CUR_HORZ_VERT_OFF:
-        s->regs.cur_hv_offs =3D data & 0x3f003f;
+        s->regs.cur_hv_offs =3D data & 0x03ff;
         if (data & BIT(31)) {
             s->regs.cur_offset |=3D data & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
@@ -715,8 +921,8 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case RADEON_CUR_CLR0:
-        if (s->regs.cur_color0 !=3D (data & 0xffffff)) {
-            s->regs.cur_color0 =3D data & 0xffffff;
+        if (s->regs.cur_color0 !=3D (data & 0xffff)) {
+            s->regs.cur_color0 =3D data & 0xffff;
             r300_cursor_define(s);
         }
         break;
@@ -731,9 +937,9 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         break;
     case RADEON_DST_OFFSET:
         if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.dst_offset =3D data & 0xfffffff0;
+            s->regs.dst_offset =3D data & 0xffff;
         } else {
-            s->regs.dst_offset =3D data & 0xfffffc00;
+            s->regs.dst_offset =3D data & 0xfc00;
         }
         break;
     case RADEON_DST_PITCH:
@@ -765,23 +971,23 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
         break;
     case RADEON_SRC_PITCH_OFFSET:
         if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.src_offset =3D (data & 0x1fffff) << 5;
-            s->regs.src_pitch =3D (data & 0x7fe00000) >> 21;
+            s->regs.src_offset =3D (data) << 5;
+            s->regs.src_pitch =3D (data ) >> 21;
             s->regs.src_tile =3D data >> 31;
         } else {
-            s->regs.src_offset =3D (data & 0x3fffff) << 10;
-            s->regs.src_pitch =3D (data & 0x3fc00000) >> 16;
+            s->regs.src_offset =3D (data ) << 10;
+            s->regs.src_pitch =3D (data) >> 16;
             s->regs.src_tile =3D (data >> 30) & 1;
         }
         break;
     case RADEON_DST_PITCH_OFFSET:
         if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.dst_offset =3D (data & 0x1fffff) << 5;
-            s->regs.dst_pitch =3D (data & 0x7fe00000) >> 21;
+            s->regs.dst_offset =3D (data) << 5;
+            s->regs.dst_pitch =3D (data) >> 21;
             s->regs.dst_tile =3D data >> 31;
         } else {
-            s->regs.dst_offset =3D (data & 0x3fffff) << 10;
-            s->regs.dst_pitch =3D (data & 0x3fc00000) >> 16;
+            s->regs.dst_offset =3D (data) << 10;
+            s->regs.dst_pitch =3D (data) >> 16;
             s->regs.dst_tile =3D data >> 30;
         }
         break;
@@ -834,12 +1040,9 @@ static void r300_mm_write(void *opaque, hwaddr addr=
,
         }
         break;
     case RADEON_SRC_PITCH:
-        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.src_pitch =3D data & 0x3fff;
-            s->regs.src_tile =3D (data >> 16) & 1;
-        } else {
+
             s->regs.src_pitch =3D data & 0x3ff0;
-        }
+
         break;
     case RADEON_DP_BRUSH_BKGD_CLR:
         s->regs.dp_brush_bkgd_clr =3D data;
@@ -860,23 +1063,19 @@ static void r300_mm_write(void *opaque, hwaddr add=
r,
         s->regs.dp_write_mask =3D data;
         break;
     case RADEON_DEFAULT_OFFSET:
-        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.default_offset =3D data & 0xfffffff0;
-        } else {
             /* Radeon has DEFAULT_PITCH_OFFSET here like DST_PITCH_OFFSE=
T */
-            s->regs.default_offset =3D (data & 0x3fffff) << 10;
-            s->regs.default_pitch =3D (data & 0x3fc00000) >> 16;
+            s->regs.default_offset =3D (data ) << 10;
+            s->regs.default_pitch =3D (data ) >> 16;
             s->regs.default_tile =3D data >> 30;
-        }
+
         break;
     case RADEON_DEFAULT_PITCH:
-        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.default_pitch =3D data & 0x3fff;
-            s->regs.default_tile =3D (data >> 16) & 1;
-        }
+        s->regs.default_pitch =3D data;
+        s->regs.default_tile =3D (data >> 16) & 1;
+
         break;
     case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
-        s->regs.default_sc_bottom_right =3D data & 0x3fff3fff;
+        s->regs.default_sc_bottom_right =3D data;
         break;
     case R300_GB_ENABLE:
         s->regs.r300_gb_enable =3D data;
@@ -887,9 +1086,159 @@ static void r300_mm_write(void *opaque, hwaddr add=
r,
     case R300_GB_FIFO_SIZE:
             s->regs.r300_gb_fifo_size =3D data;
             break;
+    case RADEON_ISYNC_CNTL:
+            s->regs.isync_cntl =3D data;
+            break;
+  case R300_DST_PIPE_CONFIG:
+            s->regs.r300_dst_pipe_config =3D data;
+            break;
+  case R300_RB2D_DSTCACHE_MODE:
+            s->regs.r300_rb2d_dstcache_mode =3D data;
+            break;
+  case RADEON_WAIT_UNTIL:
+            s->regs.wait_until =3D data;
+            break;
+  case R300_GB_SELECT:
+            s->regs.r300_gb_select =3D data;
+            break;
+  case R300_RB3D_DSTCACHE_CTLSTAT:
+            s->regs.r300_rb3d_dstcache_ctlstat =3D data;
+            break;
+  case R300_RB3D_ZCACHE_CTLSTAT:
+            s->regs.r300_rb3d_zcache_ctlstat =3D data;
+            break;
+  case R300_GB_AA_CONFIG:
+            s->regs.r300_gb_aa_config =3D data;
+            break;
+  case R300_RE_SCISSORS_TL:
+            s->regs.r300_re_scissors_tl =3D data;
+            break;
+
+  case R300_RE_SCISSORS_BR:
+            s->regs.r300_re_scissors_br =3D data;
+            break;
+  case RADEON_HOST_PATH_CNTL:
+            s->regs.host_path_cntl =3D data;
+            break;
+
+  case R300_GB_MSPOS0:
+            s->regs.r300_gb_mpos_0 =3D data;
+            break;
+
+  case R300_GB_MSPOS1:
+            s->regs.r300_gb_mpos_1 =3D data;
+            break;
+  case RADEON_SURFACE_CNTL:
+            s->regs.surface_cntl =3D data;
+            break;
+  case RADEON_SURFACE0_INFO:
+            s->regs.surface0_info =3D data;
+            break;
+  case RADEON_SURFACE1_INFO:
+            s->regs.surface1_info =3D data;
+            break;
+
+  case RADEON_SURFACE2_INFO:
+  s->regs.surface2_info =3D data;
+  break;
+  case RADEON_SURFACE3_INFO:
+  s->regs.surface3_info =3D data;
+  break;
+  case RADEON_SURFACE4_INFO:
+  s->regs.surface4_info =3D data;
+  break;
+  case RADEON_SURFACE5_INFO:
+  s->regs.surface5_info =3D data;
+  break;
+  case RADEON_SURFACE6_INFO:
+  s->regs.surface6_info =3D data;
+  break;
+  case RADEON_SURFACE7_INFO:
+  s->regs.surface7_info =3D data;
+  break;
+  case RADEON_OV0_SCALE_CNTL:
+  s->regs.ov0_scale_cntl =3D data;
+  break;
+  case RADEON_SUBPIC_CNTL:
+  s->regs.subpic_cntl =3D data;
+  break;
+  case RADEON_VIPH_CONTROL:
+  s->regs.viph_control =3D data;
+  break;
+  case RADEON_I2C_CNTL_1:
+  s->regs.i2c_cntl_1 =3D data;
+  break;
+  case RADEON_DVI_I2C_CNTL_1:
+  s->regs.dvi_i2c_cntl_1 =3D data;
+  break;
+  case RADEON_CAP0_TRIG_CNTL:
+  s->regs.cap0_trig_cntl =3D data;
+  break;
+  case RADEON_CAP1_TRIG_CNTL:
+  s->regs.cap1_trig_cntl =3D data;
+  break;
+  case RADEON_CUR2_OFFSET:
+  s->regs.cur2_offset =3D data;
+  break;
+  case RADEON_CRTC2_GEN_CNTL:
+  s->regs.crtc2_gen_cntl =3D data;
+  break;
+  case RADEON_MEM_INTF_CNTL:
+  s->regs.mem_intf_cntl =3D data;
+  break;
+  case RADEON_AGP_BASE_2:
+  s->regs.agp_base_2 =3D data;
+  break;
+  case RADEON_AGP_BASE:
+  s->regs.agp_base =3D data;
+  break;
+  case RADEON_MEM_ADDR_CONFIG:
+  s->regs.mem_addr_config =3D data;
+  break;
+  case RADEON_DISPLAY2_BASE_ADDR:
+  s->regs.display2_base_addr =3D data;
+  break;
+  case RADEON_SPLL_CNTL:
+  s->regs.spll_cntl =3D data;
+  break;
+  case RADEON_VCLK_ECP_CNTL:
+  s->regs.vclk_ecp_cntl =3D data;
+  break;
+  case RADEON_CP_RB_CNTL:
+  s->regs.cp_rb_cntl =3D data;
+  break;
+  case RADEON_MEM_CNTL:
+  s->regs.mem_cntl =3D data;
+  break;
+  case R300_CRTC_TILE_X0_Y0:
+  s->regs.tile_x0_y0 =3D data;
+
+  break;
+  case R300_MC_INIT_MISC_LAT_TIMER:
+  s->regs.r300_mc_init_misc_lat_timer =3D 0xDEADBEEF;
+  break;
+  case RADEON_AIC_CNTL:
+  s->regs.aic_cntl =3D data;
+  break;
+  case RADEON_DDA_CONFIG:
+  s->regs.dda_config =3D data;
+  break;
+
+
+
+
+
+
+
+
+
+
     default:
+    qemu_log("REGISTER NOT IMPLEMENTED 0x%08lx \n",addr);
+    s->regs.emu_register_stub[addr % 128] =3D data;
         break;
     }
+
 }
=20
 static const MemoryRegionOps r300_mm_ops =3D {
@@ -903,7 +1252,10 @@ static void r300_vga_realize(PCIDevice *dev, Error =
**errp)
     RADVGAState *s =3D RAD_VGA(dev);
     VGACommonState *vga =3D &s->vga;
=20
+    // s->regs.r300_mc_init_misc_lat_timer =3D 0xDEADBEEF;
+
     if (s->model) {
+        s->regs.vga_reset =3D 0x02;
         int i;
         for (i =3D 0; i < ARRAY_SIZE(r300_model_aliases); i++) {
             if (!strcmp(s->model, r300_model_aliases[i].name)) {
@@ -947,7 +1299,7 @@ static void r300_vga_realize(PCIDevice *dev, Error *=
*errp)
=20
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &r300_mm_ops, s,
-                          "ati.mmregs", 0x4000);
+                          "ati.mmregs", RADEON_MIN_MMIO_SIZE);
     /* io space is alias to beginning of mmregs */
     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x1=
00);
=20
@@ -955,8 +1307,11 @@ static void r300_vga_realize(PCIDevice *dev, Error =
**errp)
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
=20
+
     /* most interrupts are not yet emulated but MacOS needs at least VBl=
ank */
-    dev->config[PCI_INTERRUPT_PIN] =3D 1;
+    // dev->config[PCI_INTERRUPT_PIN] =3D 1;
+    // pci_std_vga_mmio_region_init(vga,OBJECT(s),&s->mm,&s->mm,true,tru=
e);
+
     timer_init_ns(&s->vblank_timer, QEMU_CLOCK_VIRTUAL, r300_vga_vblank_=
irq, s);
 }
=20
diff --git a/hw/display/r300.h b/hw/display/r300.h
index 19e3d97f8a..3084cc412a 100644
--- a/hw/display/r300.h
+++ b/hw/display/r300.h
@@ -27,6 +27,11 @@
 #define PCI_VENDOR_ID_ATI 0x1002
 /* Radeon 9500 PRO */
 #define PCI_DEVICE_ID_ATI_RADEON_9500_PRO 0x4e45
+/* Radeon 9500 PRO */
+#define PCI_DEVICE_ID_ATI_RADEON_9700 0x4e44
+
+#define RADEON_MIN_MMIO_SIZE 0x10000
+
=20
 #define TYPE_RAD_VGA "rad-vga"
 #define RAD_VGA(obj) OBJECT_CHECK(RADVGAState, (obj), TYPE_RAD_VGA)
@@ -82,14 +87,80 @@ typedef struct RADVGARegs{
   uint32_t default_tile;
   uint32_t default_sc_bottom_right;
   uint32_t mc_status;
+  uint32_t isync_cntl;
+  uint32_t host_path_cntl;
+  uint32_t wait_until;
+  uint32_t cp_csq_cntl;
+  uint32_t scratch_umask;
+  uint32_t r100_display_base_addr;
+  uint32_t r100_sclk_cntl;
+
+
+
+  uint8_t vga_reset;
+  uint32_t tile_x0_y0;
+  uint32_t dda_config;
+  uint32_t aic_cntl;
+
+  uint32_t cp_rb_cntl;
+  uint32_t mem_cntl;
+
+
+  uint32_t surface_cntl;
+  uint32_t surface0_info;
+  uint32_t surface1_info;
+  uint32_t surface2_info;
+  uint32_t surface3_info;
+  uint32_t surface4_info;
+  uint32_t surface5_info;
+  uint32_t surface6_info;
+  uint32_t surface7_info;
+  uint32_t ov0_scale_cntl;
+  uint32_t i2c_cntl_1;
+  uint32_t dvi_i2c_cntl_1;
+  uint32_t subpic_cntl;
+  uint32_t viph_control;
+  uint32_t cap0_trig_cntl;
+  uint32_t cap1_trig_cntl;
+  uint32_t cur2_offset;
+
+  uint32_t crtc2_gen_cntl;
+
+  uint32_t mem_intf_cntl;
+  uint32_t agp_base_2;
+  uint32_t agp_base;
+
+  uint32_t mem_addr_config;
+  uint32_t display2_base_addr;
+  uint32_t spll_cntl;
+  uint32_t vclk_ecp_cntl;
+
+
+
+
+
+
+  //R300 DST registers
+
+  uint32_t r300_dst_pipe_config;
=20
   //R300 GB Registers
   uint32_t r300_gb_enable;
   uint32_t r300_gb_tile_config;
   uint32_t r300_gb_fifo_size;
+  uint32_t r300_gb_select;
+  uint32_t r300_gb_aa_config;
+  uint32_t r300_gb_mpos_0;
+  uint32_t r300_gb_mpos_1;
=20
+  // RE registers
+  uint32_t r300_re_scissors_tl;
+  uint32_t r300_re_scissors_br;
=20
-//Color Buffer RB3D
+  // RB2D registers
+uint32_t r300_rb2d_dstcache_mode;
+
+// RB3D Registers
   uint32_t r300_rb3d_aaresolve_ctl;
   uint32_t r300_rb3d_aaresolve_offset;
   uint32_t r300_rb3d_aaresolve_pitch;
@@ -99,11 +170,15 @@ typedef struct RADVGARegs{
   uint32_t r300_rb3d_color_mask;
   uint32_t r300_rb3d_color_pitch[4];
   uint32_t r300_rb3d_color_offset[4];
+  uint32_t r300_rb3d_zcache_ctlstat;
+  uint32_t r300_rb3d_dstcache_ctlstat;
=20
   uint32_t rbbm_gui_cntl;
   uint32_t rbbm_status;
   uint32_t rbbm_soft_reset;
=20
+  uint32_t emu_register_stub[128];
+
=20
=20
=20
--=20
2.24.0


