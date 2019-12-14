Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0843DC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91BB2077B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91BB2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwNH-0005zl-T6
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 20:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEe-000424-Qu
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEd-0001A6-02
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:44 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47422)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ifwEc-00017i-Ex; Fri, 13 Dec 2019 20:28:42 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 6108D27C8C; Fri, 13 Dec 2019 20:28:41 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <0beefa36e1c95fabb6c46c4d68559c667e68cec9.1576286757.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576286757.git.fthain@telegraphics.com.au>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 08/10] dp8393x: Implement packet size limit and RBAE interrupt
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

Add a bounds check to prevent a large packet from causing a buffer
overflow. This is defensive programming -- I haven't actually tried
sending an oversized packet or a jumbo ethernet frame.

The SONIC handles packets that are too big for the buffer by raising
the RBAE interrupt and dropping them. Linux uses that interrupt to
count dropped packets.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
QEMU passes short packets to dp8393x_receive(). But a real SONIC rejects
packets shorter than 64 bytes.

For dp8393x, the effective limit is 60 bytes because packets passed to
dp8393x_receive() lack a frame checksum. However, even 60 bytes proved
too high and blocked ARP packets when I tried it.

So the SONIC's mechanism for detecting runt packets (the RNT bit in the
RCR register) remains unimplemented in dp8393x (i.e. they are still
accepted).

This packet length issue may have implications for guests that depend on
the chip honouring the packet length threshold set in the EOBC register.
---
 hw/net/dp8393x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 5e4494a945..24f2e19f07 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -139,6 +139,7 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA_ARGS__); } while (0)
 #define SONIC_TCR_CRCI   0x2000
 #define SONIC_TCR_PINT   0x8000
 
+#define SONIC_ISR_RBAE   0x0010
 #define SONIC_ISR_RBE    0x0020
 #define SONIC_ISR_RDE    0x0040
 #define SONIC_ISR_TC     0x0080
@@ -751,6 +752,14 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     uint32_t checksum;
     int size;
 
+    if (pkt_size + 4 > dp8393x_rbwc(s) * 2) {
+        DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
+        s->regs[SONIC_ISR] |= SONIC_ISR_RBAE;
+        dp8393x_update_irq(s);
+        dp8393x_do_read_rra(s);
+        return pkt_size;
+    }
+
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
 
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
-- 
2.23.0


