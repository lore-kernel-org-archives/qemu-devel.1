Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C7C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2906420693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2906420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8O84-0008Jp-9U
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i8O3g-0002qw-RZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i8O3e-0005fx-T7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:18:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i8O3e-0005fe-OQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16A6C301D678;
 Thu, 12 Sep 2019 12:18:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEC1C5D713;
 Thu, 12 Sep 2019 12:18:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EADD3268; Thu, 12 Sep 2019 14:18:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 14:18:35 +0200
Message-Id: <20190912121835.18362-3-kraxel@redhat.com>
In-Reply-To: <20190912121835.18362-1-kraxel@redhat.com>
References: <20190912121835.18362-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 12 Sep 2019 12:18:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] ati: use vga_read_byte in ati_cursor_define
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

Reported-by: xu hang <flier_m@outlook.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8f940eee221a..6d77c40b8287 100644
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
+    unsigned srcoff;
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
-- 
2.18.1


