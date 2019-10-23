Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF3CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B932086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B932086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNKj3-0006au-BR
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 13:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iNGqI-0007IA-2X
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iNGqF-0002KI-1j
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:38:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58042 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iNGqE-00026q-M1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:38:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 4AB861A2143;
 Wed, 23 Oct 2019 15:37:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2A4931A216D;
 Wed, 23 Oct 2019 15:37:16 +0200 (CEST)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/mips: Rearrange vector compare less than (signed)
 instructions
Date: Wed, 23 Oct 2019 15:37:05 +0200
Message-Id: <1571837825-24438-3-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571837825-24438-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1571837825-24438-1-git-send-email-Filip.Bozuta@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
X-Mailman-Approved-At: Wed, 23 Oct 2019 13:09:41 -0400
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unnecessary argument and provide separate function for each
instruction.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 target/mips/msa_helper.c | 80 ++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index b5027e7..35bbf26 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1389,6 +1389,11 @@ static inline int64_t msa_clt_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 < arg2 ? -1 : 0;
 }
 
+static inline int8_t msa_clt_s_b(int8_t arg1, int8_t arg2)
+{
+    return arg1 < arg2 ? -1 : 0;
+}
+
 void helper_msa_clt_s_b(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
@@ -1396,22 +1401,27 @@ void helper_msa_clt_s_b(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->b[0]  = msa_clt_s_df(DF_BYTE, pws->b[0],  pwt->b[0]);
-    pwd->b[1]  = msa_clt_s_df(DF_BYTE, pws->b[1],  pwt->b[1]);
-    pwd->b[2]  = msa_clt_s_df(DF_BYTE, pws->b[2],  pwt->b[2]);
-    pwd->b[3]  = msa_clt_s_df(DF_BYTE, pws->b[3],  pwt->b[3]);
-    pwd->b[4]  = msa_clt_s_df(DF_BYTE, pws->b[4],  pwt->b[4]);
-    pwd->b[5]  = msa_clt_s_df(DF_BYTE, pws->b[5],  pwt->b[5]);
-    pwd->b[6]  = msa_clt_s_df(DF_BYTE, pws->b[6],  pwt->b[6]);
-    pwd->b[7]  = msa_clt_s_df(DF_BYTE, pws->b[7],  pwt->b[7]);
-    pwd->b[8]  = msa_clt_s_df(DF_BYTE, pws->b[8],  pwt->b[8]);
-    pwd->b[9]  = msa_clt_s_df(DF_BYTE, pws->b[9],  pwt->b[9]);
-    pwd->b[10] = msa_clt_s_df(DF_BYTE, pws->b[10], pwt->b[10]);
-    pwd->b[11] = msa_clt_s_df(DF_BYTE, pws->b[11], pwt->b[11]);
-    pwd->b[12] = msa_clt_s_df(DF_BYTE, pws->b[12], pwt->b[12]);
-    pwd->b[13] = msa_clt_s_df(DF_BYTE, pws->b[13], pwt->b[13]);
-    pwd->b[14] = msa_clt_s_df(DF_BYTE, pws->b[14], pwt->b[14]);
-    pwd->b[15] = msa_clt_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
+    pwd->b[0]  = msa_clt_s_b(pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_clt_s_b(pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_clt_s_b(pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_clt_s_b(pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_clt_s_b(pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_clt_s_b(pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_clt_s_b(pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_clt_s_b(pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_clt_s_b(pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_clt_s_b(pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_clt_s_b(pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_clt_s_b(pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_clt_s_b(pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_clt_s_b(pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_clt_s_b(pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_clt_s_b(pws->b[15], pwt->b[15]);
+}
+
+static inline int16_t msa_clt_s_h(int16_t arg1, int16_t arg2)
+{
+    return arg1 < arg2 ? -1 : 0;
 }
 
 void helper_msa_clt_s_h(CPUMIPSState *env,
@@ -1421,14 +1431,19 @@ void helper_msa_clt_s_h(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->h[0]  = msa_clt_s_df(DF_HALF, pws->h[0],  pwt->h[0]);
-    pwd->h[1]  = msa_clt_s_df(DF_HALF, pws->h[1],  pwt->h[1]);
-    pwd->h[2]  = msa_clt_s_df(DF_HALF, pws->h[2],  pwt->h[2]);
-    pwd->h[3]  = msa_clt_s_df(DF_HALF, pws->h[3],  pwt->h[3]);
-    pwd->h[4]  = msa_clt_s_df(DF_HALF, pws->h[4],  pwt->h[4]);
-    pwd->h[5]  = msa_clt_s_df(DF_HALF, pws->h[5],  pwt->h[5]);
-    pwd->h[6]  = msa_clt_s_df(DF_HALF, pws->h[6],  pwt->h[6]);
-    pwd->h[7]  = msa_clt_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
+    pwd->h[0]  = msa_clt_s_h(pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_clt_s_h(pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_clt_s_h(pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_clt_s_h(pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_clt_s_h(pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_clt_s_h(pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_clt_s_h(pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_clt_s_h(pws->h[7],  pwt->h[7]);
+}
+
+static inline int32_t msa_clt_s_w(int32_t arg1, int32_t arg2)
+{
+    return arg1 < arg2 ? -1 : 0;
 }
 
 void helper_msa_clt_s_w(CPUMIPSState *env,
@@ -1438,10 +1453,15 @@ void helper_msa_clt_s_w(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->w[0]  = msa_clt_s_df(DF_WORD, pws->w[0],  pwt->w[0]);
-    pwd->w[1]  = msa_clt_s_df(DF_WORD, pws->w[1],  pwt->w[1]);
-    pwd->w[2]  = msa_clt_s_df(DF_WORD, pws->w[2],  pwt->w[2]);
-    pwd->w[3]  = msa_clt_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
+    pwd->w[0]  = msa_clt_s_w(pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_clt_s_w(pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_clt_s_w(pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_clt_s_w(pws->w[3],  pwt->w[3]);
+}
+
+static inline int64_t msa_clt_s_d(int64_t arg1, int64_t arg2)
+{
+    return arg1 < arg2 ? -1 : 0;
 }
 
 void helper_msa_clt_s_d(CPUMIPSState *env,
@@ -1451,8 +1471,8 @@ void helper_msa_clt_s_d(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-    pwd->d[0]  = msa_clt_s_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
-    pwd->d[1]  = msa_clt_s_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+    pwd->d[0]  = msa_clt_s_d(pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_clt_s_d(pws->d[1],  pwt->d[1]);
 }
 
 static inline int64_t msa_clt_u_df(uint32_t df, int64_t arg1, int64_t arg2)
-- 
2.7.4


