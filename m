Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D680C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0007421D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0007421D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii9rL-0005Uq-LS
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 23:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9nh-0008UY-8A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9nf-00024L-Oi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:04 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34456)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ii9nf-000214-3S; Thu, 19 Dec 2019 23:22:03 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id BF0D828D48; Thu, 19 Dec 2019 23:22:02 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <d399b2248d6bf2b43fff916aa5d7f7d2d27edd0a.1576815466.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576815466.git.fthain@telegraphics.com.au>
References: <cover.1576815466.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 10/13] dp8393x: Pad frames to word or long word boundary
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

The existing code has a bug where the Remaining Buffer Word Count (RBWC)
is calculated with a truncating division, which gives the wrong result
for odd-sized packets.

Section 1.4.1 of the datasheet says,

    Once the end of the packet has been reached, the serializer will
    fill out the last word (16-bit mode) or long word (32-bit mode)
    if the last byte did not end on a word or long word boundary
    respectively. The fill byte will be 0FFh.

Implement buffer padding so that buffer limits are correctly enforced.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/net/dp8393x.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a3936d3b7b..f35b8b48aa 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -763,16 +763,23 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     dp8393xState *s = qemu_get_nic_opaque(nc);
     int packet_type;
     uint32_t available, address;
-    int width, rx_len = pkt_size;
+    int width, rx_len, padded_len;
     uint32_t checksum;
     int size;
 
-    width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
-
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
 
-    if (pkt_size + 4 > dp8393x_rbwc(s) * 2) {
+    rx_len = pkt_size + sizeof(checksum);
+    if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
+        width = 2;
+        padded_len = ((rx_len - 1) | 3) + 1;
+    } else {
+        width = 1;
+        padded_len = ((rx_len - 1) | 1) + 1;
+    }
+
+    if (padded_len > dp8393x_rbwc(s) * 2) {
         DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
         s->regs[SONIC_ISR] |= SONIC_ISR_RBAE;
         dp8393x_update_irq(s);
@@ -807,22 +814,32 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     s->regs[SONIC_TRBA0] = s->regs[SONIC_CRBA0];
 
     /* Calculate the ethernet checksum */
-    checksum = cpu_to_le32(crc32(0, buf, rx_len));
+    checksum = cpu_to_le32(crc32(0, buf, pkt_size));
 
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address = dp8393x_crba(s);
     address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
-    address += rx_len;
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, pkt_size, 1);
+    address += pkt_size;
+
+    /* Put frame checksum into RBA */
     address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
-    address += 4;
-    rx_len += 4;
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, sizeof(checksum), 1);
+    address += sizeof(checksum);
+
+    /* Pad short packets to keep pointers aligned */
+    if (rx_len < padded_len) {
+        size = padded_len - rx_len;
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+            (uint8_t *)"\xFF\xFF\xFF", size, 1);
+        address += size;
+    }
+
     s->regs[SONIC_CRBA1] = address >> 16;
     s->regs[SONIC_CRBA0] = address & 0xffff;
     available = dp8393x_rbwc(s);
-    available -= rx_len / 2;
+    available -= padded_len >> 1;
     s->regs[SONIC_RBWC1] = available >> 16;
     s->regs[SONIC_RBWC0] = available & 0xffff;
 
-- 
2.23.0


