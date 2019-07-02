Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B6DC06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6292A21721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6292A21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHVf-0001HH-Am
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35967)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiHKE-00018q-Ep
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiHKC-0006pL-Fx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:51:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53509 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hiHKC-0006ng-4V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:51:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id AD1E61A22D1;
 Tue,  2 Jul 2019 13:50:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 0691E1A23B2;
 Tue,  2 Jul 2019 13:50:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	arikalo@wavecomp.com
Date: Tue,  2 Jul 2019 13:50:12 +0200
Message-Id: <1562068213-11307-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562068213-11307-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1562068213-11307-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 6/7] target/mips: Unroll loops for MSA float
 max/min instructions
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Slight preformance improvement for MSA float max/min instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 target/mips/msa_helper.c | 198 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 125 insertions(+), 73 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 5377bc1..97f840b 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -3850,35 +3850,65 @@ void helper_msa_fmin_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-    uint32_t i;
 
     clear_msacsr_cause(env);
 
-    switch (df) {
-    case DF_WORD:
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
-            if (NUMBER_QNAN_PAIR(pws->w[i], pwt->w[i], 32, status)) {
-                MSA_FLOAT_MAXOP(pwx->w[i], min, pws->w[i], pws->w[i], 32);
-            } else if (NUMBER_QNAN_PAIR(pwt->w[i], pws->w[i], 32, status)) {
-                MSA_FLOAT_MAXOP(pwx->w[i], min, pwt->w[i], pwt->w[i], 32);
-            } else {
-                MSA_FLOAT_MAXOP(pwx->w[i], min, pws->w[i], pwt->w[i], 32);
-            }
+    if (df == DF_WORD) {
+
+        if (NUMBER_QNAN_PAIR(pws->w[0], pwt->w[0], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[0], min, pws->w[0], pws->w[0], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[0], pws->w[0], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[0], min, pwt->w[0], pwt->w[0], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[0], min, pws->w[0], pwt->w[0], 32);
         }
-        break;
-    case DF_DOUBLE:
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {
-            if (NUMBER_QNAN_PAIR(pws->d[i], pwt->d[i], 64, status)) {
-                MSA_FLOAT_MAXOP(pwx->d[i], min, pws->d[i], pws->d[i], 64);
-            } else if (NUMBER_QNAN_PAIR(pwt->d[i], pws->d[i], 64, status)) {
-                MSA_FLOAT_MAXOP(pwx->d[i], min, pwt->d[i], pwt->d[i], 64);
-            } else {
-                MSA_FLOAT_MAXOP(pwx->d[i], min, pws->d[i], pwt->d[i], 64);
-            }
+
+        if (NUMBER_QNAN_PAIR(pws->w[1], pwt->w[1], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[1], min, pws->w[1], pws->w[1], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[1], pws->w[1], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[1], min, pwt->w[1], pwt->w[1], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[1], min, pws->w[1], pwt->w[1], 32);
         }
-        break;
-    default:
+
+        if (NUMBER_QNAN_PAIR(pws->w[2], pwt->w[2], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[2], min, pws->w[2], pws->w[2], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[2], pws->w[2], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[2], min, pwt->w[2], pwt->w[2], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[2], min, pws->w[2], pwt->w[2], 32);
+        }
+
+        if (NUMBER_QNAN_PAIR(pws->w[3], pwt->w[3], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[3], min, pws->w[3], pws->w[3], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[3], pws->w[3], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[3], min, pwt->w[3], pwt->w[3], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[3], min, pws->w[3], pwt->w[3], 32);
+        }
+
+    } else if (df == DF_DOUBLE) {
+
+        if (NUMBER_QNAN_PAIR(pws->d[0], pwt->d[0], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[0], min, pws->d[0], pws->d[0], 64);
+        } else if (NUMBER_QNAN_PAIR(pwt->d[0], pws->d[0], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[0], min, pwt->d[0], pwt->d[0], 64);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->d[0], min, pws->d[0], pwt->d[0], 64);
+        }
+
+        if (NUMBER_QNAN_PAIR(pws->d[1], pwt->d[1], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[1], min, pws->d[1], pws->d[1], 64);
+        } else if (NUMBER_QNAN_PAIR(pwt->d[1], pws->d[1], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[1], min, pwt->d[1], pwt->d[1], 64);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->d[1], min, pws->d[1], pwt->d[1], 64);
+        }
+
+    } else {
+
         assert(0);
+
     }
 
     check_msacsr_cause(env, GETPC());
@@ -3894,22 +3924,18 @@ void helper_msa_fmin_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-    uint32_t i;
 
     clear_msacsr_cause(env);
 
-    switch (df) {
-    case DF_WORD:
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
-            FMAXMIN_A(min, max, pwx->w[i], pws->w[i], pwt->w[i], 32, status);
-        }
-        break;
-    case DF_DOUBLE:
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {
-            FMAXMIN_A(min, max, pwx->d[i], pws->d[i], pwt->d[i], 64, status);
-        }
-        break;
-    default:
+    if (df == DF_WORD) {
+        FMAXMIN_A(min, max, pwx->w[0], pws->w[0], pwt->w[0], 32, status);
+        FMAXMIN_A(min, max, pwx->w[1], pws->w[1], pwt->w[1], 32, status);
+        FMAXMIN_A(min, max, pwx->w[2], pws->w[2], pwt->w[2], 32, status);
+        FMAXMIN_A(min, max, pwx->w[3], pws->w[3], pwt->w[3], 32, status);
+    } else if (df == DF_DOUBLE) {
+        FMAXMIN_A(min, max, pwx->d[0], pws->d[0], pwt->d[0], 64, status);
+        FMAXMIN_A(min, max, pwx->d[1], pws->d[1], pwt->d[1], 64, status);
+    } else {
         assert(0);
     }
 
@@ -3921,40 +3947,70 @@ void helper_msa_fmin_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 void helper_msa_fmax_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
-    float_status *status = &env->active_tc.msa_fp_status;
+     float_status *status = &env->active_tc.msa_fp_status;
     wr_t wx, *pwx = &wx;
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-    uint32_t i;
 
     clear_msacsr_cause(env);
 
-    switch (df) {
-    case DF_WORD:
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
-            if (NUMBER_QNAN_PAIR(pws->w[i], pwt->w[i], 32, status)) {
-                MSA_FLOAT_MAXOP(pwx->w[i], max, pws->w[i], pws->w[i], 32);
-            } else if (NUMBER_QNAN_PAIR(pwt->w[i], pws->w[i], 32, status)) {
-                MSA_FLOAT_MAXOP(pwx->w[i], max, pwt->w[i], pwt->w[i], 32);
-            } else {
-                MSA_FLOAT_MAXOP(pwx->w[i], max, pws->w[i], pwt->w[i], 32);
-            }
+    if (df == DF_WORD) {
+
+        if (NUMBER_QNAN_PAIR(pws->w[0], pwt->w[0], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[0], max, pws->w[0], pws->w[0], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[0], pws->w[0], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[0], max, pwt->w[0], pwt->w[0], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[0], max, pws->w[0], pwt->w[0], 32);
         }
-        break;
-    case DF_DOUBLE:
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {
-            if (NUMBER_QNAN_PAIR(pws->d[i], pwt->d[i], 64, status)) {
-                MSA_FLOAT_MAXOP(pwx->d[i], max, pws->d[i], pws->d[i], 64);
-            } else if (NUMBER_QNAN_PAIR(pwt->d[i], pws->d[i], 64, status)) {
-                MSA_FLOAT_MAXOP(pwx->d[i], max, pwt->d[i], pwt->d[i], 64);
-            } else {
-                MSA_FLOAT_MAXOP(pwx->d[i], max, pws->d[i], pwt->d[i], 64);
-            }
+
+        if (NUMBER_QNAN_PAIR(pws->w[1], pwt->w[1], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[1], max, pws->w[1], pws->w[1], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[1], pws->w[1], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[1], max, pwt->w[1], pwt->w[1], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[1], max, pws->w[1], pwt->w[1], 32);
         }
-        break;
-    default:
+
+        if (NUMBER_QNAN_PAIR(pws->w[2], pwt->w[2], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[2], max, pws->w[2], pws->w[2], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[2], pws->w[2], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[2], max, pwt->w[2], pwt->w[2], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[2], max, pws->w[2], pwt->w[2], 32);
+        }
+
+        if (NUMBER_QNAN_PAIR(pws->w[3], pwt->w[3], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[3], max, pws->w[3], pws->w[3], 32);
+        } else if (NUMBER_QNAN_PAIR(pwt->w[3], pws->w[3], 32, status)) {
+            MSA_FLOAT_MAXOP(pwx->w[3], max, pwt->w[3], pwt->w[3], 32);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->w[3], max, pws->w[3], pwt->w[3], 32);
+        }
+
+    } else if (df == DF_DOUBLE) {
+
+        if (NUMBER_QNAN_PAIR(pws->d[0], pwt->d[0], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[0], max, pws->d[0], pws->d[0], 64);
+        } else if (NUMBER_QNAN_PAIR(pwt->d[0], pws->d[0], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[0], max, pwt->d[0], pwt->d[0], 64);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->d[0], max, pws->d[0], pwt->d[0], 64);
+        }
+
+        if (NUMBER_QNAN_PAIR(pws->d[1], pwt->d[1], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[1], max, pws->d[1], pws->d[1], 64);
+        } else if (NUMBER_QNAN_PAIR(pwt->d[1], pws->d[1], 64, status)) {
+            MSA_FLOAT_MAXOP(pwx->d[1], max, pwt->d[1], pwt->d[1], 64);
+        } else {
+            MSA_FLOAT_MAXOP(pwx->d[1], max, pws->d[1], pwt->d[1], 64);
+        }
+
+    } else {
+
         assert(0);
+
     }
 
     check_msacsr_cause(env, GETPC());
@@ -3970,22 +4026,18 @@ void helper_msa_fmax_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-    uint32_t i;
 
     clear_msacsr_cause(env);
 
-    switch (df) {
-    case DF_WORD:
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
-            FMAXMIN_A(max, min, pwx->w[i], pws->w[i], pwt->w[i], 32, status);
-        }
-        break;
-    case DF_DOUBLE:
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {
-            FMAXMIN_A(max, min, pwx->d[i], pws->d[i], pwt->d[i], 64, status);
-        }
-        break;
-    default:
+    if (df == DF_WORD) {
+        FMAXMIN_A(max, min, pwx->w[0], pws->w[0], pwt->w[0], 32, status);
+        FMAXMIN_A(max, min, pwx->w[1], pws->w[1], pwt->w[1], 32, status);
+        FMAXMIN_A(max, min, pwx->w[2], pws->w[2], pwt->w[2], 32, status);
+        FMAXMIN_A(max, min, pwx->w[3], pws->w[3], pwt->w[3], 32, status);
+    } else if (df == DF_DOUBLE) {
+        FMAXMIN_A(max, min, pwx->d[0], pws->d[0], pwt->d[0], 64, status);
+        FMAXMIN_A(max, min, pwx->d[1], pws->d[1], pwt->d[1], 64, status);
+    } else {
         assert(0);
     }
 
-- 
2.7.4


