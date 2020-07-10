Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4FBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B005F20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B005F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvIN-0002C7-UT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtvEV-0005bh-Le; Fri, 10 Jul 2020 11:46:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:41018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtvET-0008Qq-2L; Fri, 10 Jul 2020 11:46:39 -0400
IronPort-SDR: Iv8Ru4CMog5ZsfQgUuHPnzxu3bqrznBqdnCHT5UIE+HnLDzehmWIY+ko2028B2g17LyrMRW3vj
 BXKs5kxmJS7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="209754753"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="209754753"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2020 08:46:34 -0700
IronPort-SDR: TQRhjWwWId/AWMmXjERSCPjmdXHso115aC8naLI78bJsJlzur2rABZgZ1ZFDubgQfaf+s0OBuh
 YRQkRYqRHhUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="484686394"
Received: from unknown (HELO localhost.localdomain.sh.intel.com)
 ([10.239.153.142])
 by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:46:32 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 4/4] hw/nios2: exit to main CPU loop only when unmasking
 interrupts
Date: Fri, 10 Jul 2020 19:34:33 -0400
Message-Id: <20200710233433.19729-4-wentong.wu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200710233433.19729-1-wentong.wu@intel.com>
References: <20200710233433.19729-1-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=wentong.wu@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 11:46:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, marex@denx.de, crwulff@gmail.com,
 Wentong Wu <wentong.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only when guest code is unmasking interrupts, terminate the excution
of translated code and exit to the main CPU loop to handle previous
pended interrupts because of the interrupts mask by guest code.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 hw/nios2/cpu_pic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 1c1989d5..5ea7e52a 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -54,7 +54,8 @@ static void nios2_pic_cpu_handler(void *opaque, int irq, int level)
 
 void nios2_check_interrupts(CPUNios2State *env)
 {
-    if (env->irq_pending) {
+    if (env->irq_pending &&
+        (env->regs[CR_STATUS] & CR_STATUS_PIE)) {
         env->irq_pending = 0;
         cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HARD);
     }
-- 
2.21.3


