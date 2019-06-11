Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B450C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5605F2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCaF04hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5605F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haeoE-00039B-C9
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQ3-0007Ms-P0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePx-0007XL-TS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePx-0007Vs-JV
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id v19so2374414wmj.5
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n3MASxtEnCokj3COittArwSNYGq/3JuuvGmF9r8yZL4=;
 b=MCaF04hcvXMGxWhChHTbxUZ9Wo/z5+TCTzJFIiD2+xbdVG3SZNf5v6Xyqlgwxx4y6E
 hMF4sfVKW9vXb8LlNkNgz1evoj9o4SzS93+IhNVI2CqOA15G1HrqRghNl0QJQ+CJOcB6
 +IpyQupcx2r0uHzw4m9QK2wANVpR3WgeMNWYQONfqDhuAWgUhxgpP+weAP+tTqCtTF1L
 Nxy5ypQVbrRAa4q8meD5Tm/yR9iAVhkJnGAV+FTYPTevRRHFiUBcZQXQF61Oz3nAYvZN
 zbsJPi18ScPR3qhdyXmqKx+BWGdPgw4NoQSP4fuRWGExi3R2NXhqQdovkxpIugFrybA0
 Q/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n3MASxtEnCokj3COittArwSNYGq/3JuuvGmF9r8yZL4=;
 b=Qy+Q3DtssXg/ZKI+Sq+rPqXVqZFVUpNqjHN7h80J68E7OcVql8tBw2WsJn6cmoCNnI
 qowMgWPt18OmxekRH6+rTdKFniNNGBa+ylZtc9m/P5Q+hKr8uGziawIOfLwTUa8v80t8
 i/n0YbdIAFMBb2wwmsAqAjSPEYPHSj0HQdUuSI4XWEbBsV/kcsIUhpINJd8OcCx4PVpv
 MtegJ8TK0PdChqTkWMpj8syZXsWAnAhkrjOT2LFad72MTkvgUJivxLgG3D9I4baBdURB
 Be+Z343AVfpp8bYZWXpiDYU+Vy2LKpMxACMIfF2fTfb4pcbYux/eQmogyuEehB9tJ3dU
 3y2A==
X-Gm-Message-State: APjAAAVG57lulVmUi3gMyU3x2yomJGqe7tOSOTAZ4KqSvUO99/fkE147
 WfmGnSoxQ2UXPpHoZJiYAyOgSg==
X-Google-Smtp-Source: APXvYqzyD5DaZT7DLUYbFuFgOj0h+DMA3lSqm/5G8SPAzhJstyadpj0tlv2mC81H7QpsQe8uvmy3kA==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr15719919wma.20.1560250455854; 
 Tue, 11 Jun 2019 03:54:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:29 +0100
Message-Id: <20190611105351.9871-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 20/42] target/arm: Convert VFP VNMLS to
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP VNMLS instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 24 +------------------
 target/arm/vfp.decode          |  5 ++++
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 00f64401dda..1d7100debe4 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1341,3 +1341,45 @@ static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
 }
+
+static void gen_VNMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /*
+     * VNMLS: -fd + (fn * fm)
+     * Note that it isn't valid to replace (-A + B) with (B - A) or similar
+     * plausible looking simplifications because this will give wrong results
+     * for NaNs.
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_muls(tmp, vn, vm, fpst);
+    gen_helper_vfp_negs(vd, vd);
+    gen_helper_vfp_adds(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VNMLS_sp(DisasContext *s, arg_VNMLS_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_VNMLS_sp, a->vd, a->vn, a->vm, true);
+}
+
+static void gen_VNMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
+{
+    /*
+     * VNMLS: -fd + (fn * fm)
+     * Note that it isn't valid to replace (-A + B) with (B - A) or similar
+     * plausible looking simplifications because this will give wrong results
+     * for NaNs.
+     */
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_helper_vfp_muld(tmp, vn, vm, fpst);
+    gen_helper_vfp_negd(vd, vd);
+    gen_helper_vfp_addd(vd, vd, tmp, fpst);
+    tcg_temp_free_i64(tmp);
+}
+
+static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index bddc0d20447..b3d0648bb50 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1393,18 +1393,6 @@ VFP_OP2(div)
 
 #undef VFP_OP2
 
-static inline void gen_vfp_F1_mul(int dp)
-{
-    /* Like gen_vfp_mul() but put result in F1 */
-    TCGv_ptr fpst = get_fpstatus_ptr(0);
-    if (dp) {
-        gen_helper_vfp_muld(cpu_F1d, cpu_F0d, cpu_F1d, fpst);
-    } else {
-        gen_helper_vfp_muls(cpu_F1s, cpu_F0s, cpu_F1s, fpst);
-    }
-    tcg_temp_free_ptr(fpst);
-}
-
 static inline void gen_vfp_F1_neg(int dp)
 {
     /* Like gen_vfp_neg() but put result in F1 */
@@ -3134,7 +3122,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 1:
+            case 0 ... 2:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3320,16 +3308,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 2: /* VNMLS: -fd + (fn * fm) */
-                    /* Note that it isn't valid to replace (-A + B) with (B - A)
-                     * or similar plausible looking simplifications
-                     * because this will give wrong results for NaNs.
-                     */
-                    gen_vfp_F1_mul(dp);
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_neg(dp);
-                    gen_vfp_add(dp);
-                    break;
                 case 3: /* VNMLA: -fd + -(fn * fm) */
                     gen_vfp_mul(dp);
                     gen_vfp_F1_neg(dp);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 7bcf2260eec..08e4f427408 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -107,3 +107,8 @@ VMLS_sp      ---- 1110 0.00 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VMLS_dp      ---- 1110 0.00 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


