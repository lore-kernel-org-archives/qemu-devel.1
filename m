Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D054CC2BB55
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B076420748
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B076420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLYZ1-00015S-AR
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 16:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jLYY1-0008Pu-II
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jLYXz-0006Dn-NW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:40:44 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:57373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jLYXv-00061V-CX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:40:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3B141747DF7;
 Mon,  6 Apr 2020 22:40:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 19559747D5D; Mon,  6 Apr 2020 22:40:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ati-vga: Fix checks in ati_2d_blt() to avoid crash
Date: Mon, 06 Apr 2020 22:34:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Message-Id: <20200406204029.19559747D5D@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: mcascell@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some corner cases (that never happen during normal operation but a
malicious guest could program wrong values) pixman functions were
called with parameters that result in a crash. Fix this and add more
checks to disallow such cases.

Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 42e82311eb..23a8ae0cd8 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -53,12 +53,20 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    int dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                 s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    int dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                 s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height)=
;
+    unsigned dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_wi=
dth);
+    unsigned dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_he=
ight);
     int bpp =3D ati_bpp_from_datatype(s);
+    if (!bpp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
+        return;
+    }
     int dst_stride =3D DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.defaul=
t_pitch;
+    if (!dst_stride) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
+        return;
+    }
     uint8_t *dst_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
                         s->regs.dst_offset : s->regs.default_offset);
=20
@@ -82,12 +90,16 @@ void ati_2d_blt(ATIVGAState *s)
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
-        int src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                     s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_wid=
th);
-        int src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                     s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_hei=
ght);
+        unsigned src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_w=
idth);
+        unsigned src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_h=
eight);
         int src_stride =3D DEFAULT_CNTL ?
                          s->regs.src_pitch : s->regs.default_pitch;
+        if (!src_stride) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
+            return;
+        }
         uint8_t *src_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
                             s->regs.src_offset : s->regs.default_offset)=
;
=20
@@ -137,8 +149,10 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(=
ds));
         }
-        s->regs.dst_x +=3D s->regs.dst_width;
-        s->regs.dst_y +=3D s->regs.dst_height;
+        s->regs.dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                         dst_x + s->regs.dst_width : dst_x);
+        s->regs.dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     case ROP3_PATCOPY:
@@ -179,7 +193,8 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(=
ds));
         }
-        s->regs.dst_y +=3D s->regs.dst_height;
+        s->regs.dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     default:
--=20
2.21.1


