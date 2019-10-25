Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7419CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE022084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE022084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2zu-0000vr-50
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2im-0005Fb-8p
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ih-0002Lo-DK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:52 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34456 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iO2ih-0002EI-2B
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1812E1A2284;
 Fri, 25 Oct 2019 18:44:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CF2151A229D;
 Fri, 25 Oct 2019 18:44:29 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] target/mips: Refactor handling of vector compare 'equal'
 instructions
Date: Fri, 25 Oct 2019 18:44:16 +0200
Message-Id: <1572021862-28273-15-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

From: Filip Bozuta <Filip.Bozuta@rt-rk.com>

Remove unnecessary argument and provide separate function for each
instruction.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1571837825-24438-2-git-send-email-Filip.Bozuta@rt-rk.com>
---
 target/mips/msa_helper.c | 80 ++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 0e39016..7d4d15c 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1641,28 +1641,38 @@ static inline int64_t msa_ceq_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 == arg2 ? -1 : 0;
 }
 
+static inline int8_t msa_ceq_b(int8_t arg1, int8_t arg2)
+{
+    return arg1 == arg2 ? -1 : 0;
+}
+
 void helper_msa_ceq_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->b[0]  = msa_ceq_df(DF_BYTE, pws->b[0],  pwt->b[0]);
-    pwd->b[1]  = msa_ceq_df(DF_BYTE, pws->b[1],  pwt->b[1]);
-    pwd->b[2]  = msa_ceq_df(DF_BYTE, pws->b[2],  pwt->b[2]);
-    pwd->b[3]  = msa_ceq_df(DF_BYTE, pws->b[3],  pwt->b[3]);
-    pwd->b[4]  = msa_ceq_df(DF_BYTE, pws->b[4],  pwt->b[4]);
-    pwd->b[5]  = msa_ceq_df(DF_BYTE, pws->b[5],  pwt->b[5]);
-    pwd->b[6]  = msa_ceq_df(DF_BYTE, pws->b[6],  pwt->b[6]);
-    pwd->b[7]  = msa_ceq_df(DF_BYTE, pws->b[7],  pwt->b[7]);
-    pwd->b[8]  = msa_ceq_df(DF_BYTE, pws->b[8],  pwt->b[8]);
-    pwd->b[9]  = msa_ceq_df(DF_BYTE, pws->b[9],  pwt->b[9]);
-    pwd->b[10] = msa_ceq_df(DF_BYTE, pws->b[10], pwt->b[10]);
-    pwd->b[11] = msa_ceq_df(DF_BYTE, pws->b[11], pwt->b[11]);
-    pwd->b[12] = msa_ceq_df(DF_BYTE, pws->b[12], pwt->b[12]);
-    pwd->b[13] = msa_ceq_df(DF_BYTE, pws->b[13], pwt->b[13]);
-    pwd->b[14] = msa_ceq_df(DF_BYTE, pws->b[14], pwt->b[14]);
-    pwd->b[15] = msa_ceq_df(DF_BYTE, pws->b[15], pwt->b[15]);
+    pwd->b[0]  = msa_ceq_b(pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_ceq_b(pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_ceq_b(pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_ceq_b(pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_ceq_b(pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_ceq_b(pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_ceq_b(pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_ceq_b(pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_ceq_b(pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_ceq_b(pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_ceq_b(pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_ceq_b(pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_ceq_b(pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_ceq_b(pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_ceq_b(pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_ceq_b(pws->b[15], pwt->b[15]);
+}
+
+static inline int16_t msa_ceq_h(int16_t arg1, int16_t arg2)
+{
+    return arg1 == arg2 ? -1 : 0;
 }
 
 void helper_msa_ceq_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
@@ -1671,14 +1681,19 @@ void helper_msa_ceq_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->h[0]  = msa_ceq_df(DF_HALF, pws->h[0],  pwt->h[0]);
-    pwd->h[1]  = msa_ceq_df(DF_HALF, pws->h[1],  pwt->h[1]);
-    pwd->h[2]  = msa_ceq_df(DF_HALF, pws->h[2],  pwt->h[2]);
-    pwd->h[3]  = msa_ceq_df(DF_HALF, pws->h[3],  pwt->h[3]);
-    pwd->h[4]  = msa_ceq_df(DF_HALF, pws->h[4],  pwt->h[4]);
-    pwd->h[5]  = msa_ceq_df(DF_HALF, pws->h[5],  pwt->h[5]);
-    pwd->h[6]  = msa_ceq_df(DF_HALF, pws->h[6],  pwt->h[6]);
-    pwd->h[7]  = msa_ceq_df(DF_HALF, pws->h[7],  pwt->h[7]);
+    pwd->h[0]  = msa_ceq_h(pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_ceq_h(pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_ceq_h(pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_ceq_h(pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_ceq_h(pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_ceq_h(pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_ceq_h(pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_ceq_h(pws->h[7],  pwt->h[7]);
+}
+
+static inline int32_t msa_ceq_w(int32_t arg1, int32_t arg2)
+{
+    return arg1 == arg2 ? -1 : 0;
 }
 
 void helper_msa_ceq_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
@@ -1687,10 +1702,15 @@ void helper_msa_ceq_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->w[0]  = msa_ceq_df(DF_WORD, pws->w[0],  pwt->w[0]);
-    pwd->w[1]  = msa_ceq_df(DF_WORD, pws->w[1],  pwt->w[1]);
-    pwd->w[2]  = msa_ceq_df(DF_WORD, pws->w[2],  pwt->w[2]);
-    pwd->w[3]  = msa_ceq_df(DF_WORD, pws->w[3],  pwt->w[3]);
+    pwd->w[0]  = msa_ceq_w(pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_ceq_w(pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_ceq_w(pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_ceq_w(pws->w[3],  pwt->w[3]);
+}
+
+static inline int64_t msa_ceq_d(int64_t arg1, int64_t arg2)
+{
+    return arg1 == arg2 ? -1 : 0;
 }
 
 void helper_msa_ceq_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
@@ -1699,8 +1719,8 @@ void helper_msa_ceq_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->d[0]  = msa_ceq_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
-    pwd->d[1]  = msa_ceq_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+    pwd->d[0]  = msa_ceq_d(pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_ceq_d(pws->d[1],  pwt->d[1]);
 }
 
 static inline int64_t msa_cle_s_df(uint32_t df, int64_t arg1, int64_t arg2)
-- 
2.7.4


