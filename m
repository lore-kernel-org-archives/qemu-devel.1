Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9579C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8F6206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9bf32EX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8F6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV126-0005JA-My
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0su-0003Hv-B7
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0st-0004nG-DT
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:24 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0ss-0004kf-Vr
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:23 -0400
Received: by mail-pf1-x442.google.com with SMTP id f7so3533590pfa.9
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HkrQs5dpEFTRpOusdkDcmR/jxV9J9hkTnHpacMdwp8Y=;
 b=b9bf32EXnUvjntIHj/5yJHKXOw/KTHIu6oftw7zymW/onndkCLzsDPFDkU1WZzVRRC
 SnWpLpZ5wkH72ikbhFaYrMXV+5/W6hLS6YYBJmW4ateHNxt/VXJ2tYfbJjbNQgjsJr9n
 oEBADLAmMBDJ5mUBFti78UdvC4wULzYVU79O7W5D+iY0h5phdNdc34cGH34Jhcd6d0AZ
 DZeZLxtG1tumCP6mwFij02F+t0dCUzR7bMWNVgRlDfKdxeQs6W1uxiP4+yr8PtHmTiMV
 YYw9tHMUQB2CTERFPI0APOyGCCdQB5/64L8/JQfOjgQNC5roClnzWAg3O8Vi7qFDLu5Y
 gw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HkrQs5dpEFTRpOusdkDcmR/jxV9J9hkTnHpacMdwp8Y=;
 b=QLbHc6JzMalxdwUy0fp8M7NEVo3iVBLu/XsFPhK5hi8qwevc46n7wnrTYg/Fn9W+SC
 BxDEciMBj68YzLDQsGB1XzFaNYnuzVu+z91IgEM31CMeVcBynzCvBy2QTjBouwV5+XOb
 l5GeDjnqLT3t47b/3xE2uZid2nxcRM0x6ljm1rhE8IAVM605ThDMrK+B41vdU6xydKZo
 bxATaIaX4GWbf55A+lc+SEWRhdeMe0CDIDWJYbXu+CS4ArZMEe+hLmxnSEdKcbQswkZd
 nPkI6wCyUCqQao9mXf/4E08sT32e0Vir6GH/oSi6w8Cp2ajlOAqOvb/FT/tpSUHzAzuA
 sXsw==
X-Gm-Message-State: AGi0PuaBaU3uACpyMRx3lLuDYTtkFxq3Js10eY1RgRO6+Kd53BlRwmxI
 z84nENcwEnlprEIvQ51rCMuaQjmc/4U=
X-Google-Smtp-Source: APiQypKONqfrkm4rgtVYQRo4hqHOcMBKOQA2w1J85fqAE4GKFuN/lRYcMiVfegKmcbFC/UkJBOt4/g==
X-Received: by 2002:a63:7e1b:: with SMTP id z27mr10123554pgc.19.1588459521156; 
 Sat, 02 May 2020 15:45:21 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/15] target/arm: Wrap vector qrdmla/qrdmls in GVecGen3Fn
Date: Sat,  2 May 2020 15:44:59 -0700
Message-Id: <20200502224503.2282-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::442
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
 target/arm/translate.h     |  5 ++++
 target/arm/translate-a64.c | 34 ++----------------------
 target/arm/translate.c     | 54 +++++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index ada84d411d..76cd3d31c7 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -332,6 +332,11 @@ void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4d5cdcef2f..1821a8e09d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -604,18 +604,6 @@ static void gen_gvec_op3_ool(DisasContext *s, bool is_q, int rd,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
-/* Expand a 3-operand + env pointer operation using
- * an out-of-line helper.
- */
-static void gen_gvec_op3_env(DisasContext *s, bool is_q, int rd,
-                             int rn, int rm, gen_helper_gvec_3_ptr *fn)
-{
-    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm), cpu_env,
-                       is_q ? 16 : 8, vec_full_reg_size(s), 0, fn);
-}
-
 /* Expand a 3-operand + fpstatus pointer + simd data value operation using
  * an out-of-line helper.
  */
@@ -11710,29 +11698,11 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x0: /* SQRDMLAH (vector) */
-        switch (size) {
-        case 1:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlah_s16);
-            break;
-        case 2:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlah_s32);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmlah_qc, size);
         return;
 
     case 0x1: /* SQRDMLSH (vector) */
-        switch (size) {
-        case 1:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlsh_s16);
-            break;
-        case 2:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlsh_s32);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmlsh_qc, size);
         return;
 
     case 0x2: /* SDOT / UDOT */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a5bb4b0040..8d20726dcf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3901,20 +3901,26 @@ static const uint8_t neon_2rm_sizes[] = {
     [NEON_2RM_VCVT_UF] = 0x4,
 };
 
-
-/* Expand v8.1 simd helper.  */
-static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
-                         int q, int rd, int rn, int rm)
+void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
-    if (dc_isar_feature(aa32_rdm, s)) {
-        int opr_sz = (1 + q) * 8;
-        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                           vfp_reg_offset(1, rn),
-                           vfp_reg_offset(1, rm), cpu_env,
-                           opr_sz, opr_sz, 0, fn);
-        return 0;
-    }
-    return 1;
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_gvec_qrdmlah_s16, gen_helper_gvec_qrdmlah_s32
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, cpu_env,
+                       opr_sz, max_sz, 0, fns[vece - 1]);
+}
+
+void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_gvec_qrdmlsh_s16, gen_helper_gvec_qrdmlsh_s32
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, cpu_env,
+                       opr_sz, max_sz, 0, fns[vece - 1]);
 }
 
 #define GEN_CMP0(NAME, COND)                                            \
@@ -5465,13 +5471,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;  /* VPADD */
             }
             /* VQRDMLAH */
-            switch (size) {
-            case 1:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s16,
-                                     q, rd, rn, rm);
-            case 2:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s32,
-                                     q, rd, rn, rm);
+            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
+                gen_gvec_sqrdmlah_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                     vec_size, vec_size);
+                return 0;
             }
             return 1;
 
@@ -5484,13 +5487,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;
             }
             /* VQRDMLSH */
-            switch (size) {
-            case 1:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s16,
-                                     q, rd, rn, rm);
-            case 2:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s32,
-                                     q, rd, rn, rm);
+            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
+                gen_gvec_sqrdmlsh_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                     vec_size, vec_size);
+                return 0;
             }
             return 1;
 
-- 
2.20.1


