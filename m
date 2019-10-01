Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3DECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B709320842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B709320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFK9W-0002jU-Ra
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJtj-0004kC-SR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJte-0001va-HY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59926 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iFJtd-0001sq-MP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 341F41A23AE;
 Tue,  1 Oct 2019 17:15:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.55])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 996181A23B0;
 Tue,  1 Oct 2019 17:15:54 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] target/mips: msa: Split helpers for
 B<CLR|NEG|SEL>.<B|H|W|D>
Date: Tue,  1 Oct 2019 17:15:35 +0200
Message-Id: <1569942944-10381-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Achieves clearer code and slightly better performance.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1569415572-19635-12-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/helper.h     |  18 +++-
 target/mips/msa_helper.c | 227 ++++++++++++++++++++++++++++++++++++++++++-----
 target/mips/translate.c  |  57 ++++++++++--
 3 files changed, 267 insertions(+), 35 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 27544a1..1411e0e 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -807,6 +807,21 @@ DEF_HELPER_4(msa_bmnz_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_bmz_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_bsel_v, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_bclr_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bclr_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bclr_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bclr_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_bneg_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bneg_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bneg_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bneg_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_bset_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bset_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bset_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_bset_d, void, env, i32, i32, i32)
+
 
 DEF_HELPER_4(msa_andi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ori_b, void, env, i32, i32, i32)
@@ -846,9 +861,6 @@ DEF_HELPER_5(msa_srlri_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_sll_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_sra_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srl_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_bclr_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_bset_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_bneg_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsr_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_addv_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 82c8871..5177e41 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -523,7 +523,210 @@ void helper_msa_bsel_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
  * +---------------+----------------------------------------------------------+
  */
 
-/* TODO: insert Bit Set group helpers here */
+static inline int64_t msa_bclr_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    return UNSIGNED(arg1 & (~(1LL << b_arg2)), df);
+}
+
+void helper_msa_bclr_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_bclr_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_bclr_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_bclr_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_bclr_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_bclr_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_bclr_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_bclr_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_bclr_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_bclr_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_bclr_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_bclr_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_bclr_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_bclr_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_bclr_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_bclr_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_bclr_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_bclr_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_bclr_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_bclr_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_bclr_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_bclr_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_bclr_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_bclr_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_bclr_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_bclr_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_bclr_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_bclr_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_bclr_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_bclr_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_bclr_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_bclr_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_bclr_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_bclr_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+static inline int64_t msa_bneg_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    return UNSIGNED(arg1 ^ (1LL << b_arg2), df);
+}
+
+void helper_msa_bneg_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_bneg_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_bneg_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_bneg_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_bneg_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_bneg_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_bneg_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_bneg_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_bneg_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_bneg_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_bneg_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_bneg_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_bneg_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_bneg_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_bneg_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_bneg_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_bneg_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_bneg_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_bneg_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_bneg_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_bneg_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_bneg_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_bneg_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_bneg_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_bneg_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_bneg_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_bneg_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_bneg_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_bneg_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_bneg_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_bneg_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_bneg_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_bneg_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_bneg_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+static inline int64_t msa_bset_df(uint32_t df, int64_t arg1,
+        int64_t arg2)
+{
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    return UNSIGNED(arg1 | (1LL << b_arg2), df);
+}
+
+void helper_msa_bset_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_bset_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_bset_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_bset_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_bset_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_bset_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_bset_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_bset_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_bset_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_bset_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_bset_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_bset_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_bset_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_bset_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_bset_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_bset_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_bset_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_bset_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_bset_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_bset_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_bset_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_bset_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_bset_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_bset_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_bset_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_bset_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_bset_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_bset_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_bset_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_bset_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_bset_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_bset_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_bset_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_bset_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
 
 
 /*
@@ -1220,25 +1423,6 @@ static inline int64_t msa_srl_df(uint32_t df, int64_t arg1, int64_t arg2)
     return u_arg1 >> b_arg2;
 }
 
-static inline int64_t msa_bclr_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    return UNSIGNED(arg1 & (~(1LL << b_arg2)), df);
-}
-
-static inline int64_t msa_bset_df(uint32_t df, int64_t arg1,
-        int64_t arg2)
-{
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    return UNSIGNED(arg1 | (1LL << b_arg2), df);
-}
-
-static inline int64_t msa_bneg_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    return UNSIGNED(arg1 ^ (1LL << b_arg2), df);
-}
-
 static inline int64_t msa_sat_s_df(uint32_t df, int64_t arg, uint32_t m)
 {
     return arg < M_MIN_INT(m + 1) ? M_MIN_INT(m + 1) :
@@ -1734,9 +1918,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
 MSA_BINOP_DF(sll)
 MSA_BINOP_DF(sra)
 MSA_BINOP_DF(srl)
-MSA_BINOP_DF(bclr)
-MSA_BINOP_DF(bset)
-MSA_BINOP_DF(bneg)
 MSA_BINOP_DF(addv)
 MSA_BINOP_DF(subv)
 MSA_BINOP_DF(max_s)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6080c72..1a87f79 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28418,6 +28418,54 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case OPC_BCLR_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_bclr_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_bclr_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_bclr_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_bclr_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_BNEG_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_bneg_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_bneg_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_bneg_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_bneg_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_BSET_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_bset_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_bset_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_bset_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_bset_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
     case OPC_SLL_df:
         gen_helper_msa_sll_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28487,9 +28535,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SRLR_df:
         gen_helper_msa_srlr_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_BCLR_df:
-        gen_helper_msa_bclr_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_MAX_U_df:
         gen_helper_msa_max_u_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28505,9 +28550,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_PCKOD_df:
         gen_helper_msa_pckod_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_BSET_df:
-        gen_helper_msa_bset_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_MIN_S_df:
         gen_helper_msa_min_s_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28526,9 +28568,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_ILVL_df:
         gen_helper_msa_ilvl_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_BNEG_df:
-        gen_helper_msa_bneg_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_MIN_U_df:
         gen_helper_msa_min_u_df(cpu_env, tdf, twd, tws, twt);
         break;
-- 
2.7.4


