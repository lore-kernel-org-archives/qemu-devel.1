Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F65C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1FE214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1FE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClhP-00079F-Dc
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iCkrN-0007zE-SY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iCkrJ-0001Eo-Vx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46889 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iCkrG-0001BW-UK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id F1E2B1A1D45;
 Tue, 24 Sep 2019 15:26:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BF4DC1A2290;
 Tue, 24 Sep 2019 15:26:48 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] target/mips: msa: Unroll loops and demacro
 <BMNZ|BMZ|BSEL>.V
Date: Tue, 24 Sep 2019 15:26:41 +0200
Message-Id: <1569331602-2586-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569331602-2586-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1569331602-2586-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Achieves clearer code and slightly better performance.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/helper.h     |  7 +++---
 target/mips/msa_helper.c | 63 ++++++++++++++++++++++++++++++------------------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 9349482..27544a1 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -803,6 +803,10 @@ DEF_HELPER_4(msa_binsr_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_binsr_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_binsr_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_bmnz_v, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bmz_v, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bsel_v, void, env, i32, i32, i32)
+
 
 DEF_HELPER_4(msa_andi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ori_b, void, env, i32, i32, i32)
@@ -957,9 +961,6 @@ DEF_HELPER_4(msa_and_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_or_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_nor_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_xor_v, void, env, i32, i32, i32)
-DEF_HELPER_4(msa_bmnz_v, void, env, i32, i32, i32)
-DEF_HELPER_4(msa_bmz_v, void, env, i32, i32, i32)
-DEF_HELPER_4(msa_bsel_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_fill_df, void, env, i32, i32, i32)
 
 DEF_HELPER_4(msa_copy_s_b, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 7c9da99..eda675a 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -466,6 +466,42 @@ void helper_msa_binsr_d(CPUMIPSState *env,
     pwd->d[1]  = msa_binsr_df(DF_DOUBLE, pwd->d[0],  pws->d[0], pwt->d[1]);
 }
 
+void helper_msa_bmnz_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = UNSIGNED(                                                     \
+        ((pwd->d[0] & (~pwt->d[0])) | (pws->d[0] & pwt->d[0])), DF_DOUBLE);
+    pwd->d[1] = UNSIGNED(                                                     \
+        ((pwd->d[1] & (~pwt->d[1])) | (pws->d[1] & pwt->d[1])), DF_DOUBLE);
+}
+
+void helper_msa_bmz_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = UNSIGNED(                                                     \
+        ((pwd->d[0] & pwt->d[0]) | (pws->d[0] & (~pwt->d[0]))), DF_DOUBLE);
+    pwd->d[1] = UNSIGNED(                                                     \
+        ((pwd->d[1] & pwt->d[1]) | (pws->d[1] & (~pwt->d[1]))), DF_DOUBLE);
+}
+
+void helper_msa_bsel_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = UNSIGNED(                                                     \
+        (pws->d[0] & (~pwd->d[0])) | (pwt->d[0] & pwd->d[0]), DF_DOUBLE);
+    pwd->d[1] = UNSIGNED(                                                     \
+        (pws->d[1] & (~pwd->d[1])) | (pwt->d[1] & pwd->d[1]), DF_DOUBLE);
+}
+
 
 /*
  * Bit Set
@@ -946,6 +982,9 @@ MSA_FN_IMM8(bmzi_b, pwd->b[i],
 MSA_FN_IMM8(bseli_b, pwd->b[i],
         BIT_SELECT(pwd->b[i], pws->b[i], i8, DF_BYTE))
 
+#undef BIT_SELECT
+#undef BIT_MOVE_IF_ZERO
+#undef BIT_MOVE_IF_NOT_ZERO
 #undef MSA_FN_IMM8
 
 #define SHF_POS(i, imm) (((i) & 0xfc) + (((imm) >> (2 * ((i) & 0x03))) & 0x03))
@@ -980,30 +1019,6 @@ void helper_msa_shf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-#define MSA_FN_VECTOR(FUNC, DEST, OPERATION)                            \
-void helper_msa_ ## FUNC(CPUMIPSState *env, uint32_t wd, uint32_t ws,   \
-        uint32_t wt)                                                    \
-{                                                                       \
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);                          \
-    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);                          \
-    uint32_t i;                                                         \
-    for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {                      \
-        DEST = OPERATION;                                               \
-    }                                                                   \
-}
-
-MSA_FN_VECTOR(bmnz_v, pwd->d[i],
-        BIT_MOVE_IF_NOT_ZERO(pwd->d[i], pws->d[i], pwt->d[i], DF_DOUBLE))
-MSA_FN_VECTOR(bmz_v, pwd->d[i],
-        BIT_MOVE_IF_ZERO(pwd->d[i], pws->d[i], pwt->d[i], DF_DOUBLE))
-MSA_FN_VECTOR(bsel_v, pwd->d[i],
-        BIT_SELECT(pwd->d[i], pws->d[i], pwt->d[i], DF_DOUBLE))
-#undef BIT_MOVE_IF_NOT_ZERO
-#undef BIT_MOVE_IF_ZERO
-#undef BIT_SELECT
-#undef MSA_FN_VECTOR
-
 void helper_msa_and_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-- 
2.7.4


