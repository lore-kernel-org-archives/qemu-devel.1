Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20168C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3D52076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mum9kL3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3D52076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbKm-0006Mv-0x
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbD7-000157-Ca
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbD6-0003vL-2R
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id f13so2490755wmc.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nNsSGVGF8y4So1qak3dO7LfQL9H2lgAJXftV4QL0Yx8=;
 b=mum9kL3ByrWhU8A0oiXiqltR/TJV+/8rb+bTO6xaOd+63TBUwim7fr5ZezQCdAfGrn
 JyyRmas30Dvkpjh7YkTmcyNKIEZeCX0Fa158jd3iOp/SIqJwSM6i/aX2xbe953yKDvGb
 b8R4Ix0DREr2evxvOHFke0Cz82gDo1TTe3BeqVUMi06hEHmqhuaaBFE3HfanvrTKDnIK
 88/zixazkxeQN84xBEfr9KsRovjzTDtEWZwdSPXZlFKl/PqYVVvfkqTJ2lYogrmDyvJU
 +xzCcfYc1JXr8bYRnnORskGzRlE4t1KKYaGokFSzEG3eFKf6t6r9QleMCUyAgfD9slYQ
 F3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nNsSGVGF8y4So1qak3dO7LfQL9H2lgAJXftV4QL0Yx8=;
 b=gqYp8VsAXAiXUOkmUodiRhn5qIl5+5vGh71dEVvlQuCmZNFsl/dpFwxvsR1ees484h
 om3w4Zb+a1LWr3v4iaXdEo+Uh7lEOXjRNeNU5heEuKV4DewoDGsUD8gOeYbst/eIBx9N
 n8gT9wZu0yKTpW37a0kpXUMyOVYXp2QXOGuBvEDTQ7om3dBHWS/3BGu0iaLa8sPP85oj
 SlljnqvuTB6Wujf6EfkG+J+fYFUTq4AKLpQ43iUEgJy+zbyCl28Ge/r3uTiQMmjY5HX7
 1ZTS2XSfoWi0VibeqDP77ZPRicJf7qcYgGARciDVVHho7TEYi5YF5mQvyt8fOIXFQpJx
 1e2w==
X-Gm-Message-State: AOAM5337/kln0d7XFpvTAuxyH2/aZ/rddTBIXlitHeaJhTD4CpR73zpF
 gWqOe91KB+P8AFzWhfAoQoo3lA==
X-Google-Smtp-Source: ABdhPJzMUA5mK/DGYFshKV2Snad8Vl/Jsy0AAPzzEWscgloPDKWqUiCIj1sQ6c59edE/XZC67xWjUg==
X-Received: by 2002:a05:600c:22c9:: with SMTP id
 9mr4247016wmg.162.1589552470479; 
 Fri, 15 May 2020 07:21:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s14sm3738327wmh.18.2020.05.15.07.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:21:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/10] target/arm: Convert Neon one-register-and-immediate
 insns to decodetree
Date: Fri, 15 May 2020 15:20:56 +0100
Message-Id: <20200515142056.21346-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515142056.21346-1-peter.maydell@linaro.org>
References: <20200515142056.21346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the insns in the one-register-and-immediate group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  49 +++++++++++
 target/arm/translate-neon.inc.c | 151 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 101 +--------------------
 3 files changed, 202 insertions(+), 99 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index bce4043746e..39d2217a9c8 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -430,3 +430,52 @@ VCVT_FS_2sh      1111 001 0 1 . 1 shift:5   .... 1111 0 . . 1 .... \
                  @2reg_shift size=0
 VCVT_FU_2sh      1111 001 1 1 . 1 shift:5   .... 1111 0 . . 1 .... \
                  @2reg_shift size=0
+
+######################################################################
+# 1-reg-and-modified-immediate grouping:
+# 1111 001 i 1 D 000 imm:3 Vd:4 cmode:4 0 Q op 1 Vm:4
+######################################################################
+
+&1reg_imm        vd q imm cmode op
+
+%asimd_imm_value 24:1 16:3 0:4
+
+@1reg_imm        .... ... . . . ... ... .... .... . q:1 . . .... \
+                 &1reg_imm imm=%asimd_imm_value vd=%vd_dp
+
+{
+  # Logic operations, ie not VMOV or VMVN: (cmode & 1) && cmode < 12
+  VORR_1r        1111 001 . 1 . 000 ... .... 0001 0 . 0 1 .... \
+                 @1reg_imm cmode=1 op=0
+  VORR_1r        1111 001 . 1 . 000 ... .... 0011 0 . 0 1 .... \
+                 @1reg_imm cmode=3 op=0
+  VORR_1r        1111 001 . 1 . 000 ... .... 0101 0 . 0 1 .... \
+                 @1reg_imm cmode=5 op=0
+  VORR_1r        1111 001 . 1 . 000 ... .... 0111 0 . 0 1 .... \
+                 @1reg_imm cmode=7 op=0
+  VORR_1r        1111 001 . 1 . 000 ... .... 1001 0 . 0 1 .... \
+                 @1reg_imm cmode=9 op=0
+  VORR_1r        1111 001 . 1 . 000 ... .... 1011 0 . 0 1 .... \
+                 @1reg_imm cmode=11 op=0
+
+  VBIC_1r        1111 001 . 1 . 000 ... .... 0001 0 . 1 1 .... \
+                 @1reg_imm cmode=1 op=1
+  VBIC_1r        1111 001 . 1 . 000 ... .... 0011 0 . 1 1 .... \
+                 @1reg_imm cmode=3 op=1
+  VBIC_1r        1111 001 . 1 . 000 ... .... 0101 0 . 1 1 .... \
+                 @1reg_imm cmode=5 op=1
+  VBIC_1r        1111 001 . 1 . 000 ... .... 0111 0 . 1 1 .... \
+                 @1reg_imm cmode=7 op=1
+  VBIC_1r        1111 001 . 1 . 000 ... .... 1001 0 . 1 1 .... \
+                 @1reg_imm cmode=9 op=1
+  VBIC_1r        1111 001 . 1 . 000 ... .... 1011 0 . 1 1 .... \
+                 @1reg_imm cmode=11 op=1
+
+  # A VMVN special case: cmode == 14 op == 1
+  VMVN_14_1r     1111 001 . 1 . 000 ... .... 1110 0 . 1 1 .... \
+                 @1reg_imm cmode=14 op=1
+
+  # VMOV, VMVN: all other cmode/op combinations
+  VMOV_1r        1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... \
+                 @1reg_imm
+}
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index f27fe769f85..f4eeb84541f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1821,3 +1821,154 @@ DO_FP_2SH(VCVT_SF, gen_helper_vfp_sltos)
 DO_FP_2SH(VCVT_UF, gen_helper_vfp_ultos)
 DO_FP_2SH(VCVT_FS, gen_helper_vfp_tosls_round_to_zero)
 DO_FP_2SH(VCVT_FU, gen_helper_vfp_touls_round_to_zero)
+
+static uint32_t asimd_imm_const(uint32_t imm, int cmode, int op)
+{
+    /*
+     * Expand the encoded constant.
+     * Note that cmode = 2,3,4,5,6,7,10,11,12,13 imm=0 is UNPREDICTABLE.
+     * We choose to not special-case this and will behave as if a
+     * valid constant encoding of 0 had been given.
+     * cmode = 15 op = 1 must UNDEF; we assume decode has handled that.
+     */
+    switch (cmode) {
+    case 0: case 1:
+        /* no-op */
+        break;
+    case 2: case 3:
+        imm <<= 8;
+        break;
+    case 4: case 5:
+        imm <<= 16;
+        break;
+    case 6: case 7:
+        imm <<= 24;
+        break;
+    case 8: case 9:
+        imm |= imm << 16;
+        break;
+    case 10: case 11:
+        imm = (imm << 8) | (imm << 24);
+        break;
+    case 12:
+        imm = (imm << 8) | 0xff;
+        break;
+    case 13:
+        imm = (imm << 16) | 0xffff;
+        break;
+    case 14:
+        imm |= (imm << 8) | (imm << 16) | (imm << 24);
+        if (op) {
+            imm = ~imm;
+        }
+        break;
+    case 15:
+        imm = ((imm & 0x80) << 24) | ((imm & 0x3f) << 19)
+            | ((imm & 0x40) ? (0x1f << 25) : (1 << 30));
+        break;
+    }
+    if (op) {
+        imm = ~imm;
+    }
+    return imm;
+}
+
+static bool do_1reg_imm(DisasContext *s, arg_1reg_imm *a,
+                        GVecGen2iFn *fn)
+{
+    uint32_t imm;
+    int reg_ofs, vec_size;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (a->vd & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    reg_ofs = neon_reg_offset(a->vd, 0);
+    vec_size = a->q ? 16 : 8;
+    imm = asimd_imm_const(a->imm, a->cmode, a->op);
+
+    fn(MO_32, reg_ofs, reg_ofs, imm, vec_size, vec_size);
+    return true;
+}
+
+static bool trans_VORR_1r(DisasContext *s, arg_1reg_imm *a)
+{
+    return do_1reg_imm(s, a, tcg_gen_gvec_ori);
+}
+
+static bool trans_VBIC_1r(DisasContext *s, arg_1reg_imm *a)
+{
+    /* The immediate value will be inverted, so BIC becomes AND. */
+    return do_1reg_imm(s, a, tcg_gen_gvec_andi);
+}
+
+static bool trans_VMVN_14_1r(DisasContext *s, arg_1reg_imm *a)
+{
+    /* The cmode==14 op==1 special case isn't vectorized */
+    uint32_t imm;
+    TCGv_i64 t64;
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (a->vd & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    imm = asimd_imm_const(a->imm, a->cmode, a->op);
+
+    t64 = tcg_temp_new_i64();
+    for (pass = 0; pass <= a->q; ++pass) {
+        uint64_t val = 0;
+        int n;
+
+        for (n = 0; n < 8; n++) {
+            if (imm & (1 << (n + pass * 8))) {
+                val |= 0xffull << (n * 8);
+            }
+        }
+        tcg_gen_movi_i64(t64, val);
+        neon_store_reg64(t64, a->vd + pass);
+    }
+    tcg_temp_free_i64(t64);
+    return true;
+}
+
+static void gen_VMOV_1r(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_dup_imm(MO_32, dofs, oprsz, maxsz, c);
+}
+
+static bool trans_VMOV_1r(DisasContext *s, arg_1reg_imm *a)
+{
+    /* There is one unallocated cmode/op combination in this space */
+    if (a->cmode == 15 && a->op == 1) {
+        return false;
+    }
+    return do_1reg_imm(s, a, gen_VMOV_1r);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9cc44e6258e..20d07e99053 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5232,105 +5232,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         /* Three register same length: handled by decodetree */
         return 1;
     } else if (insn & (1 << 4)) {
-        if ((insn & 0x00380080) != 0) {
-            /* Two registers and shift: handled by decodetree */
-            return 1;
-        } else { /* (insn & 0x00380080) == 0 */
-            int invert, reg_ofs, vec_size;
-
-            if (q && (rd & 1)) {
-                return 1;
-            }
-
-            op = (insn >> 8) & 0xf;
-            /* One register and immediate.  */
-            imm = (u << 7) | ((insn >> 12) & 0x70) | (insn & 0xf);
-            invert = (insn & (1 << 5)) != 0;
-            /* Note that op = 2,3,4,5,6,7,10,11,12,13 imm=0 is UNPREDICTABLE.
-             * We choose to not special-case this and will behave as if a
-             * valid constant encoding of 0 had been given.
-             */
-            switch (op) {
-            case 0: case 1:
-                /* no-op */
-                break;
-            case 2: case 3:
-                imm <<= 8;
-                break;
-            case 4: case 5:
-                imm <<= 16;
-                break;
-            case 6: case 7:
-                imm <<= 24;
-                break;
-            case 8: case 9:
-                imm |= imm << 16;
-                break;
-            case 10: case 11:
-                imm = (imm << 8) | (imm << 24);
-                break;
-            case 12:
-                imm = (imm << 8) | 0xff;
-                break;
-            case 13:
-                imm = (imm << 16) | 0xffff;
-                break;
-            case 14:
-                imm |= (imm << 8) | (imm << 16) | (imm << 24);
-                if (invert) {
-                    imm = ~imm;
-                }
-                break;
-            case 15:
-                if (invert) {
-                    return 1;
-                }
-                imm = ((imm & 0x80) << 24) | ((imm & 0x3f) << 19)
-                      | ((imm & 0x40) ? (0x1f << 25) : (1 << 30));
-                break;
-            }
-            if (invert) {
-                imm = ~imm;
-            }
-
-            reg_ofs = neon_reg_offset(rd, 0);
-            vec_size = q ? 16 : 8;
-
-            if (op & 1 && op < 12) {
-                if (invert) {
-                    /* The immediate value has already been inverted,
-                     * so BIC becomes AND.
-                     */
-                    tcg_gen_gvec_andi(MO_32, reg_ofs, reg_ofs, imm,
-                                      vec_size, vec_size);
-                } else {
-                    tcg_gen_gvec_ori(MO_32, reg_ofs, reg_ofs, imm,
-                                     vec_size, vec_size);
-                }
-            } else {
-                /* VMOV, VMVN.  */
-                if (op == 14 && invert) {
-                    TCGv_i64 t64 = tcg_temp_new_i64();
-
-                    for (pass = 0; pass <= q; ++pass) {
-                        uint64_t val = 0;
-                        int n;
-
-                        for (n = 0; n < 8; n++) {
-                            if (imm & (1 << (n + pass * 8))) {
-                                val |= 0xffull << (n * 8);
-                            }
-                        }
-                        tcg_gen_movi_i64(t64, val);
-                        neon_store_reg64(t64, rd + pass);
-                    }
-                    tcg_temp_free_i64(t64);
-                } else {
-                    tcg_gen_gvec_dup_imm(MO_32, reg_ofs, vec_size,
-                                         vec_size, imm);
-                }
-            }
-        }
+        /* Two registers and shift or reg and imm: handled by decodetree */
+        return 1;
     } else { /* (insn & 0x00800010 == 0x00800000) */
         if (size != 3) {
             op = (insn >> 8) & 0xf;
-- 
2.20.1


