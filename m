Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99676C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F87B214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F87B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABTG-0002ZI-8l
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iABRa-0001Zs-OV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iABRZ-000635-If
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iABRZ-00062Q-Da
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DDFFC0568FD;
 Tue, 17 Sep 2019 11:14:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 656595C1D8;
 Tue, 17 Sep 2019 11:14:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8DD5117538; Tue, 17 Sep 2019 13:14:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 13:14:41 +0200
Message-Id: <20190917111441.27405-3-kraxel@redhat.com>
In-Reply-To: <20190917111441.27405-1-kraxel@redhat.com>
References: <20190917111441.27405-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 17 Sep 2019 11:14:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/2] ati: use vga_read_byte in
 ati_cursor_define
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 flier_m@outlook.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes sure reads are confined to vga video memory.

v3: use uint32_t, fix cut+paste bug.
v2: fix ati_cursor_draw_line too.

Reported-by: xu hang <flier_m@outlook.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8f940eee221a..db3b2543163f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "ati_int.h"
 #include "ati_regs.h"
+#include "vga-access.h"
 #include "hw/qdev-properties.h"
 #include "vga_regs.h"
 #include "qemu/log.h"
@@ -135,19 +136,19 @@ static void ati_vga_switch_mode(ATIVGAState *s)
 static void ati_cursor_define(ATIVGAState *s)
 {
     uint8_t data[1024];
-    uint8_t *src;
+    uint32_t srcoff;
     int i, j, idx = 0;
 
     if ((s->regs.cur_offset & BIT(31)) || s->cursor_guest_mode) {
         return; /* Do not update cursor if locked or rendered by guest */
     }
     /* FIXME handle cur_hv_offs correctly */
-    src = s->vga.vram_ptr + s->regs.cur_offset -
-          (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
+    srcoff = s->regs.cur_offset -
+        (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
     for (i = 0; i < 64; i++) {
         for (j = 0; j < 8; j++, idx++) {
-            data[idx] = src[i * 16 + j];
-            data[512 + idx] = src[i * 16 + j + 8];
+            data[idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j);
+            data[512 + idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j + 8);
         }
     }
     if (!s->cursor) {
@@ -189,7 +190,7 @@ static void ati_cursor_invalidate(VGACommonState *vga)
 static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
 {
     ATIVGAState *s = container_of(vga, ATIVGAState, vga);
-    uint8_t *src;
+    uint32_t srcoff;
     uint32_t *dp = (uint32_t *)d;
     int i, j, h;
 
@@ -199,13 +200,13 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
         return;
     }
     /* FIXME handle cur_hv_offs correctly */
-    src = s->vga.vram_ptr + s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
+    srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
     dp = &dp[vga->hw_cursor_x];
     h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
     for (i = 0; i < 8; i++) {
         uint32_t color;
-        uint8_t abits = src[i];
-        uint8_t xbits = src[i + 8];
+        uint8_t abits = vga_read_byte(vga, srcoff + i);
+        uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
         for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1) {
             if (abits & BIT(7)) {
                 if (xbits & BIT(7)) {
-- 
2.18.1


