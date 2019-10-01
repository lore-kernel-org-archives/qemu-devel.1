Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C75BECE58A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66ECB2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ECB2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43387 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFK1C-00032f-4i
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJtg-0004h6-O6
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJte-0001uO-0K
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59920 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iFJtd-0001si-Jh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id EDBF11A23BC;
 Tue,  1 Oct 2019 17:15:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.55])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 83D6A1A239D;
 Tue,  1 Oct 2019 17:15:54 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] target/mips: msa: Split helpers for PCNT.<B|H|W|D>
Date: Tue,  1 Oct 2019 17:15:32 +0200
Message-Id: <1569942944-10381-7-git-send-email-aleksandar.markovic@rt-rk.com>
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
Message-Id: <1569415572-19635-9-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/helper.h     |   6 +-
 target/mips/msa_helper.c | 143 ++++++++++++++++++++++++-----------------------
 target/mips/translate.c  |  19 ++++++-
 3 files changed, 95 insertions(+), 73 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index d709083..18e4c7a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -788,6 +788,11 @@ DEF_HELPER_3(msa_nlzc_h, void, env, i32, i32)
 DEF_HELPER_3(msa_nlzc_w, void, env, i32, i32)
 DEF_HELPER_3(msa_nlzc_d, void, env, i32, i32)
 
+DEF_HELPER_3(msa_pcnt_b, void, env, i32, i32)
+DEF_HELPER_3(msa_pcnt_h, void, env, i32, i32)
+DEF_HELPER_3(msa_pcnt_w, void, env, i32, i32)
+DEF_HELPER_3(msa_pcnt_d, void, env, i32, i32)
+
 
 DEF_HELPER_4(msa_andi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ori_b, void, env, i32, i32, i32)
@@ -946,7 +951,6 @@ DEF_HELPER_4(msa_bmnz_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_bmz_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_bsel_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_fill_df, void, env, i32, i32, i32)
-DEF_HELPER_4(msa_pcnt_df, void, env, i32, i32, i32)
 
 DEF_HELPER_4(msa_copy_s_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_s_h, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 8c27c1b..fe27efc 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -207,6 +207,80 @@ void helper_msa_nlzc_d(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->d[1]  = msa_nlzc_df(DF_DOUBLE, pws->d[1]);
 }
 
+static inline int64_t msa_pcnt_df(uint32_t df, int64_t arg)
+{
+    uint64_t x;
+
+    x = UNSIGNED(arg, df);
+
+    x = (x & 0x5555555555555555ULL) + ((x >>  1) & 0x5555555555555555ULL);
+    x = (x & 0x3333333333333333ULL) + ((x >>  2) & 0x3333333333333333ULL);
+    x = (x & 0x0F0F0F0F0F0F0F0FULL) + ((x >>  4) & 0x0F0F0F0F0F0F0F0FULL);
+    x = (x & 0x00FF00FF00FF00FFULL) + ((x >>  8) & 0x00FF00FF00FF00FFULL);
+    x = (x & 0x0000FFFF0000FFFFULL) + ((x >> 16) & 0x0000FFFF0000FFFFULL);
+    x = (x & 0x00000000FFFFFFFFULL) + ((x >> 32));
+
+    return x;
+}
+
+void helper_msa_pcnt_b(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+
+    pwd->b[0]  = msa_pcnt_df(DF_BYTE, pws->b[0]);
+    pwd->b[1]  = msa_pcnt_df(DF_BYTE, pws->b[1]);
+    pwd->b[2]  = msa_pcnt_df(DF_BYTE, pws->b[2]);
+    pwd->b[3]  = msa_pcnt_df(DF_BYTE, pws->b[3]);
+    pwd->b[4]  = msa_pcnt_df(DF_BYTE, pws->b[4]);
+    pwd->b[5]  = msa_pcnt_df(DF_BYTE, pws->b[5]);
+    pwd->b[6]  = msa_pcnt_df(DF_BYTE, pws->b[6]);
+    pwd->b[7]  = msa_pcnt_df(DF_BYTE, pws->b[7]);
+    pwd->b[8]  = msa_pcnt_df(DF_BYTE, pws->b[8]);
+    pwd->b[9]  = msa_pcnt_df(DF_BYTE, pws->b[9]);
+    pwd->b[10] = msa_pcnt_df(DF_BYTE, pws->b[10]);
+    pwd->b[11] = msa_pcnt_df(DF_BYTE, pws->b[11]);
+    pwd->b[12] = msa_pcnt_df(DF_BYTE, pws->b[12]);
+    pwd->b[13] = msa_pcnt_df(DF_BYTE, pws->b[13]);
+    pwd->b[14] = msa_pcnt_df(DF_BYTE, pws->b[14]);
+    pwd->b[15] = msa_pcnt_df(DF_BYTE, pws->b[15]);
+}
+
+void helper_msa_pcnt_h(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+
+    pwd->h[0]  = msa_pcnt_df(DF_HALF, pws->h[0]);
+    pwd->h[1]  = msa_pcnt_df(DF_HALF, pws->h[1]);
+    pwd->h[2]  = msa_pcnt_df(DF_HALF, pws->h[2]);
+    pwd->h[3]  = msa_pcnt_df(DF_HALF, pws->h[3]);
+    pwd->h[4]  = msa_pcnt_df(DF_HALF, pws->h[4]);
+    pwd->h[5]  = msa_pcnt_df(DF_HALF, pws->h[5]);
+    pwd->h[6]  = msa_pcnt_df(DF_HALF, pws->h[6]);
+    pwd->h[7]  = msa_pcnt_df(DF_HALF, pws->h[7]);
+}
+
+void helper_msa_pcnt_w(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+
+    pwd->w[0]  = msa_pcnt_df(DF_WORD, pws->w[0]);
+    pwd->w[1]  = msa_pcnt_df(DF_WORD, pws->w[1]);
+    pwd->w[2]  = msa_pcnt_df(DF_WORD, pws->w[2]);
+    pwd->w[3]  = msa_pcnt_df(DF_WORD, pws->w[3]);
+}
+
+void helper_msa_pcnt_d(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+
+    pwd->d[0]  = msa_pcnt_df(DF_DOUBLE, pws->d[0]);
+    pwd->d[1]  = msa_pcnt_df(DF_DOUBLE, pws->d[1]);
+}
+
 
 /*
  * Bit Move
@@ -2648,22 +2722,6 @@ void helper_msa_move_v(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     msa_move_v(pwd, pws);
 }
 
-static inline int64_t msa_pcnt_df(uint32_t df, int64_t arg)
-{
-    uint64_t x;
-
-    x = UNSIGNED(arg, df);
-
-    x = (x & 0x5555555555555555ULL) + ((x >>  1) & 0x5555555555555555ULL);
-    x = (x & 0x3333333333333333ULL) + ((x >>  2) & 0x3333333333333333ULL);
-    x = (x & 0x0F0F0F0F0F0F0F0FULL) + ((x >>  4) & 0x0F0F0F0F0F0F0F0FULL);
-    x = (x & 0x00FF00FF00FF00FFULL) + ((x >>  8) & 0x00FF00FF00FF00FFULL);
-    x = (x & 0x0000FFFF0000FFFFULL) + ((x >> 16) & 0x0000FFFF0000FFFFULL);
-    x = (x & 0x00000000FFFFFFFFULL) + ((x >> 32));
-
-    return x;
-}
-
 void helper_msa_fill_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t rs)
 {
@@ -2696,59 +2754,6 @@ void helper_msa_fill_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     }
 }
 
-#define MSA_UNOP_DF(func) \
-void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
-                              uint32_t wd, uint32_t ws)                 \
-{                                                                       \
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);                          \
-                                                                        \
-    switch (df) {                                                       \
-    case DF_BYTE:                                                       \
-        pwd->b[0]  = msa_ ## func ## _df(df, pws->b[0]);                \
-        pwd->b[1]  = msa_ ## func ## _df(df, pws->b[1]);                \
-        pwd->b[2]  = msa_ ## func ## _df(df, pws->b[2]);                \
-        pwd->b[3]  = msa_ ## func ## _df(df, pws->b[3]);                \
-        pwd->b[4]  = msa_ ## func ## _df(df, pws->b[4]);                \
-        pwd->b[5]  = msa_ ## func ## _df(df, pws->b[5]);                \
-        pwd->b[6]  = msa_ ## func ## _df(df, pws->b[6]);                \
-        pwd->b[7]  = msa_ ## func ## _df(df, pws->b[7]);                \
-        pwd->b[8]  = msa_ ## func ## _df(df, pws->b[8]);                \
-        pwd->b[9]  = msa_ ## func ## _df(df, pws->b[9]);                \
-        pwd->b[10] = msa_ ## func ## _df(df, pws->b[10]);               \
-        pwd->b[11] = msa_ ## func ## _df(df, pws->b[11]);               \
-        pwd->b[12] = msa_ ## func ## _df(df, pws->b[12]);               \
-        pwd->b[13] = msa_ ## func ## _df(df, pws->b[13]);               \
-        pwd->b[14] = msa_ ## func ## _df(df, pws->b[14]);               \
-        pwd->b[15] = msa_ ## func ## _df(df, pws->b[15]);               \
-        break;                                                          \
-    case DF_HALF:                                                       \
-        pwd->h[0] = msa_ ## func ## _df(df, pws->h[0]);                 \
-        pwd->h[1] = msa_ ## func ## _df(df, pws->h[1]);                 \
-        pwd->h[2] = msa_ ## func ## _df(df, pws->h[2]);                 \
-        pwd->h[3] = msa_ ## func ## _df(df, pws->h[3]);                 \
-        pwd->h[4] = msa_ ## func ## _df(df, pws->h[4]);                 \
-        pwd->h[5] = msa_ ## func ## _df(df, pws->h[5]);                 \
-        pwd->h[6] = msa_ ## func ## _df(df, pws->h[6]);                 \
-        pwd->h[7] = msa_ ## func ## _df(df, pws->h[7]);                 \
-        break;                                                          \
-    case DF_WORD:                                                       \
-        pwd->w[0] = msa_ ## func ## _df(df, pws->w[0]);                 \
-        pwd->w[1] = msa_ ## func ## _df(df, pws->w[1]);                 \
-        pwd->w[2] = msa_ ## func ## _df(df, pws->w[2]);                 \
-        pwd->w[3] = msa_ ## func ## _df(df, pws->w[3]);                 \
-        break;                                                          \
-    case DF_DOUBLE:                                                     \
-        pwd->d[0] = msa_ ## func ## _df(df, pws->d[0]);                 \
-        pwd->d[1] = msa_ ## func ## _df(df, pws->d[1]);                 \
-        break;                                                          \
-    default:                                                            \
-        assert(0);                                                      \
-    }                                                                   \
-}
-
-MSA_UNOP_DF(pcnt)
-#undef MSA_UNOP_DF
 
 #define FLOAT_ONE32 make_float32(0x3f8 << 20)
 #define FLOAT_ONE64 make_float64(0x3ffULL << 52)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6de4609..0d06ba9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28958,9 +28958,6 @@ static void gen_msa_2r(CPUMIPSState *env, DisasContext *ctx)
 #endif
         gen_helper_msa_fill_df(cpu_env, tdf, twd, tws); /* trs */
         break;
-    case OPC_PCNT_df:
-        gen_helper_msa_pcnt_df(cpu_env, tdf, twd, tws);
-        break;
     case OPC_NLOC_df:
         switch (df) {
         case DF_BYTE:
@@ -28993,6 +28990,22 @@ static void gen_msa_2r(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case OPC_PCNT_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_pcnt_b(cpu_env, twd, tws);
+            break;
+        case DF_HALF:
+            gen_helper_msa_pcnt_h(cpu_env, twd, tws);
+            break;
+        case DF_WORD:
+            gen_helper_msa_pcnt_w(cpu_env, twd, tws);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_pcnt_d(cpu_env, twd, tws);
+            break;
+        }
+        break;
     default:
         MIPS_INVAL("MSA instruction");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4


