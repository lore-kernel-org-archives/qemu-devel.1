Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB7BC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A127206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A127206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwLD-0003o5-7J
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 20:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEe-00041t-6i
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEc-00019F-KF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:44 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47408)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ifwEc-00016s-78; Fri, 13 Dec 2019 20:28:42 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 5238A27C43; Fri, 13 Dec 2019 20:28:41 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <c37c8c085be7b484fb68a34f0e39851bdd1e48ca.1576286757.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576286757.git.fthain@telegraphics.com.au>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 07/10] dp8393x: Implement TBWC0 and TBWC1 registers to restore
 buffer state
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

Restore the receive buffer state when the SONIC runs out of receive
descriptors. Otherwise it may write the next packet past the end of the
buffer and corrupt guest memory. This implements behaviour described
in section 3.4.6.2 in the datasheet.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/net/dp8393x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 3fdc6cc6f9..5e4494a945 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -39,7 +39,7 @@ static const char* reg_names[] = {
     "CR", "DCR", "RCR", "TCR", "IMR", "ISR", "UTDA", "CTDA",
     "TPS", "TFC", "TSA0", "TSA1", "TFS", "URDA", "CRDA", "CRBA0",
     "CRBA1", "RBWC0", "RBWC1", "EOBC", "URRA", "RSA", "REA", "RRP",
-    "RWP", "TRBA0", "TRBA1", "0x1b", "0x1c", "0x1d", "0x1e", "LLFA",
+    "RWP", "TRBA0", "TRBA1", "TBWC0", "TBWC1", "0x1d", "0x1e", "LLFA",
     "TTDA", "CEP", "CAP2", "CAP1", "CAP0", "CE", "CDP", "CDC",
     "SR", "WT0", "WT1", "RSC", "CRCT", "FAET", "MPT", "MDT",
     "0x30", "0x31", "0x32", "0x33", "0x34", "0x35", "0x36", "0x37",
@@ -78,6 +78,8 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA_ARGS__); } while (0)
 #define SONIC_RWP    0x18
 #define SONIC_TRBA0  0x19
 #define SONIC_TRBA1  0x1a
+#define SONIC_TBWC0  0x1b
+#define SONIC_TBWC1  0x1c
 #define SONIC_LLFA   0x1f
 #define SONIC_TTDA   0x20
 #define SONIC_CEP    0x21
@@ -777,6 +779,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* Save current position */
     s->regs[SONIC_TRBA1] = s->regs[SONIC_CRBA1];
     s->regs[SONIC_TRBA0] = s->regs[SONIC_CRBA0];
+    s->regs[SONIC_TBWC1] = s->regs[SONIC_RBWC1];
+    s->regs[SONIC_TBWC0] = s->regs[SONIC_RBWC0];
 
     /* Calculate the ethernet checksum */
     checksum = cpu_to_le32(crc32(0, buf, rx_len));
@@ -827,6 +831,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
+
+        /* Restore buffer state */
+        s->regs[SONIC_CRBA1] = s->regs[SONIC_TRBA1];
+        s->regs[SONIC_CRBA0] = s->regs[SONIC_TRBA0];
+        s->regs[SONIC_RBWC1] = s->regs[SONIC_TBWC1];
+        s->regs[SONIC_RBWC0] = s->regs[SONIC_TBWC0];
     } else {
         /* Clear in_use */
         int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
-- 
2.23.0


