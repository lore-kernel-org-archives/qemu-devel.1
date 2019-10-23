Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDCCA9EB7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B2A2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B2A2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEj0-0008C1-Q1
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iNDq2-000132-Vk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iNDpy-00032O-11
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:25:57 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35871 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iNDpv-0002ys-KQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:25:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 222961A1D8C;
 Wed, 23 Oct 2019 12:24:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 153B91A22B4;
 Wed, 23 Oct 2019 12:24:00 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/14] target/mips: msa: Split helpers for
 S<LL|RA|RAR|RL|RLR>.<B|H|W|D>
Date: Wed, 23 Oct 2019 12:23:42 +0200
Message-Id: <1571826227-10583-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571826227-10583-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1571826227-10583-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: aleksandar.rikalo@rt-rk.com, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Achieves clearer code and slightly better performance.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/helper.h     |  30 +++-
 target/mips/msa_helper.c | 424 +++++++++++++++++++++++++++++++++++++++++------
 target/mips/translate.c  |  91 ++++++++--
 3 files changed, 479 insertions(+), 66 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index f25ba90..f779404 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -967,6 +967,31 @@ DEF_HELPER_4(msa_nor_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_or_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_xor_v, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_sll_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_sll_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_sll_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_sll_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_sra_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_sra_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_sra_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_sra_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_srar_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srar_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srar_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srar_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_srl_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srl_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srl_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srl_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_srlr_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srlr_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srlr_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_srlr_d, void, env, i32, i32, i32)
+
 DEF_HELPER_3(msa_move_v, void, env, i32, i32)
 
 DEF_HELPER_4(msa_andi_b, void, env, i32, i32, i32)
@@ -1004,9 +1029,6 @@ DEF_HELPER_5(msa_sat_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srari_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srlri_df, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_5(msa_sll_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_sra_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_srl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsr_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subv_df, void, env, i32, i32, i32, i32)
@@ -1030,8 +1052,6 @@ DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_hsub_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_hsub_u_df, void, env, i32, i32, i32, i32)
 
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index f5d3737..38ff1da 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -3461,7 +3461,382 @@ void helper_msa_move_v(CPUMIPSState *env, uint32_t wd, uint32_t ws)
  * +---------------+----------------------------------------------------------+
  */
 
-/* TODO: insert Shift group helpers here */
+
+static inline int64_t msa_sll_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    return arg1 << b_arg2;
+}
+
+void helper_msa_sll_b(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_sll_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_sll_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_sll_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_sll_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_sll_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_sll_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_sll_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_sll_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_sll_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_sll_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_sll_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_sll_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_sll_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_sll_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_sll_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_sll_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_sll_h(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_sll_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_sll_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_sll_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_sll_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_sll_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_sll_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_sll_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_sll_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_sll_w(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_sll_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_sll_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_sll_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_sll_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_sll_d(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_sll_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_sll_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
+static inline int64_t msa_sra_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    return arg1 >> b_arg2;
+}
+
+void helper_msa_sra_b(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_sra_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_sra_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_sra_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_sra_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_sra_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_sra_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_sra_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_sra_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_sra_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_sra_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_sra_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_sra_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_sra_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_sra_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_sra_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_sra_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_sra_h(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_sra_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_sra_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_sra_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_sra_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_sra_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_sra_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_sra_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_sra_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_sra_w(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_sra_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_sra_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_sra_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_sra_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_sra_d(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_sra_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_sra_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
+static inline int64_t msa_srar_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    if (b_arg2 == 0) {
+        return arg1;
+    } else {
+        int64_t r_bit = (arg1 >> (b_arg2 - 1)) & 1;
+        return (arg1 >> b_arg2) + r_bit;
+    }
+}
+
+void helper_msa_srar_b(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_srar_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_srar_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_srar_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_srar_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_srar_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_srar_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_srar_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_srar_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_srar_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_srar_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_srar_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_srar_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_srar_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_srar_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_srar_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_srar_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_srar_h(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_srar_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_srar_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_srar_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_srar_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_srar_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_srar_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_srar_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_srar_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_srar_w(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_srar_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_srar_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_srar_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_srar_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_srar_d(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_srar_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_srar_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
+static inline int64_t msa_srl_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    uint64_t u_arg1 = UNSIGNED(arg1, df);
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    return u_arg1 >> b_arg2;
+}
+
+void helper_msa_srl_b(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_srl_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_srl_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_srl_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_srl_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_srl_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_srl_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_srl_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_srl_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_srl_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_srl_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_srl_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_srl_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_srl_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_srl_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_srl_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_srl_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_srl_h(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_srl_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_srl_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_srl_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_srl_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_srl_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_srl_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_srl_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_srl_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_srl_w(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_srl_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_srl_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_srl_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_srl_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_srl_d(CPUMIPSState *env,
+                      uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_srl_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_srl_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
+static inline int64_t msa_srlr_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    uint64_t u_arg1 = UNSIGNED(arg1, df);
+    int32_t b_arg2 = BIT_POSITION(arg2, df);
+    if (b_arg2 == 0) {
+        return u_arg1;
+    } else {
+        uint64_t r_bit = (u_arg1 >> (b_arg2 - 1)) & 1;
+        return (u_arg1 >> b_arg2) + r_bit;
+    }
+}
+
+void helper_msa_srlr_b(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_srlr_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_srlr_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_srlr_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_srlr_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_srlr_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_srlr_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_srlr_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_srlr_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_srlr_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_srlr_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_srlr_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_srlr_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_srlr_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_srlr_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_srlr_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_srlr_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_srlr_h(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_srlr_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_srlr_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_srlr_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_srlr_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_srlr_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_srlr_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_srlr_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_srlr_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_srlr_w(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_srlr_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_srlr_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_srlr_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_srlr_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_srlr_d(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_srlr_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_srlr_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
 
 
 #define MSA_FN_IMM8(FUNC, DEST, OPERATION)                              \
@@ -3617,25 +3992,6 @@ void helper_msa_ldi_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     }
 }
 
-static inline int64_t msa_sll_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    return arg1 << b_arg2;
-}
-
-static inline int64_t msa_sra_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    return arg1 >> b_arg2;
-}
-
-static inline int64_t msa_srl_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    uint64_t u_arg1 = UNSIGNED(arg1, df);
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    return u_arg1 >> b_arg2;
-}
-
 static inline int64_t msa_sat_s_df(uint32_t df, int64_t arg, uint32_t m)
 {
     return arg < M_MIN_INT(m + 1) ? M_MIN_INT(m + 1) :
@@ -3650,29 +4006,6 @@ static inline int64_t msa_sat_u_df(uint32_t df, int64_t arg, uint32_t m)
                                         M_MAX_UINT(m + 1);
 }
 
-static inline int64_t msa_srar_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    if (b_arg2 == 0) {
-        return arg1;
-    } else {
-        int64_t r_bit = (arg1 >> (b_arg2 - 1)) & 1;
-        return (arg1 >> b_arg2) + r_bit;
-    }
-}
-
-static inline int64_t msa_srlr_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    uint64_t u_arg1 = UNSIGNED(arg1, df);
-    int32_t b_arg2 = BIT_POSITION(arg2, df);
-    if (b_arg2 == 0) {
-        return u_arg1;
-    } else {
-        uint64_t r_bit = (u_arg1 >> (b_arg2 - 1)) & 1;
-        return (u_arg1 >> b_arg2) + r_bit;
-    }
-}
-
 #define MSA_BINOP_IMMU_DF(helper, func)                                  \
 void helper_msa_ ## helper ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd, \
                        uint32_t ws, uint32_t u5)                        \
@@ -3995,9 +4328,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
     }                                                                   \
 }
 
-MSA_BINOP_DF(sll)
-MSA_BINOP_DF(sra)
-MSA_BINOP_DF(srl)
 MSA_BINOP_DF(subv)
 MSA_BINOP_DF(subs_s)
 MSA_BINOP_DF(subs_u)
@@ -4008,8 +4338,6 @@ MSA_BINOP_DF(asub_u)
 MSA_BINOP_DF(mulv)
 MSA_BINOP_DF(dotp_s)
 MSA_BINOP_DF(dotp_u)
-MSA_BINOP_DF(srar)
-MSA_BINOP_DF(srlr)
 MSA_BINOP_DF(hsub_s)
 MSA_BINOP_DF(hsub_u)
 
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9e8e973..7cdf68d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28915,7 +28915,84 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_SLL_df:
-        gen_helper_msa_sll_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_sll_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_sll_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_sll_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_sll_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_SRA_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_sra_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_sra_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_sra_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_sra_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_SRAR_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_srar_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_srar_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_srar_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_srar_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_SRL_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_srl_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_srl_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_srl_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_srl_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_SRLR_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_srlr_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_srlr_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_srlr_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_srlr_d(cpu_env, twd, tws, twt);
+            break;
+        }
         break;
     case OPC_SUBS_S_df:
         gen_helper_msa_subs_s_df(cpu_env, tdf, twd, tws, twt);
@@ -28929,9 +29006,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_VSHF_df:
         gen_helper_msa_vshf_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_SRA_df:
-        gen_helper_msa_sra_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_SUBV_df:
         gen_helper_msa_subv_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28944,12 +29018,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SPLAT_df:
         gen_helper_msa_splat_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_SRAR_df:
-        gen_helper_msa_srar_df(cpu_env, tdf, twd, tws, twt);
-        break;
-    case OPC_SRL_df:
-        gen_helper_msa_srl_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_SUBSUS_U_df:
         gen_helper_msa_subsus_u_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28959,9 +29027,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_PCKEV_df:
         gen_helper_msa_pckev_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_SRLR_df:
-        gen_helper_msa_srlr_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_SUBSUU_S_df:
         gen_helper_msa_subsuu_s_df(cpu_env, tdf, twd, tws, twt);
         break;
-- 
2.7.4


