Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CAC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B720836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx3Q2jBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDpt-0001ye-Ma
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeB-0001bE-5I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDde-0000sK-8P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdd-0000q2-Pf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id y24so3074877wma.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pYERjdwlGd9H/In1eyFUoX/A0ms9RFWjYCm6IAS3174=;
 b=sx3Q2jBEVWtqWJp4qTwbOZi5hUp2OWDQqLXBl21YHquJrlho5+OSbQmyjb3K7DDBlt
 wcd7BwfU4oSDwUXUbhSCJxaNA2EBzvYVB5VMfQBSvEPu+QqpgaR/iEEFUESXaoTklKQQ
 NcixyQGEku152DTymxqlJna/B5GZLQTM9+K062Wnh5/vF/lbDP2n0GMMRKog0HO3ZCsl
 KVqdx+ygXwQXEA/lemg3TNqvF6JEHn2R/uT17yzFI0wdTfDNpsU+BrKNGd7qyT6ftt2u
 iJEIEarRkq6KMZKxcfzGpgLBZn6JmDVWkCzTpPdlUhn2hMM0RNlPN1CilbVVUPkRGKIa
 MP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pYERjdwlGd9H/In1eyFUoX/A0ms9RFWjYCm6IAS3174=;
 b=Elr8ee+0iSTFJoVJDsYUV0yACIuGtvd6bFdkc2o+odG7W09EX9DHz7veycPkGLCrEZ
 ir9+PM2pl+W7KFy3qIhUWBEiOZf3phYpbsWGNcxOJ3PtnM9mobgormNzARg+/Dw+tWy3
 yzrdgvW6g6E0gcVZ7m6VPdZYPplBeFHtchk8Emf7GDUpLiJDePIbh2KDczWYojdIbMf2
 fy2Cau60TIQalBHw9Fj5DEPlc4+appQCbcXkrb2SvOjtkEfNSMNYxVZWvLFTcrp3WaAd
 jvPsJQtz9KBELs+eod4UsaM8ATf9ZPnirKB2dIRPoZ/06ZqzLt377frTsexHLw0acKWb
 TNbw==
X-Gm-Message-State: AGi0PuaO3jd6s7CuEFbo9APKLcWDfFL5xab0UuyoF3yoFvaHj0actvT3
 /IiFj66DCnPP1W2UxHE3tG8JsVkG1j8N1Q==
X-Google-Smtp-Source: APiQypJ3n+fh+usYPFuqanzNlYbruWkv/tMLJ9QBOHOzzbG3jMH5hGmaV3dENdXyoG3U/I4B0cNksg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr4184964wmi.72.1588270220405; 
 Thu, 30 Apr 2020 11:10:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/36] target/arm: Convert Neon load/store multiple structures
 to decodetree
Date: Thu, 30 Apr 2020 19:09:38 +0100
Message-Id: <20200430181003.21682-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

Convert the Neon "load/store multiple structures" insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 124 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  91 +----------------------
 target/arm/neon-ls.decode       |   7 ++
 3 files changed, 133 insertions(+), 89 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index b06542b8b83..966c0d92012 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -274,3 +274,127 @@ static bool trans_VFML_scalar(DisasContext *s, arg_VFML_scalar *a)
                        gen_helper_gvec_fmlal_idx_a32);
     return true;
 }
+
+static struct {
+    int nregs;
+    int interleave;
+    int spacing;
+} const neon_ls_element_type[11] = {
+    {1, 4, 1},
+    {1, 4, 2},
+    {4, 1, 1},
+    {2, 2, 2},
+    {1, 3, 1},
+    {1, 3, 2},
+    {3, 1, 1},
+    {1, 1, 1},
+    {1, 2, 1},
+    {1, 2, 2},
+    {2, 1, 1}
+};
+
+static void gen_neon_ldst_base_update(DisasContext *s, int rm, int rn,
+                                      int stride)
+{
+    if (rm != 15) {
+        TCGv_i32 base;
+
+        base = load_reg(s, rn);
+        if (rm == 13) {
+            tcg_gen_addi_i32(base, base, stride);
+        } else {
+            TCGv_i32 index;
+            index = load_reg(s, rm);
+            tcg_gen_add_i32(base, base, index);
+            tcg_temp_free_i32(index);
+        }
+        store_reg(s, rn, base);
+    }
+}
+
+static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
+{
+    /* Neon load/store multiple structures */
+    int nregs, interleave, spacing, reg, n;
+    MemOp endian = s->be_data;
+    int mmu_idx = get_mem_index(s);
+    int size = a->size;
+    TCGv_i64 tmp64;
+    TCGv_i32 addr, tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+    if (a->itype > 10) {
+        return false;
+    }
+    /* Catch UNDEF cases for bad values of align field */
+    switch (a->itype & 0xc) {
+    case 4:
+        if (a->align >= 2) {
+            return false;
+        }
+        break;
+    case 8:
+        if (a->align == 3) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+    nregs = neon_ls_element_type[a->itype].nregs;
+    interleave = neon_ls_element_type[a->itype].interleave;
+    spacing = neon_ls_element_type[a->itype].spacing;
+    if (size == 3 && (interleave | spacing) != 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* For our purposes, bytes are always little-endian.  */
+    if (size == 0) {
+        endian = MO_LE;
+    }
+    /*
+     * Consecutive little-endian elements from a single register
+     * can be promoted to a larger little-endian operation.
+     */
+    if (interleave == 1 && endian == MO_LE) {
+        size = 3;
+    }
+    tmp64 = tcg_temp_new_i64();
+    addr = tcg_temp_new_i32();
+    tmp = tcg_const_i32(1 << size);
+    load_reg_var(s, addr, a->rn);
+    for (reg = 0; reg < nregs; reg++) {
+        for (n = 0; n < 8 >> size; n++) {
+            int xs;
+            for (xs = 0; xs < interleave; xs++) {
+                int tt = a->vd + reg + spacing * xs;
+
+                if (a->l) {
+                    gen_aa32_ld_i64(s, tmp64, addr, mmu_idx, endian | size);
+                    neon_store_element64(tt, n, size, tmp64);
+                } else {
+                    neon_load_element64(tmp64, tt, n, size);
+                    gen_aa32_st_i64(s, tmp64, addr, mmu_idx, endian | size);
+                }
+                tcg_gen_add_i32(addr, addr, tmp);
+            }
+        }
+    }
+    tcg_temp_free_i32(addr);
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i64(tmp64);
+
+    gen_neon_ldst_base_update(s, a->rm, a->rn, nregs * interleave * 8);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 90f2f37908b..3f97635a524 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3214,45 +3214,19 @@ static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
 }
 
 
-static struct {
-    int nregs;
-    int interleave;
-    int spacing;
-} const neon_ls_element_type[11] = {
-    {1, 4, 1},
-    {1, 4, 2},
-    {4, 1, 1},
-    {2, 2, 2},
-    {1, 3, 1},
-    {1, 3, 2},
-    {3, 1, 1},
-    {1, 1, 1},
-    {1, 2, 1},
-    {1, 2, 2},
-    {2, 1, 1}
-};
-
 /* Translate a NEON load/store element instruction.  Return nonzero if the
    instruction is invalid.  */
 static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
 {
     int rd, rn, rm;
-    int op;
     int nregs;
-    int interleave;
-    int spacing;
     int stride;
     int size;
     int reg;
     int load;
-    int n;
     int vec_size;
-    int mmu_idx;
-    MemOp endian;
     TCGv_i32 addr;
     TCGv_i32 tmp;
-    TCGv_i32 tmp2;
-    TCGv_i64 tmp64;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return 1;
@@ -3274,70 +3248,9 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     rn = (insn >> 16) & 0xf;
     rm = insn & 0xf;
     load = (insn & (1 << 21)) != 0;
-    endian = s->be_data;
-    mmu_idx = get_mem_index(s);
     if ((insn & (1 << 23)) == 0) {
-        /* Load store all elements.  */
-        op = (insn >> 8) & 0xf;
-        size = (insn >> 6) & 3;
-        if (op > 10)
-            return 1;
-        /* Catch UNDEF cases for bad values of align field */
-        switch (op & 0xc) {
-        case 4:
-            if (((insn >> 5) & 1) == 1) {
-                return 1;
-            }
-            break;
-        case 8:
-            if (((insn >> 4) & 3) == 3) {
-                return 1;
-            }
-            break;
-        default:
-            break;
-        }
-        nregs = neon_ls_element_type[op].nregs;
-        interleave = neon_ls_element_type[op].interleave;
-        spacing = neon_ls_element_type[op].spacing;
-        if (size == 3 && (interleave | spacing) != 1) {
-            return 1;
-        }
-        /* For our purposes, bytes are always little-endian.  */
-        if (size == 0) {
-            endian = MO_LE;
-        }
-        /* Consecutive little-endian elements from a single register
-         * can be promoted to a larger little-endian operation.
-         */
-        if (interleave == 1 && endian == MO_LE) {
-            size = 3;
-        }
-        tmp64 = tcg_temp_new_i64();
-        addr = tcg_temp_new_i32();
-        tmp2 = tcg_const_i32(1 << size);
-        load_reg_var(s, addr, rn);
-        for (reg = 0; reg < nregs; reg++) {
-            for (n = 0; n < 8 >> size; n++) {
-                int xs;
-                for (xs = 0; xs < interleave; xs++) {
-                    int tt = rd + reg + spacing * xs;
-
-                    if (load) {
-                        gen_aa32_ld_i64(s, tmp64, addr, mmu_idx, endian | size);
-                        neon_store_element64(tt, n, size, tmp64);
-                    } else {
-                        neon_load_element64(tmp64, tt, n, size);
-                        gen_aa32_st_i64(s, tmp64, addr, mmu_idx, endian | size);
-                    }
-                    tcg_gen_add_i32(addr, addr, tmp2);
-                }
-            }
-        }
-        tcg_temp_free_i32(addr);
-        tcg_temp_free_i32(tmp2);
-        tcg_temp_free_i64(tmp64);
-        stride = nregs * interleave * 8;
+        /* Load store all elements -- handled already by decodetree */
+        return 1;
     } else {
         size = (insn >> 10) & 3;
         if (size == 3) {
diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index 2b16c9256df..dd03d5a37bd 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -27,3 +27,10 @@
 #   0b1111_1001_xxx0_xxxx_xxxx_xxxx_xxxx_xxxx
 # This file works on the A32 encoding only; calling code for T32 has to
 # transform the insn into the A32 version first.
+
+%vd_dp  22:1 12:4
+
+# Neon load/store multiple structures
+
+VLDST_multiple 1111 0100 0 . l:1 0 rn:4 .... itype:4 size:2 align:2 rm:4 \
+               vd=%vd_dp
-- 
2.20.1


