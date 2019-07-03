Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F54C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF3E21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF3E21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hid6z-0007ER-Py
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hid1F-0000oX-Uo
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hid1D-0005ER-BT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hid1C-00054c-RV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A88937462B7;
 Wed,  3 Jul 2019 13:01:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1FE477462B8; Wed,  3 Jul 2019 13:01:38 +0200 (CEST)
Message-Id: <045b82d2c5167e0b2a23dfbf8a80085b0550e4ca.1562151410.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1562151410.git.balaton@eik.bme.hu>
References: <cover.1562151410.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 03 Jul 2019 12:56:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH 3/3] ati-vga: Fix reverse bit blts
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

The pixman library only supports blts with left to right, top to
bottom order but the ATI VGA engine can also do different directions.
Fix support for these via a temporary buffer for now. This fixes
rendering issues related to such blts (such as moving windows) but
some other glitches still remain.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 53 ++++++++++++++++++++++++++++++++++++++---------=
------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index b09753320a..07a776c31d 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -53,6 +53,10 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    int dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                 s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
+    int dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                 s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height)=
;
     int bpp =3D ati_bpp_from_datatype(s);
     int dst_stride =3D DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.defaul=
t_pitch;
     uint8_t *dst_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
@@ -63,20 +67,25 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride *=3D bpp;
     }
     uint8_t *end =3D s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_bits >=3D end ||
-        dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) =
*
+    if (dst_bits >=3D end || dst_bits + dst_x + (dst_y + s->regs.dst_hei=
ght) *
         dst_stride >=3D end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
-    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d\n",
+    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offs=
et,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
             s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
-            s->regs.dst_width, s->regs.dst_height);
+            s->regs.dst_width, s->regs.dst_height,
+            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
+            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
+        int src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                     s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_wid=
th);
+        int src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                     s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_hei=
ght);
         int src_stride =3D DEFAULT_CNTL ?
                          s->regs.src_pitch : s->regs.default_pitch;
         uint8_t *src_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
@@ -86,9 +95,8 @@ void ati_2d_blt(ATIVGAState *s)
             src_bits +=3D s->regs.crtc_offset & 0x07ffffff;
             src_stride *=3D bpp;
         }
-        if (src_bits >=3D end ||
-            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_heig=
ht) *
-            src_stride >=3D end) {
+        if (src_bits >=3D end || src_bits + src_x +
+            (src_y + s->regs.dst_height) * src_stride >=3D end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
             return;
         }
@@ -97,19 +105,34 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride /=3D sizeof(uint32_t);
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, =
%d)\n",
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst=
_y,
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
+            /* FIXME: We only really need a temporary if src and dst ove=
rlap */
+            uint32_t *tmp =3D g_malloc(src_stride * sizeof(uint32_t) *
+                                     s->regs.dst_height);
+            pixman_blt((uint32_t *)src_bits, tmp,
+                       src_stride, src_stride, bpp, bpp,
+                       src_x, src_y, 0, 0,
+                       s->regs.dst_width, s->regs.dst_height);
+            pixman_blt(tmp, (uint32_t *)dst_bits,
+                       src_stride, dst_stride, bpp, bpp,
+                       0, 0, dst_x, dst_y,
+                       s->regs.dst_width, s->regs.dst_height);
+            g_free(tmp);
+        }
         if (dst_bits >=3D s->vga.vram_ptr + s->vga.vbe_start_addr &&
             dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offs=
et) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr =
+
                                     s->regs.dst_offset +
-                                    s->regs.dst_y * surface_stride(ds),
+                                    dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(=
ds));
         }
         s->regs.dst_x +=3D s->regs.dst_width;
@@ -151,7 +174,7 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offs=
et) {
             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr =
+
                                     s->regs.dst_offset +
-                                    s->regs.dst_y * surface_stride(ds),
+                                    dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(=
ds));
         }
         s->regs.dst_y +=3D s->regs.dst_height;
--=20
2.13.7


