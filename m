Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D1C3F2CE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 09:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5754920661
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 09:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="T3fzgvoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5754920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7yoo-0005Rr-2d
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 04:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1j7yll-0004h0-5D
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1j7ylj-0004nc-SM
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:50:49 -0500
Received: from smtp.duncanthrax.net ([178.63.180.169]:38424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1j7ylj-0004n2-Bu
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZG0v8FVysTuE+UkESg/FvlLJyxWq9TgL3tVGtsWFuaI=; b=T3fzgvoGiLMXPUlsje85tL7LTa
 xpRdnnUVfJs5GrmFucg3w5Bqaykdsyrq0bMNtQPA7Nfi6ZUdF6de52uTXzpO4ffWh5AghlJBzeKOb
 Afwptto3Tz1k4CA+YGwGRMsFMigxhC1i/ooQNCnkV5KhOpjel8CZLla/eW3fEcBeDUOo=;
Received: from [134.3.47.90] (helo=x280.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1j7ylg-0006kF-Ro; Sat, 29 Feb 2020 10:50:45 +0100
From: Sven Schnelle <svens@stackframe.org>
To: deller@gmx.de
Subject: [PATCH] fix out of bounds check
Date: Sat, 29 Feb 2020 10:50:40 +0100
Message-Id: <20200229095040.29616-1-svens@stackframe.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.63.180.169
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
Cc: Sven Schnelle <svens@stackframe.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/display/artist.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index f3a1375224..6cc85eb292 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -340,14 +340,13 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask = s->vram_bitmask;
-    int mask, i, pix_count, pix_length, offset, height, width;
+    int mask, i, pix_count, pix_length, offset, width;
     uint8_t *data8, *p;
 
     pix_count = vram_write_pix_per_transfer(s);
     pix_length = vram_pixel_length(s);
 
     buf = vram_write_buffer(s);
-    height = buf->height;
     width = buf->width;
 
     if (s->cmap_bm_access) {
@@ -367,20 +366,13 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
         pix_count = size * 8;
     }
 
-    if (posy * width + posx + pix_count > buf->size) {
-        qemu_log("write outside bounds: wants %dx%d, max size %dx%d\n",
-                 posx, posy, width, height);
-        return;
-    }
-
-
     switch (pix_length) {
     case 0:
         if (s->image_bitmap_op & 0x20000000) {
             data &= vram_bitmask;
         }
 
-        for (i = 0; i < pix_count; i++) {
+        for (i = 0; i < pix_count && offset + i < buf->size; i++) {
             artist_rop8(s, p + offset + pix_count - 1 - i,
                         (data & 1) ? (s->plane_mask >> 24) : 0);
             data >>= 1;
@@ -398,7 +390,9 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
         for (i = 3; i >= 0; i--) {
             if (!(s->image_bitmap_op & 0x20000000) ||
                 s->vram_bitmask & (1 << (28 + i))) {
-                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
+                if (offset + 3 - i < buf->size) {
+                    artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
+                }
             }
         }
         memory_region_set_dirty(&buf->mr, offset, 3);
@@ -420,7 +414,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
             break;
         }
 
-        for (i = 0; i < pix_count; i++) {
+        for (i = 0; i < pix_count && offset + i < buf->size; i++) {
             mask = 1 << (pix_count - 1 - i);
 
             if (!(s->image_bitmap_op & 0x20000000) ||
-- 
2.24.1


