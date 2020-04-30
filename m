Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B2C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5E220870
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ul7PTTVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5E220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDjI-0001Iq-DU
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdv-0001Ok-D5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdX-0000VZ-Cd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdW-0000QE-OW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id z6so3079372wml.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XnXDSVyzZWZjdX4ANWhTglZeil8eXcC0WohiZGPb7HI=;
 b=ul7PTTVKdJRlwfCnzQJ/lmbwfvvxYv3rrV/TXzbAoU187elCk50ci5g11G9TbdC/uB
 rJMSK4CfqzvtXWUQB0hrCEgh6AKg0pPwDpLy6SgTQwQQ94KOjS6Q1bvTON4HkAwPVmFD
 EUoiFl9erPToF+RpzmLH9osuEdFyn6UPkEF15uiV6xEtkrlI0J+LduHQTk0cZMV405Ug
 epvmY0euMoIyU5WdLA3X8sPXm+DZ5x4MZVvS3AOVrFrbXSUvvZqgBvBOVfrCenqX7brd
 kOcfssYlm9g1181LUyXvi7nOgOzVENbpmQJ3D3doZ6ZMyCSvqsJ2ITvE1w5b38S+5THI
 V6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XnXDSVyzZWZjdX4ANWhTglZeil8eXcC0WohiZGPb7HI=;
 b=NUJjxrSjyeCr9HeMPWlLEBICkjUj651gaGqv6fwhiRKl1gRmIfCm4KX1Nvhdy2ulUp
 I2gHnm7H1ZZBBrr7gN7jrX1NeM19m3nKba5+LIfnFBbemwKVOhowFvyr3l3pTok43+6D
 fJyznQGyW6tZrSDYG+8XDOK+hYfwpPZTAnUaspfdA6N1oqvixQcRvRJ1h7FY8jPanFMt
 hDmRJywOrDKUqTloMYAk6p0DHQAk01LcG8islzG9jfRf2VC2NsaBHtEV33b8g1m1Z3Je
 ZHj1ygw+cosfZkuVf1vVb8z3POYQ84zY3cEU3Q+pE0pJFZxN2HsOr9deMX0irOlmD/LP
 zacQ==
X-Gm-Message-State: AGi0Pub4u86Um2dcop0hkZL0GvqQw41q58YiMxFuzQhnOdwlTru96D73
 R46sQPoNnwQpKiL1vpl8nz/F5A==
X-Google-Smtp-Source: APiQypJ3m8MA2RKDWt6CJZ5kby130yQyfjnzc7mBLuub37jlObF8xxNJvLkc/l7sGvypXDUhUefQ4Q==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr4284482wmi.88.1588270213204; 
 Thu, 30 Apr 2020 11:10:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/36] target/arm: Convert VCADD (vector) to decodetree
Date: Thu, 30 Apr 2020 19:09:32 +0100
Message-Id: <20200430181003.21682-6-peter.maydell@linaro.org>
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

Convert the VCADD (vector) insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 37 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 11 +---------
 target/arm/neon-shared.decode   |  3 +++
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0baae1338a3..28011e88d9e 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -67,3 +67,40 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
+{
+    int opr_sz;
+    TCGv_ptr fpst;
+    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+
+    if (!dc_isar_feature(aa32_vcma, s)
+        || (!a->size && !dc_isar_feature(aa32_fp16_arith, s))) {
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
+    fpst = get_fpstatus_ptr(1);
+    fn_gvec_ptr = a->size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       fpst, opr_sz, opr_sz, a->rot,
+                       fn_gvec_ptr);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 17167634e29..571b64aa89d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7048,16 +7048,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xfea00f10) == 0xfc800800) {
-        /* VCADD -- 1111 110R 1.0S .... .... 1000 ...0 .... */
-        int size = extract32(insn, 20, 1);
-        data = extract32(insn, 24, 1); /* rot */
-        if (!dc_isar_feature(aa32_vcma, s)
-            || (!size && !dc_isar_feature(aa32_fp16_arith, s))) {
-            return 1;
-        }
-        fn_gvec_ptr = size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
-    } else if ((insn & 0xfeb00f00) == 0xfc200d00) {
+    if ((insn & 0xfeb00f00) == 0xfc200d00) {
         /* V[US]DOT -- 1111 1100 0.10 .... .... 1101 .Q.U .... */
         bool u = extract32(insn, 4, 1);
         if (!dc_isar_feature(aa32_dp, s)) {
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index d1d707a56d5..ed65dae1809 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -36,3 +36,6 @@
 
 VCMLA          1111 110 rot:2 . 1 size:1 .... .... 1000 . q:1 . 0 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VCADD          1111 110 rot:1 1 . 0 size:1 .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


