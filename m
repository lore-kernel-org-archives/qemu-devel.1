Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A3C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8596220787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYPoP52P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8596220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE4f-0003nA-FA
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDec-0002iR-Cp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe5-0001MC-0g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDe4-0001LN-Du
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so2972776wmc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZIjWH/BMWn1aPzoUWlcba5rXgD9JHAHjoL2L71Jcs1E=;
 b=cYPoP52PhNL2As4lE55S+uUDA0T1Xtifgl6+37FDoRNCHP1rulxDpHotQ2UseUU1Cp
 ejxC1+hvS+pSJXYwBqZEOAXxQDC02TtekQs5tB4ctl/qNviBXsVjykLDgRDdejg24jsO
 qxa/jrzilA40w3QobOpowc/co3oKoGTpkdRsZVjdqBsaMxKjJDQDr2803Htc1dRS6+8B
 O3LK4LQXXql+JdTQqwO4rBDewJvJi6pSAgT84/P3zvl9SOH9aXUJ386JOkmlovRX/sOT
 Jq6xpt35ahygrJKdJOE9eVIg4xRWIMHazk9AHw8Al+VMUiy7SAilgCLCJzx3G/DgY+95
 23gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZIjWH/BMWn1aPzoUWlcba5rXgD9JHAHjoL2L71Jcs1E=;
 b=oxaOln2syvN3JiDE9qrrGD++knvCNXF1G4pc8TwWC30PISHsIE3pj6pXLfWY6NdNnv
 K0O7mtGVhOg8jGdwqTJV3nYoR0bopAbjQsPVCphm6QJOb5rYBhTQA2EVyIbzl/GOeBqt
 /RtMAafIGZuA9ZwqyUkr/JXdfaz5klFfCZapYNGozh9ZEIWPnF58NFoRVXg0Z7IRyBvM
 xAyrkmoC8HuMNUhyZ3siIH1KCYUWEcTb5Ai+iz516r8d0LFQ9Y5ZCK8/vwbb6JIQmCT3
 T9qbyspGriutG0uO/wz/Wz5uQ0HuGEQUW+DiRSBSrurlDks2YJcrBuHXScvnTbd9Pos3
 hxKQ==
X-Gm-Message-State: AGi0PuYTdaidllsdtkJ+pAtpPBAIDSosxmusJahdu0lpSRi6IEdI3Pdx
 52Nz+Ghb+2TJQTgTydwEUqonaw==
X-Google-Smtp-Source: APiQypKnlqqUZDhMWjP9uvHNsjCbDbUrbm//haxl1ZibFgz04hoOSlSKBFCvJ9ILj/K+QErCcl3X9A==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr4148549wmi.57.1588270244911; 
 Thu, 30 Apr 2020 11:10:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 31/36] target/arm: Convert Neon VADD, VSUB,
 VABD 3-reg-same insns to decodetree
Date: Thu, 30 Apr 2020 19:09:58 +0100
Message-Id: <20200430181003.21682-32-peter.maydell@linaro.org>
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

Convert the Neon VADD, VSUB, VABD 3-reg-same insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 54 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 10 ++----
 target/arm/neon-dp.decode       |  8 +++++
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 2fab547840d..6a27b7673c2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1321,3 +1321,57 @@ static bool trans_VQRDMULH_3s(DisasContext *s, arg_3same *a)
     }
     return do_3same_32(s, a, fns[a->size - 1]);
 }
+
+static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
+{
+    /* FP operations handled elementwise 32 bits at a time */
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
+    TCGv_ptr fpstatus = get_fpstatus_ptr(1);
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        tmp = neon_load_reg(a->vn, pass);
+        tmp2 = neon_load_reg(a->vm, pass);
+        fn(tmp, tmp, tmp2, fpstatus);
+        tcg_temp_free_i32(tmp2);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    tcg_temp_free_ptr(fpstatus);
+    return true;
+}
+
+/*
+ * For all the functions using this macro, size == 1 means fp16,
+ * which is an architecture extension we don't implement yet.
+ */
+#define DO_3S_FP(INSN,FUNC)                                         \
+    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
+    {                                                               \
+        if (a->size != 0) {                                         \
+            /* TODO fp16 support */                                 \
+            return false;                                           \
+        }                                                           \
+        return do_3same_fp(s, a, FUNC);                             \
+    }
+
+DO_3S_FP(VADD, gen_helper_vfp_adds)
+DO_3S_FP(VSUB, gen_helper_vfp_subs)
+DO_3S_FP(VABD, gen_helper_neon_abd_f32)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9fec1889613..c944cbf20af 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4797,6 +4797,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         switch (op) {
         case NEON_3R_FLOAT_ARITH:
             pairwise = (u && size < 2); /* if VPADD (float) */
+            if (!pairwise) {
+                return 1; /* handled by decodetree */
+            }
             break;
         case NEON_3R_FLOAT_MINMAX:
             pairwise = u; /* if VPMIN/VPMAX (float) */
@@ -4853,16 +4856,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
             switch ((u << 2) | size) {
-            case 0: /* VADD */
             case 4: /* VPADD */
                 gen_helper_vfp_adds(tmp, tmp, tmp2, fpstatus);
                 break;
-            case 2: /* VSUB */
-                gen_helper_vfp_subs(tmp, tmp, tmp2, fpstatus);
-                break;
-            case 6: /* VABD */
-                gen_helper_neon_abd_f32(tmp, tmp, tmp2, fpstatus);
-                break;
             default:
                 abort();
             }
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 8ceedd8b8d8..9d6a17d6f04 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -45,6 +45,10 @@
 @3same_q0        .... ... . . . size:2 .... .... .... . 0 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
 
+# For FP insns the high bit of 'size' is used as part of opcode decode
+@3same_fp        .... ... . . . . size:1 .... .... .... . q:1 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
 VHADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 0 .... @3same
 VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
 VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
@@ -154,3 +158,7 @@ SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... \
                  vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
 VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
+
+VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
+VSUB_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
-- 
2.20.1


