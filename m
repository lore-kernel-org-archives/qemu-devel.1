Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FD0C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9D5208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WG28M6n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9D5208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0x4-0002sJ-Gq
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sn-0003ES-Mi
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0sm-0004i7-Pb
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:17 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sm-0004eg-7v
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:16 -0400
Received: by mail-pl1-x643.google.com with SMTP id s10so5199599plr.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SGz8AkTuw4m2K0/Y+X8G2iZzicXAVy+z9HaUzJVjiyw=;
 b=WG28M6n9jGMfmZK8eGrGKV06ifVIOSEuxewCJp/5bxAzk8ucgmF9rf53j1LSXLrR7R
 JzSW4fcibt9ULmZdtmnKuQpUTV1a9ZwexDl0xsNfVO/sX6RPaq5wZr9Y014gsuPdQm2s
 KOsXVMCi+b6/ziCiTSRgmRar7ZRr/XuhEDgPTPhc5BZih7abHnN2sOLZT6dfrFu6jegy
 8xM9Ox6P7kWjl9wyrs9txOKke7J1VKU4Nrisky9rIGh0/K7fveqcYVDVqsnm6uza5f0N
 rOjP+J5kBUaf8B1UN0wqvuTU1aPOjbytgjb3GO9c4Rj20eccV8AZlnWSQCnMJbh+6J2s
 ZS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SGz8AkTuw4m2K0/Y+X8G2iZzicXAVy+z9HaUzJVjiyw=;
 b=dMIV0F3F00nPTJdtK8X+ztvvBeEDrPKMavPhZ5KGYchZOfOdiiZ5VUsFeyFscNYWnd
 q/kqV2/WbWeiVUp+XQc3jn/rKvxiR0pdMEHH3/RuUvxs/4i2PvFmNQ70bZ0xonX3ff/p
 hxroDuBGElOEs/9Wo9SbuAX1oqquAmpYc7YOU+uipW6odZsEQwwikv4flCYwInVey5J8
 93vwYa5JXv7R/OCmzoqjx78ts/vubspmjSVSLQQcBtkBndIgX4gqA4RxETeMSLfgdiIu
 goBTTHUOUUdcrkFg7zUcw7dvSxJxn9x/oDOEj8Vq/Ot75AoEDJRxG+7epQivetNU/lUa
 /q+w==
X-Gm-Message-State: AGi0PuYsijIKe1HcKQJL0+fCeMEIwvUCvTPa+4+BKOlUW/7rjCmvzYJf
 6LTjnm+lX0CzwqE9kBNlNJm7LiuVMBA=
X-Google-Smtp-Source: APiQypJxx6oH48P0baljlIAHDZpSS43ubunxxmwSp6g+eJz+KCc3zvWHvMFFFwPfFibBwY+N2Kmm6g==
X-Received: by 2002:a17:902:a60a:: with SMTP id
 u10mr10666516plq.249.1588459514622; 
 Sat, 02 May 2020 15:45:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/15] target/arm: Wrap vector mla/mls GVecGen3 in
 GVecGen3Fn
Date: Sat,  2 May 2020 15:44:55 -0700
Message-Id: <20200502224503.2282-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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

Provide a functional interface for the vector expansion.
This fits better with the existing set of helpers that
we provide for other operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |   7 ++-
 target/arm/translate-a64.c |   4 +-
 target/arm/translate.c     | 124 ++++++++++++++++++++-----------------
 3 files changed, 74 insertions(+), 61 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 20ec9cedd7..4fbcdf1294 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -286,8 +286,11 @@ void gen_gvec_cle0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_cge0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    uint32_t opr_sz, uint32_t max_sz);
 
-extern const GVecGen3 mla_op[4];
-extern const GVecGen3 mls_op[4];
+void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 extern const GVecGen3 cmtst_op[4];
 extern const GVecGen3 sshl_op[4];
 extern const GVecGen3 ushl_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8208651394..2b5ae4d43a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11243,9 +11243,9 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         return;
     case 0x12: /* MLA, MLS */
         if (u) {
-            gen_gvec_op3(s, is_q, rd, rn, rm, &mls_op[size]);
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mls, size);
         } else {
-            gen_gvec_op3(s, is_q, rd, rn, rm, &mla_op[size]);
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mla, size);
         }
         return;
     case 0x11:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b08c4a2527..da807242ff 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4792,62 +4792,69 @@ static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 /* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
  * these tables are shared with AArch64 which does support them.
  */
+void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_mla8_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_mla16_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_mla32_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_mla64_i64,
+          .fniv = gen_mla_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
-static const TCGOpcode vecop_list_mla[] = {
-    INDEX_op_mul_vec, INDEX_op_add_vec, 0
-};
-
-static const TCGOpcode vecop_list_mls[] = {
-    INDEX_op_mul_vec, INDEX_op_sub_vec, 0
-};
-
-const GVecGen3 mla_op[4] = {
-    { .fni4 = gen_mla8_i32,
-      .fniv = gen_mla_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_8 },
-    { .fni4 = gen_mla16_i32,
-      .fniv = gen_mla_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_16 },
-    { .fni4 = gen_mla32_i32,
-      .fniv = gen_mla_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_32 },
-    { .fni8 = gen_mla64_i64,
-      .fniv = gen_mla_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_64 },
-};
-
-const GVecGen3 mls_op[4] = {
-    { .fni4 = gen_mls8_i32,
-      .fniv = gen_mls_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_8 },
-    { .fni4 = gen_mls16_i32,
-      .fniv = gen_mls_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_16 },
-    { .fni4 = gen_mls32_i32,
-      .fniv = gen_mls_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_32 },
-    { .fni8 = gen_mls64_i64,
-      .fniv = gen_mls_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_64 },
-};
+void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_mls8_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_mls16_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_mls32_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_mls64_i64,
+          .fniv = gen_mls_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 /* CMTST : test is "if (X & Y != 0)". */
 static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
@@ -5529,8 +5536,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 0;
 
         case NEON_3R_VML: /* VMLA, VMLS */
-            tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
-                           u ? &mls_op[size] : &mla_op[size]);
+            if (u) {
+                gen_gvec_mls(size, rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
+            } else {
+                gen_gvec_mla(size, rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
+            }
             return 0;
 
         case NEON_3R_VTST_VCEQ:
-- 
2.20.1


