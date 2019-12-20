Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C4FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B1A206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B1A206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii9pg-00034Z-DZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 23:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9ng-0008TI-4H
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9ne-0001yi-E5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:03 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34416)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ii9ne-0001xK-6E; Thu, 19 Dec 2019 23:22:02 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id EE6062829C; Thu, 19 Dec 2019 23:22:01 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <e44d136b8b71414e17200bb1b7edfd94fe866705.1576815466.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576815466.git.fthain@telegraphics.com.au>
References: <cover.1576815466.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 02/13] dp8393x: Clean up endianness hacks
Date: Fri, 20 Dec 2019 15:17:46 +1100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The in_use field is no different to the other words handled using
dp8393x_put() and dp8393x_get(). Use the same technique for in_use
that is used everywhere else.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v1:
 - Use existing 'address' variable rather than declare a new one.

Laurent tells me that this clean-up has been tried before. He referred
me to commit c744cf7879 ("dp8393x: fix dp8393x_receive()") and
commit 409b52bfe1 ("net/dp8393x: correctly reset in_use field").

Both of those patches look wrong to me because they both pass the wrong
byte count to address_space_rw(). It's possible that those patches were
needed to work around some kind of bug elsewhere, for example, an
off-by-one result from dp8393x_crda(). The preceding patch in this series
might help there.
---
 hw/net/dp8393x.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 1957bd391e..b2cc768d9b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -765,8 +765,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         return -1;
     }
 
-    /* XXX: Check byte ordering */
-
     /* Check for EOL */
     if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* Are we still in resource exhaustion? */
@@ -836,15 +834,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        /* Clear in_use, but it is always 16bit wide */
-        int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
-        if (s->big_endian && width == 2) {
-            /* we need to adjust the offset of the 16bit field */
-            offset += sizeof(uint16_t);
-        }
-        s->data[0] = 0;
-        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)s->data, sizeof(uint16_t), 1);
+        /* Clear in_use */
+        address = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        size = sizeof(uint16_t) * width;
+        dp8393x_put(s, width, 0, 0);
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, size, 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.23.0


