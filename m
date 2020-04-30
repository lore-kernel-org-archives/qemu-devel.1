Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C1C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE95D20836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3ctwcjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE95D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDt8-0007Z1-Uh
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeK-0001xe-Tq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdp-0001FB-LM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdp-0001EF-85
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so3072993wmh.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Id3Uc/B7n4Syo/SnHMGumI6na3pAMsUQ7gLuSb0aqVo=;
 b=U3ctwcjO4D9WXH7EdS5+jX0xmj1PdoqMG14/7NAgxY4tGUI38WZUfp7iSBZqg3jk1a
 bxAtf3gySMlV3WsCoXBxSR1Q60KlA9nxOq4jZDzQTjg40Z/yFsgqsrz0WIIHSD8o6QMz
 CJWQyIm+0mpQVbluaq3xqAFME2DdP9nwCyDLODDMf5l/5n1jO16I7ns9z3PP0PgPG5jC
 aMTdudtbMj+/o4e9cwYFHKYjdGqpvK5dQdGaJDew6ou2gQQM6WhdRKNAbrI/JBzPsJwf
 NjCkzgEfWCXD20mQoe0DSwnsi+qZa9jFNHIFfcfDs80LeGr9FN0PL25tMFZ/rUf0HtK6
 c9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Id3Uc/B7n4Syo/SnHMGumI6na3pAMsUQ7gLuSb0aqVo=;
 b=PNk23VBcBGGbv22LwsiBZR/iEkltEXIOhN/e8c80CljAJjFlFaP1xdAD7zGRu8lZb0
 WsQSWydjzoW4ARUQU3tGJxhSSwDLABnYDEwcLSla/9huj7cL2fxhCXIwwxDXf4Jz/1Og
 lLRc/goQeto5I9mgqUQ7tfaggDQIsOTjTclmdIIft20UAr3+V+N64pF9ggjYY+I7mbXY
 Cjs/29fEIVKnCVazVBs9Yb8NBtgnBWXE/JrZnZlZAC2Iyk2zAe4avw75NbKmm0cNd5Sf
 JXHkZtK4Inx7hhinWj0Af46qjbbdeYMCraUHBU2a05VBVcm4AyNQlrw2uXlgkfuAQgTG
 Fuxg==
X-Gm-Message-State: AGi0Pub/QQ7nZFqh172esh5OOH2zK1srAnU7VWx4/AMKcxfMSXQ/4ams
 20pwEPVfFsczfUTETKkTrBSOEw==
X-Google-Smtp-Source: APiQypISEGM+f9sl+zb1QGRq1emThEcJGMySa7lvgeWakl1Z+I0LAo/E9jjZJr0HpdOjoxs2xBpmgw==
X-Received: by 2002:a05:600c:2306:: with SMTP id
 6mr4546477wmo.17.1588270231867; 
 Thu, 30 Apr 2020 11:10:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 20/36] target/arm: Convert Neon 3-reg-same VQRDMLAH/VQRDMLSH
 to decodetree
Date: Thu, 30 Apr 2020 19:09:47 +0100
Message-Id: <20200430181003.21682-21-peter.maydell@linaro.org>
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

Convert the Neon VQRDMLAH and VQRDMLSH insns in the 3-reg-same group
to decodetree.  These don't use do_3same() because they want to
operate on VFP double registers, whose offsets are different from the
neon_reg_offset() calculations do_3same does.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 57 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 36 ++-------------------
 target/arm/neon-dp.decode       |  3 ++
 3 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 50b77b6d714..c8beb048fa2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -712,3 +712,60 @@ DO_3SAME_GVEC3_NO_SZ_3(VMLS, mls_op)
 
 DO_3SAME_GVEC3_SHIFT(VSHL_S, sshl_op)
 DO_3SAME_GVEC3_SHIFT(VSHL_U, ushl_op)
+
+static bool do_vqrdmlah(DisasContext *s, arg_3same *a,
+                        gen_helper_gvec_3_ptr *fn)
+{
+    int vec_size = a->q ? 16 : 8;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_rdm, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!fn) {
+        return false; /* bad size */
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
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       cpu_env, vec_size, vec_size, 0, fn);
+    return true;
+}
+
+static bool trans_VQRDMLAH_3s(DisasContext *s, arg_3same *a)
+{
+    static gen_helper_gvec_3_ptr * const fns[] = {
+        NULL,
+        gen_helper_gvec_qrdmlah_s16,
+        gen_helper_gvec_qrdmlah_s32,
+        NULL,
+    };
+    return do_vqrdmlah(s, a, fns[a->size]);
+}
+
+static bool trans_VQRDMLSH_3s(DisasContext *s, arg_3same *a)
+{
+    static gen_helper_gvec_3_ptr * const fns[] = {
+        NULL,
+        gen_helper_gvec_qrdmlsh_s16,
+        gen_helper_gvec_qrdmlsh_s32,
+        NULL,
+    };
+    return do_vqrdmlah(s, a, fns[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ad60b7190f9..adc42362469 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3629,22 +3629,6 @@ static const uint8_t neon_2rm_sizes[] = {
     [NEON_2RM_VCVT_UF] = 0x4,
 };
 
-
-/* Expand v8.1 simd helper.  */
-static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
-                         int q, int rd, int rn, int rm)
-{
-    if (dc_isar_feature(aa32_rdm, s)) {
-        int opr_sz = (1 + q) * 8;
-        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                           vfp_reg_offset(1, rn),
-                           vfp_reg_offset(1, rm), cpu_env,
-                           opr_sz, opr_sz, 0, fn);
-        return 0;
-    }
-    return 1;
-}
-
 static void gen_ceq0_i32(TCGv_i32 d, TCGv_i32 a)
 {
     tcg_gen_setcondi_i32(TCG_COND_EQ, d, a, 0);
@@ -4818,15 +4802,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             if (!u) {
                 break;  /* VPADD */
             }
-            /* VQRDMLAH */
-            switch (size) {
-            case 1:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s16,
-                                     q, rd, rn, rm);
-            case 2:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s32,
-                                     q, rd, rn, rm);
-            }
+            /* VQRDMLAH : handled by decodetree */
             return 1;
 
         case NEON_3R_VFM_VQRDMLSH:
@@ -4837,15 +4813,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
                 break;
             }
-            /* VQRDMLSH */
-            switch (size) {
-            case 1:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s16,
-                                     q, rd, rn, rm);
-            case 2:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s32,
-                                     q, rd, rn, rm);
-            }
+            /* VQRDMLSH : handled by decodetree */
             return 1;
 
         case NEON_3R_VADD_VSUB:
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ec3a92fe753..ce0db476c88 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -84,3 +84,6 @@ VMLS_3s          1111 001 1 0 . .. .... .... 1001 . . . 0 .... @3same
 
 VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
 VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
+
+VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
+VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
-- 
2.20.1


