Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF803C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28FC2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwoSxga9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28FC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPkq-0001S5-UZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdt-0008TP-Qp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdX-0004is-N2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdX-0004dN-1S
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id c66so9956600wmf.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UWZ8POqtCLLS+7rTG+ATFraE2eoKU38JQdvr+gOnm4E=;
 b=rwoSxga9YcTH0TJ/d3JVVO2z1lFR+N14ciXmtQyMKgwMulsEfeHn+xpXs0JruILQAs
 MkwWWxx5vdKbC+hJbZHrHcIYAFdxcWwbSGXeOP5dacv2nfZzr0AIZsQ0zCno5olxfXAJ
 0ysTKT/+da/gZFCrlsHs033IFkzn//1AnWmVg5oP4hsi+i8OPwG/L7u91kHQHNPmBUpL
 h1CNmPp1rbtL38OEkG6dzrORk2SDeumhiVPAkNeHdrgix3fhRQshINuTblWTERwkazAT
 0hAk7l6+UC9xrIGj/7pF1RMXe3aXFZS5lEjkjywZ6wNB555tXXnkkKboIpFz1QEJ1EOI
 rJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UWZ8POqtCLLS+7rTG+ATFraE2eoKU38JQdvr+gOnm4E=;
 b=JhpmNsKIUqRRnxLvV7++LZV8h+AkagBcIWCJqYOIaKd/GL4U1POqM2AABbSQM+Y9KC
 Iv7mikGaoswLsmlQPMTBVNc77omsbIYPkLqBfFwz51msnbSq+wekvjvSVU84mS0dUfiP
 9f2lOOsRK3nKc2Nx+bYV4HyZLxopCr8S1knDHN2rqwXrYo14S+A9ZRgYykvgYji6/YG8
 LA34yokk/4mSAldXQaOIyfMZT6gcHSLeNOsFxxlh0y6aEhjcC/KtB71mgOheL4/HSXAP
 BvYJ3dacmAapwNPAQszV2Bela+ig6VMLfUsbrqbXFhHy7SmizRjmZOUi49zw2YgRyhN3
 dUSQ==
X-Gm-Message-State: APjAAAXQbNEGktzsrZk9wJhEgs2y5UTYlzuwKjQu0YvuMY3lG3FlJBhD
 NKU1NbZMam6gx3RpUI+WJw6UP/yqz8oFdA==
X-Google-Smtp-Source: APXvYqyHv2k90H4st3OSqBYGe+d/LRpsRYvtr6kqgOLqDOB5lIqIECd/+SgFzAFrfiqo09w8I8WLeg==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr3589122wms.8.1560428120342;
 Thu, 13 Jun 2019 05:15:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:27 +0100
Message-Id: <20190613121433.5246-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 42/48] target/arm: Convert VFP round insns to
 decodetree
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

Convert the VFP round-to-integer instructions VRINTR, VRINTZ and
VRINTX to decodetree.

These instructions were only introduced as part of the "VFP misc"
additions in v8A, so we check this. The old decoder's implementation
was incorrectly providing them even for v7A CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 163 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  45 +--------
 target/arm/vfp.decode          |  15 +++
 3 files changed, 179 insertions(+), 44 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index a19ede86719..e94a8f2f0c5 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2157,3 +2157,166 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     tcg_temp_free_i32(tmp);
     return true;
 }
+
+static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rints(tmp, tmp, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i64 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i64();
+    neon_load_reg64(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rintd(tmp, tmp, fpst);
+    neon_store_reg64(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
+
+static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+    TCGv_i32 tcg_rmode;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    tcg_rmode = tcg_const_i32(float_round_to_zero);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    gen_helper_rints(tmp, tmp, fpst);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tcg_rmode);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i64 tmp;
+    TCGv_i32 tcg_rmode;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i64();
+    neon_load_reg64(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    tcg_rmode = tcg_const_i32(float_round_to_zero);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    gen_helper_rintd(tmp, tmp, fpst);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    neon_store_reg64(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i32(tcg_rmode);
+    return true;
+}
+
+static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rints_exact(tmp, tmp, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i64 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i64();
+    neon_load_reg64(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rintd_exact(tmp, tmp, fpst);
+    neon_store_reg64(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 21423b264fa..0c855069d85 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 11:
+                case 0 ... 14:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,11 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x0c: /* vrintr */
-                case 0x0d: /* vrintz */
-                case 0x0e: /* vrintx */
-                    break;
-
                 case 0x0f: /* vcvt double<->single */
                     rd_is_dp = !dp;
                     break;
@@ -3190,44 +3185,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 12: /* vrintr */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(0);
-                        if (dp) {
-                            gen_helper_rintd(cpu_F0d, cpu_F0d, fpst);
-                        } else {
-                            gen_helper_rints(cpu_F0s, cpu_F0s, fpst);
-                        }
-                        tcg_temp_free_ptr(fpst);
-                        break;
-                    }
-                    case 13: /* vrintz */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(0);
-                        TCGv_i32 tcg_rmode;
-                        tcg_rmode = tcg_const_i32(float_round_to_zero);
-                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-                        if (dp) {
-                            gen_helper_rintd(cpu_F0d, cpu_F0d, fpst);
-                        } else {
-                            gen_helper_rints(cpu_F0s, cpu_F0s, fpst);
-                        }
-                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-                        tcg_temp_free_i32(tcg_rmode);
-                        tcg_temp_free_ptr(fpst);
-                        break;
-                    }
-                    case 14: /* vrintx */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(0);
-                        if (dp) {
-                            gen_helper_rintd_exact(cpu_F0d, cpu_F0d, fpst);
-                        } else {
-                            gen_helper_rints_exact(cpu_F0s, cpu_F0s, fpst);
-                        }
-                        tcg_temp_free_ptr(fpst);
-                        break;
-                    }
                     case 15: /* single<->double conversion */
                         if (dp) {
                             gen_helper_vfp_fcvtsd(cpu_F0s, cpu_F0d, cpu_env);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index b88d1d06f02..9942d2ae7ad 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -193,3 +193,18 @@ VCVT_f16_f32 ---- 1110 1.11 0011 .... 1010 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_f16_f64 ---- 1110 1.11 0011 .... 1011 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+VRINTR_sp    ---- 1110 1.11 0110 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VRINTR_dp    ---- 1110 1.11 0110 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
+
+VRINTZ_sp    ---- 1110 1.11 0110 .... 1010 11.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VRINTZ_dp    ---- 1110 1.11 0110 .... 1011 11.0 .... \
+             vd=%vd_dp vm=%vm_dp
+
+VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


