Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D1EC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE02F20663
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE02F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwJS-0000uR-M0
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 20:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEe-00041v-8W
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ifwEc-00019q-OS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:28:44 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47392)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ifwEc-000157-5V; Fri, 13 Dec 2019 20:28:42 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 26EE72786C; Fri, 13 Dec 2019 20:28:40 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <fb6dc2fc63561e73ecd62286a2703883e31fd394.1576286757.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576286757.git.fthain@telegraphics.com.au>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 03/10] dp8393x: Have dp8393x_receive() return the packet size
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

This function re-uses its 'size' argument as a scratch variable.
Instead, declare a local 'size' variable for that purpose so that the
function result doesn't get messed up.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/net/dp8393x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 3fd59bc1d4..462f8646e0 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -741,20 +741,21 @@ static int dp8393x_receive_filter(dp8393xState *s, const uint8_t * buf,
 }
 
 static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
-                               size_t size)
+                               size_t pkt_size)
 {
     dp8393xState *s = qemu_get_nic_opaque(nc);
     int packet_type;
     uint32_t available, address;
-    int width, rx_len = size;
+    int width, rx_len = pkt_size;
     uint32_t checksum;
+    int size;
 
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
 
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
 
-    packet_type = dp8393x_receive_filter(s, buf, size);
+    packet_type = dp8393x_receive_filter(s, buf, pkt_size);
     if (packet_type < 0) {
         DPRINTF("packet not for netcard\n");
         return -1;
@@ -848,7 +849,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* Done */
     dp8393x_update_irq(s);
 
-    return size;
+    return pkt_size;
 }
 
 static void dp8393x_reset(DeviceState *dev)
-- 
2.23.0


