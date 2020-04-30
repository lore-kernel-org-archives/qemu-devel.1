Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A950C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695FB20787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSmHwkAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695FB20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE10-0006IE-IJ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDef-0002rv-W0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe8-0001Uo-Em
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDe5-0001Lh-Bx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so8182729wrs.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Fs4PAxS9dtCpCFLIxob1CFFrrH7DolbHDsxKsK9olg=;
 b=vSmHwkAWmXhR/Z4EKoX+jfwJ8EfXjGQxAlrWZyCCTW+pkjVuwgfU+Uwc3OH+rTnJeY
 7JFvf9YwH7q5pbvY5fmc0H6OcnSGu3e2Z4HLspRfqvTkv21h0aQfGb27rHaaFqmwuSBT
 CrPsvHhBywEwW6QBOI3xJLP9yqNhKmhiWmZAjXOZTGWlWWcr3WZvhNYkoH11oky7muXl
 5IbDcbV7j1lpbNphUuBQyYBVkjAWvjq7VTtvAFfreyS4MYAqMUDLNyzosMAfIoxxk8AM
 BCXSBgvUfH1wwYZ5uMbxeJjd6DRq8z+GCPpAWglD0Vjkt9xxyceLahTMbm2pdNbZvOGG
 /rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Fs4PAxS9dtCpCFLIxob1CFFrrH7DolbHDsxKsK9olg=;
 b=fUlNiks7jNyPpQ/zCHZwR5rJUn9OJqWZydVJB9H37uxiAnGTwshZIz/d98XFMxknUb
 z+cfMVr0tFE4Nsm50cyS51xVezDzfscM2NAYuj8crPZ5qM8sYR0N7q+6yiEJuKmpS6tZ
 hoRQmkJUaWgu3l5PysLpibqhyGUbWlSVH7qp7eL94ASKBnYg9g0WliJv5rQkj3zp3GWN
 NleRKHlXIqwcp5w+X/Iq1VRe6oMmiWxyO9j9lBmZSdDz6WkTpmk20//E4+wwsoGIGB0R
 TgnwdJvAazTdLTzUJ5intR6LDUXgN8iH3JBNe1KZiHbDBmB1uIdiIXaYPU8w8sydcajT
 QAuA==
X-Gm-Message-State: AGi0PuaXZBi2OINaPSpPfXMPX41Q8qS8B44VOVTDuaMWZZ1HFk4kNpp1
 0FFThVo+XGOooVRP5OOzrALDoAa4WuIPgg==
X-Google-Smtp-Source: APiQypKb7LGDoxXWCOOQPQy5VL+ZGQF531zGJRHLoStmgChtkSvIr5y2/eyNzFTufbw8YWiPjh+gcg==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr4938260wrw.291.1588270247892; 
 Thu, 30 Apr 2020 11:10:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 33/36] target/arm: Convert Neon fp VMUL, VMLA,
 VMLS 3-reg-same insns to decodetree
Date: Thu, 30 Apr 2020 19:10:00 +0100
Message-Id: <20200430181003.21682-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon integer VMUL, VMLA, and VMLS 3-reg-same inssn to
decodetree.

Since VMLA and VMLS accumulate into the destination register, we add
a reads_vd parameter to do_3same_fp() which tells it to load the
old value into vd before calling the callback function, in the same
way that the translate-vfp.inc.c do_vfp_3op_sp() and do_vfp_3op_dp()
functions work.

This conversion fixes in passing an underdecoding for VMUL
(originally reported by Fredrik Strupe <fredrik@strupe.net>): bit 1
of the 'size' field must be 0.  The old decoder didn't enforce this,
but the decodetree pattern does.

The gen_VMLA_fp_reg() function performs the addition operation
with the operands in the opposite order to the old decoder:
since Neon sets 'default NaN mode' float32_add operations are
commutative so there is no behaviour difference, but putting
them this way around matches the Arm ARM pseudocode and the
required operation order for the subtraction in gen_VMLS_fp_reg().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 49 +++++++++++++++++++++++++++------
 target/arm/translate.c          | 17 +-----------
 target/arm/neon-dp.decode       |  3 ++
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 30832309924..47879bbb6c9 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1322,9 +1322,15 @@ static bool trans_VQRDMULH_3s(DisasContext *s, arg_3same *a)
     return do_3same_32(s, a, fns[a->size - 1]);
 }
 
-static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
+static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn,
+                        bool reads_vd)
 {
-    /* FP operations handled elementwise 32 bits at a time */
+    /*
+     * FP operations handled elementwise 32 bits at a time.
+     * If reads_vd is true then the old value of Vd will be
+     * loaded before calling the callback function. This is
+     * used for multiply-accumulate type operations.
+     */
     TCGv_i32 tmp, tmp2;
     int pass;
 
@@ -1350,9 +1356,16 @@ static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
         tmp = neon_load_reg(a->vn, pass);
         tmp2 = neon_load_reg(a->vm, pass);
-        fn(tmp, tmp, tmp2, fpstatus);
+        if (reads_vd) {
+            TCGv_i32 tmp_rd = neon_load_reg(a->vd, pass);
+            fn(tmp_rd, tmp, tmp2, fpstatus);
+            neon_store_reg(a->vd, pass, tmp_rd);
+            tcg_temp_free_i32(tmp);
+        } else {
+            fn(tmp, tmp, tmp2, fpstatus);
+            neon_store_reg(a->vd, pass, tmp);
+        }
         tcg_temp_free_i32(tmp2);
-        neon_store_reg(a->vd, pass, tmp);
     }
     tcg_temp_free_ptr(fpstatus);
     return true;
@@ -1362,19 +1375,37 @@ static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
  * For all the functions using this macro, size == 1 means fp16,
  * which is an architecture extension we don't implement yet.
  */
-#define DO_3S_FP(INSN,FUNC)                                         \
+#define DO_3S_FP(INSN,FUNC,READS_VD)                                \
     static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
     {                                                               \
         if (a->size != 0) {                                         \
             /* TODO fp16 support */                                 \
             return false;                                           \
         }                                                           \
-        return do_3same_fp(s, a, FUNC);                             \
+        return do_3same_fp(s, a, FUNC, READS_VD);                   \
     }
 
-DO_3S_FP(VADD, gen_helper_vfp_adds)
-DO_3S_FP(VSUB, gen_helper_vfp_subs)
-DO_3S_FP(VABD, gen_helper_neon_abd_f32)
+DO_3S_FP(VADD, gen_helper_vfp_adds, false)
+DO_3S_FP(VSUB, gen_helper_vfp_subs, false)
+DO_3S_FP(VABD, gen_helper_neon_abd_f32, false)
+DO_3S_FP(VMUL, gen_helper_vfp_muls, false)
+
+static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
+                            TCGv_ptr fpstatus)
+{
+    gen_helper_vfp_muls(vn, vn, vm, fpstatus);
+    gen_helper_vfp_adds(vd, vd, vn, fpstatus);
+}
+
+static void gen_VMLS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
+                            TCGv_ptr fpstatus)
+{
+    gen_helper_vfp_muls(vn, vn, vm, fpstatus);
+    gen_helper_vfp_subs(vd, vd, vn, fpstatus);
+}
+
+DO_3S_FP(VMLA, gen_VMLA_fp_3s, true)
+DO_3S_FP(VMLS, gen_VMLS_fp_3s, true)
 
 static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5ae982ee253..57343daa10a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4785,6 +4785,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VPADD_VQRDMLAH:
         case NEON_3R_VQDMULH_VQRDMULH:
         case NEON_3R_FLOAT_ARITH:
+        case NEON_3R_FLOAT_MULTIPLY:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4831,22 +4832,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         tmp = neon_load_reg(rn, pass);
         tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_MULTIPLY:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            gen_helper_vfp_muls(tmp, tmp, tmp2, fpstatus);
-            if (!u) {
-                tcg_temp_free_i32(tmp2);
-                tmp2 = neon_load_reg(rd, pass);
-                if (size == 0) {
-                    gen_helper_vfp_adds(tmp, tmp, tmp2, fpstatus);
-                } else {
-                    gen_helper_vfp_subs(tmp, tmp2, tmp, fpstatus);
-                }
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
         case NEON_3R_FLOAT_CMP:
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 378c2dd5105..96866c03db4 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -165,5 +165,8 @@ VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
 VSUB_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
 VPADD_fp_3s      1111 001 1 0 . 0 . .... .... 1101 ... 0 .... @3same_fp_q0
 VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VMLA_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
+VMLS_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 1 .... @3same_fp
+VMUL_fp_3s       1111 001 1 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
 VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
 VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
-- 
2.20.1


