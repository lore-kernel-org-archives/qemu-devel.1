Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB56CC3B1B9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90E52168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0TaMt+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90E52168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fbL-0008Pd-Uh
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVW-0004Vs-Vx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVV-0000GM-Lm
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:06 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVV-0000Fu-FM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:05 -0500
Received: by mail-pf1-x444.google.com with SMTP id p14so5264995pfn.4
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KNXQ9uIT7Co5CZWLUxtFqeHCHOoXldJvxdr++tcI33U=;
 b=p0TaMt+fQy9mNLg6/mlONYUBZ8Ubz9qwoEP++u5+q95ZSw4TxN78D30n9LgP0kSIXB
 c/B16AWveocGQ/PH60hrOV/Hceqe4EAmCqJWcHndjka8Q3io0iGeba03jZafyvruNZaY
 Lnvo+6nGlcjQu9fCWefveEVTZI6tt53R3RWpmvXd4Hw013bDHu0tHgn6i8cjsl5gf7gM
 HHIXeEm3YarIz8BAGKec1I09BtV50tQLMU+7LMyULJXG2TrL7aCKOQ/yxbYCuNLkdbFk
 jrz/omI5pC9V5fg9CWHYFWZ7xTUOWj7NGPNfjsWHvsscP/k/Eq5LE3xzLv4QqcQvU2oZ
 YtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KNXQ9uIT7Co5CZWLUxtFqeHCHOoXldJvxdr++tcI33U=;
 b=tH3eB+7WX2oRoSbZoMi/bH2mlZXftsIbfTSfJ4xog9xGhQswwIi3rptOJ6ykXW3GRR
 j3+vBVV0WoStx8b64DumDCYzsnXBp8bqRr/qBCODNbPPnvTZl97gRqXWbQ7GbgeqVSOi
 MrF68UIzuWe7RbT5mj+XdJsYIDzTmpUc16TK70bSttMdSSHSTcmNPXW+lPICRFR37lXw
 aPizTmiYeplC/WqitbkactQZdNVEqxnMN2gRDqoUsgnPNiUlAD8v0otBgKuG9M6QKW0H
 DelZQxAqZ9BC49EjiwkNGbr7L8y5nrkmBpEEa0yEfzdE0XyYQCX5LUzyF/9jXd5QBqL7
 hHFg==
X-Gm-Message-State: APjAAAW4/PK0EG/Kbzd5UapSs55Dh5/5ovBit6wZ27H12w7i9hdKXiKW
 /R3HIIhx/1+6qtuIVtWjcxUpdGI9P6w=
X-Google-Smtp-Source: APXvYqzdiCTG6m9MKi+gipSGguA2OM9G+qIjl3IwUcFBUhbnd2RVyP9osEsERfRukvC31MoPZvjpsA==
X-Received: by 2002:a65:6147:: with SMTP id o7mr5138480pgv.442.1581704164122; 
 Fri, 14 Feb 2020 10:16:04 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/19] target/arm: Move VLLDM and VLSTM to vfp.decode
Date: Fri, 14 Feb 2020 10:15:41 -0800
Message-Id: <20200214181547.21408-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we no longer have an early check for ARM_FEATURE_VFP,
we can use the proper ISA check in trans_VLLDM_VLSTM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp.decode          |  2 ++
 target/arm/translate-vfp.inc.c | 35 ++++++++++++++++++++++
 target/arm/translate.c         | 53 ++++++----------------------------
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index a67b3f29ee..592fe9e1e4 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -242,3 +242,5 @@ VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index f6f7601fe2..8f2b97e0e7 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2816,3 +2816,38 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+/*
+ * Decode VLLDM of VLSTM are nonstandard because:
+ *  * if there is no FPU then these insns must NOP in
+ *    Secure state and UNDEF in Nonsecure state
+ *  * if there is an FPU then these insns do not have
+ *    the usual behaviour that disas_vfp_insn() provides of
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
+    if (!dc_isar_feature(aa32_fpsp_v2, s)) {
+        /* No FPU: NOP if secure, otherwise UNDEF.  */
+        return s->v8m_secure;
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
index e8c3d4f26f..b2641b4262 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10708,53 +10708,18 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
-- 
2.20.1


