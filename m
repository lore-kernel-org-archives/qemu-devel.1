Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58442C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306C7218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306C7218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOgx-00089j-9t
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hjOUL-0007sD-0Z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hjOUJ-0008Ey-N1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hjOUJ-00081B-FS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62AAA59441;
 Fri,  5 Jul 2019 13:42:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com
 [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86C0817AD4;
 Fri,  5 Jul 2019 13:42:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AD8B517515; Fri,  5 Jul 2019 15:42:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 15:42:38 +0200
Message-Id: <20190705134239.11718-4-kraxel@redhat.com>
In-Reply-To: <20190705134239.11718-1-kraxel@redhat.com>
References: <20190705134239.11718-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 13:42:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] ati-vga: Fix reverse bit blts
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

The pixman library only supports blts with left to right, top to
bottom order but the ATI VGA engine can also do different directions.
Fix support for these via a temporary buffer for now. This fixes
rendering issues related to such blts (such as moving windows) but
some other glitches still remain.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: e21855faaeb30d7b1771f084f283f6a30bedb1a3.1562227303.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_2d.c | 55 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index b09753320a9e..42e82311eb44 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -53,6 +53,10 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    int dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                 s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
+    int dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                 s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
     int bpp = ati_bpp_from_datatype(s);
     int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
     uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
@@ -63,20 +67,25 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride *= bpp;
     }
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_bits >= end ||
-        dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
+    if (dst_bits >= end || dst_bits + dst_x + (dst_y + s->regs.dst_height) *
         dst_stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
-    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d\n",
+    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
             s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
-            s->regs.dst_width, s->regs.dst_height);
+            s->regs.dst_width, s->regs.dst_height,
+            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
+            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
+        int src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                     s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
+        int src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                     s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
         int src_stride = DEFAULT_CNTL ?
                          s->regs.src_pitch : s->regs.default_pitch;
         uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
@@ -86,9 +95,8 @@ void ati_2d_blt(ATIVGAState *s)
             src_bits += s->regs.crtc_offset & 0x07ffffff;
             src_stride *= bpp;
         }
-        if (src_bits >= end ||
-            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_height) *
-            src_stride >= end) {
+        if (src_bits >= end || src_bits + src_x +
+            (src_y + s->regs.dst_height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -97,19 +105,36 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
+                src_x, src_y, dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height);
-        pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                   src_stride, dst_stride, bpp, bpp,
-                   s->regs.src_x, s->regs.src_y,
-                   s->regs.dst_x, s->regs.dst_y,
-                   s->regs.dst_width, s->regs.dst_height);
+        if (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
+            s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
+            pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
+                       src_stride, dst_stride, bpp, bpp,
+                       src_x, src_y, dst_x, dst_y,
+                       s->regs.dst_width, s->regs.dst_height);
+        } else {
+            /* FIXME: We only really need a temporary if src and dst overlap */
+            int llb = s->regs.dst_width * (bpp / 8);
+            int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
+            uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
+                                     s->regs.dst_height);
+            pixman_blt((uint32_t *)src_bits, tmp,
+                       src_stride, tmp_stride, bpp, bpp,
+                       src_x, src_y, 0, 0,
+                       s->regs.dst_width, s->regs.dst_height);
+            pixman_blt(tmp, (uint32_t *)dst_bits,
+                       tmp_stride, dst_stride, bpp, bpp,
+                       0, 0, dst_x, dst_y,
+                       s->regs.dst_width, s->regs.dst_height);
+            g_free(tmp);
+        }
         if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
             dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    s->regs.dst_y * surface_stride(ds),
+                                    dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds));
         }
         s->regs.dst_x += s->regs.dst_width;
@@ -151,7 +176,7 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
                                     s->regs.dst_offset +
-                                    s->regs.dst_y * surface_stride(ds),
+                                    dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds));
         }
         s->regs.dst_y += s->regs.dst_height;
-- 
2.18.1


