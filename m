Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62ADC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E48421882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E48421882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hid8i-0001AL-Ra
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59958)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hid1E-0000le-Gq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hid1D-0005EF-As
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44209)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hid1C-00054W-Ua
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9FD097461AE;
 Wed,  3 Jul 2019 13:01:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 257447462BB; Wed,  3 Jul 2019 13:01:38 +0200 (CEST)
Message-Id: <439aa85061f103446df7b42632d730971a372432.1562151410.git.balaton@eik.bme.hu>
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
Subject: [Qemu-devel] [PATCH 2/3] ati-vga: Fix frame buffer endianness for
 big endian target
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

The extended mode frame buffer should be little endian even when
emulating big endian machine (such as PPC). This fixes color problems
with MorphOS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c    |  1 +
 hw/display/ati_2d.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index c1d9d1518f..590362ea56 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -89,6 +89,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp=
, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+            s->vga.big_endian_fb =3D false;
             /* reset VBE regs then set up mode */
             s->vga.vbe_regs[VBE_DISPI_INDEX_XRES] =3D h;
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] =3D v;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index c31142af6e..b09753320a 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -124,15 +124,15 @@ void ati_2d_blt(ATIVGAState *s)
=20
         switch (s->regs.dp_mix & GMC_ROP3_MASK) {
         case ROP3_PATCOPY:
-            filler =3D bswap32(s->regs.dp_brush_frgd_clr);
+            filler =3D s->regs.dp_brush_frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler =3D rgb_to_pixel32(s->vga.palette[0], s->vga.palette[=
1],
-                                    s->vga.palette[2]) << 8 | 0xff;
+            filler =3D 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[0],
+                     s->vga.palette[1], s->vga.palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler =3D rgb_to_pixel32(s->vga.palette[3], s->vga.palette[=
4],
-                                    s->vga.palette[5]) << 8 | 0xff;
+            filler =3D 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[3],
+                     s->vga.palette[4], s->vga.palette[5]);
             break;
         }
=20
--=20
2.13.7


