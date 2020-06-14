Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5623C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FC4206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FC4206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTpE-00007X-SZ
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTej-00006e-Eb; Sun, 14 Jun 2020 10:30:41 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38468
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTeh-0005SH-MF; Sun, 14 Jun 2020 10:30:41 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTeZ-0006Hv-Hi; Sun, 14 Jun 2020 15:30:37 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Sun, 14 Jun 2020 15:28:35 +0100
Message-Id: <20200614142840.10245-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 17/22] pmu: add adb_autopoll_block() and
 adb_autopoll_unblock() functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Ensure that the PMU buffer is protected from autopoll requests overwriting
its contents whilst existing PMU requests are in progress.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index e2291cc9f6..833dea4f71 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -515,6 +515,7 @@ static void pmu_update(PMUState *s)
 {
     MOS6522PMUState *mps = &s->mos6522_pmu;
     MOS6522State *ms = MOS6522(mps);
+    ADBBusState *adb_bus = &s->adb_bus;
 
     /* Only react to changes in reg B */
     if (ms->b == s->last_b) {
@@ -576,6 +577,7 @@ static void pmu_update(PMUState *s)
         s->cmd_rsp_pos = 0;
         s->cmd_state = pmu_state_cmd;
 
+        adb_autopoll_block(adb_bus);
         trace_pmu_debug_protocol_cmd(s->cmd, s->cmdlen, s->rsplen);
         break;
 
@@ -634,6 +636,7 @@ static void pmu_update(PMUState *s)
     if (s->cmd_state == pmu_state_rsp && s->rsplen == s->cmd_rsp_pos) {
         trace_pmu_debug_protocol_cmd_resp_complete(ms->ier);
 
+        adb_autopoll_unblock(adb_bus);
         s->cmd_state = pmu_state_idle;
     }
 }
-- 
2.20.1


