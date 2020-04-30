Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E3C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2A4206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTSRPdyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2A4206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDlp-0004tf-AB
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeG-0001jm-Ff
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdk-0001Ar-QF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdk-000122-CX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so8174046wrt.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ktz+IFnCp3WGIM8gI5HERLwJEWJsvRvRgBzd2QeRej4=;
 b=UTSRPdyBe6ll966cCrLPgCj0IicUKzxeGzcV4DGtYxx2+G5JeOIYa9gZR8D/Deq5LE
 A0BSBuLeAT3YqPLZxkX5dc4WdtM0JKsJZGbHYsoASEaZ4AZksflG6SZ85IBA8Uv5Fcfx
 Uw3flsEvOk3numcLBIJO0oIwAc2r3h5i4jJBr5cn/BYRoLnhF+RPP7ewfjgPsL88KswB
 t3j+rAYZl///NgIKKYJEoEx9eTwoz3sR8uFvMo7x7yN36dld8NJPz8v5A99rpy8UUKr4
 SmvW2ihugfFvbhrMViS0/nWGsqSlcIbPeaichpdQCjyuT1QLkjuwW+yzbHWxqPwNCVTY
 FQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ktz+IFnCp3WGIM8gI5HERLwJEWJsvRvRgBzd2QeRej4=;
 b=DfrsyUwr7YuMP+L3Cq9eYnXrfng5QXUBaBcHP/s+nVqBz/10s429XMujQgUuPFTuN7
 rm0OEA3sDeQCX9Fj5mvB+QE9MpvGpW76maQSD5J9Q/S/2zJJUE78mMrwxnl0vyf+orMg
 FDpoK/+nhOdvdwgZdBbjhTII9+jMocgI7yaU2nh0qCqqhR2qC3Zp+lvXm1LSu6s/jqxi
 Z/yGW+RKr74w1BUEQhHN8P66nEwa7kxm4jWikLujev0AKN4lUXihkbMSEyjXl6Ozfssm
 I+r3ss+PJrHTpSBU6oL6kuUNbPu3lYyAncISl9LU62QeTIu4heLWzJmgJmZn7CZfrTI3
 mj4g==
X-Gm-Message-State: AGi0PuYAxhW9OW3Pp5itohFdouvd5+ROSsdy7S/ofOIVwVb6iDPlQ2WG
 zrd2Cgo0aXjQczOoZgAKqIpJ0w==
X-Google-Smtp-Source: APiQypIdwscYlhhiZDbjzh1aFJbZT8+UdA5NkN6J3gYyc2Y3EnmODEVtOmJ5q5IpUAJe/jEOSZRMmA==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr5171455wrt.236.1588270224115; 
 Thu, 30 Apr 2020 11:10:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/36] target/arm: Convert Neon 3-reg-same VADD/VSUB to
 decodetree
Date: Thu, 30 Apr 2020 19:09:41 +0100
Message-Id: <20200430181003.21682-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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

Convert the Neon 3-reg-same VADD and VSUB insns to decodetree.

Note that we don't need the neon_3r_sizes[op] check here because all
size values are OK for VADD and VSUB; we'll add this when we convert
the first insn that has size restrictions.

For this we need one of the GVecGen*Fn typedefs currently in
translate-a64.h; move them all to translate.h as a block so they
are visible to the 32-bit decoder.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h      |  9 --------
 target/arm/translate.h          |  9 ++++++++
 target/arm/translate-neon.inc.c | 38 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 14 ++++--------
 target/arm/neon-dp.decode       | 17 +++++++++++++++
 5 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 4c2c91ae1b2..f02fbb63a4a 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -115,13 +115,4 @@ static inline int vec_full_reg_size(DisasContext *s)
 
 bool disas_sve(DisasContext *, uint32_t);
 
-/* Note that the gvec expanders operate on offsets + sizes.  */
-typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
-typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
-                         uint32_t, uint32_t);
-typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
-                        uint32_t, uint32_t, uint32_t);
-typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
-                        uint32_t, uint32_t, uint32_t);
-
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 98b319f3f69..95b43e7ab65 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -305,4 +305,13 @@ void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 #define dc_isar_feature(name, ctx) \
     ({ DisasContext *ctx_ = (ctx); isar_feature_##name(ctx_->isar); })
 
+/* Note that the gvec expanders operate on offsets + sizes.  */
+typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
+typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
+                         uint32_t, uint32_t);
+typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c881d1cf607..bd9e697b3e2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -560,3 +560,41 @@ static bool trans_VLDST_single(DisasContext *s, arg_VLDST_single *a)
 
     return true;
 }
+
+static bool do_3same(DisasContext *s, arg_3same *a, GVecGen3Fn fn)
+{
+    int vec_size = a->q ? 16 : 8;
+    int rd_ofs = neon_reg_offset(a->vd, 0);
+    int rn_ofs = neon_reg_offset(a->vn, 0);
+    int rm_ofs = neon_reg_offset(a->vm, 0);
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fn(a->size, rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
+    return true;
+}
+
+#define DO_3SAME(INSN, FUNC)                                            \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        return do_3same(s, a, FUNC);                                    \
+    }
+
+DO_3SAME(VADD, tcg_gen_gvec_add)
+DO_3SAME(VSUB, tcg_gen_gvec_sub)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8c059af0e7e..81a0df78e40 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4885,16 +4885,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 0;
 
-        case NEON_3R_VADD_VSUB:
-            if (u) {
-                tcg_gen_gvec_sub(size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            } else {
-                tcg_gen_gvec_add(size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            }
-            return 0;
-
         case NEON_3R_VQADD:
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
@@ -4970,6 +4960,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
                            u ? &ushl_op[size] : &sshl_op[size]);
             return 0;
+
+        case NEON_3R_VADD_VSUB:
+            /* Already handled by decodetree */
+            return 1;
         }
 
         if (size == 3) {
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index c89a1a58591..a61b1e88476 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -18,6 +18,10 @@
 #
 # This file is processed by scripts/decodetree.py
 #
+# VFP/Neon register fields; same as vfp.decode
+%vm_dp  5:1 0:4
+%vn_dp  7:1 16:4
+%vd_dp  22:1 12:4
 
 # Encodings for Neon data processing instructions where the T32 encoding
 # is a simple transformation of the A32 encoding.
@@ -27,3 +31,16 @@
 #   0b111p_1111_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
 # This file works on the A32 encoding only; calling code for T32 has to
 # transform the insn into the A32 version first.
+
+######################################################################
+# 3-reg-same grouping:
+# 1111 001 U 0 D sz:2 Vn:4 Vd:4 opc:4 N Q M op Vm:4
+######################################################################
+
+&3same vm vn vd q size
+
+@3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
+VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
-- 
2.20.1


