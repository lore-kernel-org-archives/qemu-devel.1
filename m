Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1AFC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D05120787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ji4g1vmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D05120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE4l-0003yQ-Fg
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeg-0002th-QE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe9-0001XS-4y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDe8-0001N0-DI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id f13so8126669wrm.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=br31+94xk2iuX4LX0dtLuZ7yS2HpgC0VmUDIcN1CJ/Y=;
 b=ji4g1vmCR8QuaWebesXMZpqQ871NJ5xgAmdcGzknTpelxOI0T+f0VfnSto87l2OsFk
 Sa+txs9AYmhaV+BLK/jRpfBcK/J49jGpkxr21/fAK27DPkXK4PHPUJvwvqV/f7hDQ5mg
 Xg601r4kdhvibKsg0rFt08GcEpZwwL4b0QMydMrEx7tClxzq+zepKSaU98ilxA3jjF4u
 BmgPvItDLHauhmtMaqCzpYgT9YOL2AASrB9Q58wFqA3D4sHmKLWezZ34HDMDAk29iWbe
 4qm1mP9tXmeudEU6txjRB9l4IeTLPbsXWvU5sG5g2QQoOzKU0PMbDP0/iFnDmeV1DgD7
 akSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=br31+94xk2iuX4LX0dtLuZ7yS2HpgC0VmUDIcN1CJ/Y=;
 b=KFVMerFEzJUsiiC27CW5gg4+yc25YOWY0CBvxgBLpk/5RU5HWcWhtwdrpFBCwVCSQ+
 Gk60PQK1kgR7Zs+XofcVscU2nIpTLJABNVh9PpiI1k4njp7RD06OHSKpMNnACT6wOLs7
 IGkeYWKl3YHOeyPcJ7RNLgkIqL6G+sPyLDV60u13jaDvnA+1ixQB0Myw4w87qZ1uHWGn
 KDW6h/8V0WmCNsvFRQG+lQqEecIBlbFP0rnNmyoNhXz9x9S7V+ksI/yBVqLALdpKz/gq
 58wZlneU1ueJOkfj5Kq2viZgB9NF+zJmCOEgGbB4w33R14H3rsxgZHirz4yLdcDk/sqg
 5s9w==
X-Gm-Message-State: AGi0PuZ2fgfrDtbpzo6aDY1crz66I0EsCLcEHuk6x/VI3dRFD3LOVeTO
 HrWFGG+ZrbDo8SOwXfI3Xh+LSw==
X-Google-Smtp-Source: APiQypIAHBvHAX4l/cXDUKGUhezLEUSttmnhNBGrndRsup+CwW9pudBikzjvU+9lxadN0cuYiLFPQw==
X-Received: by 2002:a5d:61c5:: with SMTP id q5mr5388182wrv.260.1588270249194; 
 Thu, 30 Apr 2020 11:10:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 34/36] target/arm: Convert Neon 3-reg-same compare insns to
 decodetree
Date: Thu, 30 Apr 2020 19:10:01 +0100
Message-Id: <20200430181003.21682-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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

Convert the Neon integer 3-reg-same compare insns VCGE, VCGT,
VCEQ, VACGE and VACGT to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c |  5 +++++
 target/arm/translate.c          | 39 ++-------------------------------
 target/arm/neon-dp.decode       |  5 +++++
 3 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 47879bbb6c9..29a3f7677c7 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1389,6 +1389,11 @@ DO_3S_FP(VADD, gen_helper_vfp_adds, false)
 DO_3S_FP(VSUB, gen_helper_vfp_subs, false)
 DO_3S_FP(VABD, gen_helper_neon_abd_f32, false)
 DO_3S_FP(VMUL, gen_helper_vfp_muls, false)
+DO_3S_FP(VCEQ, gen_helper_neon_ceq_f32, false)
+DO_3S_FP(VCGE, gen_helper_neon_cge_f32, false)
+DO_3S_FP(VCGT, gen_helper_neon_cgt_f32, false)
+DO_3S_FP(VACGE, gen_helper_neon_acge_f32, false)
+DO_3S_FP(VACGT, gen_helper_neon_acgt_f32, false)
 
 static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
                             TCGv_ptr fpstatus)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 57343daa10a..c68dbe126eb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4786,6 +4786,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQDMULH_VQRDMULH:
         case NEON_3R_FLOAT_ARITH:
         case NEON_3R_FLOAT_MULTIPLY:
+        case NEON_3R_FLOAT_CMP:
+        case NEON_3R_FLOAT_ACMP:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4800,17 +4802,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 1; /* VPMIN/VPMAX handled by decodetree */
             }
             break;
-        case NEON_3R_FLOAT_CMP:
-            if (!u && size) {
-                /* no encoding for U=0 C=1x */
-                return 1;
-            }
-            break;
-        case NEON_3R_FLOAT_ACMP:
-            if (!u) {
-                return 1;
-            }
-            break;
         case NEON_3R_FLOAT_MISC:
             /* VMAXNM/VMINNM in ARMv8 */
             if (u && !arm_dc_feature(s, ARM_FEATURE_V8)) {
@@ -4832,32 +4823,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         tmp = neon_load_reg(rn, pass);
         tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_CMP:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            if (!u) {
-                gen_helper_neon_ceq_f32(tmp, tmp, tmp2, fpstatus);
-            } else {
-                if (size == 0) {
-                    gen_helper_neon_cge_f32(tmp, tmp, tmp2, fpstatus);
-                } else {
-                    gen_helper_neon_cgt_f32(tmp, tmp, tmp2, fpstatus);
-                }
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
-        case NEON_3R_FLOAT_ACMP:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            if (size == 0) {
-                gen_helper_neon_acge_f32(tmp, tmp, tmp2, fpstatus);
-            } else {
-                gen_helper_neon_acgt_f32(tmp, tmp, tmp2, fpstatus);
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
         case NEON_3R_FLOAT_MINMAX:
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 96866c03db4..e90c7a9afe9 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -168,5 +168,10 @@ VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
 VMLA_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
 VMLS_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 1 .... @3same_fp
 VMUL_fp_3s       1111 001 1 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
+VCEQ_fp_3s       1111 001 0 0 . 0 . .... .... 1110 ... 0 .... @3same_fp
+VCGE_fp_3s       1111 001 1 0 . 0 . .... .... 1110 ... 0 .... @3same_fp
+VACGE_fp_3s      1111 001 1 0 . 0 . .... .... 1110 ... 1 .... @3same_fp
+VCGT_fp_3s       1111 001 1 0 . 1 . .... .... 1110 ... 0 .... @3same_fp
+VACGT_fp_3s      1111 001 1 0 . 1 . .... .... 1110 ... 1 .... @3same_fp
 VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
 VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
-- 
2.20.1


