Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D82C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6B420640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6B420640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6wD-0008RB-A7
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iD6gq-0001TL-FF
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iD6go-0002Lw-Uu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56141 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iD6go-0002Go-MO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 462C81A23C3;
 Wed, 25 Sep 2019 14:46:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 170EE1A23CF;
 Wed, 25 Sep 2019 14:46:22 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/20] target/mips: msa: Simplify and move helper for MOVE.V
Date: Wed, 25 Sep 2019 14:46:11 +0200
Message-Id: <1569415572-19635-20-git-send-email-aleksandar.markovic@rt-rk.com>
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
 target/mips/helper.h     |  2 +-
 target/mips/msa_helper.c | 31 +++++++++++++------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index cc216f7..3b1a965 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -887,6 +887,7 @@ DEF_HELPER_4(msa_mod_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_mod_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_mod_s_d, void, env, i32, i32, i32)
 
+DEF_HELPER_3(msa_move_v, void, env, i32, i32)
 
 DEF_HELPER_4(msa_andi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ori_b, void, env, i32, i32, i32)
@@ -977,7 +978,6 @@ DEF_HELPER_5(msa_splati_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_insve_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_3(msa_ctcmsa, void, env, tl, i32)
 DEF_HELPER_2(msa_cfcmsa, tl, env, i32)
-DEF_HELPER_3(msa_move_v, void, env, i32, i32)
 
 DEF_HELPER_5(msa_fcaf_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_fcun_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 8ad9d42..cece69b 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1974,7 +1974,19 @@ void helper_msa_mod_u_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt
  * +---------------+----------------------------------------------------------+
  */
 
-/* TODO: insert Move group helpers here */
+static inline void msa_move_v(wr_t *pwd, wr_t *pws)
+{
+    pwd->d[0] = pws->d[0];
+    pwd->d[1] = pws->d[1];
+}
+
+void helper_msa_move_v(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+
+    msa_move_v(pwd, pws);
+}
 
 
 /*
@@ -2031,15 +2043,6 @@ void helper_msa_mod_u_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt
 /* TODO: insert Shift group helpers here */
 
 
-static inline void msa_move_v(wr_t *pwd, wr_t *pws)
-{
-    uint32_t i;
-
-    for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {
-        pwd->d[i] = pws->d[i];
-    }
-}
-
 #define MSA_FN_IMM8(FUNC, DEST, OPERATION)                              \
 void helper_msa_ ## FUNC(CPUMIPSState *env, uint32_t wd, uint32_t ws,   \
         uint32_t i8)                                                    \
@@ -3826,14 +3829,6 @@ target_ulong helper_msa_cfcmsa(CPUMIPSState *env, uint32_t cs)
     return 0;
 }
 
-void helper_msa_move_v(CPUMIPSState *env, uint32_t wd, uint32_t ws)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
-
-    msa_move_v(pwd, pws);
-}
-
 void helper_msa_fill_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t rs)
 {
-- 
2.7.4


