Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6EC433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7AB20844
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7AB20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwvVi-0007hm-OE
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 17:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSy-00020B-R7
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSw-00045q-Ux
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:55464)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hwvSw-0003yS-NW
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 89BB974CC7E;
 Sun, 11 Aug 2019 23:33:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E718B74B841; Sun, 11 Aug 2019 23:33:11 +0200 (CEST)
Message-Id: <e6acb1fa3ca980dc948045443e5986e2aa79bf7c.1565558093.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1565558093.git.balaton@eik.bme.hu>
References: <cover.1565558093.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 11 Aug 2019 23:14:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH 5/7] ati-vga: Fix hardware cursor image offset
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

The crtc_offset is not needed, cur_offset is relative to the start of
vram not the start of displayed area. This fixes broken pointer image
with MacOS that uses non-0 crtc_offset.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index b849f5d510..bbcdd6bc83 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -132,9 +132,8 @@ static void ati_cursor_define(ATIVGAState *s)
         return; /* Do not update cursor if locked or rendered by guest *=
/
     }
     /* FIXME handle cur_hv_offs correctly */
-    src =3D s->vga.vram_ptr + (s->regs.crtc_offset & 0x07ffffff) +
-          s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
-          (s->regs.cur_hv_offs & 0xffff) * 16;
+    src =3D s->vga.vram_ptr + s->regs.cur_offset -
+          (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) *=
 16;
     for (i =3D 0; i < 64; i++) {
         for (j =3D 0; j < 8; j++, idx++) {
             data[idx] =3D src[i * 16 + j];
@@ -190,8 +189,7 @@ static void ati_cursor_draw_line(VGACommonState *vga,=
 uint8_t *d, int scr_y)
         return;
     }
     /* FIXME handle cur_hv_offs correctly */
-    src =3D s->vga.vram_ptr + (s->regs.crtc_offset & 0x07ffffff) +
-          s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
+    src =3D s->vga.vram_ptr + s->cursor_offset + (scr_y - vga->hw_cursor=
_y) * 16;
     dp =3D &dp[vga->hw_cursor_x];
     h =3D ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
     for (i =3D 0; i < 8; i++) {
--=20
2.13.7


