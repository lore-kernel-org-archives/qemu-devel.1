Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4962336F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4962336F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpozT-0004IP-7P
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jpoyk-0003N0-JQ; Mon, 29 Jun 2020 04:17:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:11113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jpoyi-0002TY-7d; Mon, 29 Jun 2020 04:17:26 -0400
IronPort-SDR: deRQyy878sRa2bdMzDADfR2YdETp34vciT7eEpNH/9Ifjj3+J2/Xmkv9r767bf5SVidaseHM+4
 PY6t/9QddSdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145923683"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="145923683"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 01:17:21 -0700
IronPort-SDR: 1Zwyzu/YwPn1MkJ9OCFZdXVksM3QsXLAqo19SoVGH0MMnnfIyAUsruC5b1uOGHTX0hAKUH4iUv
 c6m+KD1m9y7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="480702391"
Received: from unknown (HELO localhost.localdomain.sh.intel.com)
 ([10.239.153.142])
 by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 01:17:19 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/nios2: in line the semantics of DISAS_UPDATE with
 other targets
Date: Mon, 29 Jun 2020 12:05:34 -0400
Message-Id: <20200629160535.3910-2-wentong.wu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629160535.3910-1-wentong.wu@intel.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wentong.wu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 04:17:22
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

In line the semantics of DISAS_UPDATE on nios2 target with other targets
which is to explicitly write the PC back into the cpu state before doing
a tcg_gen_exit_tb().

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 target/nios2/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index b052be85..83c10eb2 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -865,6 +865,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     /* Indicate where the next block should start */
     switch (dc->is_jmp) {
     case DISAS_NEXT:
+    case DISAS_UPDATE:
         /* Save the current PC back into the CPU register */
         tcg_gen_movi_tl(cpu_R[R_PC], dc->pc);
         tcg_gen_exit_tb(NULL, 0);
@@ -872,7 +873,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 
     default:
     case DISAS_JUMP:
-    case DISAS_UPDATE:
         /* The jump will already have updated the PC register */
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.21.3


