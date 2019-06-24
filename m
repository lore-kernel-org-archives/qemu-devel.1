Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB9C48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99CE213F2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99CE213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLps-0001xK-BU
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hfLlo-0000zx-WA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hfLln-0001fQ-BL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:00:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:26056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hfLln-0001O3-1W
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:00:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A0D29746397;
 Mon, 24 Jun 2019 12:00:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7A1CA746395; Mon, 24 Jun 2019 12:00:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 24 Jun 2019 11:50:12 +0200
To: qemu-devel@nongnu.org
Message-Id: <20190624100005.7A1CA746395@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH] ati-vga: Fixes to offset and pitch registers
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix bit masks of registers for offset and pitch and also handle
default values for both R128P and RV100. This improves picture a bit
but does not resolve all problems yet so there might be some more bugs
somewhere.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 32 ++++++++++++++++++++++----------
 hw/display/ati_2d.c   | 26 ++++++++++++++++++--------
 hw/display/ati_int.h  |  1 +
 hw/display/ati_regs.h |  4 ++--
 4 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 932a1eacea..0cb1173848 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -419,9 +419,15 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     case DEFAULT_OFFSET:
         val = s->regs.default_offset;
+        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            val >>= 10;
+            val |= s->regs.default_pitch << 16;
+            val |= s->regs.default_tile << 30;
+        }
         break;
     case DEFAULT_PITCH:
         val = s->regs.default_pitch;
+        val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
         val = s->regs.default_sc_bottom_right;
@@ -682,22 +688,22 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case SRC_PITCH_OFFSET:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.src_offset = (data & 0x1fffff) << 5;
-            s->regs.src_pitch = (data >> 21) & 0x3ff;
+            s->regs.src_offset = (data & 0x1fffff) << 4;
+            s->regs.src_pitch = (data & 0x7fe00000) >> 21;
             s->regs.src_tile = data >> 31;
         } else {
-            s->regs.src_offset = (data & 0x3fffff) << 11;
+            s->regs.src_offset = (data & 0x3fffff) << 10;
             s->regs.src_pitch = (data & 0x3fc00000) >> 16;
             s->regs.src_tile = (data >> 30) & 1;
         }
         break;
     case DST_PITCH_OFFSET:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.dst_offset = (data & 0x1fffff) << 5;
-            s->regs.dst_pitch = (data >> 21) & 0x3ff;
+            s->regs.dst_offset = (data & 0x1fffff) << 4;
+            s->regs.dst_pitch = (data & 0x7fe00000) >> 21;
             s->regs.dst_tile = data >> 31;
         } else {
-            s->regs.dst_offset = (data & 0x3fffff) << 11;
+            s->regs.dst_offset = (data & 0x3fffff) << 10;
             s->regs.dst_pitch = (data & 0x3fc00000) >> 16;
             s->regs.dst_tile = data >> 30;
         }
@@ -777,13 +783,19 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_write_mask = data;
         break;
     case DEFAULT_OFFSET:
-        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
-                 0x03fffc00 : 0xfffffc00);
-        s->regs.default_offset = data;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.default_offset = data & 0xfffffff0;
+        } else {
+            /* Radeon has DEFAULT_PITCH_OFFSET here like DST_PITCH_OFFSET */
+            s->regs.default_offset = (data & 0x3fffff) << 10;
+            s->regs.default_pitch = (data & 0x3fc00000) >> 16;
+            s->regs.default_tile = data >> 30;
+        }
         break;
     case DEFAULT_PITCH:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.default_pitch = data & 0x103ff;
+            s->regs.default_pitch = data & 0x3fff;
+            s->regs.default_tile = (data >> 16) & 1;
         }
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index d83c29c6d9..2dbf53f039 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -51,8 +51,9 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    DPRINTF("%d %d, %d %d, (%d,%d) -> (%d,%d) %dx%d\n", s->regs.src_offset,
-            s->regs.dst_offset, s->regs.src_pitch, s->regs.dst_pitch,
+    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d\n",
+            s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
+            s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
             s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
             s->regs.dst_width, s->regs.dst_height);
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
@@ -60,10 +61,16 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint8_t *src_bits, *dst_bits, *end;
         int src_stride, dst_stride, bpp = ati_bpp_from_datatype(s);
-        src_bits = s->vga.vram_ptr + s->regs.src_offset;
-        dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
-        src_stride = s->regs.src_pitch;
-        dst_stride = s->regs.dst_pitch;
+        src_bits = s->vga.vram_ptr +
+                   (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL ?
+                    s->regs.src_offset : s->regs.default_offset);
+        dst_bits = s->vga.vram_ptr +
+                   (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
+                    s->regs.dst_offset : s->regs.default_offset);
+        src_stride = (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL ?
+                      s->regs.src_pitch : s->regs.default_pitch);
+        dst_stride = (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
+                      s->regs.dst_pitch : s->regs.default_pitch);
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits += s->regs.crtc_offset & 0x07ffffff;
@@ -111,8 +118,11 @@ void ati_2d_blt(ATIVGAState *s)
         uint8_t *dst_bits, *end;
         int dst_stride, bpp = ati_bpp_from_datatype(s);
         uint32_t filler = 0;
-        dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
-        dst_stride = s->regs.dst_pitch;
+        dst_bits = s->vga.vram_ptr +
+                   (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
+                    s->regs.dst_offset : s->regs.default_offset);
+        dst_stride = (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
+                      s->regs.dst_pitch : s->regs.default_pitch);
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             dst_bits += s->regs.crtc_offset & 0x07ffffff;
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 51465f5630..9b67d0022a 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -74,6 +74,7 @@ typedef struct ATIVGARegs {
     uint32_t dp_write_mask;
     uint32_t default_offset;
     uint32_t default_pitch;
+    uint32_t default_tile;
     uint32_t default_sc_bottom_right;
 } ATIVGARegs;
 
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 1ec3498b73..d7155c93d5 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -370,8 +370,8 @@
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
 /* DP_GUI_MASTER_CNTL bit constants */
-#define GMC_SRC_PITCH_OFFSET_DEFAULT            0x00000000
-#define GMC_DST_PITCH_OFFSET_DEFAULT            0x00000000
+#define GMC_SRC_PITCH_OFFSET_CNTL               0x00000001
+#define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
 #define GMC_SRC_CLIP_DEFAULT                    0x00000000
 #define GMC_DST_CLIP_DEFAULT                    0x00000000
 #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
-- 
2.13.7


