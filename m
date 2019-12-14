Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12532C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029C620663
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029C620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwGV-0005gU-9N
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 20:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEd-00041p-Iy
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEc-000185-7o
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:43 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47380)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ifwEc-00014z-3J; Fri, 13 Dec 2019 20:28:42 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 17B8923555; Fri, 13 Dec 2019 20:28:41 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <b38300386380fa2075ad980965033d1218468681.1576286757.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576286757.git.fthain@telegraphics.com.au>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 04/10] dp8393x: Don't advance RX descriptor twice
Date: Sat, 14 Dec 2019 12:25:57 +1100
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
 Herve Poussineau <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Follow the algorithm given in the National Semiconductor DP83932C
datasheet in sections 3.4.5 and 3.4.6.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/net/dp8393x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 462f8646e0..49d7d9769e 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -771,8 +771,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
-        } else {
-            s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         }
     }
 
@@ -821,7 +819,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     address_space_rw(&s->as, dp8393x_crda(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
 
-    /* Move to next descriptor */
+    /* Check link field */
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
@@ -836,6 +834,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         dp8393x_put(s, width, 0, 0);
         address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)s->data, size, 1);
+
+        /* Move to next descriptor */
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.23.0


