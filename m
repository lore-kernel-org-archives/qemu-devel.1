Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EDC28CC1
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 18:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5FD2778D
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 18:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5FD2778D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hX8uB-0008EE-GT
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 14:38:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hX8nV-0002sr-Kl
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hX8nS-0005uO-1S
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33321 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hX8nR-0005tU-IJ
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 0DE561A1D11;
	Sat,  1 Jun 2019 20:30:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id BA8CE1A1E14;
	Sat,  1 Jun 2019 20:30:55 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sat,  1 Jun 2019 20:30:46 +0200
Message-Id: <1559413846-4402-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559413846-4402-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559413846-4402-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 8/8] target/mips: Improve performance of certain
 MSA instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Eliminate loops for better performance.

Following MSA instructions from "UNOP" group are affected:

 - NLZC.<B|H|W|D>
 - NLOC.<B|H|W|D>
 - PCNT.<B|H|W|D>

Following MSA instructions from "BINOP" group are affected:

 - ADD_A.<B|H|W|D>
 - ADDS_A.<B|H|W|D>
 - ADDS_S.<B|H|W|D>
 - ADDS_U.<B|H|W|D>
 - ADDV.<B|H|W|D>
 - ASUB_S.<B|H|W|D>
 - ASUB_U.<B|H|W|D>
 - AVE_S.<B|H|W|D>
 - AVE_U.<B|H|W|D>
 - AVER_S.<B|H|W|D>
 - AVER_U.<B|H|W|D>
 - BCLR.<B|H|W|D>
 - BNEG.<B|H|W|D>
 - BSET.<B|H|W|D>
 - CEQ.<B|H|W|D>
 - CLE_S.<B|H|W|D>
 - CLE_U.<B|H|W|D>
 - CLT_S.<B|H|W|D>
 - CLT_U.<B|H|W|D>
 - DIV_S.<B|H|W|D>
 - DIV_U.<B|H|W|D>
 - DOTP_S.<B|H|W|D>
 - DOTP_U.<B|H|W|D>
 - HADD_S.<B|H|W|D>
 - HADD_U.<B|H|W|D>
 - HSUB_S.<B|H|W|D>
 - HSUB_U.<B|H|W|D>
 - MAX_A.<B|H|W|D>
 - MAX_S.<B|H|W|D>
 - MAX_U.<B|H|W|D>
 - MIN_A.<B|H|W|D>
 - MIN_S.<B|H|W|D>
 - MIN_U.<B|H|W|D>
 - MOD_S.<B|H|W|D>
 - MOD_U.<B|H|W|D>
 - MUL_Q.<B|H|W|D>
 - MULR_Q.<B|H|W|D>
 - MULV.<B|H|W|D>
 - SLL.<B|H|W|D>
 - SRA.<B|H|W|D>
 - SRAR.<B|H|W|D>
 - SRL.<B|H|W|D>
 - SRLR.<B|H|W|D>
 - SUBS_S.<B|H|W|D>
 - SUBS_U.<B|H|W|D>
 - SUBSUS_U.<B|H|W|D>
 - SUBSUU_S.<B|H|W|D>
 - SUBV.<B|H|W|D>

Following MSA instructions from "TEROP" group are affected:

 - BINSL.<B|H|W|D>
 - BINSR.<B|H|W|D>
 - DPADD_S.<B|H|W|D>
 - DPADD_U.<B|H|W|D>
 - DPSUB_S.<B|H|W|D>
 - DPSUB_U.<B|H|W|D>
 - MADD_Q.<B|H|W|D>
 - MADDR_Q.<B|H|W|D>
 - MADDV.<B|H|W|D>
 - MSUB_Q.<B|H|W|D>
 - MSUBR_Q.<B|H|W|D>
 - MSUBV.<B|H|W|D>

Additionally, following MSA instructionas are also affected:

 - ILVL.<B|H|W|D>
 - ILVR.<B|H|W|D>
 - ILVEV.<B|H|W|D>
 - ILVOD.<B|H|W|D>
 - PCKEV.<B|H|W|D>
 - PCKOD.<B|H|W|D>

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 542 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 433 insertions(+), 109 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index ee1b1fa..f6e16c2 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -805,28 +805,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);                          \
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);                          \
-    uint32_t i;                                                         \
                                                                         \
     switch (df) {                                                       \
     case DF_BYTE:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_BYTE); i++) {                    \
-            pwd->b[i] = msa_ ## func ## _df(df, pws->b[i], pwt->b[i]);  \
-        }                                                               \
+        pwd->b[0]  = msa_ ## func ## _df(df, pws->b[0],  pwt->b[0]);    \
+        pwd->b[1]  = msa_ ## func ## _df(df, pws->b[1],  pwt->b[1]);    \
+        pwd->b[2]  = msa_ ## func ## _df(df, pws->b[2],  pwt->b[2]);    \
+        pwd->b[3]  = msa_ ## func ## _df(df, pws->b[3],  pwt->b[3]);    \
+        pwd->b[4]  = msa_ ## func ## _df(df, pws->b[4],  pwt->b[4]);    \
+        pwd->b[5]  = msa_ ## func ## _df(df, pws->b[5],  pwt->b[5]);    \
+        pwd->b[6]  = msa_ ## func ## _df(df, pws->b[6],  pwt->b[6]);    \
+        pwd->b[7]  = msa_ ## func ## _df(df, pws->b[7],  pwt->b[7]);    \
+        pwd->b[8]  = msa_ ## func ## _df(df, pws->b[8],  pwt->b[8]);    \
+        pwd->b[9]  = msa_ ## func ## _df(df, pws->b[9],  pwt->b[9]);    \
+        pwd->b[10] = msa_ ## func ## _df(df, pws->b[10], pwt->b[10]);   \
+        pwd->b[11] = msa_ ## func ## _df(df, pws->b[11], pwt->b[11]);   \
+        pwd->b[12] = msa_ ## func ## _df(df, pws->b[12], pwt->b[12]);   \
+        pwd->b[13] = msa_ ## func ## _df(df, pws->b[13], pwt->b[13]);   \
+        pwd->b[14] = msa_ ## func ## _df(df, pws->b[14], pwt->b[14]);   \
+        pwd->b[15] = msa_ ## func ## _df(df, pws->b[15], pwt->b[15]);   \
         break;                                                          \
     case DF_HALF:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_HALF); i++) {                    \
-            pwd->h[i] = msa_ ## func ## _df(df, pws->h[i], pwt->h[i]);  \
-        }                                                               \
+        pwd->h[0] = msa_ ## func ## _df(df, pws->h[0], pwt->h[0]);      \
+        pwd->h[1] = msa_ ## func ## _df(df, pws->h[1], pwt->h[1]);      \
+        pwd->h[2] = msa_ ## func ## _df(df, pws->h[2], pwt->h[2]);      \
+        pwd->h[3] = msa_ ## func ## _df(df, pws->h[3], pwt->h[3]);      \
+        pwd->h[4] = msa_ ## func ## _df(df, pws->h[4], pwt->h[4]);      \
+        pwd->h[5] = msa_ ## func ## _df(df, pws->h[5], pwt->h[5]);      \
+        pwd->h[6] = msa_ ## func ## _df(df, pws->h[6], pwt->h[6]);      \
+        pwd->h[7] = msa_ ## func ## _df(df, pws->h[7], pwt->h[7]);      \
         break;                                                          \
     case DF_WORD:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {                    \
-            pwd->w[i] = msa_ ## func ## _df(df, pws->w[i], pwt->w[i]);  \
-        }                                                               \
+        pwd->w[0] = msa_ ## func ## _df(df, pws->w[0], pwt->w[0]);      \
+        pwd->w[1] = msa_ ## func ## _df(df, pws->w[1], pwt->w[1]);      \
+        pwd->w[2] = msa_ ## func ## _df(df, pws->w[2], pwt->w[2]);      \
+        pwd->w[3] = msa_ ## func ## _df(df, pws->w[3], pwt->w[3]);      \
         break;                                                          \
     case DF_DOUBLE:                                                     \
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {                  \
-            pwd->d[i] = msa_ ## func ## _df(df, pws->d[i], pwt->d[i]);  \
-        }                                                               \
+        pwd->d[0] = msa_ ## func ## _df(df, pws->d[0], pwt->d[0]);      \
+        pwd->d[1] = msa_ ## func ## _df(df, pws->d[1], pwt->d[1]);      \
         break;                                                          \
     default:                                                            \
         assert(0);                                                      \
@@ -1012,42 +1029,71 @@ static inline int64_t msa_msubr_q_df(uint32_t df, int64_t dest, int64_t arg1,
 }
 
 #define MSA_TEROP_DF(func) \
-void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,   \
-                          uint32_t ws, uint32_t wt)                     \
-{                                                                       \
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);                          \
-    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);                          \
-    uint32_t i;                                                         \
-                                                                        \
-    switch (df) {                                                       \
-    case DF_BYTE:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_BYTE); i++) {                    \
-            pwd->b[i] = msa_ ## func ## _df(df, pwd->b[i], pws->b[i],   \
-                                            pwt->b[i]);                 \
-        }                                                               \
-        break;                                                          \
-    case DF_HALF:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_HALF); i++) {                    \
-            pwd->h[i] = msa_ ## func ## _df(df, pwd->h[i], pws->h[i],   \
-                                            pwt->h[i]);                 \
-        }                                                               \
-        break;                                                          \
-    case DF_WORD:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {                    \
-            pwd->w[i] = msa_ ## func ## _df(df, pwd->w[i], pws->w[i],   \
-                                            pwt->w[i]);                 \
-        }                                                               \
-        break;                                                          \
-    case DF_DOUBLE:                                                     \
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {                  \
-            pwd->d[i] = msa_ ## func ## _df(df, pwd->d[i], pws->d[i],   \
-                                            pwt->d[i]);                 \
-        }                                                               \
-        break;                                                          \
-    default:                                                            \
-        assert(0);                                                      \
-    }                                                                   \
+void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,  \
+                                uint32_t ws, uint32_t wt)                     \
+{                                                                             \
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                                \
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);                                \
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);                                \
+                                                                              \
+    switch (df) {                                                             \
+    case DF_BYTE:                                                             \
+        pwd->b[0]  = msa_ ## func ## _df(df, pwd->b[0],  pws->b[0],           \
+                                             pwt->b[0]);                      \
+        pwd->b[1]  = msa_ ## func ## _df(df, pwd->b[1],  pws->b[1],           \
+                                             pwt->b[1]);                      \
+        pwd->b[2]  = msa_ ## func ## _df(df, pwd->b[2],  pws->b[2],           \
+                                             pwt->b[2]);                      \
+        pwd->b[3]  = msa_ ## func ## _df(df, pwd->b[3],  pws->b[3],           \
+                                             pwt->b[3]);                      \
+        pwd->b[4]  = msa_ ## func ## _df(df, pwd->b[4],  pws->b[4],           \
+                                             pwt->b[4]);                      \
+        pwd->b[5]  = msa_ ## func ## _df(df, pwd->b[5],  pws->b[5],           \
+                                             pwt->b[5]);                      \
+        pwd->b[6]  = msa_ ## func ## _df(df, pwd->b[6],  pws->b[6],           \
+                                             pwt->b[6]);                      \
+        pwd->b[7]  = msa_ ## func ## _df(df, pwd->b[7],  pws->b[7],           \
+                                             pwt->b[7]);                      \
+        pwd->b[8]  = msa_ ## func ## _df(df, pwd->b[8],  pws->b[8],           \
+                                             pwt->b[8]);                      \
+        pwd->b[9]  = msa_ ## func ## _df(df, pwd->b[9],  pws->b[9],           \
+                                             pwt->b[9]);                      \
+        pwd->b[10] = msa_ ## func ## _df(df, pwd->b[10], pws->b[10],          \
+                                             pwt->b[10]);                     \
+        pwd->b[11] = msa_ ## func ## _df(df, pwd->b[11], pws->b[11],          \
+                                             pwt->b[11]);                     \
+        pwd->b[12] = msa_ ## func ## _df(df, pwd->b[12], pws->b[12],          \
+                                             pwt->b[12]);                     \
+        pwd->b[13] = msa_ ## func ## _df(df, pwd->b[13], pws->b[13],          \
+                                             pwt->b[13]);                     \
+        pwd->b[14] = msa_ ## func ## _df(df, pwd->b[14], pws->b[14],          \
+                                             pwt->b[14]);                     \
+        pwd->b[15] = msa_ ## func ## _df(df, pwd->b[15], pws->b[15],          \
+                                             pwt->b[15]);                     \
+        break;                                                                \
+    case DF_HALF:                                                             \
+        pwd->h[0] = msa_ ## func ## _df(df, pwd->h[0], pws->h[0], pwt->h[0]); \
+        pwd->h[1] = msa_ ## func ## _df(df, pwd->h[1], pws->h[1], pwt->h[1]); \
+        pwd->h[2] = msa_ ## func ## _df(df, pwd->h[2], pws->h[2], pwt->h[2]); \
+        pwd->h[3] = msa_ ## func ## _df(df, pwd->h[3], pws->h[3], pwt->h[3]); \
+        pwd->h[4] = msa_ ## func ## _df(df, pwd->h[4], pws->h[4], pwt->h[4]); \
+        pwd->h[5] = msa_ ## func ## _df(df, pwd->h[5], pws->h[5], pwt->h[5]); \
+        pwd->h[6] = msa_ ## func ## _df(df, pwd->h[6], pws->h[6], pwt->h[6]); \
+        pwd->h[7] = msa_ ## func ## _df(df, pwd->h[7], pws->h[7], pwt->h[7]); \
+        break;                                                                \
+    case DF_WORD:                                                             \
+        pwd->w[0] = msa_ ## func ## _df(df, pwd->w[0], pws->w[0], pwt->w[0]); \
+        pwd->w[1] = msa_ ## func ## _df(df, pwd->w[1], pws->w[1], pwt->w[1]); \
+        pwd->w[2] = msa_ ## func ## _df(df, pwd->w[2], pws->w[2], pwt->w[2]); \
+        pwd->w[3] = msa_ ## func ## _df(df, pwd->w[3], pws->w[3], pwt->w[3]); \
+        break;                                                                \
+    case DF_DOUBLE:                                                           \
+        pwd->d[0] = msa_ ## func ## _df(df, pwd->d[0], pws->d[0], pwt->d[0]); \
+        pwd->d[1] = msa_ ## func ## _df(df, pwd->d[1], pws->d[1], pwt->d[1]); \
+        break;                                                                \
+    default:                                                                  \
+        assert(0);                                                            \
+    }                                                                         \
 }
 
 MSA_TEROP_DF(maddv)
@@ -1167,53 +1213,6 @@ void helper_msa_##FUNC(CPUMIPSState *env, uint32_t df, uint32_t wd, \
 #define Rd(pwr, i) (pwr->d[i])
 #define Ld(pwr, i) (pwr->d[i + DF_ELEMENTS(DF_DOUBLE)/2])
 
-#define MSA_DO(DF)                      \
-    do {                                \
-        R##DF(pwx, i) = pwt->DF[2*i];   \
-        L##DF(pwx, i) = pws->DF[2*i];   \
-    } while (0)
-MSA_FN_DF(pckev_df)
-#undef MSA_DO
-
-#define MSA_DO(DF)                      \
-    do {                                \
-        R##DF(pwx, i) = pwt->DF[2*i+1]; \
-        L##DF(pwx, i) = pws->DF[2*i+1]; \
-    } while (0)
-MSA_FN_DF(pckod_df)
-#undef MSA_DO
-
-#define MSA_DO(DF)                      \
-    do {                                \
-        pwx->DF[2*i]   = L##DF(pwt, i); \
-        pwx->DF[2*i+1] = L##DF(pws, i); \
-    } while (0)
-MSA_FN_DF(ilvl_df)
-#undef MSA_DO
-
-#define MSA_DO(DF)                      \
-    do {                                \
-        pwx->DF[2*i]   = R##DF(pwt, i); \
-        pwx->DF[2*i+1] = R##DF(pws, i); \
-    } while (0)
-MSA_FN_DF(ilvr_df)
-#undef MSA_DO
-
-#define MSA_DO(DF)                      \
-    do {                                \
-        pwx->DF[2*i]   = pwt->DF[2*i];  \
-        pwx->DF[2*i+1] = pws->DF[2*i];  \
-    } while (0)
-MSA_FN_DF(ilvev_df)
-#undef MSA_DO
-
-#define MSA_DO(DF)                          \
-    do {                                    \
-        pwx->DF[2*i]   = pwt->DF[2*i+1];    \
-        pwx->DF[2*i+1] = pws->DF[2*i+1];    \
-    } while (0)
-MSA_FN_DF(ilvod_df)
-#undef MSA_DO
 #undef MSA_LOOP_COND
 
 #define MSA_LOOP_COND(DF) \
@@ -1231,6 +1230,314 @@ MSA_FN_DF(vshf_df)
 #undef MSA_LOOP_COND
 #undef MSA_FN_DF
 
+
+void helper_msa_ilvev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                         uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[15] = pws->b[14];
+        pwd->b[14] = pwt->b[14];
+        pwd->b[13] = pws->b[12];
+        pwd->b[12] = pwt->b[12];
+        pwd->b[11] = pws->b[10];
+        pwd->b[10] = pwt->b[10];
+        pwd->b[9]  = pws->b[8];
+        pwd->b[8]  = pwt->b[8];
+        pwd->b[7]  = pws->b[6];
+        pwd->b[6]  = pwt->b[6];
+        pwd->b[5]  = pws->b[4];
+        pwd->b[4]  = pwt->b[4];
+        pwd->b[3]  = pws->b[2];
+        pwd->b[2]  = pwt->b[2];
+        pwd->b[1]  = pws->b[0];
+        pwd->b[0]  = pwt->b[0];
+        break;
+    case DF_HALF:
+        pwd->h[7] = pws->h[6];
+        pwd->h[6] = pwt->h[6];
+        pwd->h[5] = pws->h[4];
+        pwd->h[4] = pwt->h[4];
+        pwd->h[3] = pws->h[2];
+        pwd->h[2] = pwt->h[2];
+        pwd->h[1] = pws->h[0];
+        pwd->h[0] = pwt->h[0];
+        break;
+    case DF_WORD:
+        pwd->w[3] = pws->w[2];
+        pwd->w[2] = pwt->w[2];
+        pwd->w[1] = pws->w[0];
+        pwd->w[0] = pwt->w[0];
+        break;
+    case DF_DOUBLE:
+        pwd->d[1] = pws->d[0];
+        pwd->d[0] = pwt->d[0];
+        break;
+    default:
+        assert(0);
+    }
+}
+
+void helper_msa_ilvod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                         uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[0]  = pwt->b[1];
+        pwd->b[1]  = pws->b[1];
+        pwd->b[2]  = pwt->b[3];
+        pwd->b[3]  = pws->b[3];
+        pwd->b[4]  = pwt->b[5];
+        pwd->b[5]  = pws->b[5];
+        pwd->b[6]  = pwt->b[7];
+        pwd->b[7]  = pws->b[7];
+        pwd->b[8]  = pwt->b[9];
+        pwd->b[9]  = pws->b[9];
+        pwd->b[10] = pwt->b[11];
+        pwd->b[11] = pws->b[11];
+        pwd->b[12] = pwt->b[13];
+        pwd->b[13] = pws->b[13];
+        pwd->b[14] = pwt->b[15];
+        pwd->b[15] = pws->b[15];
+        break;
+    case DF_HALF:
+        pwd->h[0] = pwt->h[1];
+        pwd->h[1] = pws->h[1];
+        pwd->h[2] = pwt->h[3];
+        pwd->h[3] = pws->h[3];
+        pwd->h[4] = pwt->h[5];
+        pwd->h[5] = pws->h[5];
+        pwd->h[6] = pwt->h[7];
+        pwd->h[7] = pws->h[7];
+        break;
+    case DF_WORD:
+        pwd->w[0] = pwt->w[1];
+        pwd->w[1] = pws->w[1];
+        pwd->w[2] = pwt->w[3];
+        pwd->w[3] = pws->w[3];
+        break;
+    case DF_DOUBLE:
+        pwd->d[0] = pwt->d[1];
+        pwd->d[1] = pws->d[1];
+        break;
+    default:
+        assert(0);
+    }
+}
+
+void helper_msa_ilvl_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                        uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[0]  = pwt->b[8];
+        pwd->b[1]  = pws->b[8];
+        pwd->b[2]  = pwt->b[9];
+        pwd->b[3]  = pws->b[9];
+        pwd->b[4]  = pwt->b[10];
+        pwd->b[5]  = pws->b[10];
+        pwd->b[6]  = pwt->b[11];
+        pwd->b[7]  = pws->b[11];
+        pwd->b[8]  = pwt->b[12];
+        pwd->b[9]  = pws->b[12];
+        pwd->b[10] = pwt->b[13];
+        pwd->b[11] = pws->b[13];
+        pwd->b[12] = pwt->b[14];
+        pwd->b[13] = pws->b[14];
+        pwd->b[14] = pwt->b[15];
+        pwd->b[15] = pws->b[15];
+        break;
+    case DF_HALF:
+        pwd->h[0] = pwt->h[4];
+        pwd->h[1] = pws->h[4];
+        pwd->h[2] = pwt->h[5];
+        pwd->h[3] = pws->h[5];
+        pwd->h[4] = pwt->h[6];
+        pwd->h[5] = pws->h[6];
+        pwd->h[6] = pwt->h[7];
+        pwd->h[7] = pws->h[7];
+        break;
+    case DF_WORD:
+        pwd->w[0] = pwt->w[2];
+        pwd->w[1] = pws->w[2];
+        pwd->w[2] = pwt->w[3];
+        pwd->w[3] = pws->w[3];
+        break;
+    case DF_DOUBLE:
+        pwd->d[0] = pwt->d[1];
+        pwd->d[1] = pws->d[1];
+        break;
+    default:
+        assert(0);
+    }
+}
+
+void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                        uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[15] = pws->b[7];
+        pwd->b[14] = pwt->b[7];
+        pwd->b[13] = pws->b[6];
+        pwd->b[12] = pwt->b[6];
+        pwd->b[11] = pws->b[5];
+        pwd->b[10] = pwt->b[5];
+        pwd->b[9]  = pws->b[4];
+        pwd->b[8]  = pwt->b[4];
+        pwd->b[7]  = pws->b[3];
+        pwd->b[6]  = pwt->b[3];
+        pwd->b[5]  = pws->b[2];
+        pwd->b[4]  = pwt->b[2];
+        pwd->b[3]  = pws->b[1];
+        pwd->b[2]  = pwt->b[1];
+        pwd->b[1]  = pws->b[0];
+        pwd->b[0]  = pwt->b[0];
+        break;
+    case DF_HALF:
+        pwd->h[7] = pws->h[3];
+        pwd->h[6] = pwt->h[3];
+        pwd->h[5] = pws->h[2];
+        pwd->h[4] = pwt->h[2];
+        pwd->h[3] = pws->h[1];
+        pwd->h[2] = pwt->h[1];
+        pwd->h[1] = pws->h[0];
+        pwd->h[0] = pwt->h[0];
+        break;
+    case DF_WORD:
+        pwd->w[3] = pws->w[1];
+        pwd->w[2] = pwt->w[1];
+        pwd->w[1] = pws->w[0];
+        pwd->w[0] = pwt->w[0];
+        break;
+    case DF_DOUBLE:
+        pwd->d[1] = pws->d[0];
+        pwd->d[0] = pwt->d[0];
+        break;
+    default:
+        assert(0);
+    }
+}
+
+void helper_msa_pckev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                         uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[15] = pws->b[14];
+        pwd->b[13] = pws->b[10];
+        pwd->b[11] = pws->b[6];
+        pwd->b[9]  = pws->b[2];
+        pwd->b[7]  = pwt->b[14];
+        pwd->b[5]  = pwt->b[10];
+        pwd->b[3]  = pwt->b[6];
+        pwd->b[1]  = pwt->b[2];
+        pwd->b[14] = pws->b[12];
+        pwd->b[10] = pws->b[4];
+        pwd->b[6]  = pwt->b[12];
+        pwd->b[2]  = pwt->b[4];
+        pwd->b[12] = pws->b[8];
+        pwd->b[4]  = pwt->b[8];
+        pwd->b[8]  = pws->b[0];
+        pwd->b[0]  = pwt->b[0];
+        break;
+    case DF_HALF:
+        pwd->h[7] = pws->h[6];
+        pwd->h[5] = pws->h[2];
+        pwd->h[3] = pwt->h[6];
+        pwd->h[1] = pwt->h[2];
+        pwd->h[6] = pws->h[4];
+        pwd->h[2] = pwt->h[4];
+        pwd->h[4] = pws->h[0];
+        pwd->h[0] = pwt->h[0];
+        break;
+    case DF_WORD:
+        pwd->w[3] = pws->w[2];
+        pwd->w[1] = pwt->w[2];
+        pwd->w[2] = pws->w[0];
+        pwd->w[0] = pwt->w[0];
+        break;
+    case DF_DOUBLE:
+        pwd->d[1] = pws->d[0];
+        pwd->d[0] = pwt->d[0];
+        break;
+    default:
+        assert(0);
+    }
+}
+
+void helper_msa_pckod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                         uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[0]  = pwt->b[1];
+        pwd->b[2]  = pwt->b[5];
+        pwd->b[4]  = pwt->b[9];
+        pwd->b[6]  = pwt->b[13];
+        pwd->b[8]  = pws->b[1];
+        pwd->b[10] = pws->b[5];
+        pwd->b[12] = pws->b[9];
+        pwd->b[14] = pws->b[13];
+        pwd->b[1]  = pwt->b[3];
+        pwd->b[5]  = pwt->b[11];
+        pwd->b[9]  = pws->b[3];
+        pwd->b[13] = pws->b[11];
+        pwd->b[3]  = pwt->b[7];
+        pwd->b[11] = pws->b[7];
+        pwd->b[7]  = pwt->b[15];
+        pwd->b[15] = pws->b[15];
+        break;
+    case DF_HALF:
+        pwd->h[0] = pwt->h[1];
+        pwd->h[2] = pwt->h[5];
+        pwd->h[4] = pws->h[1];
+        pwd->h[6] = pws->h[5];
+        pwd->h[1] = pwt->h[3];
+        pwd->h[5] = pws->h[3];
+        pwd->h[3] = pwt->h[7];
+        pwd->h[7] = pws->h[7];
+        break;
+    case DF_WORD:
+        pwd->w[0] = pwt->w[1];
+        pwd->w[2] = pws->w[1];
+        pwd->w[1] = pwt->w[3];
+        pwd->w[3] = pws->w[3];
+        break;
+    case DF_DOUBLE:
+        pwd->d[0] = pwt->d[1];
+        pwd->d[1] = pws->d[1];
+        break;
+    default:
+        assert(0);
+    }
+}
+
+
 void helper_msa_sldi_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t n)
 {
@@ -1537,28 +1844,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
 {                                                                       \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);                          \
-    uint32_t i;                                                         \
                                                                         \
     switch (df) {                                                       \
     case DF_BYTE:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_BYTE); i++) {                    \
-            pwd->b[i] = msa_ ## func ## _df(df, pws->b[i]);             \
-        }                                                               \
+        pwd->b[0]  = msa_ ## func ## _df(df, pws->b[0]);                \
+        pwd->b[1]  = msa_ ## func ## _df(df, pws->b[1]);                \
+        pwd->b[2]  = msa_ ## func ## _df(df, pws->b[2]);                \
+        pwd->b[3]  = msa_ ## func ## _df(df, pws->b[3]);                \
+        pwd->b[4]  = msa_ ## func ## _df(df, pws->b[4]);                \
+        pwd->b[5]  = msa_ ## func ## _df(df, pws->b[5]);                \
+        pwd->b[6]  = msa_ ## func ## _df(df, pws->b[6]);                \
+        pwd->b[7]  = msa_ ## func ## _df(df, pws->b[7]);                \
+        pwd->b[8]  = msa_ ## func ## _df(df, pws->b[8]);                \
+        pwd->b[9]  = msa_ ## func ## _df(df, pws->b[9]);                \
+        pwd->b[10] = msa_ ## func ## _df(df, pws->b[10]);               \
+        pwd->b[11] = msa_ ## func ## _df(df, pws->b[11]);               \
+        pwd->b[12] = msa_ ## func ## _df(df, pws->b[12]);               \
+        pwd->b[13] = msa_ ## func ## _df(df, pws->b[13]);               \
+        pwd->b[14] = msa_ ## func ## _df(df, pws->b[14]);               \
+        pwd->b[15] = msa_ ## func ## _df(df, pws->b[15]);               \
         break;                                                          \
     case DF_HALF:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_HALF); i++) {                    \
-            pwd->h[i] = msa_ ## func ## _df(df, pws->h[i]);             \
-        }                                                               \
+        pwd->h[0] = msa_ ## func ## _df(df, pws->h[0]);                 \
+        pwd->h[1] = msa_ ## func ## _df(df, pws->h[1]);                 \
+        pwd->h[2] = msa_ ## func ## _df(df, pws->h[2]);                 \
+        pwd->h[3] = msa_ ## func ## _df(df, pws->h[3]);                 \
+        pwd->h[4] = msa_ ## func ## _df(df, pws->h[4]);                 \
+        pwd->h[5] = msa_ ## func ## _df(df, pws->h[5]);                 \
+        pwd->h[6] = msa_ ## func ## _df(df, pws->h[6]);                 \
+        pwd->h[7] = msa_ ## func ## _df(df, pws->h[7]);                 \
         break;                                                          \
     case DF_WORD:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {                    \
-            pwd->w[i] = msa_ ## func ## _df(df, pws->w[i]);             \
-        }                                                               \
+        pwd->w[0] = msa_ ## func ## _df(df, pws->w[0]);                 \
+        pwd->w[1] = msa_ ## func ## _df(df, pws->w[1]);                 \
+        pwd->w[2] = msa_ ## func ## _df(df, pws->w[2]);                 \
+        pwd->w[3] = msa_ ## func ## _df(df, pws->w[3]);                 \
         break;                                                          \
     case DF_DOUBLE:                                                     \
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {                  \
-            pwd->d[i] = msa_ ## func ## _df(df, pws->d[i]);             \
-        }                                                               \
+        pwd->d[0] = msa_ ## func ## _df(df, pws->d[0]);                 \
+        pwd->d[1] = msa_ ## func ## _df(df, pws->d[1]);                 \
         break;                                                          \
     default:                                                            \
         assert(0);                                                      \
-- 
2.7.4


