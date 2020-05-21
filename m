Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E357C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D769A207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D769A207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbihw-0008Gv-3M
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbih2-0006tZ-QN; Thu, 21 May 2020 06:44:53 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbih0-0006Or-NC; Thu, 21 May 2020 06:44:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06439554|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_alarm|0.0191878-0.000189457-0.980623; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03267; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.HbdT-lO_1590057884; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HbdT-lO_1590057884)
 by smtp.aliyun-inc.com(10.147.40.200);
 Thu, 21 May 2020 18:44:45 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v8 30/62] target/riscv: Update fp_status when float rounding
 mode changes
Date: Thu, 21 May 2020 17:43:41 +0800
Message-Id: <20200521094413.10425-31-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 05:19:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For scalar float instruction, round mode is encoded in instruction,
so fp_status is updating dynamiclly.

For vector float instruction, round mode is always frm, so
update fp_status when frm changes is enough.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/csr.c        |  7 +++++++
 target/riscv/fpu_helper.c | 19 ++++++++++++++-----
 target/riscv/internals.h  |  3 +++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d71c49dfff..438093152b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
+#include "internals.h"
 
 /* CSR function table */
 static riscv_csr_operations csr_ops[];
@@ -174,6 +175,9 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
     env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
+    if (!riscv_cpu_set_rounding_mode(env, env->frm)) {
+        return -1;
+    }
     return 0;
 }
 
@@ -207,6 +211,9 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
         env->vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
     }
     riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
+    if (!riscv_cpu_set_rounding_mode(env, env->frm)) {
+        return -1;
+    }
     return 0;
 }
 
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 0b79562a69..262610e837 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -50,13 +50,10 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
     set_float_exception_flags(soft, &env->fp_status);
 }
 
-void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
+bool riscv_cpu_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     int softrm;
 
-    if (rm == 7) {
-        rm = env->frm;
-    }
     switch (rm) {
     case 0:
         softrm = float_round_nearest_even;
@@ -74,10 +71,22 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
         softrm = float_round_ties_away;
         break;
     default:
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return false;
     }
 
     set_float_rounding_mode(softrm, &env->fp_status);
+    return true;
+}
+
+void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
+{
+    if (rm == 7) {
+        rm = env->frm;
+    }
+
+    if (!riscv_cpu_set_rounding_mode(env, rm)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
 }
 
 uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f699d80c41..52f6af2513 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -27,4 +27,7 @@ FIELD(VDATA, VM, 8, 1)
 FIELD(VDATA, LMUL, 9, 2)
 FIELD(VDATA, NF, 11, 4)
 FIELD(VDATA, WD, 11, 1)
+
+/* set float rounding mode */
+bool riscv_cpu_set_rounding_mode(CPURISCVState *env, uint32_t rm);
 #endif
-- 
2.23.0


