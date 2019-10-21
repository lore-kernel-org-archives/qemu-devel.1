Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9AE2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9AE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMd9a-0003yN-Or
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 15:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iMd73-0001VK-PF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iMd71-0004IN-3t
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:13:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54035 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iMd70-0004H8-Nf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:13:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 697571A2176;
 Mon, 21 Oct 2019 21:11:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774.domain.local [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1B9C01A2193;
 Mon, 21 Oct 2019 21:11:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/12] target/mips: msa: Split helpers for
 ASUB_<S|U>.<B|H|W|D>
Date: Mon, 21 Oct 2019 21:11:37 +0200
Message-Id: <1571685097-15175-13-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571685097-15175-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1571685097-15175-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/helper.h     |  12 +++-
 target/mips/msa_helper.c | 169 ++++++++++++++++++++++++++++++++++++++++++-----
 target/mips/translate.c  |  38 +++++++++--
 3 files changed, 193 insertions(+), 26 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index d7c4bbf..7b8ad74 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -945,6 +945,16 @@ DEF_HELPER_4(msa_mod_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_mod_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_mod_s_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_asub_s_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_asub_s_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_asub_s_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_asub_s_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(msa_asub_u_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_asub_u_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_asub_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_asub_u_d, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_hsub_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_hsub_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_hsub_s_d, void, env, i32, i32, i32)
@@ -1053,8 +1063,6 @@ DEF_HELPER_5(msa_subs_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subs_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsus_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsuu_s_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_asub_s_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_asub_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_maddv_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_msubv_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index ae9e8e0..0e39016 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2888,6 +2888,157 @@ void helper_msa_mod_u_d(CPUMIPSState *env,
  * +---------------+----------------------------------------------------------+
  */
 
+
+static inline int64_t msa_asub_s_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    /* signed compare */
+    return (arg1 < arg2) ?
+        (uint64_t)(arg2 - arg1) : (uint64_t)(arg1 - arg2);
+}
+
+void helper_msa_asub_s_b(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_asub_s_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_asub_s_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_asub_s_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_asub_s_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_asub_s_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_asub_s_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_asub_s_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_asub_s_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_asub_s_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_asub_s_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_asub_s_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_asub_s_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_asub_s_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_asub_s_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_asub_s_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_asub_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_asub_s_h(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_asub_s_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_asub_s_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_asub_s_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_asub_s_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_asub_s_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_asub_s_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_asub_s_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_asub_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_asub_s_w(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_asub_s_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_asub_s_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_asub_s_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_asub_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_asub_s_d(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_asub_s_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_asub_s_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
+static inline uint64_t msa_asub_u_df(uint32_t df, uint64_t arg1, uint64_t arg2)
+{
+    uint64_t u_arg1 = UNSIGNED(arg1, df);
+    uint64_t u_arg2 = UNSIGNED(arg2, df);
+    /* unsigned compare */
+    return (u_arg1 < u_arg2) ?
+        (uint64_t)(u_arg2 - u_arg1) : (uint64_t)(u_arg1 - u_arg2);
+}
+
+void helper_msa_asub_u_b(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_asub_u_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_asub_u_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_asub_u_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_asub_u_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_asub_u_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_asub_u_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_asub_u_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_asub_u_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_asub_u_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_asub_u_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_asub_u_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_asub_u_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_asub_u_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_asub_u_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_asub_u_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_asub_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_asub_u_h(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_asub_u_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_asub_u_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_asub_u_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_asub_u_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_asub_u_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_asub_u_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_asub_u_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_asub_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_asub_u_w(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_asub_u_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_asub_u_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_asub_u_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_asub_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_asub_u_d(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_asub_u_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_asub_u_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
 /* TODO: insert the rest of Int Subtract group helpers here */
 
 
@@ -4447,22 +4598,6 @@ static inline int64_t msa_subsuu_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-static inline int64_t msa_asub_s_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    /* signed compare */
-    return (arg1 < arg2) ?
-        (uint64_t)(arg2 - arg1) : (uint64_t)(arg1 - arg2);
-}
-
-static inline uint64_t msa_asub_u_df(uint32_t df, uint64_t arg1, uint64_t arg2)
-{
-    uint64_t u_arg1 = UNSIGNED(arg1, df);
-    uint64_t u_arg2 = UNSIGNED(arg2, df);
-    /* unsigned compare */
-    return (u_arg1 < u_arg2) ?
-        (uint64_t)(u_arg2 - u_arg1) : (uint64_t)(u_arg1 - u_arg2);
-}
-
 static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     return arg1 * arg2;
@@ -4624,8 +4759,6 @@ MSA_BINOP_DF(subs_s)
 MSA_BINOP_DF(subs_u)
 MSA_BINOP_DF(subsus_u)
 MSA_BINOP_DF(subsuu_s)
-MSA_BINOP_DF(asub_s)
-MSA_BINOP_DF(asub_u)
 MSA_BINOP_DF(mulv)
 MSA_BINOP_DF(dotp_s)
 MSA_BINOP_DF(dotp_u)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4c68c5b..20c69d2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28850,6 +28850,38 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case OPC_ASUB_S_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_asub_s_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_asub_s_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_asub_s_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_asub_s_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_ASUB_U_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_asub_u_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_asub_u_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_asub_u_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_asub_u_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
     case OPC_ILVEV_df:
         switch (df) {
         case DF_BYTE:
@@ -29059,12 +29091,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SUBSUU_S_df:
         gen_helper_msa_subsuu_s_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_ASUB_S_df:
-        gen_helper_msa_asub_s_df(cpu_env, tdf, twd, tws, twt);
-        break;
-    case OPC_ASUB_U_df:
-        gen_helper_msa_asub_u_df(cpu_env, tdf, twd, tws, twt);
-        break;
 
     case OPC_DOTP_S_df:
     case OPC_DOTP_U_df:
-- 
2.7.4


