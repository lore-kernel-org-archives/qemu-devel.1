Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06937C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90614208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90614208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDCM-0006zy-Dl
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59464)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl5-0003pB-7n
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl3-00088T-Ad
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50164 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hZBl3-0007vD-0p
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 266B21A1E34;
 Fri,  7 Jun 2019 12:05:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id F00681A0F10;
 Fri,  7 Jun 2019 12:05:49 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 12:05:38 +0200
Message-Id: <1559901944-4578-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 04/10] target/mips: Unroll loops in helpers for
 MSA logic instructions
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

Unroll loops in helpers for MSA logic instructions for better
performance.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1559838440-9866-5-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/msa_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 8dd73d2..be059a3 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -591,10 +591,6 @@ void helper_msa_ ## FUNC(CPUMIPSState *env, uint32_t wd, uint32_t ws,   \
     }                                                                   \
 }
 
-MSA_FN_VECTOR(and_v, pwd->d[i], pws->d[i] & pwt->d[i])
-MSA_FN_VECTOR(or_v, pwd->d[i], pws->d[i] | pwt->d[i])
-MSA_FN_VECTOR(nor_v, pwd->d[i], ~(pws->d[i] | pwt->d[i]))
-MSA_FN_VECTOR(xor_v, pwd->d[i], pws->d[i] ^ pwt->d[i])
 MSA_FN_VECTOR(bmnz_v, pwd->d[i],
         BIT_MOVE_IF_NOT_ZERO(pwd->d[i], pws->d[i], pwt->d[i], DF_DOUBLE))
 MSA_FN_VECTOR(bmz_v, pwd->d[i],
@@ -606,6 +602,46 @@ MSA_FN_VECTOR(bsel_v, pwd->d[i],
 #undef BIT_SELECT
 #undef MSA_FN_VECTOR
 
+void helper_msa_and_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = pws->d[0] & pwt->d[0];
+    pwd->d[1] = pws->d[1] & pwt->d[1];
+}
+
+void helper_msa_or_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = pws->d[0] | pwt->d[0];
+    pwd->d[1] = pws->d[1] | pwt->d[1];
+}
+
+void helper_msa_nor_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = ~(pws->d[0] | pwt->d[0]);
+    pwd->d[1] = ~(pws->d[1] | pwt->d[1]);
+}
+
+void helper_msa_xor_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = pws->d[0] ^ pwt->d[0];
+    pwd->d[1] = pws->d[1] ^ pwt->d[1];
+}
+
 static inline int64_t msa_addv_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     return arg1 + arg2;
-- 
2.7.4


