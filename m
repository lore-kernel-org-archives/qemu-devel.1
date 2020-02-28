Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7845BC3F2D4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4345A2467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eC90pNS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4345A2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7itJ-00007m-9X
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifI-0007gW-Ai
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifG-0001wN-S3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:04 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifG-0001vj-Lp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:02 -0500
Received: by mail-wr1-x436.google.com with SMTP id l5so3681536wrx.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eSnuWh5zos/20PohnmnqFwoVE6VjZG74my10MbXx4a8=;
 b=eC90pNS4MpNXEqzseUx4VTjCvGMYt0OXlFCG+IACn9Wwix+E2YKxbNTIudTw8O91QJ
 emZ9oxbuWEimFDteHAhd5YOXUmLMugkDGjsiC/OQvaWeh6xYmBh7FNRTT3v2TjKsqXwx
 wX2SXfM/D+x4FlSBTba1ydhkS9valfgiTrL+Cxh83A7wag5LvTomdVLtl5KtLVM3FzFx
 JQQ2DnYYRkQvqJ1yWawt39toCDj3Ht5zxfEJ8TUlkVC9FSOgWrNNPzwitIkUkoHAvIIK
 RbhaDzWsMzCturzgXFrX8dY3jwRGsslxYtO0JSr77XEE66yYZRX5iZ3Te/fjFTVhdZ5l
 5ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eSnuWh5zos/20PohnmnqFwoVE6VjZG74my10MbXx4a8=;
 b=NdF3NuJTDLIZJfEni5KED7skksvrU6xWzrY/I7aiI4pcWZtzCdoQD3nM3bIKFgZsoy
 TcQLcFcYcoKxnRZob00G4yaHzqzssad5s1yHIhP+11YttRFV7nH9+/TNnVbdBBulRKGL
 DPmW4OelI+Yv2QhdA7ivI2OO/s/cS+wKiqSQhLctlsB16rbBz3EC1H5Du5m7hJ69AZcI
 QTh4+spj3zgNE2C8dTygR8zFqyemULgRXhxP2a981waRsQ2PG6lVOsrqpElO/Qn+Pv+P
 4hIviBlkUWQvbd6YglcS/FxqESS3A9QvgELYwmz+3T8YfJjIAsLOBo0xQU6FfgTX41b1
 k38w==
X-Gm-Message-State: APjAAAV8rGca/WIqEx44OWy+8ztSn2WFRhcdaTwdGXE9SpQ5DRMUiFU1
 K9Z40ZANG94R/iAE1x8cA/zj3SIzjuc32Q==
X-Google-Smtp-Source: APXvYqzMasEKTjb7UmRnJZpUnoOS8R+TyRR2juQOnCBGbL1pAsTF1MzgGaBgEhFkbh/i1KOMQo8kMQ==
X-Received: by 2002:a05:6000:1083:: with SMTP id
 y3mr5256674wrw.146.1582907941458; 
 Fri, 28 Feb 2020 08:39:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/33] target/arm: Move VLLDM and VLSTM to vfp.decode
Date: Fri, 28 Feb 2020 16:38:23 +0000
Message-Id: <20200228163840.23585-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

From: Richard Henderson <richard.henderson@linaro.org>

Now that we no longer have an early check for ARM_FEATURE_VFP,
we can use the proper ISA check in trans_VLLDM_VLSTM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200224222232.13807-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 39 +++++++++++++++++++++++++
 target/arm/translate.c         | 53 ++++++----------------------------
 target/arm/vfp.decode          |  2 ++
 3 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 03ba8d7aac0..1964af3ea5e 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2828,3 +2828,42 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+/*
+ * Decode VLLDM and VLSTM are nonstandard because:
+ *  * if there is no FPU then these insns must NOP in
+ *    Secure state and UNDEF in Nonsecure state
+ *  * if there is an FPU then these insns do not have
+ *    the usual behaviour that vfp_access_check() provides of
+ *    being controlled by CPACR/NSACR enable bits or the
+ *    lazy-stacking logic.
+ */
+static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
+{
+    TCGv_i32 fptr;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M) ||
+        !arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+    /* If not secure, UNDEF. */
+    if (!s->v8m_secure) {
+        return false;
+    }
+    /* If no fpu, NOP. */
+    if (!dc_isar_feature(aa32_vfp, s)) {
+        return true;
+    }
+
+    fptr = load_reg(s, a->rn);
+    if (a->l) {
+        gen_helper_v7m_vlldm(cpu_env, fptr);
+    } else {
+        gen_helper_v7m_vlstm(cpu_env, fptr);
+    }
+    tcg_temp_free_i32(fptr);
+
+    /* End the TB, because we have updated FP control bits */
+    s->base.is_jmp = DISAS_UPDATE;
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 893911fca70..5b7cad1ea2d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10962,53 +10962,18 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 goto illegal_op; /* op0 = 0b11 : unallocated */
             }
 
-            /*
-             * Decode VLLDM and VLSTM first: these are nonstandard because:
-             *  * if there is no FPU then these insns must NOP in
-             *    Secure state and UNDEF in Nonsecure state
-             *  * if there is an FPU then these insns do not have
-             *    the usual behaviour that disas_vfp_insn() provides of
-             *    being controlled by CPACR/NSACR enable bits or the
-             *    lazy-stacking logic.
-             */
-            if (arm_dc_feature(s, ARM_FEATURE_V8) &&
-                (insn & 0xffa00f00) == 0xec200a00) {
-                /* 0b1110_1100_0x1x_xxxx_xxxx_1010_xxxx_xxxx
-                 *  - VLLDM, VLSTM
-                 * We choose to UNDEF if the RAZ bits are non-zero.
-                 */
-                if (!s->v8m_secure || (insn & 0x0040f0ff)) {
+            if (disas_vfp_insn(s, insn)) {
+                if (((insn >> 8) & 0xe) == 10 &&
+                    dc_isar_feature(aa32_fpsp_v2, s)) {
+                    /* FP, and the CPU supports it */
                     goto illegal_op;
+                } else {
+                    /* All other insns: NOCP */
+                    gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
+                                       syn_uncategorized(),
+                                       default_exception_el(s));
                 }
-
-                if (arm_dc_feature(s, ARM_FEATURE_VFP)) {
-                    uint32_t rn = (insn >> 16) & 0xf;
-                    TCGv_i32 fptr = load_reg(s, rn);
-
-                    if (extract32(insn, 20, 1)) {
-                        gen_helper_v7m_vlldm(cpu_env, fptr);
-                    } else {
-                        gen_helper_v7m_vlstm(cpu_env, fptr);
-                    }
-                    tcg_temp_free_i32(fptr);
-
-                    /* End the TB, because we have updated FP control bits */
-                    s->base.is_jmp = DISAS_UPDATE;
-                }
-                break;
             }
-            if (arm_dc_feature(s, ARM_FEATURE_VFP) &&
-                ((insn >> 8) & 0xe) == 10) {
-                /* FP, and the CPU supports it */
-                if (disas_vfp_insn(s, insn)) {
-                    goto illegal_op;
-                }
-                break;
-            }
-
-            /* All other insns: NOCP */
-            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
-                               default_exception_el(s));
             break;
         }
         if ((insn & 0xfe000a00) == 0xfc000800
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index a67b3f29ee5..592fe9e1e42 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -242,3 +242,5 @@ VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
-- 
2.20.1


