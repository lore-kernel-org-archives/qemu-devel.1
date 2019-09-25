Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09657C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11AC20640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11AC20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD78A-0003rN-OB
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iD6gr-0001U7-B8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iD6go-0002Li-Mm
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56136 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iD6go-0002GJ-Bc
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2CADE1A23BC;
 Wed, 25 Sep 2019 14:46:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E2BCD1A23BF;
 Wed, 25 Sep 2019 14:46:21 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/20] target/mips: msa: Split helpers for
 CLE_<S|U>.<B|H|W|D>
Date: Wed, 25 Sep 2019 14:46:07 +0200
Message-Id: <1569415572-19635-16-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Achieves clearer code and slightly better performance.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/helper.h     |  12 +++-
 target/mips/msa_helper.c | 150 ++++++++++++++++++++++++++++++++++++++++++-----
 target/mips/translate.c  |  38 ++++++++++--
 3 files changed, 178 insertions(+), 22 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 95eb065..32ff24b 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -847,6 +847,16 @@ DEF_HELPER_4(msa_ceq_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ceq_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ceq_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_cle_s_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_cle_s_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_cle_s_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_cle_s_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_cle_u_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_cle_u_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_cle_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_cle_u_d, void, env, i32, i32, i32)
+
 
 DEF_HELPER_4(msa_andi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ori_b, void, env, i32, i32, i32)
@@ -898,8 +908,6 @@ DEF_HELPER_5(msa_max_a_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_min_a_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_clt_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_clt_u_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_cle_s_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_cle_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_add_a_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_adds_a_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_adds_s_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 65d9c9b..c4bff76 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1204,6 +1204,142 @@ void helper_msa_ceq_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->d[1]  = msa_ceq_df(DF_DOUBLE, pws->d[0],  pwt->d[1]);
 }
 
+static inline int64_t msa_cle_s_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    return arg1 <= arg2 ? -1 : 0;
+}
+
+void helper_msa_cle_s_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[1]);
+    pwd->b[2]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[2]);
+    pwd->b[3]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[3]);
+    pwd->b[4]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[4]);
+    pwd->b[5]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[5]);
+    pwd->b[6]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[6]);
+    pwd->b[7]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[7]);
+    pwd->b[8]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[8]);
+    pwd->b[9]  = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[9]);
+    pwd->b[10] = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[10]);
+    pwd->b[11] = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[11]);
+    pwd->b[12] = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[12]);
+    pwd->b[13] = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[13]);
+    pwd->b[14] = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[14]);
+    pwd->b[15] = msa_cle_s_df(DF_BYTE, pws->b[0],  pwt->b[15]);
+}
+
+void helper_msa_cle_s_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[1]);
+    pwd->h[2]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[2]);
+    pwd->h[3]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[3]);
+    pwd->h[4]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[4]);
+    pwd->h[5]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[5]);
+    pwd->h[6]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[6]);
+    pwd->h[7]  = msa_cle_s_df(DF_HALF, pws->h[0],  pwt->h[7]);
+}
+
+void helper_msa_cle_s_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_cle_s_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_cle_s_df(DF_WORD, pws->w[0],  pwt->w[1]);
+    pwd->w[2]  = msa_cle_s_df(DF_WORD, pws->w[0],  pwt->w[2]);
+    pwd->w[3]  = msa_cle_s_df(DF_WORD, pws->w[0],  pwt->w[3]);
+}
+
+void helper_msa_cle_s_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_cle_s_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_cle_s_df(DF_DOUBLE, pws->d[0],  pwt->d[1]);
+}
+
+static inline int64_t msa_cle_u_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    uint64_t u_arg1 = UNSIGNED(arg1, df);
+    uint64_t u_arg2 = UNSIGNED(arg2, df);
+    return u_arg1 <= u_arg2 ? -1 : 0;
+}
+
+void helper_msa_cle_u_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[1]);
+    pwd->b[2]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[2]);
+    pwd->b[3]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[3]);
+    pwd->b[4]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[4]);
+    pwd->b[5]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[5]);
+    pwd->b[6]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[6]);
+    pwd->b[7]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[7]);
+    pwd->b[8]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[8]);
+    pwd->b[9]  = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[9]);
+    pwd->b[10] = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[10]);
+    pwd->b[11] = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[11]);
+    pwd->b[12] = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[12]);
+    pwd->b[13] = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[13]);
+    pwd->b[14] = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[14]);
+    pwd->b[15] = msa_cle_u_df(DF_BYTE, pws->b[0],  pwt->b[15]);
+}
+
+void helper_msa_cle_u_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[1]);
+    pwd->h[2]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[2]);
+    pwd->h[3]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[3]);
+    pwd->h[4]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[4]);
+    pwd->h[5]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[5]);
+    pwd->h[6]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[6]);
+    pwd->h[7]  = msa_cle_u_df(DF_HALF, pws->h[0],  pwt->h[7]);
+}
+
+void helper_msa_cle_u_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_cle_u_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_cle_u_df(DF_WORD, pws->w[0],  pwt->w[1]);
+    pwd->w[2]  = msa_cle_u_df(DF_WORD, pws->w[0],  pwt->w[2]);
+    pwd->w[3]  = msa_cle_u_df(DF_WORD, pws->w[0],  pwt->w[3]);
+}
+
+void helper_msa_cle_u_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_cle_u_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_cle_u_df(DF_DOUBLE, pws->d[0],  pwt->d[1]);
+}
+
 
 /*
  * Int Divide
@@ -1611,18 +1747,6 @@ static inline int64_t msa_subv_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 - arg2;
 }
 
-static inline int64_t msa_cle_s_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    return arg1 <= arg2 ? -1 : 0;
-}
-
-static inline int64_t msa_cle_u_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    uint64_t u_arg1 = UNSIGNED(arg1, df);
-    uint64_t u_arg2 = UNSIGNED(arg2, df);
-    return u_arg1 <= u_arg2 ? -1 : 0;
-}
-
 static inline int64_t msa_clt_s_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     return arg1 < arg2 ? -1 : 0;
@@ -2234,8 +2358,6 @@ MSA_BINOP_DF(max_a)
 MSA_BINOP_DF(min_a)
 MSA_BINOP_DF(clt_s)
 MSA_BINOP_DF(clt_u)
-MSA_BINOP_DF(cle_s)
-MSA_BINOP_DF(cle_u)
 MSA_BINOP_DF(add_a)
 MSA_BINOP_DF(adds_a)
 MSA_BINOP_DF(adds_s)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ad1572e..614b9e7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28546,6 +28546,38 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case OPC_CLE_S_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_cle_s_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_cle_s_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_cle_s_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_cle_s_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_CLE_U_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_cle_u_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_cle_u_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_cle_u_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_cle_u_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
     case OPC_SLL_df:
         gen_helper_msa_sll_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28630,9 +28662,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MIN_S_df:
         gen_helper_msa_min_s_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_CLE_S_df:
-        gen_helper_msa_cle_s_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_ASUB_S_df:
         gen_helper_msa_asub_s_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28645,9 +28674,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MIN_U_df:
         gen_helper_msa_min_u_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_CLE_U_df:
-        gen_helper_msa_cle_u_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_ASUB_U_df:
         gen_helper_msa_asub_u_df(cpu_env, tdf, twd, tws, twt);
         break;
-- 
2.7.4


