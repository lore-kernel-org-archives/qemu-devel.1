Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B55C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932182147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALMXSS7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932182147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPkE-0000XU-UM
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdr-0008R0-SO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdW-0004fO-8Y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdV-0004DD-I8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so9882387wmg.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9pWSJmsiYxVaBT4ZhuUEOssPCHT4ENw/4ruzvNmgVzc=;
 b=ALMXSS7siIl0gHl2/VshaCisXwC0DAT0vjZEashtRRo/A9ZYVIRabYZ2NYyW+VQkzm
 dyGthGcY0kR/lh/tFCY0MkxczlYMpu5amH562hAG9f765o6JvC34qdYZBBnBReF5sY/5
 zYawAN4PPjLZF4FDO7CveXaJfS7pQGdDr+Qk9kXZCSz+Ot7AU3bvoy+kR7rp7GCUqpVC
 W3kxV2+PgDYAQz51Ks2vFqUf9ydrWrq9cQKwRV7x19EXCEvgba9dgTG/aX/zCREpkIAr
 MIj5RhEJqV903mBuz9P6uobkhQlx0WY0cc6hfVQLF4zkK7LqNV33HscY6SwZyyO0zd0R
 nx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9pWSJmsiYxVaBT4ZhuUEOssPCHT4ENw/4ruzvNmgVzc=;
 b=GUg3+bdWXIh1KCI8fsab+XkMacSD2teUwiYYMByUzILqwdLxMyM7ugwC5Raf1VO6Yl
 Rqh3/7k7SjfqF2UY99dN/1nhIDlQOx2442t4w8N6uMQe29PJTFwUDx7yo2Fw59vA+eSt
 fB3Oe0k7Eb3nS3S33qUBjbGex90qhOB/inkLB9RSosc6Bk26RU/+bYI5Ri/J3C9yD693
 kyN4a7wkiictaZ+MVnu6kct8svdDDHgueyUDVqqVEUcnJ0dBKLsuaEbgitpe4Fm4CLGv
 YtyofIObPXyCIZzXEr7KpU3Ht7z0MCQCVadm2Ewx8UATTgDf3ixswYChWTfSxpAJqOpa
 J/8A==
X-Gm-Message-State: APjAAAX3u4gEOPArdRkJ0AssB/FL7OC8Su6BZBx7hlyQJBJnD+NwkdnY
 sGcvjuzq1j6ztoUxQo7DKhCMjbQ+dIezPw==
X-Google-Smtp-Source: APXvYqwWZc2GLOfUMTRkaBKVMbNFnTcPUUV878MLNdXli11/rhfcgiZIzQGwkqZ4JIAMjzlp4y+MFA==
X-Received: by 2002:a05:600c:20ca:: with SMTP id
 y10mr3445878wmm.72.1560428100032; 
 Thu, 13 Jun 2019 05:15:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:07 +0100
Message-Id: <20190613121433.5246-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 22/48] target/arm: Convert the VFP load/store
 multiple insns to decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP load/store multiple insns to decodetree.
This includes tightening up the UNDEF checking for pre-VFPv3
CPUs which only have D0-D15 : they now UNDEF for any access
to D16-D31, not merely when the smallest register in the
transfer list is in D16-D31.

This conversion does not try to share code between the single
precision and the double precision versions; this looks a bit
duplicative of code, but it leaves the door open for a future
refactoring which gets rid of the use of the "F0" registers
by inlining the various functions like gen_vfp_ld() and
gen_mov_F0_reg() which are hiding "if (dp) { ... } else { ... }"
conditionalisation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 162 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  97 +-------------------
 target/arm/vfp.decode          |  18 ++++
 3 files changed, 183 insertions(+), 94 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 40f2cac3e2e..32a1805e582 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -926,3 +926,165 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 
     return true;
 }
+
+static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr;
+    int i, n;
+
+    n = a->imm;
+
+    if (n == 0 || (a->vd + n) > 32) {
+        /*
+         * UNPREDICTABLE cases for bad immediates: we choose to
+         * UNDEF to avoid generating huge numbers of TCG ops
+         */
+        return false;
+    }
+    if (a->rn == 15 && a->w) {
+        /* writeback to PC is UNPREDICTABLE, we choose to UNDEF */
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (s->thumb && a->rn == 15) {
+        /* This is actually UNPREDICTABLE */
+        addr = tcg_temp_new_i32();
+        tcg_gen_movi_i32(addr, s->pc & ~2);
+    } else {
+        addr = load_reg(s, a->rn);
+    }
+    if (a->p) {
+        /* pre-decrement */
+        tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
+    }
+
+    if (s->v8m_stackcheck && a->rn == 13 && a->w) {
+        /*
+         * Here 'addr' is the lowest address we will store to,
+         * and is either the old SP (if post-increment) or
+         * the new SP (if pre-decrement). For post-increment
+         * where the old value is below the limit and the new
+         * value is above, it is UNKNOWN whether the limit check
+         * triggers; we choose to trigger.
+         */
+        gen_helper_v8m_stackcheck(cpu_env, addr);
+    }
+
+    offset = 4;
+    for (i = 0; i < n; i++) {
+        if (a->l) {
+            /* load */
+            gen_vfp_ld(s, false, addr);
+            gen_mov_vreg_F0(false, a->vd + i);
+        } else {
+            /* store */
+            gen_mov_F0_vreg(false, a->vd + i);
+            gen_vfp_st(s, false, addr);
+        }
+        tcg_gen_addi_i32(addr, addr, offset);
+    }
+    if (a->w) {
+        /* writeback */
+        if (a->p) {
+            offset = -offset * n;
+            tcg_gen_addi_i32(addr, addr, offset);
+        }
+        store_reg(s, a->rn, addr);
+    } else {
+        tcg_temp_free_i32(addr);
+    }
+
+    return true;
+}
+
+static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr;
+    int i, n;
+
+    n = a->imm >> 1;
+
+    if (n == 0 || (a->vd + n) > 32 || n > 16) {
+        /*
+         * UNPREDICTABLE cases for bad immediates: we choose to
+         * UNDEF to avoid generating huge numbers of TCG ops
+         */
+        return false;
+    }
+    if (a->rn == 15 && a->w) {
+        /* writeback to PC is UNPREDICTABLE, we choose to UNDEF */
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd + n) > 16) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (s->thumb && a->rn == 15) {
+        /* This is actually UNPREDICTABLE */
+        addr = tcg_temp_new_i32();
+        tcg_gen_movi_i32(addr, s->pc & ~2);
+    } else {
+        addr = load_reg(s, a->rn);
+    }
+    if (a->p) {
+        /* pre-decrement */
+        tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
+    }
+
+    if (s->v8m_stackcheck && a->rn == 13 && a->w) {
+        /*
+         * Here 'addr' is the lowest address we will store to,
+         * and is either the old SP (if post-increment) or
+         * the new SP (if pre-decrement). For post-increment
+         * where the old value is below the limit and the new
+         * value is above, it is UNKNOWN whether the limit check
+         * triggers; we choose to trigger.
+         */
+        gen_helper_v8m_stackcheck(cpu_env, addr);
+    }
+
+    offset = 8;
+    for (i = 0; i < n; i++) {
+        if (a->l) {
+            /* load */
+            gen_vfp_ld(s, true, addr);
+            gen_mov_vreg_F0(true, a->vd + i);
+        } else {
+            /* store */
+            gen_mov_F0_vreg(true, a->vd + i);
+            gen_vfp_st(s, true, addr);
+        }
+        tcg_gen_addi_i32(addr, addr, offset);
+    }
+    if (a->w) {
+        /* writeback */
+        if (a->p) {
+            offset = -offset * n;
+        } else if (a->imm & 1) {
+            offset = 4;
+        } else {
+            offset = 0;
+        }
+
+        if (offset != 0) {
+            tcg_gen_addi_i32(addr, addr, offset);
+        }
+        store_reg(s, a->rn, addr);
+    } else {
+        tcg_temp_free_i32(addr);
+    }
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0c92f3ed4ec..f9b07247b4c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3092,9 +3092,8 @@ static void gen_neon_dup_high16(TCGv_i32 var)
  */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, op, i, n, offset, delta_d, delta_m, bank_mask;
+    uint32_t rd, rn, rm, op, i, n, delta_d, delta_m, bank_mask;
     int dp, veclen;
-    TCGv_i32 addr;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
 
@@ -3702,98 +3701,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         break;
     case 0xc:
     case 0xd:
-        if ((insn & 0x03e00000) == 0x00400000) {
-            /* Already handled by decodetree */
-            return 1;
-        } else {
-            /* Load/store */
-            rn = (insn >> 16) & 0xf;
-            if (dp)
-                VFP_DREG_D(rd, insn);
-            else
-                rd = VFP_SREG_D(insn);
-            if ((insn & 0x01200000) == 0x01000000) {
-                /* Already handled by decodetree */
-                return 1;
-            } else {
-                /* load/store multiple */
-                int w = insn & (1 << 21);
-                if (dp)
-                    n = (insn >> 1) & 0x7f;
-                else
-                    n = insn & 0xff;
-
-                if (w && !(((insn >> 23) ^ (insn >> 24)) & 1)) {
-                    /* P == U , W == 1  => UNDEF */
-                    return 1;
-                }
-                if (n == 0 || (rd + n) > 32 || (dp && n > 16)) {
-                    /* UNPREDICTABLE cases for bad immediates: we choose to
-                     * UNDEF to avoid generating huge numbers of TCG ops
-                     */
-                    return 1;
-                }
-                if (rn == 15 && w) {
-                    /* writeback to PC is UNPREDICTABLE, we choose to UNDEF */
-                    return 1;
-                }
-
-                if (s->thumb && rn == 15) {
-                    /* This is actually UNPREDICTABLE */
-                    addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~2);
-                } else {
-                    addr = load_reg(s, rn);
-                }
-                if (insn & (1 << 24)) /* pre-decrement */
-                    tcg_gen_addi_i32(addr, addr, -((insn & 0xff) << 2));
-
-                if (s->v8m_stackcheck && rn == 13 && w) {
-                    /*
-                     * Here 'addr' is the lowest address we will store to,
-                     * and is either the old SP (if post-increment) or
-                     * the new SP (if pre-decrement). For post-increment
-                     * where the old value is below the limit and the new
-                     * value is above, it is UNKNOWN whether the limit check
-                     * triggers; we choose to trigger.
-                     */
-                    gen_helper_v8m_stackcheck(cpu_env, addr);
-                }
-
-                if (dp)
-                    offset = 8;
-                else
-                    offset = 4;
-                for (i = 0; i < n; i++) {
-                    if (insn & ARM_CP_RW_BIT) {
-                        /* load */
-                        gen_vfp_ld(s, dp, addr);
-                        gen_mov_vreg_F0(dp, rd + i);
-                    } else {
-                        /* store */
-                        gen_mov_F0_vreg(dp, rd + i);
-                        gen_vfp_st(s, dp, addr);
-                    }
-                    tcg_gen_addi_i32(addr, addr, offset);
-                }
-                if (w) {
-                    /* writeback */
-                    if (insn & (1 << 24))
-                        offset = -offset * n;
-                    else if (dp && (insn & 1))
-                        offset = 4;
-                    else
-                        offset = 0;
-
-                    if (offset != 0)
-                        tcg_gen_addi_i32(addr, addr, offset);
-                    store_reg(s, rn, addr);
-                } else {
-                    tcg_temp_free_i32(addr);
-                }
-            }
-        }
-        break;
+        /* Already handled by decodetree */
+        return 1;
     default:
         /* Should never happen.  */
         return 1;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 8fa7fa0bead..68c9ffcfd3c 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -78,3 +78,21 @@ VLDR_VSTR_sp ---- 1101 u:1 .0 l:1 rn:4 .... 1010 imm:8 \
              vd=%vd_sp
 VLDR_VSTR_dp ---- 1101 u:1 .0 l:1 rn:4 .... 1011 imm:8 \
              vd=%vd_dp
+
+# We split the load/store multiple up into two patterns to avoid
+# overlap with other insns in the "Advanced SIMD load/store and 64-bit move"
+# grouping:
+#   P=0 U=0 W=0 is 64-bit VMOV
+#   P=1 W=0 is VLDR/VSTR
+#   P=U W=1 is UNDEF
+# leaving P=0 U=1 W=x and P=1 U=0 W=1 for load/store multiple.
+# These include FSTM/FLDM.
+VLDM_VSTM_sp ---- 1100 1 . w:1 l:1 rn:4 .... 1010 imm:8 \
+             vd=%vd_sp p=0 u=1
+VLDM_VSTM_dp ---- 1100 1 . w:1 l:1 rn:4 .... 1011 imm:8 \
+             vd=%vd_dp p=0 u=1
+
+VLDM_VSTM_sp ---- 1101 0.1 l:1 rn:4 .... 1010 imm:8 \
+             vd=%vd_sp p=1 u=0 w=1
+VLDM_VSTM_dp ---- 1101 0.1 l:1 rn:4 .... 1011 imm:8 \
+             vd=%vd_dp p=1 u=0 w=1
-- 
2.20.1


