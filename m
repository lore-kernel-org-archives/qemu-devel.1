Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DACC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 17:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B32A20881
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 17:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B32A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhdkv-0001ha-QJ
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 13:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58313)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hhdjU-0000LN-9l
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hhdjT-0000UF-Az
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:35:20 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:40190
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hhdjT-0007ys-5Q
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:35:19 -0400
Received: from host109-146-132-17.range109-146.btcentralplus.com
 ([109.146.132.17] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hhdfr-0001xd-Ps
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 18:31:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Sun, 30 Jun 2019 18:32:01 +0100
Message-Id: <20190630173203.9620-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190630173203.9620-1-mark.cave-ayland@ilande.co.uk>
References: <20190630173203.9620-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.132.17
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 3/5] sunhme: flush any queued packets when
 HME_MAC_RXCFG_ENABLE bit is raised
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

Some client drivers use this bit to pause and resume the driver so make sure
that queued packets are flushed when the MAC is disabled and then reactivated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/sunhme.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index e3a488ee1d..14e7effb88 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -373,10 +373,20 @@ static void sunhme_mac_write(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
     SunHMEState *s = SUNHME(opaque);
+    uint64_t oldval = s->macregs[addr >> 2];
 
     trace_sunhme_mac_write(addr, val);
 
     s->macregs[addr >> 2] = val;
+
+    switch (addr) {
+    case HME_MACI_RXCFG:
+        if (!(oldval & HME_MAC_RXCFG_ENABLE) &&
+             (val & HME_MAC_RXCFG_ENABLE)) {
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        }
+        break;
+    }
 }
 
 static uint64_t sunhme_mac_read(void *opaque, hwaddr addr,
-- 
2.11.0


