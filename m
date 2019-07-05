Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F717C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D1920651
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D1920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOe6-0004nr-Bs
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hjOUG-0007hz-NP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hjOUE-0007oy-Ez
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hjOUE-0007h8-75
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 853B7C050003;
 Fri,  5 Jul 2019 13:42:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com
 [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8687F8069A;
 Fri,  5 Jul 2019 13:42:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9C85917444; Fri,  5 Jul 2019 15:42:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 15:42:36 +0200
Message-Id: <20190705134239.11718-2-kraxel@redhat.com>
In-Reply-To: <20190705134239.11718-1-kraxel@redhat.com>
References: <20190705134239.11718-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 05 Jul 2019 13:42:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/4] ati-vga: Improve readability of ati_2d_blt
 function
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Move common parts before the switch to remove code duplication and
improve readibility.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 04b67ff483223d4722b0b044192558e7d17b36b5.1562151410.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_2d.c | 80 +++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 47 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 2dbf53f03936..c31142af6e19 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -42,6 +42,8 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
@@ -51,6 +53,22 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    int bpp = ati_bpp_from_datatype(s);
+    int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
+    uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
+                        s->regs.dst_offset : s->regs.default_offset);
+
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        dst_bits += s->regs.crtc_offset & 0x07ffffff;
+        dst_stride *= bpp;
+    }
+    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
+    if (dst_bits >= end ||
+        dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
+        dst_stride >= end) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return;
+    }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
@@ -59,41 +77,28 @@ void ati_2d_blt(ATIVGAState *s)
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
-        uint8_t *src_bits, *dst_bits, *end;
-        int src_stride, dst_stride, bpp = ati_bpp_from_datatype(s);
-        src_bits = s->vga.vram_ptr +
-                   (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL ?
-                    s->regs.src_offset : s->regs.default_offset);
-        dst_bits = s->vga.vram_ptr +
-                   (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
-                    s->regs.dst_offset : s->regs.default_offset);
-        src_stride = (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL ?
-                      s->regs.src_pitch : s->regs.default_pitch);
-        dst_stride = (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
-                      s->regs.dst_pitch : s->regs.default_pitch);
+        int src_stride = DEFAULT_CNTL ?
+                         s->regs.src_pitch : s->regs.default_pitch;
+        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
+                            s->regs.src_offset : s->regs.default_offset);
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits += s->regs.crtc_offset & 0x07ffffff;
-            dst_bits += s->regs.crtc_offset & 0x07ffffff;
             src_stride *= bpp;
-            dst_stride *= bpp;
         }
+        if (src_bits >= end ||
+            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_height) *
+            src_stride >= end) {
+            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+            return;
+        }
+
         src_stride /= sizeof(uint32_t);
         dst_stride /= sizeof(uint32_t);
-
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
                 s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
                 s->regs.dst_width, s->regs.dst_height);
-        end = s->vga.vram_ptr + s->vga.vram_size;
-        if (src_bits >= end || dst_bits >= end ||
-            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_height) *
-            src_stride * sizeof(uint32_t) >= end ||
-            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
-            dst_stride * sizeof(uint32_t) >= end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
-        }
         pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
                    src_stride, dst_stride, bpp, bpp,
                    s->regs.src_x, s->regs.src_y,
@@ -115,20 +120,7 @@ void ati_2d_blt(ATIVGAState *s)
     case ROP3_BLACKNESS:
     case ROP3_WHITENESS:
     {
-        uint8_t *dst_bits, *end;
-        int dst_stride, bpp = ati_bpp_from_datatype(s);
         uint32_t filler = 0;
-        dst_bits = s->vga.vram_ptr +
-                   (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
-                    s->regs.dst_offset : s->regs.default_offset);
-        dst_stride = (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL ?
-                      s->regs.dst_pitch : s->regs.default_pitch);
-
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            dst_bits += s->regs.crtc_offset & 0x07ffffff;
-            dst_stride *= bpp;
-        }
-        dst_stride /= sizeof(uint32_t);
 
         switch (s->regs.dp_mix & GMC_ROP3_MASK) {
         case ROP3_PATCOPY:
@@ -144,22 +136,16 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
 
+        dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
                 dst_bits, dst_stride, bpp,
                 s->regs.dst_x, s->regs.dst_y,
                 s->regs.dst_width, s->regs.dst_height,
                 filler);
-        end = s->vga.vram_ptr + s->vga.vram_size;
-        if (dst_bits >= end ||
-            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
-            dst_stride * sizeof(uint32_t) >= end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
-        }
         pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
-                   s->regs.dst_x, s->regs.dst_y,
-                   s->regs.dst_width, s->regs.dst_height,
-                   filler);
+                    s->regs.dst_x, s->regs.dst_y,
+                    s->regs.dst_width, s->regs.dst_height,
+                    filler);
         if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
             dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-- 
2.18.1


