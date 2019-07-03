Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B724CC06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAE021882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAE021882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hid73-0007S4-UH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59961)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hid1E-0000mE-Og
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hid1D-0005EK-Bd
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hid1C-00054V-RV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9E4787461AA;
 Wed,  3 Jul 2019 13:01:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 149AA7462AA; Wed,  3 Jul 2019 13:01:38 +0200 (CEST)
Message-Id: <04b67ff483223d4722b0b044192558e7d17b36b5.1562151410.git.balaton@eik.bme.hu>
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
Subject: [Qemu-devel] [PATCH 1/3] ati-vga: Improve readability of ati_2d_blt
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

Move common parts before the switch to remove code duplication and
improve readibility.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 80 ++++++++++++++++++++++-------------------------=
------
 1 file changed, 33 insertions(+), 47 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 2dbf53f039..c31142af6e 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -42,6 +42,8 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
=20
+#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_=
CNTL)
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
@@ -51,6 +53,22 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    int bpp =3D ati_bpp_from_datatype(s);
+    int dst_stride =3D DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.defaul=
t_pitch;
+    uint8_t *dst_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
+                        s->regs.dst_offset : s->regs.default_offset);
+
+    if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        dst_bits +=3D s->regs.crtc_offset & 0x07ffffff;
+        dst_stride *=3D bpp;
+    }
+    uint8_t *end =3D s->vga.vram_ptr + s->vga.vram_size;
+    if (dst_bits >=3D end ||
+        dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) =
*
+        dst_stride >=3D end) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return;
+    }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d\n",
             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offs=
et,
             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
@@ -59,41 +77,28 @@ void ati_2d_blt(ATIVGAState *s)
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
-        uint8_t *src_bits, *dst_bits, *end;
-        int src_stride, dst_stride, bpp =3D ati_bpp_from_datatype(s);
-        src_bits =3D s->vga.vram_ptr +
-                   (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CN=
TL ?
-                    s->regs.src_offset : s->regs.default_offset);
-        dst_bits =3D s->vga.vram_ptr +
-                   (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CN=
TL ?
-                    s->regs.dst_offset : s->regs.default_offset);
-        src_stride =3D (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSE=
T_CNTL ?
-                      s->regs.src_pitch : s->regs.default_pitch);
-        dst_stride =3D (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSE=
T_CNTL ?
-                      s->regs.dst_pitch : s->regs.default_pitch);
+        int src_stride =3D DEFAULT_CNTL ?
+                         s->regs.src_pitch : s->regs.default_pitch;
+        uint8_t *src_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
+                            s->regs.src_offset : s->regs.default_offset)=
;
=20
         if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
             src_bits +=3D s->regs.crtc_offset & 0x07ffffff;
-            dst_bits +=3D s->regs.crtc_offset & 0x07ffffff;
             src_stride *=3D bpp;
-            dst_stride *=3D bpp;
         }
+        if (src_bits >=3D end ||
+            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_heig=
ht) *
+            src_stride >=3D end) {
+            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
+            return;
+        }
+
         src_stride /=3D sizeof(uint32_t);
         dst_stride /=3D sizeof(uint32_t);
-
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, =
%d)\n",
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
                 s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst=
_y,
                 s->regs.dst_width, s->regs.dst_height);
-        end =3D s->vga.vram_ptr + s->vga.vram_size;
-        if (src_bits >=3D end || dst_bits >=3D end ||
-            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_heig=
ht) *
-            src_stride * sizeof(uint32_t) >=3D end ||
-            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_heig=
ht) *
-            dst_stride * sizeof(uint32_t) >=3D end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
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
-        int dst_stride, bpp =3D ati_bpp_from_datatype(s);
         uint32_t filler =3D 0;
-        dst_bits =3D s->vga.vram_ptr +
-                   (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CN=
TL ?
-                    s->regs.dst_offset : s->regs.default_offset);
-        dst_stride =3D (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSE=
T_CNTL ?
-                      s->regs.dst_pitch : s->regs.default_pitch);
-
-        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            dst_bits +=3D s->regs.crtc_offset & 0x07ffffff;
-            dst_stride *=3D bpp;
-        }
-        dst_stride /=3D sizeof(uint32_t);
=20
         switch (s->regs.dp_mix & GMC_ROP3_MASK) {
         case ROP3_PATCOPY:
@@ -144,22 +136,16 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
=20
+        dst_stride /=3D sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
                 dst_bits, dst_stride, bpp,
                 s->regs.dst_x, s->regs.dst_y,
                 s->regs.dst_width, s->regs.dst_height,
                 filler);
-        end =3D s->vga.vram_ptr + s->vga.vram_size;
-        if (dst_bits >=3D end ||
-            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_heig=
ht) *
-            dst_stride * sizeof(uint32_t) >=3D end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
-            return;
-        }
         pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
-                   s->regs.dst_x, s->regs.dst_y,
-                   s->regs.dst_width, s->regs.dst_height,
-                   filler);
+                    s->regs.dst_x, s->regs.dst_y,
+                    s->regs.dst_width, s->regs.dst_height,
+                    filler);
         if (dst_bits >=3D s->vga.vram_ptr + s->vga.vbe_start_addr &&
             dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offs=
et) {
--=20
2.13.7


