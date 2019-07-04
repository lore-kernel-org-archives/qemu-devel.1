Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB623C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91995218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91995218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiwnO-0004HV-Rk
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 04:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51559)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hiwl2-0002cP-V3
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hiwl1-0007oK-Ln
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:06:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:57181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hiwl1-0007iP-BX
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:06:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 17F3474569A;
 Thu,  4 Jul 2019 10:06:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DEB9F7462AA; Thu,  4 Jul 2019 10:06:03 +0200 (CEST)
Message-Id: <e21855faaeb30d7b1771f084f283f6a30bedb1a3.1562227303.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1562227303.git.balaton@eik.bme.hu>
References: <cover.1562227303.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 04 Jul 2019 10:01:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH v2 1/1] ati-vga: Fix reverse bit blts
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
v2: Only allocate needed amount of memory for tmp,
rest of the series is unchanged

 hw/display/ati_2d.c | 55 ++++++++++++++++++++++++++++++++++++++---------=
------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index b09753320a..42e82311eb 100644
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
@@ -97,19 +105,36 @@ void ati_2d_blt(ATIVGAState *s)
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
+            int llb =3D s->regs.dst_width * (bpp / 8);
+            int tmp_stride =3D DIV_ROUND_UP(llb, sizeof(uint32_t));
+            uint32_t *tmp =3D g_malloc(tmp_stride * sizeof(uint32_t) *
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
@@ -151,7 +176,7 @@ void ati_2d_blt(ATIVGAState *s)
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


