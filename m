Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6CDC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696F220787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQjBsTPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696F220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDyg-0001eA-Eb
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeX-0002VV-Pk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdz-0001KJ-6Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdy-0001J3-HU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id u127so3087387wmg.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JwbXqF77a6fQmoa2jYeTO1NO0SsDTG6KHF0nvVXllEU=;
 b=xQjBsTPIS+OilQStQBkWmxLItw1sfAOBa//TJst5E+8mDoT6JDQfm2NhJU8FOfwu23
 wSrFuDHcS9Z1m/3wZIzHgXT8KBhFWRkQm6KkQA8AGu+n/aXKvIJtOr8BsysPG6Cm3G7v
 e5olbQ2gq5T5pKW3eRfKxoBxH21IZFc1CfgsRz+iNzBZv2KgYZLaRUt+Nb6/3ZymeRTL
 sIsQZ8Lw7ijYONUBOgP3hNXsiI6we8D/UDUm3j3M7YV/fts3aP6m+GVa8PyTDXtHbkdI
 btcwj2djMYLCZOZD5uaD5Z97hSYuCVkR5yTiuXbgkqojG+dpuvejHMikg08wdFolhKD/
 H4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JwbXqF77a6fQmoa2jYeTO1NO0SsDTG6KHF0nvVXllEU=;
 b=f06VsyOAfSRBBYg2BXgXLPffMym4AUOKzhw8uwK4CWCfvrFJ5eML+8rZ4vqnQkFyjQ
 lPwjh5odC5wcD2diFm3xfkmMNRwpr37hNKWyM7Wjf1Wponi/r4cctnFXOnT7eaIKOCSE
 xxUJZgFhalKNOepUuqCNMShkhBsQm2lS3abyK2rDfNrRjwqCPkFzWwMnWLUa2OCckpSy
 wP3ZC8xTPrzkOXrtKAC6jpswViYGqr10jAUh89jrikUVwlDHBxSdffuGR6JOEKPXpk0P
 pU6Ck+9JAwXQbfYFaFAdA9hXTAlOHZbV/fuhHWoLfWAB1RX77t4EBrqyFdKM1PQVgdHH
 dI8A==
X-Gm-Message-State: AGi0PuZwbof40FeLJh288GKCw+vt4l+2nqoavHMPMOt9FyUNngh5gFG4
 wYhlmqGilTLLHKwmYLWRUN2rUg==
X-Google-Smtp-Source: APiQypI3Gyotrn9okAFjQJpRjsbsYPSd5LspFo/akPdY6parrTXOiTRCI3WlukJlJK5vtI6cQma5Ng==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr4429742wmj.111.1588270240326; 
 Thu, 30 Apr 2020 11:10:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 27/36] target/arm: Convert Neon VABA 3-reg-same to decodetree
Date: Thu, 30 Apr 2020 19:09:54 +0100
Message-Id: <20200430181003.21682-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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

Convert the NEON VABA insn in the 3-reg-same group to decodetree.
This is the only insn in this group which does an integer
accumulate into the destination register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 76 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  7 +--
 target/arm/neon-dp.decode       |  3 ++
 3 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 084c78eea58..4692448fc5f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1128,3 +1128,79 @@ DO_3SAME_QS32(VQRSHL_U,qrshl_u)
 
 DO_3SAME_SHIFT32(VRSHL_S, rshl_s)
 DO_3SAME_SHIFT32(VRSHL_U, rshl_u)
+
+static bool do_vaba(DisasContext *s, arg_3same *a,
+                    NeonGenTwoOpFn *abd_fn, NeonGenTwoOpFn *add_fn)
+{
+    /* VABA: handled elementwise 32 bits at a time, accumulating */
+    TCGv_i32 tmp, tmp2;
+    int pass;
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
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        tmp = neon_load_reg(a->vn, pass);
+        tmp2 = neon_load_reg(a->vm, pass);
+        abd_fn(tmp, tmp, tmp2);
+        tcg_temp_free_i32(tmp2);
+        tmp2 = neon_load_reg(a->vd, pass);
+        add_fn(tmp, tmp, tmp2);
+        tcg_temp_free_i32(tmp2);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    return true;
+}
+
+static bool trans_VABA_S_3s(DisasContext *s, arg_3same *a)
+{
+    static NeonGenTwoOpFn * const abd_fns[] = {
+        gen_helper_neon_abd_s8,
+        gen_helper_neon_abd_s16,
+        gen_helper_neon_abd_s32,
+    };
+    static NeonGenTwoOpFn * const add_fns[] = {
+        gen_helper_neon_add_u8,
+        gen_helper_neon_add_u16,
+        tcg_gen_add_i32,
+    };
+
+    if (a->size > 2) {
+        return false;
+    }
+    return do_vaba(s, a, abd_fns[a->size], add_fns[a->size]);
+}
+
+static bool trans_VABA_U_3s(DisasContext *s, arg_3same *a)
+{
+    static NeonGenTwoOpFn * const abd_fns[] = {
+        gen_helper_neon_abd_u8,
+        gen_helper_neon_abd_u16,
+        gen_helper_neon_abd_u32,
+    };
+    static NeonGenTwoOpFn * const add_fns[] = {
+        gen_helper_neon_add_u8,
+        gen_helper_neon_add_u16,
+        tcg_gen_add_i32,
+    };
+
+    if (a->size > 2) {
+        return false;
+    }
+    return do_vaba(s, a, abd_fns[a->size], add_fns[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4406fe54647..b04643cec9a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4793,6 +4793,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQSHL:
         case NEON_3R_VRSHL:
         case NEON_3R_VQRSHL:
+        case NEON_3R_VABA:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4862,12 +4863,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VABA:
-            GEN_NEON_INTEGER_OP(abd);
-            tcg_temp_free_i32(tmp2);
-            tmp2 = neon_load_reg(rd, pass);
-            gen_neon_add(size, tmp, tmp2);
-            break;
         case NEON_3R_VPMAX:
             GEN_NEON_INTEGER_OP(pmax);
             break;
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ae442071ef1..d91f944f84a 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -113,6 +113,9 @@ VMIN_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 1 .... @3same
 VABD_S_3s        1111 001 0 0 . .. .... .... 0111 . . . 0 .... @3same
 VABD_U_3s        1111 001 1 0 . .. .... .... 0111 . . . 0 .... @3same
 
+VABA_S_3s        1111 001 0 0 . .. .... .... 0111 . . . 1 .... @3same
+VABA_U_3s        1111 001 1 0 . .. .... .... 0111 . . . 1 .... @3same
+
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
 
-- 
2.20.1


