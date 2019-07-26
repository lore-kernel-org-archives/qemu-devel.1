Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD63C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2182173B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LERFRk9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2182173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4NT-0004fT-Tp
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Me-0001tO-Mf
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Ma-0007I4-6H
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4MZ-00079o-07
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id u14so24877361pfn.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7SlZHRojqaDrAigAWryRfk9aPa/pHb9UCpOA1gKKEjI=;
 b=LERFRk9HPSpHkSWvqJP4AF45a9EYb5Hly5D8dtugH9nx6e5yN/PBTDdNVSaC2Rts31
 I9XoErtG+r8XTfVdEckBmiGAPqhWfBMELsm6p4JKVeKzA58YEOSL3yC3rAHZWj7pj/3b
 vH8LgHNeGhFo8VFDCDNmA50gkU7fx0GIfY3T5weG71XGK/mSdw0NhZmlARR/ExKUUFJr
 J395y0zBgnnyRcfCAfQR/WXkiG9p1IlwCoATCETpAjkokWM7Pxz4+HXASJTxNKMle2uq
 pK0IOLV8xEMXWsFX0ee+zgX5VDbmQv0h+Z/lRHo/bhji6L0C/mQLRWIFFw5iZGgtNHKp
 4/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7SlZHRojqaDrAigAWryRfk9aPa/pHb9UCpOA1gKKEjI=;
 b=DuogEeP2ac3Hmjo4QpEkgUL/wGsdVEje0gkTSx0bkRxNgR9shSoDe0Hc79B7jtf11l
 gb9tNqnJZ706degd+Fd72kIFx/sd2wXfnz/11oFVobrCvrAyjGIF4HMQgeaZXmYwwzel
 ABbGXuGSlwSCeX8LrdqK0YwrnpPdTjGHH24Zz6a/8gTCUBVHQN7ypruPd8GxZx7x/gZ1
 kHnN1kzK5xkzdz0eUMxkB3O++qYmSbRNkBd+3Kkw8DNsTVhMmxr8HAIyBpHkqNek/VRf
 pHn+SFuRoFWBkrsXM6rLfuanbKcTbEduPfK5Rte6gDfkEHYucyAgg8vexZiNJPxxTBz5
 woXQ==
X-Gm-Message-State: APjAAAXbOXG/+ZjcXYJ16MfcEQmzi3ZwVMFISsfO8RfJogXBJQBiWL/v
 Uux21wHEeogmjgdI3g8t4brzKxwLc9c=
X-Google-Smtp-Source: APXvYqwZ10jR7S3Jw9vaIEJhprcYYfEB1OiUa6mgFvRr2eLx6b46KUmjgNSwz8kVpt0glC8pKj6AEQ==
X-Received: by 2002:a63:2252:: with SMTP id t18mr92745343pgm.5.1564163436713; 
 Fri, 26 Jul 2019 10:50:36 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:27 -0700
Message-Id: <20190726175032.6769-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 02/67] target/arm: Remove offset argument to
 gen_exception_insn
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The address of the current insn is still available in s->base.pc_next.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c |  6 +++---
 target/arm/translate.c         | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 092eb5ec53..e7389bc057 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -96,10 +96,10 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 {
     if (s->fp_excp_el) {
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+            gen_exception_insn(s, EXCP_NOCP, syn_uncategorized(),
                                s->fp_excp_el);
         } else {
-            gen_exception_insn(s, 4, EXCP_UDEF,
+            gen_exception_insn(s, EXCP_UDEF,
                                syn_fp_access_trap(1, 0xe, false),
                                s->fp_excp_el);
         }
@@ -108,7 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+        gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
                            default_exception_el(s));
         return false;
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462b21..33f78296eb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1247,11 +1247,11 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_insn(DisasContext *s, int offset, int excp,
-                               int syn, uint32_t target_el)
+static void gen_exception_insn(DisasContext *s, int excp, int syn,
+                               uint32_t target_el)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next);
     gen_exception(excp, syn, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1298,7 +1298,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, s->thumb ? 2 : 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -3175,7 +3175,7 @@ static bool msr_banked_access_decode(DisasContext *s, int r, int sysm, int rn,
 
 undef:
     /* If we get here then some access check did not pass */
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(), exc_target);
+    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(), exc_target);
     return false;
 }
 
@@ -3569,7 +3569,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -4840,7 +4840,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -6968,7 +6968,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     }
 
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -7091,7 +7091,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
         off_rm = vfp_reg_offset(0, rm);
     }
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -7584,7 +7584,7 @@ static void gen_srs(DisasContext *s,
      * For the UNPREDICTABLE cases we choose to UNDEF.
      */
     if (s->current_el == 1 && !s->ns && mode == ARM_CPU_MODE_MON) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(), 3);
+        gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(), 3);
         return;
     }
 
@@ -7620,7 +7620,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+        gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
                            default_exception_el(s));
         return;
     }
@@ -7711,7 +7711,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
      * UsageFault exception.
      */
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        gen_exception_insn(s, 4, EXCP_INVSTATE, syn_uncategorized(),
+        gen_exception_insn(s, EXCP_INVSTATE, syn_uncategorized(),
                            default_exception_el(s));
         return;
     }
@@ -9254,7 +9254,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+            gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
                                default_exception_el(s));
             break;
         }
@@ -10288,7 +10288,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
 
             /* All other insns: NOCP */
-            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+            gen_exception_insn(s, EXCP_NOCP, syn_uncategorized(),
                                default_exception_el(s));
             break;
         }
@@ -10972,7 +10972,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -11809,7 +11809,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, 2, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
-- 
2.17.1


