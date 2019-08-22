Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D6F20870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D6F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0i87-0000IZ-HZ
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5m-0007Ly-0l
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5k-0005pJ-PH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5k-0005oO-JG
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D32EB30832C8;
 Thu, 22 Aug 2019 08:05:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D17D60605;
 Thu, 22 Aug 2019 08:05:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3365993E3; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:04:59 +0200
Message-Id: <20190822080503.12063-6-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
References: <20190822080503.12063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 22 Aug 2019 08:05:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/8] ati-vga: Fix hardware cursor image offset
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

The crtc_offset is not needed, cur_offset is relative to the start of
vram not the start of displayed area. This fixes broken pointer image
with MacOS that uses non-0 crtc_offset.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: e6acb1fa3ca980dc948045443e5986e2aa79bf7c.1565558093.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d372e346ffd9..ff04f7eb4a2d 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -132,9 +132,8 @@ static void ati_cursor_define(ATIVGAState *s)
         return; /* Do not update cursor if locked or rendered by guest */
     }
     /* FIXME handle cur_hv_offs correctly */
-    src = s->vga.vram_ptr + (s->regs.crtc_offset & 0x07ffffff) +
-          s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
-          (s->regs.cur_hv_offs & 0xffff) * 16;
+    src = s->vga.vram_ptr + s->regs.cur_offset -
+          (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
     for (i = 0; i < 64; i++) {
         for (j = 0; j < 8; j++, idx++) {
             data[idx] = src[i * 16 + j];
@@ -190,8 +189,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
         return;
     }
     /* FIXME handle cur_hv_offs correctly */
-    src = s->vga.vram_ptr + (s->regs.crtc_offset & 0x07ffffff) +
-          s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
+    src = s->vga.vram_ptr + s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
     dp = &dp[vga->hw_cursor_x];
     h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
     for (i = 0; i < 8; i++) {
-- 
2.18.1


