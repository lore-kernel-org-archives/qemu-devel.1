Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE2C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E8621773
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8DqNydj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E8621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbP3k-0007U4-Lp
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdH-0007xz-ID
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdE-0004Hh-UH
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:32988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdA-00049C-41
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id n9so20573060wru.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Wun7v8ziEJU7Y16HcNfdAppp3ATFiw3GSpGschvFs5g=;
 b=n8DqNydjY4dkxEp2lOwg3CURchNCowlqsViLoXYOqYa8yp0nS+CZFNUnw8o4NEAom3
 /DYQ6xG3Dlx3SeCp2RBWAhBNr5E7oTvL9eEemm9INH+0KlPqniVD4mTe8G/ZQu4MZ0yD
 o5llUhkhsUFmd+a6e8+lzyr+8oYc0m7kF107EmtKHyeq/sn+M3eiLdSpWULKLrEkpPa/
 AVXWbNs6N8oROtsOecmsOyn74nX7b8iq8OgEpP0FkjGg9YccEuJIy8xizFRbNv32n1zZ
 oXDtlZQOlPBIYmkNwwR+HN6741eGWxE3FgXC/7YfQIHBsvRttiO2a8pthsc5R3MnfuPm
 iA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wun7v8ziEJU7Y16HcNfdAppp3ATFiw3GSpGschvFs5g=;
 b=P6hS6lDy0sah4sK1SFIhRQRKQMMxqU/5MVJX/D/PSKbE5neo/696x0clXlh0gLym7V
 NRIEYgfpof9rU8TiAZUr8WzFs0GufY4nvFivd91Tu9PdbxLihERY/hfptqSftw1H//os
 wLD+rCEIbUqRy3m9O7ROR+0FmcjmHkub8AXpGW2BC+T4IUDTBNMu0IWoxWNhwAWsix7R
 HxwRRomn9F25AFjkqF9DB3thMpPP8M23BnQHRV3tn3DiKnbAkp+EcetQxGJ6IVGEfXY/
 aN4my705RqgO44dxH8iNcmDPrTR9+fxRy0QEvHwJi4Pwmt7WBrlOSy3GT0euORo9b2iv
 yYZw==
X-Gm-Message-State: APjAAAX+1ufexl3KXM4djy1o+7pkyBJ7gig3Vc7bKRYxeaHYvAtM3oAv
 aBVF5IdAFWSrLkc5quBa56mMq8P15PZERA==
X-Google-Smtp-Source: APXvYqyXUzzPSIQCkB1dnLQ83s9uSh3+J8DD+ZpbdkwcOsZRQLrCRJWNA9iKcwuzBkl7EpXPkzwyQQ==
X-Received: by 2002:a05:6000:104e:: with SMTP id
 c14mr8698133wrx.71.1560428095153; 
 Thu, 13 Jun 2019 05:14:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:03 +0100
Message-Id: <20190613121433.5246-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL 18/48] target/arm: Convert "double-precision"
 register moves to decodetree
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

Convert the "double-precision" register moves to decodetree:
this covers VMOV scalar-to-gpreg, VMOV gpreg-to-scalar and VDUP.

Note that the conversion process has tightened up a few of the
UNDEF encoding checks: we now correctly forbid:
 * VMOV-to-gpr with U:opc1:opc2 == 10x00 or x0x10
 * VMOV-from-gpr with opc1:opc2 == 0x10
 * VDUP with B:E == 11
 * VDUP with Q == 1 and Vn<0> == 1

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The accesses of elements < 32 bits could be improved by doing
direct ld/st of the right size rather than 32-bit read-and-shift
or read-modify-write, but we leave this for later cleanup,
since this series is generally trying to stick to fixing
the decode.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 147 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  83 +------------------
 target/arm/vfp.decode          |  36 ++++++++
 3 files changed, 185 insertions(+), 81 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 24358f3d3eb..8b0899fa05c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -475,3 +475,150 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
 
     return true;
 }
+
+static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
+{
+    /* VMOV scalar to general purpose register */
+    TCGv_i32 tmp;
+    int pass;
+    uint32_t offset;
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+        return false;
+    }
+
+    offset = a->index << a->size;
+    pass = extract32(offset, 2, 1);
+    offset = extract32(offset, 0, 2) * 8;
+
+    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = neon_load_reg(a->vn, pass);
+    switch (a->size) {
+    case 0:
+        if (offset) {
+            tcg_gen_shri_i32(tmp, tmp, offset);
+        }
+        if (a->u) {
+            gen_uxtb(tmp);
+        } else {
+            gen_sxtb(tmp);
+        }
+        break;
+    case 1:
+        if (a->u) {
+            if (offset) {
+                tcg_gen_shri_i32(tmp, tmp, 16);
+            } else {
+                gen_uxth(tmp);
+            }
+        } else {
+            if (offset) {
+                tcg_gen_sari_i32(tmp, tmp, 16);
+            } else {
+                gen_sxth(tmp);
+            }
+        }
+        break;
+    case 2:
+        break;
+    }
+    store_reg(s, a->rt, tmp);
+
+    return true;
+}
+
+static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
+{
+    /* VMOV general purpose register to scalar */
+    TCGv_i32 tmp, tmp2;
+    int pass;
+    uint32_t offset;
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+        return false;
+    }
+
+    offset = a->index << a->size;
+    pass = extract32(offset, 2, 1);
+    offset = extract32(offset, 0, 2) * 8;
+
+    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = load_reg(s, a->rt);
+    switch (a->size) {
+    case 0:
+        tmp2 = neon_load_reg(a->vn, pass);
+        tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 8);
+        tcg_temp_free_i32(tmp2);
+        break;
+    case 1:
+        tmp2 = neon_load_reg(a->vn, pass);
+        tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 16);
+        tcg_temp_free_i32(tmp2);
+        break;
+    case 2:
+        break;
+    }
+    neon_store_reg(a->vn, pass, tmp);
+
+    return true;
+}
+
+static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
+{
+    /* VDUP (general purpose register) */
+    TCGv_i32 tmp;
+    int size, vec_size;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+        return false;
+    }
+
+    if (a->b && a->e) {
+        return false;
+    }
+
+    if (a->q && (a->vn & 1)) {
+        return false;
+    }
+
+    vec_size = a->q ? 16 : 8;
+    if (a->b) {
+        size = 0;
+    } else if (a->e) {
+        size = 1;
+    } else {
+        size = 2;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = load_reg(s, a->rt);
+    tcg_gen_gvec_dup_i32(size, neon_reg_offset(a->vn, 0),
+                         vec_size, vec_size, tmp);
+    tcg_temp_free_i32(tmp);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index bebd03f9da8..7e0771cd165 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3151,87 +3151,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             /* single register transfer */
             rd = (insn >> 12) & 0xf;
             if (dp) {
-                int size;
-                int pass;
-
-                VFP_DREG_N(rn, insn);
-                if (insn & 0xf)
-                    return 1;
-                if (insn & 0x00c00060
-                    && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
-                    return 1;
-                }
-
-                pass = (insn >> 21) & 1;
-                if (insn & (1 << 22)) {
-                    size = 0;
-                    offset = ((insn >> 5) & 3) * 8;
-                } else if (insn & (1 << 5)) {
-                    size = 1;
-                    offset = (insn & (1 << 6)) ? 16 : 0;
-                } else {
-                    size = 2;
-                    offset = 0;
-                }
-                if (insn & ARM_CP_RW_BIT) {
-                    /* vfp->arm */
-                    tmp = neon_load_reg(rn, pass);
-                    switch (size) {
-                    case 0:
-                        if (offset)
-                            tcg_gen_shri_i32(tmp, tmp, offset);
-                        if (insn & (1 << 23))
-                            gen_uxtb(tmp);
-                        else
-                            gen_sxtb(tmp);
-                        break;
-                    case 1:
-                        if (insn & (1 << 23)) {
-                            if (offset) {
-                                tcg_gen_shri_i32(tmp, tmp, 16);
-                            } else {
-                                gen_uxth(tmp);
-                            }
-                        } else {
-                            if (offset) {
-                                tcg_gen_sari_i32(tmp, tmp, 16);
-                            } else {
-                                gen_sxth(tmp);
-                            }
-                        }
-                        break;
-                    case 2:
-                        break;
-                    }
-                    store_reg(s, rd, tmp);
-                } else {
-                    /* arm->vfp */
-                    tmp = load_reg(s, rd);
-                    if (insn & (1 << 23)) {
-                        /* VDUP */
-                        int vec_size = pass ? 16 : 8;
-                        tcg_gen_gvec_dup_i32(size, neon_reg_offset(rn, 0),
-                                             vec_size, vec_size, tmp);
-                        tcg_temp_free_i32(tmp);
-                    } else {
-                        /* VMOV */
-                        switch (size) {
-                        case 0:
-                            tmp2 = neon_load_reg(rn, pass);
-                            tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 8);
-                            tcg_temp_free_i32(tmp2);
-                            break;
-                        case 1:
-                            tmp2 = neon_load_reg(rn, pass);
-                            tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 16);
-                            tcg_temp_free_i32(tmp2);
-                            break;
-                        case 2:
-                            break;
-                        }
-                        neon_store_reg(rn, pass, tmp);
-                    }
-                }
+                /* already handled by decodetree */
+                return 1;
             } else { /* !dp */
                 bool is_sysreg;
 
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 28ee664d8c3..8286bdc0729 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -26,3 +26,39 @@
 #  1110 1110 .... .... .... 101. .... ....
 # (but those patterns might also cover some Neon instructions,
 # which do not live in this file.)
+
+# VFP registers have an odd encoding with a four-bit field
+# and a one-bit field which are assembled in different orders
+# depending on whether the register is double or single precision.
+# Each individual instruction function must do the checks for
+# "double register selected but CPU does not have double support"
+# and "double register number has bit 4 set but CPU does not
+# support D16-D31" (which should UNDEF).
+%vm_dp  5:1 0:4
+%vm_sp  0:4 5:1
+%vn_dp  7:1 16:4
+%vn_sp  16:4 7:1
+%vd_dp  22:1 12:4
+%vd_sp  12:4 22:1
+
+%vmov_idx_b     21:1 5:2
+%vmov_idx_h     21:1 6:1
+
+# VMOV scalar to general-purpose register; note that this does
+# include some Neon cases.
+VMOV_to_gp   ---- 1110 u:1 1.        1 .... rt:4 1011 ... 1 0000 \
+             vn=%vn_dp size=0 index=%vmov_idx_b
+VMOV_to_gp   ---- 1110 u:1 0.        1 .... rt:4 1011 ..1 1 0000 \
+             vn=%vn_dp size=1 index=%vmov_idx_h
+VMOV_to_gp   ---- 1110 0   0 index:1 1 .... rt:4 1011 .00 1 0000 \
+             vn=%vn_dp size=2 u=0
+
+VMOV_from_gp ---- 1110 0 1.        0 .... rt:4 1011 ... 1 0000 \
+             vn=%vn_dp size=0 index=%vmov_idx_b
+VMOV_from_gp ---- 1110 0 0.        0 .... rt:4 1011 ..1 1 0000 \
+             vn=%vn_dp size=1 index=%vmov_idx_h
+VMOV_from_gp ---- 1110 0 0 index:1 0 .... rt:4 1011 .00 1 0000 \
+             vn=%vn_dp size=2
+
+VDUP         ---- 1110 1 b:1 q:1 0 .... rt:4 1011 . 0 e:1 1 0000 \
+             vn=%vn_dp
-- 
2.20.1


