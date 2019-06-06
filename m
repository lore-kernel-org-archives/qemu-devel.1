Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A2C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32974206E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32974206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrU2-0007nw-BG
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:27:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYrSA-0006LL-7q
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYrS9-00063S-0r
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33391 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hYrS6-0005oN-Tc
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:25:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id F37B21A2199;
	Thu,  6 Jun 2019 14:25:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id D3DB21A21BE;
	Thu,  6 Jun 2019 14:25:02 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:24:34 +0200
Message-Id: <1559823880-29103-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 04/10] target/mips: Unroll loops in helpers
 for MSA logic instructions
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Unroll loops in helpers for MSA logic instructions for better
performance.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1559745316-1454-4-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/msa_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 7b73e22..a861155 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -268,10 +268,6 @@ void helper_msa_ ## FUNC(CPUMIPSState *env, uint32_t wd, uint32_t ws,   \
     }                                                                   \
 }
 
-MSA_FN_VECTOR(and_v, pwd->d[i], pws->d[i] & pwt->d[i])
-MSA_FN_VECTOR(or_v, pwd->d[i], pws->d[i] | pwt->d[i])
-MSA_FN_VECTOR(nor_v, pwd->d[i], ~(pws->d[i] | pwt->d[i]))
-MSA_FN_VECTOR(xor_v, pwd->d[i], pws->d[i] ^ pwt->d[i])
 MSA_FN_VECTOR(bmnz_v, pwd->d[i],
         BIT_MOVE_IF_NOT_ZERO(pwd->d[i], pws->d[i], pwt->d[i], DF_DOUBLE))
 MSA_FN_VECTOR(bmz_v, pwd->d[i],
@@ -283,6 +279,46 @@ MSA_FN_VECTOR(bsel_v, pwd->d[i],
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


