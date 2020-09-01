Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B16FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423EA206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ie+3+c/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423EA206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8eB-0008Oc-Da
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD849-00011Y-Q9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD848-0006Jn-2c
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id v4so1548540wmj.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QJKPdWWI2bNrMalgLjLEBjxHbT2RGeUfNlGCficDhQk=;
 b=ie+3+c/QyAvnvK+jw9K5lWEVG0mXXEAzmFl2sVE8hfcUHpYd6mSZgPRSudsWwYBxHI
 Fako960zjFAR5czfLxf6UsOKM0Rmmu2/fKG/9tq2P17QZQliiR+e06mO6c9qPG6IoA8u
 9dFC2LE5LruRAP6Gfi89dHAssh+bQoIlmVXWNVTrhpEYkySvRH6NowNQbZ0jxRVBf5nE
 Zx8tSxDygbEQLuodStOilmnIXdaalootPNZu1k23s7Fres5Nl2mLGiIN8cSQiIaDzE2V
 oGZpbhMqHcWoPaZT6La4GDX8jY7D1gl1GtigWz/LDVUriew6KUxlQZTJmITeiVv/6eZv
 5HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QJKPdWWI2bNrMalgLjLEBjxHbT2RGeUfNlGCficDhQk=;
 b=iaxmaVn5gWBesieokymwsm1SXoFRoIQCmqPLYwH4vjjuVeJY7an/9v2SYCz1qyKjPd
 81gdzm7UBTF7ZK8G+fPQzGEkSpqoMk1wEDRZGuktFwfpZBo/yRPzt09izH7yA0hhisb4
 iRZm0CvMv3w3YLA/uetEWCxdnO2jU38gCLWFaAstsn2pfDkqG6XofcIXfo9vSTRo6lt1
 3WemkR+Jq7Maqurb1GjfDXwZ7NlrScHB+DluHoDMdM/NEi6pWfLvcA3Tlfd+VD7hAF3/
 /52gC5qI/j5Q7qCltu2utJbuVa+wgPgQUo9457Nm2nzQSyfb9qoBacNJwKlpAMxtRMTg
 JmQA==
X-Gm-Message-State: AOAM531sortq6L2gBMr2SGBSpg6TplSMXwgjX23oU3X1Oq5CsVh5/xok
 bdouMpCNu0LuIes3WE+y/8SiCWQMi4qruPCB
X-Google-Smtp-Source: ABdhPJzUsCBF3uIWkz3Q+LyB+FOaN5o2Ksrhvv4Tvz77udvm1Y75wbQUsy4mZgkJlpLEtj4OlLpmIw==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr2302520wmc.188.1598973558398; 
 Tue, 01 Sep 2020 08:19:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/47] target/arm: Implement fp16 for Neon VMUL, VMLA, VMLS
Date: Tue,  1 Sep 2020 16:18:19 +0100
Message-Id: <20200901151823.29785-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon floating-point VMUL, VMLA and VMLS to use gvec,
and use this to implement fp16 support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-45-peter.maydell@linaro.org
---
 target/arm/translate-neon.c.inc | 114 ++++++++++++++++----------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 5726afe4d72..2d4926316a4 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -2432,70 +2432,70 @@ static bool trans_VMLS_2sc(DisasContext *s, arg_2scalar *a)
     return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
 }
 
-/*
- * Rather than have a float-specific version of do_2scalar just for
- * three insns, we wrap a NeonGenTwoSingleOpFn to turn it into
- * a NeonGenTwoOpFn.
- */
-#define WRAP_FP_FN(WRAPNAME, FUNC)                              \
-    static void WRAPNAME(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm) \
-    {                                                           \
-        TCGv_ptr fpstatus = fpstatus_ptr(FPST_STD);             \
-        FUNC(rd, rn, rm, fpstatus);                             \
-        tcg_temp_free_ptr(fpstatus);                            \
+static bool do_2scalar_fp_vec(DisasContext *s, arg_2scalar *a,
+                              gen_helper_gvec_3_ptr *fn)
+{
+    /* Two registers and a scalar, using gvec */
+    int vec_size = a->q ? 16 : 8;
+    int rd_ofs = neon_reg_offset(a->vd, 0);
+    int rn_ofs = neon_reg_offset(a->vn, 0);
+    int rm_ofs;
+    int idx;
+    TCGv_ptr fpstatus;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
     }
 
-WRAP_FP_FN(gen_VMUL_F_mul, gen_helper_vfp_muls)
-WRAP_FP_FN(gen_VMUL_F_add, gen_helper_vfp_adds)
-WRAP_FP_FN(gen_VMUL_F_sub, gen_helper_vfp_subs)
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
 
-static bool trans_VMUL_F_2sc(DisasContext *s, arg_2scalar *a)
-{
-    static NeonGenTwoOpFn * const opfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_mul,
-        NULL,
-    };
+    if (!fn) {
+        /* Bad size (including size == 3, which is a different insn group) */
+        return false;
+    }
 
-    return do_2scalar(s, a, opfn[a->size], NULL);
+    if (a->q && ((a->vd | a->vn) & 1)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* a->vm is M:Vm, which encodes both register and index */
+    idx = extract32(a->vm, a->size + 2, 2);
+    a->vm = extract32(a->vm, 0, a->size + 2);
+    rm_ofs = neon_reg_offset(a->vm, 0);
+
+    fpstatus = fpstatus_ptr(a->size == 1 ? FPST_STD_F16 : FPST_STD);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, fpstatus,
+                       vec_size, vec_size, idx, fn);
+    tcg_temp_free_ptr(fpstatus);
+    return true;
 }
 
-static bool trans_VMLA_F_2sc(DisasContext *s, arg_2scalar *a)
-{
-    static NeonGenTwoOpFn * const opfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_mul,
-        NULL,
-    };
-    static NeonGenTwoOpFn * const accfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_add,
-        NULL,
-    };
+#define DO_VMUL_F_2sc(NAME, FUNC)                                       \
+    static bool trans_##NAME##_F_2sc(DisasContext *s, arg_2scalar *a)   \
+    {                                                                   \
+        static gen_helper_gvec_3_ptr * const opfn[] = {                 \
+            NULL,                                                       \
+            gen_helper_##FUNC##_h,                                      \
+            gen_helper_##FUNC##_s,                                      \
+            NULL,                                                       \
+        };                                                              \
+        if (a->size == MO_16 && !dc_isar_feature(aa32_fp16_arith, s)) { \
+            return false;                                               \
+        }                                                               \
+        return do_2scalar_fp_vec(s, a, opfn[a->size]);                  \
+    }
 
-    return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
-}
-
-static bool trans_VMLS_F_2sc(DisasContext *s, arg_2scalar *a)
-{
-    static NeonGenTwoOpFn * const opfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_mul,
-        NULL,
-    };
-    static NeonGenTwoOpFn * const accfn[] = {
-        NULL,
-        NULL, /* TODO: fp16 support */
-        gen_VMUL_F_sub,
-        NULL,
-    };
-
-    return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
-}
+DO_VMUL_F_2sc(VMUL, gvec_fmul_idx)
+DO_VMUL_F_2sc(VMLA, gvec_fmla_nf_idx)
+DO_VMUL_F_2sc(VMLS, gvec_fmls_nf_idx)
 
 WRAP_ENV_FN(gen_VQDMULH_16, gen_helper_neon_qdmulh_s16)
 WRAP_ENV_FN(gen_VQDMULH_32, gen_helper_neon_qdmulh_s32)
-- 
2.20.1


