Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0116CC33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4880206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4880206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itJsf-0004na-Kl
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 18:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJg2-0004ez-Ar
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJg1-00041G-CH
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:08:18 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:54740)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1itJg1-0003lk-8R; Sun, 19 Jan 2020 18:08:17 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 747F32997F; Sun, 19 Jan 2020 18:07:55 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <a226aca301bf9ef0ee6d64569dc4eb9623089fc2.1579474761.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1579474761.git.fthain@telegraphics.com.au>
References: <cover.1579474761.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 12/14] dp8393x: Always update RRA pointers and sequence
 numbers
Date: Mon, 20 Jan 2020 09:59:21 +1100
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

These operations have to take place regardless of whether or not rx
descriptors have been used up (that is, EOL flag was observed).

The algorithm is the now the same for a packet that was withheld as
for a packet that was not.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 99c5dad7c4..1b73a8703b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -897,12 +897,14 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* Move to next descriptor */
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
-        s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
+    }
 
-        if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
-            /* Read next RRA */
-            dp8393x_do_read_rra(s);
-        }
+    s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) |
+                         ((s->regs[SONIC_RSC] + 1) & 0x00ff);
+
+    if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
+        /* Read next RRA */
+        dp8393x_do_read_rra(s);
     }
 
     /* Done */
-- 
2.24.1


