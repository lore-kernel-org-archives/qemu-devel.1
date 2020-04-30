Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42762C83004
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36EE208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5deyNEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36EE208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTydG-0004gj-6s
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYw-0006yP-1L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXg-0004je-W9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXg-0004jU-HY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id p8so2003421pgi.5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rFHIQ9gnK1y50o1in1Rk9q+bTI5N/EWp2WgbbTSdhTY=;
 b=m5deyNEyqdnNkDjltijr9SHncA6Y8rOkJxtNPAiWqW18n09PTfGTCBn52I3nGiFgWS
 8SPjYq9hdwMf1msM0tp4d+TttrGNj6qQU67qvArcD7biNWuwAhqWHP45blCWQC8Jzrv5
 4JwvKWv5dp+LmqZ5oO9AaImGY0yPEIieSA8d6lx+i7KBqxeZOOkx4YocznYAwo56dhq4
 34CiaiksSkYcrkVCBaHH4PVEleUfyEP4ZbmFRLYikWJSKHiBUVhdab1z4Wy07QTcRgd8
 3CK05cRxd7ll2MyPRQ1VFTYDpoaR6WWlI8SzFqq2iczs5J5vZRmtxFoXdsg29d5EguPn
 3inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rFHIQ9gnK1y50o1in1Rk9q+bTI5N/EWp2WgbbTSdhTY=;
 b=D+mwWp5AHMKuQWL3EVVYr3PGm1e79rxKRSPlnutHOYlNsppvFkH2AzTvFhMPfBCDor
 xa2gfEdeEa31PyTJj4mbIkEsyIHaBnUR/fxRM36jjjFq5i4aLQ/RofJPFh8onnqsOuK+
 lyLAOwz4imRUpxpgpYK8d9l4iB/1VbKaKOk3HFMvxW/fPmnZB3akhp/r+/B4OaY5O64r
 LeQ0OugrsVv0pUPuozqv0sFnDACBPbHfBHu46dvHf+29OTK1Bxoz8QZWm5whtsjvxx3C
 NndWA1Gzt7AATPs41oV6/Wto9J8FHFMm2Mbq4dRMoz9jp63t4kesoJOg2J/l5L/54IGd
 PLqw==
X-Gm-Message-State: AGi0PubIxLSNeN0GTKt8kTHsA8/1f0L3UiePja3AlUqMN+EuUeoqE0Qa
 ngnqb/W8YebRogkrr04JF3CkU0wy4GM=
X-Google-Smtp-Source: APiQypJXnxaPv0aDfeydJW6dGFf9SxLM8DfPmH9sgWoBTCKYb7XP+RsGAMTpgRph1dWglNolLK+iVQ==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr1140034pfj.256.1588212190327;
 Wed, 29 Apr 2020 19:03:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] target/arm: Convert sha1 and sha256 to gvec helpers
Date: Wed, 29 Apr 2020 19:02:58 -0700
Message-Id: <20200430020303.20264-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not yet convert the helpers to loop over opr_sz, but the
descriptor allows the vector tail to be cleared.  Which fixes
an existing bug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 12 +++++------
 target/arm/crypto_helper.c | 24 +++++++++++++++------
 target/arm/translate-a64.c | 34 +++++++++++------------------
 target/arm/translate.c     | 44 +++++++++++++++-----------------------
 4 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d564747808..07466ddc6c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -517,13 +517,13 @@ DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_2(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_3(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_3(crypto_sha256h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
-DEF_HELPER_FLAGS_2(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_3(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_4(crypto_sha256h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha512h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha512h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 637e4c00bb..7124745c32 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -303,7 +303,7 @@ void HELPER(crypto_sha1_3reg)(void *vd, void *vn, void *vm, uint32_t op)
     rd[1] = d.l[1];
 }
 
-void HELPER(crypto_sha1h)(void *vd, void *vm)
+void HELPER(crypto_sha1h)(void *vd, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rm = vm;
@@ -314,9 +314,11 @@ void HELPER(crypto_sha1h)(void *vd, void *vm)
 
     rd[0] = m.l[0];
     rd[1] = m.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha1su1)(void *vd, void *vm)
+void HELPER(crypto_sha1su1)(void *vd, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rm = vm;
@@ -330,6 +332,8 @@ void HELPER(crypto_sha1su1)(void *vd, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
 /*
@@ -357,7 +361,7 @@ static uint32_t s1(uint32_t x)
     return ror32(x, 17) ^ ror32(x, 19) ^ (x >> 10);
 }
 
-void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -388,9 +392,11 @@ void HELPER(crypto_sha256h)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -413,9 +419,11 @@ void HELPER(crypto_sha256h2)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha256su0)(void *vd, void *vm)
+void HELPER(crypto_sha256su0)(void *vd, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rm = vm;
@@ -429,9 +437,11 @@ void HELPER(crypto_sha256su0)(void *vd, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
+void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     uint64_t *rd = vd;
     uint64_t *rn = vn;
@@ -447,6 +457,8 @@ void HELPER(crypto_sha256su1)(void *vd, void *vn, void *vm)
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(vd, desc);
 }
 
 /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c737a409d0..48f71e01e4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14517,8 +14517,7 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    CryptoThreeOpFn *genfn;
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
+    gen_helper_gvec_3 *genfn;
     bool feature;
 
     if (size != 0) {
@@ -14560,23 +14559,22 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-    tcg_rm_ptr = vec_full_reg_ptr(s, rm);
-
     if (genfn) {
-        genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
+        gen_gvec_op3_ool(s, true, rd, rn, rm, 0, genfn);
     } else {
         TCGv_i32 tcg_opcode = tcg_const_i32(opcode);
+        TCGv_ptr tcg_rd_ptr = vec_full_reg_ptr(s, rd);
+        TCGv_ptr tcg_rn_ptr = vec_full_reg_ptr(s, rn);
+        TCGv_ptr tcg_rm_ptr = vec_full_reg_ptr(s, rm);
 
         gen_helper_crypto_sha1_3reg(tcg_rd_ptr, tcg_rn_ptr,
                                     tcg_rm_ptr, tcg_opcode);
-        tcg_temp_free_i32(tcg_opcode);
-    }
 
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
-    tcg_temp_free_ptr(tcg_rm_ptr);
+        tcg_temp_free_i32(tcg_opcode);
+        tcg_temp_free_ptr(tcg_rd_ptr);
+        tcg_temp_free_ptr(tcg_rn_ptr);
+        tcg_temp_free_ptr(tcg_rm_ptr);
+    }
 }
 
 /* Crypto two-reg SHA
@@ -14591,9 +14589,8 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    CryptoTwoOpFn *genfn;
+    gen_helper_gvec_2 *genfn;
     bool feature;
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
 
     if (size != 0) {
         unallocated_encoding(s);
@@ -14626,14 +14623,7 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     if (!fp_access_check(s)) {
         return;
     }
-
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-
-    genfn(tcg_rd_ptr, tcg_rn_ptr);
-
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
+    gen_gvec_op2_ool(s, true, rd, rn, 0, genfn);
 }
 
 static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index caa98ed309..517048e982 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5364,28 +5364,30 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 tmp4 = tcg_const_i32(size);
                 gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp4);
                 tcg_temp_free_i32(tmp4);
+                tcg_temp_free_ptr(ptr1);
+                tcg_temp_free_ptr(ptr2);
+                tcg_temp_free_ptr(ptr3);
             } else { /* SHA-256 */
-                if (!dc_isar_feature(aa32_sha2, s) || size == 3) {
+                gen_helper_gvec_3 *fn;
+
+                if (!dc_isar_feature(aa32_sha2, s)) {
                     return 1;
                 }
-                ptr1 = vfp_reg_ptr(true, rd);
-                ptr2 = vfp_reg_ptr(true, rn);
-                ptr3 = vfp_reg_ptr(true, rm);
                 switch (size) {
                 case 0:
-                    gen_helper_crypto_sha256h(ptr1, ptr2, ptr3);
+                    fn = gen_helper_crypto_sha256h;
                     break;
                 case 1:
-                    gen_helper_crypto_sha256h2(ptr1, ptr2, ptr3);
+                    fn = gen_helper_crypto_sha256h2;
                     break;
                 case 2:
-                    gen_helper_crypto_sha256su1(ptr1, ptr2, ptr3);
+                    fn = gen_helper_crypto_sha256su1;
                     break;
+                default:
+                    return 1;
                 }
+                tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16, 0, fn);
             }
-            tcg_temp_free_ptr(ptr1);
-            tcg_temp_free_ptr(ptr2);
-            tcg_temp_free_ptr(ptr3);
             return 0;
 
         case NEON_3R_VPADD_VQRDMLAH:
@@ -6947,13 +6949,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     if (!dc_isar_feature(aa32_sha1, s) || ((rm | rd) & 1)) {
                         return 1;
                     }
-                    ptr1 = vfp_reg_ptr(true, rd);
-                    ptr2 = vfp_reg_ptr(true, rm);
-
-                    gen_helper_crypto_sha1h(ptr1, ptr2);
-
-                    tcg_temp_free_ptr(ptr1);
-                    tcg_temp_free_ptr(ptr2);
+                    tcg_gen_gvec_2_ool(rd_ofs, rm_ofs, 16, 16, 0,
+                                       gen_helper_crypto_sha1h);
                     break;
                 case NEON_2RM_SHA1SU1:
                     if ((rm | rd) & 1) {
@@ -6967,17 +6964,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     } else if (!dc_isar_feature(aa32_sha1, s)) {
                         return 1;
                     }
-                    ptr1 = vfp_reg_ptr(true, rd);
-                    ptr2 = vfp_reg_ptr(true, rm);
-                    if (q) {
-                        gen_helper_crypto_sha256su0(ptr1, ptr2);
-                    } else {
-                        gen_helper_crypto_sha1su1(ptr1, ptr2);
-                    }
-                    tcg_temp_free_ptr(ptr1);
-                    tcg_temp_free_ptr(ptr2);
+                    tcg_gen_gvec_2_ool(rd_ofs, rm_ofs, 16, 16, 0,
+                                       q ? gen_helper_crypto_sha256su0
+                                       : gen_helper_crypto_sha1su1);
                     break;
-
                 case NEON_2RM_VMVN:
                     tcg_gen_gvec_not(0, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
-- 
2.20.1


