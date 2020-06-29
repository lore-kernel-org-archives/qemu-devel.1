Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D6CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D61023370
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D61023370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpp0h-00069K-9L
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jpoyp-0003Ww-QJ; Mon, 29 Jun 2020 04:17:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:7699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jpoyn-0002U0-4e; Mon, 29 Jun 2020 04:17:31 -0400
IronPort-SDR: f1l+pRlsHmkxIL22Oi6fNdEOGAJSm1WtEJgrdHTW+1MMtri0sHrFMO+zGofKWaSnz6pYInfWYd
 VoACTE78YXgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144988286"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="144988286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 01:17:25 -0700
IronPort-SDR: XExOUvL2zfVNb/PL1BDUwtCQidazV9W6bUlYVtE6LvUG4/m0/mvoOekT7WBz7D8sBeulSN9QV3
 CAPJe+y/sJSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="480702409"
Received: from unknown (HELO localhost.localdomain.sh.intel.com)
 ([10.239.153.142])
 by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 01:17:25 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl instruction
Date: Mon, 29 Jun 2020 12:05:35 -0400
Message-Id: <20200629160535.3910-3-wentong.wu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629160535.3910-1-wentong.wu@intel.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=wentong.wu@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 04:17:27
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Wentong Wu <wentong.wu@intel.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

wrctl instruction on nios2 target will cause checking cpu
interrupt but tcg_handle_interrupt() will call cpu_abort()
if the CPU gets an interrupt while it's not in 'can do IO'
state, so add gen_io_start around wrctl instruction. Also
at the same time, end the onging TB with DISAS_UPDATE.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 target/nios2/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 83c10eb2..51347ada 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -32,6 +32,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
+#include "exec/gen-icount.h"
 
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
@@ -518,7 +519,11 @@ static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
     /* If interrupts were enabled using WRCTL, trigger them. */
 #if !defined(CONFIG_USER_ONLY)
     if ((instr.imm5 + CR_BASE) == CR_STATUS) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_helper_check_interrupts(dc->cpu_env);
+        dc->is_jmp = DISAS_UPDATE;
     }
 #endif
 }
-- 
2.21.3


