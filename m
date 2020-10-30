Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C985BC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DC820739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUI9yWx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DC820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKGE-0000VI-0L
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7l-0005Kn-Pa
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:41 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7i-0005vy-II
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id h6so3924595pgk.4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 19:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/srvkEMVHhjFuX4GEztdA7BtJNAKhyCjy2OjjjYFdsY=;
 b=RUI9yWx5Ixh8M4p1inbRmcRCRBOSB1rxWNuVyYBrxxZZzmNzXSaPvYj9pccDCn7B6D
 dk/WwcOF1Ff4CCgVyw89CBegAP/BhIx4MKGiGsNz6SO1HyYTSQPjLg/t4LArloBYb0tX
 3o/stimnlG8DZAAOu1b8HRRYJ3qw/CSo95hIFhf8LAkTp3IBKzstiQeZYtQJaO/3y0tJ
 5mtEvwbKr4jZ3b4NzSquIHXJXWBofKA/qZ7idF0/EUXUtwPaywzn7XMWPPbaPoBfNiGI
 pXqtoM7CDdK0+QM9tOTx5hGkbd/3yCj8jauni6wzzygK4Y0jTfwHOMaf+WU17ZKxqy5b
 hXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/srvkEMVHhjFuX4GEztdA7BtJNAKhyCjy2OjjjYFdsY=;
 b=Np98nVNhTMrpHwpHNP/EuFthRKvNEeqG7F+WbBs4iBBe7BAPchni7ebhCGnEAKk5Dq
 wgNQWqB/S0YAuv30zCKhh8y58v1HxR7OcK+Rstk7eEsNTiyAfa6GO5S9lwttxSp2Kd3Q
 5kcrjbdwRtTjNRrTqnfCBDzsbWOnhhbyj+q9p7oCR8Kk1G8fm3UQnKXHqf5YSCWeeU2d
 bSZT60o/uYRbrdv9TWjGAXuG3AaQyU06pcxVMW8XiLkq1Y/S8G0mXQqXDRMB8CEUCn04
 oOKsXDJZcnEtEqfsC+DMUfStyeKkULH1zJBbjWt1F21KA5G+GeU9nPq0HgwEINA6fN6p
 Qn1g==
X-Gm-Message-State: AOAM530tjoeuqNevJXA36U/73WfxabL1LXufC+3HXDrZOvNjTbG13bBM
 IBRjtvkk+kJznGcJSAEWwAxiHAt2lSPatg==
X-Google-Smtp-Source: ABdhPJzKzloWAgDl8KsMNg+x9WyjzJ9YGL3SskZv9lNO6pX6C5tMytxDEyhmrven5nN75H7GzBQdBA==
X-Received: by 2002:a17:90a:1903:: with SMTP id 3mr127263pjg.74.1604024795293; 
 Thu, 29 Oct 2020 19:26:35 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b7sm4446517pfr.171.2020.10.29.19.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 19:26:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/11] target/arm: Improve do_prewiden_3d
Date: Thu, 29 Oct 2020 19:26:18 -0700
Message-Id: <20201030022618.785675-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030022618.785675-1-richard.henderson@linaro.org>
References: <20201030022618.785675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can use proper widening loads to extend 32-bit inputs,
and skip the "widenfn" step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c          |  6 +++
 target/arm/translate-neon.c.inc | 66 ++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7611c1f0f1..29ea1eb781 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1183,6 +1183,12 @@ static void read_neon_element64(TCGv_i64 dest, int reg, int ele, MemOp memop)
     long off = neon_element_offset(reg, ele, memop);
 
     switch (memop) {
+    case MO_SL:
+        tcg_gen_ld32s_i64(dest, cpu_env, off);
+        break;
+    case MO_UL:
+        tcg_gen_ld32u_i64(dest, cpu_env, off);
+        break;
     case MO_Q:
         tcg_gen_ld_i64(dest, cpu_env, off);
         break;
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 1c16c56e7e..59368cb243 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1788,11 +1788,10 @@ static bool trans_Vimm_1r(DisasContext *s, arg_1reg_imm *a)
 static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
                            NeonGenWidenFn *widenfn,
                            NeonGenTwo64OpFn *opfn,
-                           bool src1_wide)
+                           int src1_mop, int src2_mop)
 {
     /* 3-regs different lengths, prewidening case (VADDL/VSUBL/VAADW/VSUBW) */
     TCGv_i64 rn0_64, rn1_64, rm_64;
-    TCGv_i32 rm;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -1804,12 +1803,12 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
         return false;
     }
 
-    if (!widenfn || !opfn) {
+    if (!opfn) {
         /* size == 3 case, which is an entirely different insn group */
         return false;
     }
 
-    if ((a->vd & 1) || (src1_wide && (a->vn & 1))) {
+    if ((a->vd & 1) || (src1_mop == MO_Q && (a->vn & 1))) {
         return false;
     }
 
@@ -1821,40 +1820,48 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     rn1_64 = tcg_temp_new_i64();
     rm_64 = tcg_temp_new_i64();
 
-    if (src1_wide) {
-        read_neon_element64(rn0_64, a->vn, 0, MO_64);
+    if (src1_mop >= 0) {
+        read_neon_element64(rn0_64, a->vn, 0, src1_mop);
     } else {
         TCGv_i32 tmp = tcg_temp_new_i32();
         read_neon_element32(tmp, a->vn, 0, MO_32);
         widenfn(rn0_64, tmp);
         tcg_temp_free_i32(tmp);
     }
-    rm = tcg_temp_new_i32();
-    read_neon_element32(rm, a->vm, 0, MO_32);
+    if (src2_mop >= 0) {
+        read_neon_element64(rm_64, a->vm, 0, src2_mop);
+    } else {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        read_neon_element32(tmp, a->vm, 0, MO_32);
+        widenfn(rm_64, tmp);
+        tcg_temp_free_i32(tmp);
+    }
 
-    widenfn(rm_64, rm);
-    tcg_temp_free_i32(rm);
     opfn(rn0_64, rn0_64, rm_64);
 
     /*
      * Load second pass inputs before storing the first pass result, to
      * avoid incorrect results if a narrow input overlaps with the result.
      */
-    if (src1_wide) {
-        read_neon_element64(rn1_64, a->vn, 1, MO_64);
+    if (src1_mop >= 0) {
+        read_neon_element64(rn1_64, a->vn, 1, src1_mop);
     } else {
         TCGv_i32 tmp = tcg_temp_new_i32();
         read_neon_element32(tmp, a->vn, 1, MO_32);
         widenfn(rn1_64, tmp);
         tcg_temp_free_i32(tmp);
     }
-    rm = tcg_temp_new_i32();
-    read_neon_element32(rm, a->vm, 1, MO_32);
+    if (src2_mop >= 0) {
+        read_neon_element64(rm_64, a->vm, 1, src2_mop);
+    } else {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        read_neon_element32(tmp, a->vm, 1, MO_32);
+        widenfn(rm_64, tmp);
+        tcg_temp_free_i32(tmp);
+    }
 
     write_neon_element64(rn0_64, a->vd, 0, MO_64);
 
-    widenfn(rm_64, rm);
-    tcg_temp_free_i32(rm);
     opfn(rn1_64, rn1_64, rm_64);
     write_neon_element64(rn1_64, a->vd, 1, MO_64);
 
@@ -1865,14 +1872,13 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     return true;
 }
 
-#define DO_PREWIDEN(INSN, S, EXT, OP, SRC1WIDE)                         \
+#define DO_PREWIDEN(INSN, S, OP, SRC1WIDE, SIGN)                        \
     static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
     {                                                                   \
         static NeonGenWidenFn * const widenfn[] = {                     \
             gen_helper_neon_widen_##S##8,                               \
             gen_helper_neon_widen_##S##16,                              \
-            tcg_gen_##EXT##_i32_i64,                                    \
-            NULL,                                                       \
+            NULL, NULL,                                                 \
         };                                                              \
         static NeonGenTwo64OpFn * const addfn[] = {                     \
             gen_helper_neon_##OP##l_u16,                                \
@@ -1880,18 +1886,20 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
             tcg_gen_##OP##_i64,                                         \
             NULL,                                                       \
         };                                                              \
-        return do_prewiden_3d(s, a, widenfn[a->size],                   \
-                              addfn[a->size], SRC1WIDE);                \
+        int narrow_mop = a->size == MO_32 ? MO_32 | SIGN : -1;          \
+        return do_prewiden_3d(s, a, widenfn[a->size], addfn[a->size],   \
+                              SRC1WIDE ? MO_Q : narrow_mop,             \
+                              narrow_mop);                              \
     }
 
-DO_PREWIDEN(VADDL_S, s, ext, add, false)
-DO_PREWIDEN(VADDL_U, u, extu, add, false)
-DO_PREWIDEN(VSUBL_S, s, ext, sub, false)
-DO_PREWIDEN(VSUBL_U, u, extu, sub, false)
-DO_PREWIDEN(VADDW_S, s, ext, add, true)
-DO_PREWIDEN(VADDW_U, u, extu, add, true)
-DO_PREWIDEN(VSUBW_S, s, ext, sub, true)
-DO_PREWIDEN(VSUBW_U, u, extu, sub, true)
+DO_PREWIDEN(VADDL_S, s, add, false, MO_SIGN)
+DO_PREWIDEN(VADDL_U, u, add, false, 0)
+DO_PREWIDEN(VSUBL_S, s, sub, false, MO_SIGN)
+DO_PREWIDEN(VSUBL_U, u, sub, false, 0)
+DO_PREWIDEN(VADDW_S, s, add, true, MO_SIGN)
+DO_PREWIDEN(VADDW_U, u, add, true, 0)
+DO_PREWIDEN(VSUBW_S, s, sub, true, MO_SIGN)
+DO_PREWIDEN(VSUBW_U, u, sub, true, 0)
 
 static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
                          NeonGenTwo64OpFn *opfn, NeonGenNarrowFn *narrowfn)
-- 
2.25.1


