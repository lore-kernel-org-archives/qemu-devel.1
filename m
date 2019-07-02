Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAF1C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B53218FF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B53218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiR9j-0000B2-K7
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 18:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hiR6q-0006ov-Sh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hiR6n-0002WF-OB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:18:44 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:44564
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hiR6l-0002G1-BH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:18:40 -0400
Received: from host109-146-132-17.range109-146.btcentralplus.com
 ([109.146.132.17] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hiR3p-0004bu-CE; Tue, 02 Jul 2019 23:15:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 23:16:05 +0100
Message-Id: <20190702221606.21600-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190702221606.21600-1-mark.cave-ayland@ilande.co.uk>
References: <20190702221606.21600-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.132.17
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 5/6] sunhme: fix return values from
 sunhme_receive() during receive packet processing
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

The current return values in sunhme_receive() when processing incoming packets
are inverted from what they should be. Make sure that we return 0 to indicate
the packet was discarded (and polling is to be disabled) and -1 to indicate
that the packet was discarded but polling for incoming data is to be continued.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/sunhme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 14e7effb88..cd076d642b 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -728,7 +728,7 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
 
     /* Do nothing if MAC RX disabled */
     if (!(s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_ENABLE)) {
-        return -1;
+        return 0;
     }
 
     trace_sunhme_rx_filter_destmac(buf[0], buf[1], buf[2],
@@ -757,14 +757,14 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
                 /* Didn't match hash filter */
                 trace_sunhme_rx_filter_hash_nomatch();
                 trace_sunhme_rx_filter_reject();
-                return 0;
+                return -1;
             } else {
                 trace_sunhme_rx_filter_hash_match();
             }
         } else {
             /* Not for us */
             trace_sunhme_rx_filter_reject();
-            return 0;
+            return -1;
         }
     } else {
         trace_sunhme_rx_filter_promisc_match();
-- 
2.11.0


