Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809BFC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7D421901
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7D421901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiREM-0004Jt-Ad
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 18:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hiR6x-0006s4-VI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hiR6w-0002l9-3P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:18:51 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:44568
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hiR6u-0002G0-64
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:18:49 -0400
Received: from host109-146-132-17.range109-146.btcentralplus.com
 ([109.146.132.17] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hiR3r-0004bu-5e; Tue, 02 Jul 2019 23:15:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 23:16:06 +0100
Message-Id: <20190702221606.21600-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190702221606.21600-1-mark.cave-ayland@ilande.co.uk>
References: <20190702221606.21600-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.132.17
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 6/6] sunhme: ensure that RX descriptor ring
 overflow is indicated to client driver
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On very busy networks connected via a tap interface, it is possible to overflow
the RX descriptor ring in the time between the client driver enabling the RX
MAC and finishing writing the final configuration to the NIC registers.

Ensure that we detect this condition and update the status register accordingly
to indicate an overflow has occurred (and the incoming packet dropped) in order
to prevent the client driver becoming confused.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/sunhme.c     | 9 +++++++++
 hw/net/trace-events | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index cd076d642b..8b8603e696 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -44,6 +44,7 @@
 #define HME_SEBI_STAT                  0x100
 #define HME_SEBI_STAT_LINUXBUG         0x108
 #define HME_SEB_STAT_RXTOHOST          0x10000
+#define HME_SEB_STAT_NORXD             0x20000
 #define HME_SEB_STAT_MIFIRQ            0x800000
 #define HME_SEB_STAT_HOSTTOTX          0x1000000
 #define HME_SEB_STAT_TXALL             0x2000000
@@ -787,6 +788,14 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
     pci_dma_read(d, rb + cr * HME_DESC_SIZE, &status, 4);
     pci_dma_read(d, rb + cr * HME_DESC_SIZE + 4, &buffer, 4);
 
+    /* If we don't own the current descriptor then indicate overflow error */
+    if (!(status & HME_XD_OWN)) {
+        s->sebregs[HME_SEBI_STAT >> 2] |= HME_SEB_STAT_NORXD;
+        sunhme_update_irq(s);
+        trace_sunhme_rx_norxd();
+        return -1;
+    }
+
     rxoffset = (s->erxregs[HME_ERXI_CFG >> 2] & HME_ERX_CFG_BYTEOFFSET) >>
                 HME_ERX_CFG_BYTEOFFSET_SHIFT;
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index d16273c579..58665655cc 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -359,6 +359,7 @@ sunhme_rx_filter_reject(void) "rejecting incoming frame"
 sunhme_rx_filter_accept(void) "accepting incoming frame"
 sunhme_rx_desc(uint32_t addr, int offset, uint32_t status, int len, int cr, int nr) "addr 0x%"PRIx32"(+0x%x) status 0x%"PRIx32 " len %d (ring %d/%d)"
 sunhme_rx_xsum_calc(uint16_t xsum) "calculated incoming xsum as 0x%x"
+sunhme_rx_norxd(void) "no free rx descriptors available"
 sunhme_update_irq(uint32_t mifmask, uint32_t mif, uint32_t sebmask, uint32_t seb, int level) "mifmask: 0x%x  mif: 0x%x  sebmask: 0x%x  seb: 0x%x  level: %d"
 
 # virtio-net.c
-- 
2.11.0


