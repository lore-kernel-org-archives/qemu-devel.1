Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B878C33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4C6206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4C6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itJhM-0005zP-FN
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 18:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJfi-00049T-6D
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJfg-0003lK-Uu
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:07:58 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:54732)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1itJfg-0003l4-R7; Sun, 19 Jan 2020 18:07:56 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 278E42996D; Sun, 19 Jan 2020 18:07:55 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <dbbcc7916a82158e12e24d3bd1f388f65a3e47b6.1579474761.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1579474761.git.fthain@telegraphics.com.au>
References: <cover.1579474761.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 05/14] dp8393x: Update LLFA and CRDA registers from rx
 descriptor
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

Follow the algorithm given in the National Semiconductor DP83932C
datasheet in section 3.4.7:

    At the next reception, the SONIC re-reads the last RXpkt.link field,
    and updates its CRDA register to point to the next descriptor.

The chip is designed to allow the host to provide a new list of
descriptors in this way.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
---
Changed since v1:
 - Update CRDA register from LLFA register after EOL is cleared.
---
 hw/net/dp8393x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index ece72cbf42..249be403af 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -784,12 +784,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)s->data, size, 0);
-        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
+        s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
+        if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
             /* Still EOL ; stop reception */
             return -1;
-        } else {
-            s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         }
+        /* Link has been updated by host */
+        s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
     }
 
     /* Save current position */
@@ -837,7 +838,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     address_space_rw(&s->as, dp8393x_crda(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
 
-    /* Move to next descriptor */
+    /* Check link field */
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
@@ -852,6 +853,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         dp8393x_put(s, width, 0, 0);
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)s->data, size, 1);
+
+        /* Move to next descriptor */
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.24.1


