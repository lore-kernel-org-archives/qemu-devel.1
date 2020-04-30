Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BDCC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491EE2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkXYyGcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491EE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE6c-0007TE-97
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDee-0002nq-HH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe5-0001Mf-5b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDe4-0001LY-I2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id u127so3087970wmg.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uShlUsC/z76KQv14R09xTWGtsptGuGstuNKNs/FRUag=;
 b=AkXYyGcc4XtG7kMQpj76prB8TF6AaTxJUdTXib5uyB8euWOSGeVfj+RBNUO55zf25R
 0cpbG1Xd/YLgdER3jCkM1m9jnVPSJAIhVPq/HV0Ng5pLnPokoSo4bhueYeSaZkwI//AG
 OWHyk45Cd6/dJ2onFerRB9taI8kroWrKMbXmwkM6Nt60C8QvI9fcRNNsBBTlQnbm2npr
 z46d7LEwlq72ytt/CAsXkrTdWsAXFzyHCD8eRiiQUPd5MQP/O8gdt6zfntDlENYRwBTH
 7oUb6oaprUMBc/aSpvAoxaI/mPU2UiQL1awUz8tywtK63E7kPuo/8n/JW2H/ZNNL2g2M
 zwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uShlUsC/z76KQv14R09xTWGtsptGuGstuNKNs/FRUag=;
 b=uhG1dXuvVjJScJcJNlxdWLbaOwbVPFgWizUN5naM5cSr8sKW2cMcUKdK/AyM8DStvw
 tSfdalhytQZSQX6DFUit9KbnR/0MD4uXjkoidQrEPTnxWTaAm4J9X4EP4QFYKVvcipW+
 tGvZIvHFUuB5cmluhWdmhEr8997HFxjmq2pGrgY/VibF5zl48THA1T+hupdbqugxlT0a
 et+cf66FE/NXmE/Mrxe63SJ7P1V6PXTnEGmL0lSNkQfkI7ZO2WR1Gx1/50zJuXDxqxbf
 fa/zMuKNVRAqdrr1HJRAZ9n/c8Z4NvQ53uzqGwGLudlXl/vDNdokLjk4S0ZTw2PbHQpd
 vN+A==
X-Gm-Message-State: AGi0PuYLXj5CsUrJDgSIcvphjKCzdQfqRFQ+avC54IiKMWAsM3/jBGLY
 5Dxb7gitlZZrr4JdVWQmqodakw==
X-Google-Smtp-Source: APiQypJtUeojsNRR+wDNgC54ImLPCTUXXwsIGJsi1MSkHMUvKvv9D2Yit55pM7FSNi8BX8kkP15b5Q==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr4494231wma.91.1588270246167; 
 Thu, 30 Apr 2020 11:10:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 32/36] target/arm: Convert Neon VPMIN/VPMAX/VPADD float
 3-reg-same insns to decodetree
Date: Thu, 30 Apr 2020 19:09:59 +0100
Message-Id: <20200430181003.21682-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

Convert the Neon float VPMIN, VPMAX and VPADD 3-reg-same insns to
decodetree. These are the only remaining 'pairwise' operations,
so we can delete the pairwise-specific bits of the old decoder's
for-each-element loop now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 63 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 63 +++++----------------------------
 target/arm/neon-dp.decode       |  5 +++
 3 files changed, 76 insertions(+), 55 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 6a27b7673c2..30832309924 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1375,3 +1375,66 @@ static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 DO_3S_FP(VADD, gen_helper_vfp_adds)
 DO_3S_FP(VSUB, gen_helper_vfp_subs)
 DO_3S_FP(VABD, gen_helper_neon_abd_f32)
+
+static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
+{
+    /* FP operations handled pairwise 32 bits at a time */
+    TCGv_i32 tmp, tmp2, tmp3;
+    TCGv_ptr fpstatus;
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
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    assert(a->q == 0); /* enforced by decode patterns */
+
+    /*
+     * Note that we have to be careful not to clobber the source operands
+     * in the "vm == vd" case by storing the result of the first pass too
+     * early. Since Q is 0 there are always just two passes, so instead
+     * of a complicated loop over each pass we just unroll.
+     */
+    fpstatus = get_fpstatus_ptr(1);
+    tmp = neon_load_reg(a->vn, 0);
+    tmp2 = neon_load_reg(a->vn, 1);
+    fn(tmp, tmp, tmp2, fpstatus);
+    tcg_temp_free_i32(tmp2);
+
+    tmp3 = neon_load_reg(a->vm, 0);
+    tmp2 = neon_load_reg(a->vm, 1);
+    fn(tmp3, tmp3, tmp2, fpstatus);
+    tcg_temp_free_i32(tmp2);
+    tcg_temp_free_ptr(fpstatus);
+
+    neon_store_reg(a->vd, 0, tmp);
+    neon_store_reg(a->vd, 1, tmp3);
+    return true;
+}
+
+/*
+ * For all the functions using this macro, size == 1 means fp16,
+ * which is an architecture extension we don't implement yet.
+ */
+#define DO_3S_FP_PAIR(INSN,FUNC)                                    \
+    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
+    {                                                               \
+        if (a->size != 0) {                                         \
+            /* TODO fp16 support */                                 \
+            return false;                                           \
+        }                                                           \
+        return do_3same_fp_pair(s, a, FUNC);                        \
+    }
+
+DO_3S_FP_PAIR(VPADD, gen_helper_vfp_adds)
+DO_3S_FP_PAIR(VPMAX, gen_helper_vfp_maxs)
+DO_3S_FP_PAIR(VPMIN, gen_helper_vfp_mins)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c944cbf20af..5ae982ee253 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4700,7 +4700,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int shift;
     int pass;
     int count;
-    int pairwise;
     int u;
     int vec_size;
     uint32_t imm;
@@ -4785,6 +4784,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VPMIN:
         case NEON_3R_VPADD_VQRDMLAH:
         case NEON_3R_VQDMULH_VQRDMULH:
+        case NEON_3R_FLOAT_ARITH:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4793,16 +4793,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             /* 64-bit element instructions: handled by decodetree */
             return 1;
         }
-        pairwise = 0;
         switch (op) {
-        case NEON_3R_FLOAT_ARITH:
-            pairwise = (u && size < 2); /* if VPADD (float) */
-            if (!pairwise) {
-                return 1; /* handled by decodetree */
-            }
-            break;
         case NEON_3R_FLOAT_MINMAX:
-            pairwise = u; /* if VPMIN/VPMAX (float) */
+            if (u) {
+                return 1; /* VPMIN/VPMAX handled by decodetree */
+            }
             break;
         case NEON_3R_FLOAT_CMP:
             if (!u && size) {
@@ -4830,41 +4825,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             break;
         }
 
-        if (pairwise && q) {
-            /* All the pairwise insns UNDEF if Q is set */
-            return 1;
-        }
-
         for (pass = 0; pass < (q ? 4 : 2); pass++) {
 
-        if (pairwise) {
-            /* Pairwise.  */
-            if (pass < 1) {
-                tmp = neon_load_reg(rn, 0);
-                tmp2 = neon_load_reg(rn, 1);
-            } else {
-                tmp = neon_load_reg(rm, 0);
-                tmp2 = neon_load_reg(rm, 1);
-            }
-        } else {
-            /* Elementwise.  */
-            tmp = neon_load_reg(rn, pass);
-            tmp2 = neon_load_reg(rm, pass);
-        }
+        /* Elementwise.  */
+        tmp = neon_load_reg(rn, pass);
+        tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_ARITH: /* Floating point arithmetic. */
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            switch ((u << 2) | size) {
-            case 4: /* VPADD */
-                gen_helper_vfp_adds(tmp, tmp, tmp2, fpstatus);
-                break;
-            default:
-                abort();
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
         case NEON_3R_FLOAT_MULTIPLY:
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
@@ -4955,22 +4921,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         tcg_temp_free_i32(tmp2);
 
-        /* Save the result.  For elementwise operations we can put it
-           straight into the destination register.  For pairwise operations
-           we have to be careful to avoid clobbering the source operands.  */
-        if (pairwise && rd == rm) {
-            neon_store_scratch(pass, tmp);
-        } else {
-            neon_store_reg(rd, pass, tmp);
-        }
+        neon_store_reg(rd, pass, tmp);
 
         } /* for pass */
-        if (pairwise && rd == rm) {
-            for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                tmp = neon_load_scratch(pass);
-                neon_store_reg(rd, pass, tmp);
-            }
-        }
         /* End of 3 register same size operations.  */
     } else if (insn & (1 << 4)) {
         if ((insn & 0x00380080) != 0) {
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 9d6a17d6f04..378c2dd5105 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -48,6 +48,8 @@
 # For FP insns the high bit of 'size' is used as part of opcode decode
 @3same_fp        .... ... . . . . size:1 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
+@3same_fp_q0     .... ... . . . . size:1 .... .... .... . 0 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
 
 VHADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 0 .... @3same
 VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
@@ -161,4 +163,7 @@ VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
 
 VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
 VSUB_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VPADD_fp_3s      1111 001 1 0 . 0 . .... .... 1101 ... 0 .... @3same_fp_q0
 VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
+VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
-- 
2.20.1


