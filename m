Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0981CC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8AC206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8AC206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyOL0-0006iM-0Q
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 18:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH9-00034c-J9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH8-0006Lf-27
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47231)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hyOH7-0006KT-Ox
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A51D374BAF3;
 Fri, 16 Aug 2019 00:31:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0DB1074581E; Fri, 16 Aug 2019 00:31:14 +0200 (CEST)
Message-Id: <1e658a7a7198a9ab10084bb85348e7d0a37a9055.1565907489.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1565907489.git.balaton@eik.bme.hu>
References: <cover.1565907489.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 16 Aug 2019 00:18:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH 2/3] ati-vga: Support unaligned access to
 hardware cursor registers
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

This fixes horizontal mouse movement and pointer color with MacOS that
writes these registers with access size less than 4 so previously only
the last portion of access was effective overwriting previous partial
writes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 87 +++++++++++++++++++++++++++++++++++++-------------=
------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 87ad18664d..5e2c4ba4aa 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -385,22 +385,28 @@ static uint64_t ati_mm_read(void *opaque, hwaddr ad=
dr, unsigned int size)
     case 0xf00 ... 0xfff:
         val =3D pci_default_read_config(&s->dev, addr - 0xf00, size);
         break;
-    case CUR_OFFSET:
-        val =3D s->regs.cur_offset;
-        break;
-    case CUR_HORZ_VERT_POSN:
-        val =3D s->regs.cur_hv_pos;
-        val |=3D s->regs.cur_offset & BIT(31);
+    case CUR_OFFSET ... CUR_OFFSET + 3:
+        val =3D ati_reg_read_offs(s->regs.cur_offset, addr - CUR_OFFSET,=
 size);
+        break;
+    case CUR_HORZ_VERT_POSN ... CUR_HORZ_VERT_POSN + 3:
+        val =3D ati_reg_read_offs(s->regs.cur_hv_pos,
+                                addr - CUR_HORZ_VERT_POSN, size);
+        if (addr + size > CUR_HORZ_VERT_POSN + 3) {
+            val |=3D (s->regs.cur_offset & BIT(31)) >> (4 - size);
+        }
         break;
-    case CUR_HORZ_VERT_OFF:
-        val =3D s->regs.cur_hv_offs;
-        val |=3D s->regs.cur_offset & BIT(31);
+    case CUR_HORZ_VERT_OFF ... CUR_HORZ_VERT_OFF + 3:
+        val =3D ati_reg_read_offs(s->regs.cur_hv_offs,
+                                addr - CUR_HORZ_VERT_OFF, size);
+        if (addr + size > CUR_HORZ_VERT_OFF + 3) {
+            val |=3D (s->regs.cur_offset & BIT(31)) >> (4 - size);
+        }
         break;
-    case CUR_CLR0:
-        val =3D s->regs.cur_color0;
+    case CUR_CLR0 ... CUR_CLR0 + 3:
+        val =3D ati_reg_read_offs(s->regs.cur_color0, addr - CUR_CLR0, s=
ize);
         break;
-    case CUR_CLR1:
-        val =3D s->regs.cur_color1;
+    case CUR_CLR1 ... CUR_CLR1 + 3:
+        val =3D ati_reg_read_offs(s->regs.cur_color1, addr - CUR_CLR1, s=
ize);
         break;
     case DST_OFFSET:
         val =3D s->regs.dst_offset;
@@ -672,48 +678,71 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case 0xf00 ... 0xfff:
         /* read-only copy of PCI config space so ignore writes */
         break;
-    case CUR_OFFSET:
-        if (s->regs.cur_offset !=3D (data & 0x87fffff0)) {
-            s->regs.cur_offset =3D data & 0x87fffff0;
+    case CUR_OFFSET ... CUR_OFFSET + 3:
+    {
+        uint32_t t =3D s->regs.cur_offset;
+
+        ati_reg_write_offs(&t, addr - CUR_OFFSET, data, size);
+        t &=3D 0x87fffff0;
+        if (s->regs.cur_offset !=3D t) {
+            s->regs.cur_offset =3D t;
             ati_cursor_define(s);
         }
         break;
-    case CUR_HORZ_VERT_POSN:
-        s->regs.cur_hv_pos =3D data & 0x3fff0fff;
-        if (data & BIT(31)) {
-            s->regs.cur_offset |=3D data & BIT(31);
+    }
+    case CUR_HORZ_VERT_POSN ... CUR_HORZ_VERT_POSN + 3:
+    {
+        uint32_t t =3D s->regs.cur_hv_pos | (s->regs.cur_offset & BIT(31=
));
+
+        ati_reg_write_offs(&t, addr - CUR_HORZ_VERT_POSN, data, size);
+        s->regs.cur_hv_pos =3D t & 0x3fff0fff;
+        if (t & BIT(31)) {
+            s->regs.cur_offset |=3D t & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
             s->regs.cur_offset &=3D ~BIT(31);
             ati_cursor_define(s);
         }
         if (!s->cursor_guest_mode &&
-            (s->regs.crtc_gen_cntl & CRTC2_CUR_EN) && !(data & BIT(31)))=
 {
+            (s->regs.crtc_gen_cntl & CRTC2_CUR_EN) && !(t & BIT(31))) {
             dpy_mouse_set(s->vga.con, s->regs.cur_hv_pos >> 16,
                           s->regs.cur_hv_pos & 0xffff, 1);
         }
         break;
+    }
     case CUR_HORZ_VERT_OFF:
-        s->regs.cur_hv_offs =3D data & 0x3f003f;
-        if (data & BIT(31)) {
-            s->regs.cur_offset |=3D data & BIT(31);
+    {
+        uint32_t t =3D s->regs.cur_hv_offs | (s->regs.cur_offset & BIT(3=
1));
+
+        ati_reg_write_offs(&t, addr - CUR_HORZ_VERT_OFF, data, size);
+        s->regs.cur_hv_offs =3D t & 0x3f003f;
+        if (t & BIT(31)) {
+            s->regs.cur_offset |=3D t & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
             s->regs.cur_offset &=3D ~BIT(31);
             ati_cursor_define(s);
         }
         break;
-    case CUR_CLR0:
-        if (s->regs.cur_color0 !=3D (data & 0xffffff)) {
-            s->regs.cur_color0 =3D data & 0xffffff;
+    }
+    case CUR_CLR0 ... CUR_CLR0 + 3:
+    {
+        uint32_t t =3D s->regs.cur_color0;
+
+        ati_reg_write_offs(&t, addr - CUR_CLR0, data, size);
+        t &=3D 0xffffff;
+        if (s->regs.cur_color0 !=3D t) {
+            s->regs.cur_color0 =3D t;
             ati_cursor_define(s);
         }
         break;
-    case CUR_CLR1:
+    }
+    case CUR_CLR1 ... CUR_CLR1 + 3:
         /*
          * Update cursor unconditionally here because some clients set u=
p
          * other registers before actually writing cursor data to memory=
 at
          * offset so we would miss cursor change unless always updating =
here
          */
-        s->regs.cur_color1 =3D data & 0xffffff;
+        ati_reg_write_offs(&s->regs.cur_color1, addr - CUR_CLR1, data, s=
ize);
+        s->regs.cur_color1 &=3D 0xffffff;
         ati_cursor_define(s);
         break;
     case DST_OFFSET:
--=20
2.13.7


