Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB3C83003
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765E4208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o17U29Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765E4208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyc7-0003D0-Jt
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYv-0006yO-01
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXd-0004jL-Sf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:28 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXd-0004j8-Fu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:09 -0400
Received: by mail-pj1-x1044.google.com with SMTP id fu13so56567pjb.5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VmO/69xNBHoMNdGAHFDHCHAr0eDNIq/8r0lrH1o8vr0=;
 b=o17U29QwcQoqMMM7lJwGvMty3dbrQhQ8I7bmbNOEsvTHLSBAFOFZZllxOiliIvE0KB
 lK/QogZpWjXN+GnAE0a/Q9aSH8jX6jbz55NCFlaU3ITL8kozfHFCRVZKhHsUBzyZHSJC
 FEre82FBJ1TBuuxLKU0OAwnTcMvCpAdgm1GAsu5c1/fxPX8fHVPlh7cwTcOsVycHVace
 ulGIiccGW9h/uOzbErcjZyMvCRheqWITfR2mghjOb69PGLVZ00LVR90auZA6STpDctnL
 LqaTV0YCha4Ssm71T/ZMSGYHSv+hgpjUvYpFuErfWiAk0jfNjK1+OuvXvizpXrG8K+l0
 ErZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VmO/69xNBHoMNdGAHFDHCHAr0eDNIq/8r0lrH1o8vr0=;
 b=QcjtB7SSAjK8DC7e6tdGDwEzbjDPWH5Xox6BxhMJTEPr7WFeaDJoeqwp30Klwc2XVm
 7M8rsVOluy54IcA65ixBVQVBga6wAhB/T9xNjwRz3YLbvg0a/5ZarxbIXLLDLGZ0eiCw
 KBiC2Ry8u4giyGTQ4/vfOFYE0AtMxtgERIneURIkEsAfbWmZ43mYdXVlRIDi3vF3BW+h
 uaP3L1OZauetqwAAsc2Q6hu5//VtHEMjRHIjWM6zJAYtKNhqYBS5aE01qVzXH+7CXRih
 rmsU89iVakSykzAn3mN637c1TJcSI8keObCjthEt7b9DEMOs+WvCKX5/fVhwB1/Ir5kH
 7ypg==
X-Gm-Message-State: AGi0PubGsUfqxu3HwV066qXiLo5l0luFlrJhd1jSw2dRf4HphmqnVEeb
 PJsP1OxIoKTIz7VfbG8ABG7tgSZzWKA=
X-Google-Smtp-Source: APiQypLLoIo5GyhPvNEjgXtq1ALEJCPc2siDySZLFjGGMm78cKNeYOIDKaver3SznyMor4w13gPfwg==
X-Received: by 2002:a17:90a:8509:: with SMTP id
 l9mr272288pjn.113.1588212187889; 
 Wed, 29 Apr 2020 19:03:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] target/arm: Convert rax1 to gvec helpers
Date: Wed, 29 Apr 2020 19:02:56 -0700
Message-Id: <20200430020303.20264-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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

With this conversion, we will be able to use the same helpers
with sve.  This also fixes a bug in which we failed to clear
the high bits of the SVE register after an AdvSIMD operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  2 ++
 target/arm/translate-a64.h |  2 ++
 target/arm/crypto_helper.c | 11 ++++++++
 target/arm/translate-a64.c | 53 ++++++++++++++++++--------------------
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6623b6689a..96cf4464be 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -537,6 +537,8 @@ DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_4(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(crypto_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 84c40377bd..f2250a8dd1 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -141,4 +141,6 @@ void arm_gen_gvec_xar(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                       uint32_t rm_ofs, int64_t shift,
                       uint32_t opr_sz, uint32_t max_sz);
 
+extern const GVecGen3 rax1_op;
+
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 6bd5a3d2d0..372d8350e4 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -725,3 +725,14 @@ void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm, uint32_t desc)
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(crypto_rax1)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = n[i] ^ rol64(m[i], 1);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b2adf3a39e..2eb4315b6d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14636,6 +14636,29 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     tcg_temp_free_ptr(tcg_rn_ptr);
 }
 
+static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    tcg_gen_rotli_i64(d, m, 1);
+    tcg_gen_xor_i64(d, d, n);
+}
+
+static void gen_rax1_vec(unsigned vece, TCGv_vec d, TCGv_vec n, TCGv_vec m)
+{
+    tcg_gen_rotli_vec(vece, d, m, 1);
+    tcg_gen_xor_vec(vece, d, d, n);
+}
+
+static const TCGOpcode rax1_opc[] = { INDEX_op_rotli_vec, 0 };
+
+const GVecGen3 rax1_op =
+{
+    .fni8 = gen_rax1_i64,
+    .fniv = gen_rax1_vec,
+    .opt_opc = rax1_opc,
+    .fno = gen_helper_crypto_rax1,
+    .vece = MO_64,
+};
+
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
@@ -14670,7 +14693,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             break;
         case 3: /* RAX1 */
             feature = dc_isar_feature(aa64_sha3, s);
-            genfn = NULL;
+            gvecop = &rax1_op;
             break;
         default:
             g_assert_not_reached();
@@ -14706,10 +14729,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
 
     if (gvecop) {
         gen_gvec_op3(s, true, rd, rn, rm, gvecop);
-        return;
-    }
-
-    if (genfn) {
+    } else {
         TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
 
         tcg_rd_ptr = vec_full_reg_ptr(s, rd);
@@ -14721,29 +14741,6 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         tcg_temp_free_ptr(tcg_rd_ptr);
         tcg_temp_free_ptr(tcg_rn_ptr);
         tcg_temp_free_ptr(tcg_rm_ptr);
-    } else {
-        TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
-        int pass;
-
-        tcg_op1 = tcg_temp_new_i64();
-        tcg_op2 = tcg_temp_new_i64();
-        tcg_res[0] = tcg_temp_new_i64();
-        tcg_res[1] = tcg_temp_new_i64();
-
-        for (pass = 0; pass < 2; pass++) {
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-            tcg_gen_rotli_i64(tcg_res[pass], tcg_op2, 1);
-            tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-        }
-        write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-        write_vec_element(s, tcg_res[1], rd, 1, MO_64);
-
-        tcg_temp_free_i64(tcg_op1);
-        tcg_temp_free_i64(tcg_op2);
-        tcg_temp_free_i64(tcg_res[0]);
-        tcg_temp_free_i64(tcg_res[1]);
     }
 }
 
-- 
2.20.1


