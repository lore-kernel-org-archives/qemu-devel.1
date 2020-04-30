Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F836C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2CD20836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwZPcSth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2CD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDmq-0006Rz-Ul
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdx-0001Ou-4j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdY-0000Za-6a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdX-0000UB-Q6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id z6so3079445wml.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pxfsuF90gF/QlbN2JtQ5HjFSNuD7mNzJPj+VVM2zoKo=;
 b=cwZPcSthHybqTQCL3yyXcxaqrdS+/yNB03OCiNsLxoGAgCtofedkUWy4//0ZDRIzG/
 ZMg6lxJUMBw3XmCTaneK1318a8nQZMlBl7QLLq3Mzl22x8ccAU++uQfG5kSOuaTu4+KB
 gBBfstJDRJiC865ATcltSgo0R45Lb1vF1n19d83/iLKLMJUvQ9v/I17xcah07wKyAmx0
 MAYZMgjBebzdws7AxXVCrpJdK5cdlgB0XbF/EwWAR+Kz9pEQEMlY7YPJZqu79sgaffiq
 IVoYrh+7lSwifSgDhRyc56odpb/TP6AJQWuI1+/p4jW3qjbLZD0b+Q4mD31d7TpnPTuQ
 BJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pxfsuF90gF/QlbN2JtQ5HjFSNuD7mNzJPj+VVM2zoKo=;
 b=ueGrA8rScn0CxWNJGIrv1rCzdqMeWnKXvNn933BavYLUE7sbyubEH4v0JOlwIe18gX
 DBYeKc2mW2Vm1JEWTwHzTDr4Ef4QKaNlMymU4lx7F4/+xk4WC97yuEeVuOvc72UVkb//
 OkoYtRPL0lVutxT3/gF0o+HpDaFTzlhSzFpiJK65soFp+sOscop1uwIvy1DWOFBrTXwv
 yXpljaIA5EL+tTAfSdGeWA5Ii/xQZ8nQIUhzVGiSkgwLrkhCrKJ9z1H2wB6u+ShaL9K3
 QQ4dHYlD9SXpcJzgl+jcVcsPSo+2IsMMruSW7GMdwIogn9c0I1XSAznNa3sg/K/f3vfu
 kicg==
X-Gm-Message-State: AGi0PuZSLXtqhvLB6WR5wfHcgPIE3JpVIaKLZsC6ITc4a/r8xFG8LXpl
 9rEp5IalHB3tJqZWhg/HI5LySQ==
X-Google-Smtp-Source: APiQypI+qzLiS2kMMzCQu6roy6QVQqeuOH3ANWr1t3WXVv2VtCXlb81YJJjjWw3oCJt/MHfxCQZCKg==
X-Received: by 2002:a1c:8141:: with SMTP id c62mr4305922wmd.87.1588270214400; 
 Thu, 30 Apr 2020 11:10:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/36] target/arm: Convert V[US]DOT (vector) to decodetree
Date: Thu, 30 Apr 2020 19:09:33 +0100
Message-Id: <20200430181003.21682-7-peter.maydell@linaro.org>
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

Convert the V[US]DOT (vector) insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 32 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  9 +--------
 target/arm/neon-shared.decode   |  4 ++++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 28011e88d9e..6537506c5b6 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -104,3 +104,35 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VDOT(DisasContext *s, arg_VDOT *a)
+{
+    int opr_sz;
+    gen_helper_gvec_3 *fn_gvec;
+
+    if (!dc_isar_feature(aa32_dp, s)) {
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
+    opr_sz = (1 + a->q) * 8;
+    fn_gvec = a->u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
+    tcg_gen_gvec_3_ool(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       opr_sz, opr_sz, 0, fn_gvec);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 571b64aa89d..1190ad17cfd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7048,14 +7048,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xfeb00f00) == 0xfc200d00) {
-        /* V[US]DOT -- 1111 1100 0.10 .... .... 1101 .Q.U .... */
-        bool u = extract32(insn, 4, 1);
-        if (!dc_isar_feature(aa32_dp, s)) {
-            return 1;
-        }
-        fn_gvec = u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
-    } else if ((insn & 0xff300f10) == 0xfc200810) {
+    if ((insn & 0xff300f10) == 0xfc200810) {
         /* VFM[AS]L -- 1111 1100 S.10 .... .... 1000 .Q.1 .... */
         int is_s = extract32(insn, 23, 1);
         if (!dc_isar_feature(aa32_fhm, s)) {
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index ed65dae1809..c9c641905d3 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -39,3 +39,7 @@ VCMLA          1111 110 rot:2 . 1 size:1 .... .... 1000 . q:1 . 0 .... \
 
 VCADD          1111 110 rot:1 1 . 0 size:1 .... .... 1000 . q:1 . 0 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+# VUDOT and VSDOT
+VDOT           1111 110 00 . 10 .... .... 1101 . q:1 . u:1 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


