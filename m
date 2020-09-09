Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93616C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7CA2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKMbpIoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7CA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnwG-0003oS-7M
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnni-0000Es-M7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnf-0002HQ-OH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:26 -0400
Received: by mail-pf1-x442.google.com with SMTP id d6so545294pfn.9
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=y5irF3zqN04rzNfXKfW0upIicpgvBlypjvXV8hRJtkM=;
 b=GKMbpIoXHXNi8Fd6F7Px4I7XGXG/X6wAMFFIuo8l/pi4g0FKNsFmQ8hPMOY5gNFq/Z
 DenQJEqqHBmUf9xmHFoB9yBxLddMdkhn3l2uD4TUq2hnmR38qm3Fnuy+K5N276FstmFD
 iVruyd3Df1DEvWWPw1DvkU2/0Kem0Ov6Av1dQg9T5cfni6UMXwvzu6O5yo68qjKTEP0N
 tDpRPO5H7YF2Y5scE32Z1CtNAdjfRVt/YJOY24gOP1PAj84TVHQw6OUPVJgJ8pHx16MK
 +ZPWjZjdnrU4aHaRyhoQyj95Q6LYSAAtk4e0MpXrRTz/vwwZm4IVw4TGEmuIjvpWh5ea
 vatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y5irF3zqN04rzNfXKfW0upIicpgvBlypjvXV8hRJtkM=;
 b=BtWMdfrX/fGHtHKnCiKqa/e6egAbTWgxrbHR7Sj48yAKQTL4Ja9XtTv5pqSqp9Z2R4
 0UXoYSb7W9BpbWMxPgpGzvh3OrDSjel4EhZe3+xTqhQzbg9BLoV4lLbPNHm4vdPeu/xw
 LK4xh9S16V/N8+SLrsPZCDD75r8ZZLdQfz7jr3EVVBLn6iFWweV2aBjdtsLrew8YXc1e
 zqnRoq1tXgsQE1D/jVO5gmzlMuQGbCW/pxSSQktwq+SUIjfjCPCCVl2fllmrsFHiHhOT
 2IQBOt0wXqRMCe+OVXjtDpQBzM2i+Yj8u2KE8JVEDcA5DOdh/3wAkV3nqXakELK+4CBy
 WRrQ==
X-Gm-Message-State: AOAM5316nRJCD0SBZAtvjzhaE8PoV/e59kbDYJ0D0tBelqqF8IBqOiLu
 onMxcXJvu8lQGqFKj4O7MlYHwgyjCwtStQ==
X-Google-Smtp-Source: ABdhPJwyoSAuZ+KxTyEKKRWDcvX7Rwc32V19yPROHAlk0rju7ExlxSFQaeaZiP3v03CNc2vokENonQ==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr1008704pgv.106.1599610641777; 
 Tue, 08 Sep 2020 17:17:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/43] tcg: Use tcg_constant_{i32, i64,
 vec} with gvec expanders
Date: Tue,  8 Sep 2020 17:16:30 -0700
Message-Id: <20200909001647.532249-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |   1 +
 tcg/tcg-op-gvec.c | 125 ++++++++++++++++++----------------------------
 tcg/tcg.c         |   8 +++
 3 files changed, 58 insertions(+), 76 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index aa7b0ba163..309460704a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1081,6 +1081,7 @@ static inline TCGv_i64 tcg_constant_i64(int64_t val)
 }
 
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
+TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
 #if UINTPTR_MAX == UINT32_MAX
 # define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i32((intptr_t)(x)))
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index ddbe06b71a..80eb53c770 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -115,7 +115,7 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
                         gen_helper_gvec_2 *fn)
 {
     TCGv_ptr a0, a1;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -127,7 +127,6 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
 
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with two vector operands
@@ -137,7 +136,7 @@ void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
                          gen_helper_gvec_2i *fn)
 {
     TCGv_ptr a0, a1;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -149,7 +148,6 @@ void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
 
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with three vector operands.  */
@@ -158,7 +156,7 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         gen_helper_gvec_3 *fn)
 {
     TCGv_ptr a0, a1, a2;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -173,7 +171,6 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with four vector operands.  */
@@ -182,7 +179,7 @@ void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         int32_t data, gen_helper_gvec_4 *fn)
 {
     TCGv_ptr a0, a1, a2, a3;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -200,7 +197,6 @@ void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with five vector operands.  */
@@ -209,7 +205,7 @@ void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t maxsz, int32_t data, gen_helper_gvec_5 *fn)
 {
     TCGv_ptr a0, a1, a2, a3, a4;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -230,7 +226,6 @@ void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
     tcg_temp_free_ptr(a4);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with three vector operands
@@ -240,7 +235,7 @@ void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
                         int32_t data, gen_helper_gvec_2_ptr *fn)
 {
     TCGv_ptr a0, a1;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -252,7 +247,6 @@ void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
 
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with three vector operands
@@ -262,7 +256,7 @@ void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         int32_t data, gen_helper_gvec_3_ptr *fn)
 {
     TCGv_ptr a0, a1, a2;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -277,7 +271,6 @@ void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with four vector operands
@@ -288,7 +281,7 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         gen_helper_gvec_4_ptr *fn)
 {
     TCGv_ptr a0, a1, a2, a3;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -306,7 +299,6 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with five vector operands
@@ -317,7 +309,7 @@ void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         gen_helper_gvec_5_ptr *fn)
 {
     TCGv_ptr a0, a1, a2, a3, a4;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -338,7 +330,6 @@ void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
     tcg_temp_free_ptr(a4);
-    tcg_temp_free_i32(desc);
 }
 
 /* Return true if we want to implement something of OPRSZ bytes
@@ -602,9 +593,9 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
                 || (TCG_TARGET_REG_BITS == 64
                     && (in_c == 0 || in_c == -1
                         || !check_size_impl(oprsz, 4)))) {
-                t_64 = tcg_const_i64(in_c);
+                t_64 = tcg_constant_i64(in_c);
             } else {
-                t_32 = tcg_const_i32(in_c);
+                t_32 = tcg_constant_i32(in_c);
             }
         }
 
@@ -628,15 +619,14 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
     /* Otherwise implement out of line.  */
     t_ptr = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_ptr, cpu_env, dofs);
-    t_desc = tcg_const_i32(simd_desc(oprsz, maxsz, 0));
+    t_desc = tcg_constant_i32(simd_desc(oprsz, maxsz, 0));
 
     if (vece == MO_64) {
         if (in_64) {
             gen_helper_gvec_dup64(t_ptr, t_desc, in_64);
         } else {
-            t_64 = tcg_const_i64(in_c);
+            t_64 = tcg_constant_i64(in_c);
             gen_helper_gvec_dup64(t_ptr, t_desc, t_64);
-            tcg_temp_free_i64(t_64);
         }
     } else {
         typedef void dup_fn(TCGv_ptr, TCGv_i32, TCGv_i32);
@@ -648,24 +638,23 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
 
         if (in_32) {
             fns[vece](t_ptr, t_desc, in_32);
-        } else {
+        } else if (in_64) {
             t_32 = tcg_temp_new_i32();
-            if (in_64) {
-                tcg_gen_extrl_i64_i32(t_32, in_64);
-            } else if (vece == MO_8) {
-                tcg_gen_movi_i32(t_32, in_c & 0xff);
-            } else if (vece == MO_16) {
-                tcg_gen_movi_i32(t_32, in_c & 0xffff);
-            } else {
-                tcg_gen_movi_i32(t_32, in_c);
-            }
+            tcg_gen_extrl_i64_i32(t_32, in_64);
             fns[vece](t_ptr, t_desc, t_32);
             tcg_temp_free_i32(t_32);
+        } else {
+            if (vece == MO_8) {
+                in_c &= 0xff;
+            } else if (vece == MO_16) {
+                in_c &= 0xffff;
+            }
+            t_32 = tcg_constant_i32(in_c);
+            fns[vece](t_ptr, t_desc, t_32);
         }
     }
 
     tcg_temp_free_ptr(t_ptr);
-    tcg_temp_free_i32(t_desc);
     return;
 
  done:
@@ -1215,10 +1204,9 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
             if (g->fno) {
                 tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
             } else {
-                TCGv_i64 tcg_c = tcg_const_i64(c);
+                TCGv_i64 tcg_c = tcg_constant_i64(c);
                 tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz,
                                     maxsz, c, g->fnoi);
-                tcg_temp_free_i64(tcg_c);
             }
             oprsz = maxsz;
         }
@@ -1712,16 +1700,14 @@ static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
 
 void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_8, 0x80));
     gen_addv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_16, 0x8000));
     gen_addv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
@@ -1805,9 +1791,8 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(c);
+    TCGv_i64 tmp = tcg_constant_i64(c);
     tcg_gen_gvec_adds(vece, dofs, aofs, tmp, oprsz, maxsz);
-    tcg_temp_free_i64(tmp);
 }
 
 static const TCGOpcode vecop_list_sub[] = { INDEX_op_sub_vec, 0 };
@@ -1865,16 +1850,14 @@ static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
 
 void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_8, 0x80));
     gen_subv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_16, 0x8000));
     gen_subv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
@@ -1985,9 +1968,8 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(c);
+    TCGv_i64 tmp = tcg_constant_i64(c);
     tcg_gen_gvec_muls(vece, dofs, aofs, tmp, oprsz, maxsz);
-    tcg_temp_free_i64(tmp);
 }
 
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2044,18 +2026,16 @@ void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
 
 static void tcg_gen_usadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    TCGv_i32 max = tcg_const_i32(-1);
+    TCGv_i32 max = tcg_constant_i32(-1);
     tcg_gen_add_i32(d, a, b);
     tcg_gen_movcond_i32(TCG_COND_LTU, d, d, a, max, d);
-    tcg_temp_free_i32(max);
 }
 
 static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 max = tcg_const_i64(-1);
+    TCGv_i64 max = tcg_constant_i64(-1);
     tcg_gen_add_i64(d, a, b);
     tcg_gen_movcond_i64(TCG_COND_LTU, d, d, a, max, d);
-    tcg_temp_free_i64(max);
 }
 
 void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2088,18 +2068,16 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
 
 static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    TCGv_i32 min = tcg_const_i32(0);
+    TCGv_i32 min = tcg_constant_i32(0);
     tcg_gen_sub_i32(d, a, b);
     tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
-    tcg_temp_free_i32(min);
 }
 
 static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 min = tcg_const_i64(0);
+    TCGv_i64 min = tcg_constant_i64(0);
     tcg_gen_sub_i64(d, a, b);
     tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
-    tcg_temp_free_i64(min);
 }
 
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2260,16 +2238,14 @@ static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
 
 void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_8, 0x80));
     gen_negv_mask(d, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_16, 0x8000));
     gen_negv_mask(d, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
@@ -2538,9 +2514,8 @@ void tcg_gen_gvec_ands(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(dup_const(vece, c));
+    TCGv_i64 tmp = tcg_constant_i64(dup_const(vece, c));
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ands);
-    tcg_temp_free_i64(tmp);
 }
 
 static const GVecGen2s gop_xors = {
@@ -2563,9 +2538,8 @@ void tcg_gen_gvec_xors(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(dup_const(vece, c));
+    TCGv_i64 tmp = tcg_constant_i64(dup_const(vece, c));
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_xors);
-    tcg_temp_free_i64(tmp);
 }
 
 static const GVecGen2s gop_ors = {
@@ -2588,9 +2562,8 @@ void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,
                       int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(dup_const(vece, c));
+    TCGv_i64 tmp = tcg_constant_i64(dup_const(vece, c));
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ors);
-    tcg_temp_free_i64(tmp);
 }
 
 void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
@@ -3078,9 +3051,9 @@ static void tcg_gen_shlv_mod_vec(unsigned vece, TCGv_vec d,
                                  TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_shlv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3141,9 +3114,9 @@ static void tcg_gen_shrv_mod_vec(unsigned vece, TCGv_vec d,
                                  TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_shrv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3204,9 +3177,9 @@ static void tcg_gen_sarv_mod_vec(unsigned vece, TCGv_vec d,
                                  TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_sarv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3267,9 +3240,9 @@ static void tcg_gen_rotlv_mod_vec(unsigned vece, TCGv_vec d,
                                   TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_rotlv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3326,9 +3299,9 @@ static void tcg_gen_rotrv_mod_vec(unsigned vece, TCGv_vec d,
                                   TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_rotrv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0ce45fd123..b63da0b603 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1416,6 +1416,14 @@ TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val)
     return temp_tcgv_vec(tcg_constant_internal(type, val));
 }
 
+TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val)
+{
+    TCGTemp *t = tcgv_vec_temp(match);
+
+    tcg_debug_assert(t->temp_allocated != 0);
+    return tcg_constant_vec(t->base_type, vece, val);
+}
+
 TCGv_i32 tcg_const_i32(int32_t val)
 {
     TCGv_i32 t0;
-- 
2.25.1


