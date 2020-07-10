Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DE120725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DE120725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvG8-00074j-Ve
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtvEH-0005HC-Kq; Fri, 10 Jul 2020 11:46:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:55304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtvEF-0008Ol-3u; Fri, 10 Jul 2020 11:46:25 -0400
IronPort-SDR: hYf2wDwxyQpMFXtr/4W3h4rdVafDz+IwuD1sNbFN0LTIDS9lWUCe62j7ngyfLiU+837vhg1Ehw
 b0/cmD9CYLgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="136427517"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="136427517"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2020 08:46:19 -0700
IronPort-SDR: gHwNG1r9OK42eLBQcVH6hasSGyfPMRx8u8NWkWsfVX3/MBdEEHguCNCzG3IB4/Yi8C4yAUeBTa
 Fd/SyE00rqqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="484686336"
Received: from unknown (HELO localhost.localdomain.sh.intel.com)
 ([10.239.153.142])
 by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:46:18 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 2/4] target/nios2: in line the semantics of DISAS_UPDATE
 with other targets
Date: Fri, 10 Jul 2020 19:34:31 -0400
Message-Id: <20200710233433.19729-2-wentong.wu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200710233433.19729-1-wentong.wu@intel.com>
References: <20200710233433.19729-1-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=wentong.wu@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 11:46:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


