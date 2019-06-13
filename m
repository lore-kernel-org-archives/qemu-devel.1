Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7DAC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0A321721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pm9B8KrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0A321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPd9-0003Tz-DB
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdV-0008Au-Kc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdR-0004Ua-Ky
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdQ-000438-Db
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id d18so20521369wrs.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/aAqlk8oYj8ZyZ64S2GTvSQ7Is5HR1SWh30tE9pTHjM=;
 b=pm9B8KrQ8jxtuHZpJuvsKTlDlPBHTAWGm++ocVsgMyfocOet7MYwkURzxcb6SAOrCa
 pUBRb8qDPd+YlrdDoY99ijs5diuyhvvWTSCTqDivxtZlW9l0CSUqQ8W4om/GrrRv1oIO
 PLSZjMId+Qe6CpmlkGQEhrSa8sOwK3k/HjAUKfiVmMqGsFSZgiSbN9sUm1n7TqMLx+LE
 9kmVvRyr2LwydDBXg5uTQOmxgPqvUY0oQJxipO9cgsvsfNoVFe0hFfyfHaTehxrNJLq+
 9j27GcWM9QtFt4ALAzaU4nr/cFZLUXh0eHddRE+6ibdqcH+2YsXIqVxjuMY1L19d4t/y
 cBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/aAqlk8oYj8ZyZ64S2GTvSQ7Is5HR1SWh30tE9pTHjM=;
 b=P0HZ7knD4RYVxTG+WdP/ft7ycmsoKfJDtc0EGtDEobxDdqX7Ko7G0XOxoGoQX3On4X
 9CPvsNv73F6YKyBzD3ZDOpzwg5Qiog/ZvNIHfJWMQvMMC+nZHBZw4TQ0FAk3l5KEmME2
 vGFiYCe2X7Mg3SwLXuzrya7dSjZ1Hai78y/vKHF6PaeVL2zxmSEwuVVJnarF7ST28dDL
 MdmTZj2Cxgs5pd/rORfEUqijmQVfHvW01aSS0PSPRW/PAbw4Wmy+6XdR1che721wZy3o
 JKwOcF9i2ZN+8tZlubqZQ0TK0d4dzHaSkVaLoxcBitcR3pQBauKaJhCbAvdaogdCnPc2
 LcVw==
X-Gm-Message-State: APjAAAViB1Q7gDHbSsxoe3SipWVw0hn9eRnGvrEwPdWpaxaVRx1F7aXT
 oQk/ckyVTKrvJLdW2XhW1VloEHQrQ+1eCw==
X-Google-Smtp-Source: APXvYqwRrBMmqIFmLWTYIy2bndfcW+wlWnvY7BX2ELlhcYYaR1YYZdfIYbCl3AERbTPdpjPIZsrsJA==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr29007052wrv.228.1560428092511; 
 Thu, 13 Jun 2019 05:14:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:01 +0100
Message-Id: <20190613121433.5246-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 16/48] target/arm: Move the VFP trans_*
 functions to translate-vfp.inc.c
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

Move the trans_*() functions we've just created from translate.c
to translate-vfp.inc.c. This is pure code motion with no textual
changes (this can be checked with 'git show --color-moved').

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 337 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 337 ---------------------------------
 2 files changed, 337 insertions(+), 337 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index f7535138d0f..2f070a6e0d9 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -138,3 +138,340 @@ static bool vfp_access_check(DisasContext *s)
 {
     return full_vfp_access_check(s, false);
 }
+
+static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
+{
+    uint32_t rd, rn, rm;
+    bool dp = a->dp;
+
+    if (!dc_isar_feature(aa32_vsel, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rn = a->vn;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (dp) {
+        TCGv_i64 frn, frm, dest;
+        TCGv_i64 tmp, zero, zf, nf, vf;
+
+        zero = tcg_const_i64(0);
+
+        frn = tcg_temp_new_i64();
+        frm = tcg_temp_new_i64();
+        dest = tcg_temp_new_i64();
+
+        zf = tcg_temp_new_i64();
+        nf = tcg_temp_new_i64();
+        vf = tcg_temp_new_i64();
+
+        tcg_gen_extu_i32_i64(zf, cpu_ZF);
+        tcg_gen_ext_i32_i64(nf, cpu_NF);
+        tcg_gen_ext_i32_i64(vf, cpu_VF);
+
+        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        switch (a->cc) {
+        case 0: /* eq: Z */
+            tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
+                                frn, frm);
+            break;
+        case 1: /* vs: V */
+            tcg_gen_movcond_i64(TCG_COND_LT, dest, vf, zero,
+                                frn, frm);
+            break;
+        case 2: /* ge: N == V -> N ^ V == 0 */
+            tmp = tcg_temp_new_i64();
+            tcg_gen_xor_i64(tmp, vf, nf);
+            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
+                                frn, frm);
+            tcg_temp_free_i64(tmp);
+            break;
+        case 3: /* gt: !Z && N == V */
+            tcg_gen_movcond_i64(TCG_COND_NE, dest, zf, zero,
+                                frn, frm);
+            tmp = tcg_temp_new_i64();
+            tcg_gen_xor_i64(tmp, vf, nf);
+            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
+                                dest, frm);
+            tcg_temp_free_i64(tmp);
+            break;
+        }
+        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i64(frn);
+        tcg_temp_free_i64(frm);
+        tcg_temp_free_i64(dest);
+
+        tcg_temp_free_i64(zf);
+        tcg_temp_free_i64(nf);
+        tcg_temp_free_i64(vf);
+
+        tcg_temp_free_i64(zero);
+    } else {
+        TCGv_i32 frn, frm, dest;
+        TCGv_i32 tmp, zero;
+
+        zero = tcg_const_i32(0);
+
+        frn = tcg_temp_new_i32();
+        frm = tcg_temp_new_i32();
+        dest = tcg_temp_new_i32();
+        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        switch (a->cc) {
+        case 0: /* eq: Z */
+            tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
+                                frn, frm);
+            break;
+        case 1: /* vs: V */
+            tcg_gen_movcond_i32(TCG_COND_LT, dest, cpu_VF, zero,
+                                frn, frm);
+            break;
+        case 2: /* ge: N == V -> N ^ V == 0 */
+            tmp = tcg_temp_new_i32();
+            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
+            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
+                                frn, frm);
+            tcg_temp_free_i32(tmp);
+            break;
+        case 3: /* gt: !Z && N == V */
+            tcg_gen_movcond_i32(TCG_COND_NE, dest, cpu_ZF, zero,
+                                frn, frm);
+            tmp = tcg_temp_new_i32();
+            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
+            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
+                                dest, frm);
+            tcg_temp_free_i32(tmp);
+            break;
+        }
+        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i32(frn);
+        tcg_temp_free_i32(frm);
+        tcg_temp_free_i32(dest);
+
+        tcg_temp_free_i32(zero);
+    }
+
+    return true;
+}
+
+static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
+{
+    uint32_t rd, rn, rm;
+    bool dp = a->dp;
+    bool vmin = a->op;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rn = a->vn;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
+
+    if (dp) {
+        TCGv_i64 frn, frm, dest;
+
+        frn = tcg_temp_new_i64();
+        frm = tcg_temp_new_i64();
+        dest = tcg_temp_new_i64();
+
+        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
+        if (vmin) {
+            gen_helper_vfp_minnumd(dest, frn, frm, fpst);
+        } else {
+            gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
+        }
+        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i64(frn);
+        tcg_temp_free_i64(frm);
+        tcg_temp_free_i64(dest);
+    } else {
+        TCGv_i32 frn, frm, dest;
+
+        frn = tcg_temp_new_i32();
+        frm = tcg_temp_new_i32();
+        dest = tcg_temp_new_i32();
+
+        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
+        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
+        if (vmin) {
+            gen_helper_vfp_minnums(dest, frn, frm, fpst);
+        } else {
+            gen_helper_vfp_maxnums(dest, frn, frm, fpst);
+        }
+        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i32(frn);
+        tcg_temp_free_i32(frm);
+        tcg_temp_free_i32(dest);
+    }
+
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+/*
+ * Table for converting the most common AArch32 encoding of
+ * rounding mode to arm_fprounding order (which matches the
+ * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
+ */
+static const uint8_t fp_decode_rm[] = {
+    FPROUNDING_TIEAWAY,
+    FPROUNDING_TIEEVEN,
+    FPROUNDING_POSINF,
+    FPROUNDING_NEGINF,
+};
+
+static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
+{
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_rmode;
+    int rounding = fp_decode_rm[a->rm];
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
+
+    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+
+    if (dp) {
+        TCGv_i64 tcg_op;
+        TCGv_i64 tcg_res;
+        tcg_op = tcg_temp_new_i64();
+        tcg_res = tcg_temp_new_i64();
+        tcg_gen_ld_f64(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        gen_helper_rintd(tcg_res, tcg_op, fpst);
+        tcg_gen_st_f64(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i64(tcg_op);
+        tcg_temp_free_i64(tcg_res);
+    } else {
+        TCGv_i32 tcg_op;
+        TCGv_i32 tcg_res;
+        tcg_op = tcg_temp_new_i32();
+        tcg_res = tcg_temp_new_i32();
+        tcg_gen_ld_f32(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
+        gen_helper_rints(tcg_res, tcg_op, fpst);
+        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
+        tcg_temp_free_i32(tcg_op);
+        tcg_temp_free_i32(tcg_res);
+    }
+
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    tcg_temp_free_i32(tcg_rmode);
+
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
+{
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_rmode, tcg_shift;
+    int rounding = fp_decode_rm[a->rm];
+    bool is_signed = a->op;
+
+    if (!dc_isar_feature(aa32_vcvt_dr, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
+
+    tcg_shift = tcg_const_i32(0);
+
+    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+
+    if (dp) {
+        TCGv_i64 tcg_double, tcg_res;
+        TCGv_i32 tcg_tmp;
+        tcg_double = tcg_temp_new_i64();
+        tcg_res = tcg_temp_new_i64();
+        tcg_tmp = tcg_temp_new_i32();
+        tcg_gen_ld_f64(tcg_double, cpu_env, vfp_reg_offset(1, rm));
+        if (is_signed) {
+            gen_helper_vfp_tosld(tcg_res, tcg_double, tcg_shift, fpst);
+        } else {
+            gen_helper_vfp_tould(tcg_res, tcg_double, tcg_shift, fpst);
+        }
+        tcg_gen_extrl_i64_i32(tcg_tmp, tcg_res);
+        tcg_gen_st_f32(tcg_tmp, cpu_env, vfp_reg_offset(0, rd));
+        tcg_temp_free_i32(tcg_tmp);
+        tcg_temp_free_i64(tcg_res);
+        tcg_temp_free_i64(tcg_double);
+    } else {
+        TCGv_i32 tcg_single, tcg_res;
+        tcg_single = tcg_temp_new_i32();
+        tcg_res = tcg_temp_new_i32();
+        tcg_gen_ld_f32(tcg_single, cpu_env, vfp_reg_offset(0, rm));
+        if (is_signed) {
+            gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
+        } else {
+            gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
+        }
+        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(0, rd));
+        tcg_temp_free_i32(tcg_res);
+        tcg_temp_free_i32(tcg_single);
+    }
+
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    tcg_temp_free_i32(tcg_rmode);
+
+    tcg_temp_free_i32(tcg_shift);
+
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d59fadc8fbe..62a6c860d8a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3076,343 +3076,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
     tcg_temp_free_i32(tmp);
 }
 
-static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
-{
-    uint32_t rd, rn, rm;
-    bool dp = a->dp;
-
-    if (!dc_isar_feature(aa32_vsel, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rn = a->vn;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    if (dp) {
-        TCGv_i64 frn, frm, dest;
-        TCGv_i64 tmp, zero, zf, nf, vf;
-
-        zero = tcg_const_i64(0);
-
-        frn = tcg_temp_new_i64();
-        frm = tcg_temp_new_i64();
-        dest = tcg_temp_new_i64();
-
-        zf = tcg_temp_new_i64();
-        nf = tcg_temp_new_i64();
-        vf = tcg_temp_new_i64();
-
-        tcg_gen_extu_i32_i64(zf, cpu_ZF);
-        tcg_gen_ext_i32_i64(nf, cpu_NF);
-        tcg_gen_ext_i32_i64(vf, cpu_VF);
-
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
-        switch (a->cc) {
-        case 0: /* eq: Z */
-            tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
-                                frn, frm);
-            break;
-        case 1: /* vs: V */
-            tcg_gen_movcond_i64(TCG_COND_LT, dest, vf, zero,
-                                frn, frm);
-            break;
-        case 2: /* ge: N == V -> N ^ V == 0 */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_xor_i64(tmp, vf, nf);
-            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
-                                frn, frm);
-            tcg_temp_free_i64(tmp);
-            break;
-        case 3: /* gt: !Z && N == V */
-            tcg_gen_movcond_i64(TCG_COND_NE, dest, zf, zero,
-                                frn, frm);
-            tmp = tcg_temp_new_i64();
-            tcg_gen_xor_i64(tmp, vf, nf);
-            tcg_gen_movcond_i64(TCG_COND_GE, dest, tmp, zero,
-                                dest, frm);
-            tcg_temp_free_i64(tmp);
-            break;
-        }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i64(frn);
-        tcg_temp_free_i64(frm);
-        tcg_temp_free_i64(dest);
-
-        tcg_temp_free_i64(zf);
-        tcg_temp_free_i64(nf);
-        tcg_temp_free_i64(vf);
-
-        tcg_temp_free_i64(zero);
-    } else {
-        TCGv_i32 frn, frm, dest;
-        TCGv_i32 tmp, zero;
-
-        zero = tcg_const_i32(0);
-
-        frn = tcg_temp_new_i32();
-        frm = tcg_temp_new_i32();
-        dest = tcg_temp_new_i32();
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
-        switch (a->cc) {
-        case 0: /* eq: Z */
-            tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
-                                frn, frm);
-            break;
-        case 1: /* vs: V */
-            tcg_gen_movcond_i32(TCG_COND_LT, dest, cpu_VF, zero,
-                                frn, frm);
-            break;
-        case 2: /* ge: N == V -> N ^ V == 0 */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
-            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
-                                frn, frm);
-            tcg_temp_free_i32(tmp);
-            break;
-        case 3: /* gt: !Z && N == V */
-            tcg_gen_movcond_i32(TCG_COND_NE, dest, cpu_ZF, zero,
-                                frn, frm);
-            tmp = tcg_temp_new_i32();
-            tcg_gen_xor_i32(tmp, cpu_VF, cpu_NF);
-            tcg_gen_movcond_i32(TCG_COND_GE, dest, tmp, zero,
-                                dest, frm);
-            tcg_temp_free_i32(tmp);
-            break;
-        }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i32(frn);
-        tcg_temp_free_i32(frm);
-        tcg_temp_free_i32(dest);
-
-        tcg_temp_free_i32(zero);
-    }
-
-    return true;
-}
-
-static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
-{
-    uint32_t rd, rn, rm;
-    bool dp = a->dp;
-    bool vmin = a->op;
-    TCGv_ptr fpst;
-
-    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rn = a->vn;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    if (dp) {
-        TCGv_i64 frn, frm, dest;
-
-        frn = tcg_temp_new_i64();
-        frm = tcg_temp_new_i64();
-        dest = tcg_temp_new_i64();
-
-        tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
-        if (vmin) {
-            gen_helper_vfp_minnumd(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
-        }
-        tcg_gen_st_f64(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i64(frn);
-        tcg_temp_free_i64(frm);
-        tcg_temp_free_i64(dest);
-    } else {
-        TCGv_i32 frn, frm, dest;
-
-        frn = tcg_temp_new_i32();
-        frm = tcg_temp_new_i32();
-        dest = tcg_temp_new_i32();
-
-        tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
-        tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
-        if (vmin) {
-            gen_helper_vfp_minnums(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnums(dest, frn, frm, fpst);
-        }
-        tcg_gen_st_f32(dest, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i32(frn);
-        tcg_temp_free_i32(frm);
-        tcg_temp_free_i32(dest);
-    }
-
-    tcg_temp_free_ptr(fpst);
-    return true;
-}
-
-/*
- * Table for converting the most common AArch32 encoding of
- * rounding mode to arm_fprounding order (which matches the
- * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
- */
-static const uint8_t fp_decode_rm[] = {
-    FPROUNDING_TIEAWAY,
-    FPROUNDING_TIEEVEN,
-    FPROUNDING_POSINF,
-    FPROUNDING_NEGINF,
-};
-
-static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
-{
-    uint32_t rd, rm;
-    bool dp = a->dp;
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_rmode;
-    int rounding = fp_decode_rm[a->rm];
-
-    if (!dc_isar_feature(aa32_vrint, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
-        ((a->vm | a->vd) & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-
-    if (dp) {
-        TCGv_i64 tcg_op;
-        TCGv_i64 tcg_res;
-        tcg_op = tcg_temp_new_i64();
-        tcg_res = tcg_temp_new_i64();
-        tcg_gen_ld_f64(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
-        gen_helper_rintd(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f64(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i64(tcg_op);
-        tcg_temp_free_i64(tcg_res);
-    } else {
-        TCGv_i32 tcg_op;
-        TCGv_i32 tcg_res;
-        tcg_op = tcg_temp_new_i32();
-        tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_op, cpu_env, vfp_reg_offset(dp, rm));
-        gen_helper_rints(tcg_res, tcg_op, fpst);
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(dp, rd));
-        tcg_temp_free_i32(tcg_op);
-        tcg_temp_free_i32(tcg_res);
-    }
-
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-    tcg_temp_free_i32(tcg_rmode);
-
-    tcg_temp_free_ptr(fpst);
-    return true;
-}
-
-static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
-{
-    uint32_t rd, rm;
-    bool dp = a->dp;
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_rmode, tcg_shift;
-    int rounding = fp_decode_rm[a->rm];
-    bool is_signed = a->op;
-
-    if (!dc_isar_feature(aa32_vcvt_dr, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
-        return false;
-    }
-    rd = a->vd;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    tcg_shift = tcg_const_i32(0);
-
-    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-
-    if (dp) {
-        TCGv_i64 tcg_double, tcg_res;
-        TCGv_i32 tcg_tmp;
-        tcg_double = tcg_temp_new_i64();
-        tcg_res = tcg_temp_new_i64();
-        tcg_tmp = tcg_temp_new_i32();
-        tcg_gen_ld_f64(tcg_double, cpu_env, vfp_reg_offset(1, rm));
-        if (is_signed) {
-            gen_helper_vfp_tosld(tcg_res, tcg_double, tcg_shift, fpst);
-        } else {
-            gen_helper_vfp_tould(tcg_res, tcg_double, tcg_shift, fpst);
-        }
-        tcg_gen_extrl_i64_i32(tcg_tmp, tcg_res);
-        tcg_gen_st_f32(tcg_tmp, cpu_env, vfp_reg_offset(0, rd));
-        tcg_temp_free_i32(tcg_tmp);
-        tcg_temp_free_i64(tcg_res);
-        tcg_temp_free_i64(tcg_double);
-    } else {
-        TCGv_i32 tcg_single, tcg_res;
-        tcg_single = tcg_temp_new_i32();
-        tcg_res = tcg_temp_new_i32();
-        tcg_gen_ld_f32(tcg_single, cpu_env, vfp_reg_offset(0, rm));
-        if (is_signed) {
-            gen_helper_vfp_tosls(tcg_res, tcg_single, tcg_shift, fpst);
-        } else {
-            gen_helper_vfp_touls(tcg_res, tcg_single, tcg_shift, fpst);
-        }
-        tcg_gen_st_f32(tcg_res, cpu_env, vfp_reg_offset(0, rd));
-        tcg_temp_free_i32(tcg_res);
-        tcg_temp_free_i32(tcg_single);
-    }
-
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-    tcg_temp_free_i32(tcg_rmode);
-
-    tcg_temp_free_i32(tcg_shift);
-
-    tcg_temp_free_ptr(fpst);
-
-    return true;
-}
-
 /*
  * Disassemble a VFP instruction.  Returns nonzero if an error occurred
  * (ie. an undefined instruction).
-- 
2.20.1


