Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A8C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5601B2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4v/EB1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5601B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j589R-00030O-HR
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582G-0006oL-1r
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582E-0002iE-D1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:03 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582E-0002eK-5c
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:02 -0500
Received: by mail-wm1-x32e.google.com with SMTP id s10so1730427wmh.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ab/N74S0Z/UQCYSVFfJ9xvcUWpUkXYgMA94Bf6u7eRk=;
 b=L4v/EB1Ngl2j8yRTvJHFsdxqKXMMA0m16HO58KAV6LQcWaN50dYVfmjxEEsdBNqzk0
 mWQE1K5RzneQbQ5ZXdlCtFgFbThJ8A4VnR4mP1uD8Q34SvYOdu9s2tA2hjoRYmeLPdCG
 c4uKUkfFEYg664LXAJocA1jeZXLkTwUOXsjvUFJxeeAZ+8y1fIn7G9DhRo1qWqYXUg+k
 3nBBL/PMPIYa1VVQgCH6q67SXVcMUfR/DnWd7q95YjyUDwPsm9CmW4FcO8oD7TRsaxfd
 lEvNHGRdmTCln5oU7Ttn372JwRBngRfegYV0hpYk2VgDoNxWPEDSnXcpMTjbFnyh8do3
 c7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ab/N74S0Z/UQCYSVFfJ9xvcUWpUkXYgMA94Bf6u7eRk=;
 b=QcQ/rdT/0U/hsxt2BGxbXerbZL6EmrroOMCzaJHNP88khGDE05Cl3DifTjMnE/14tw
 I6BKnuIqCzkNuwi/lZ/uJ+55JfYgTDmsSUsfJz9p8EpPQvLAH1KUlgOy0FtDe0qGxDtQ
 Li+9stQjEL400NwPyDO3V29w6ure/7m/tqBY7jXVH+43gCYJmmTuy3YT5ywKU26TcZGM
 glpuhKMQPcU57UtL87O2+EtMYoT4ZATA6jbXyLqiyj9Hfgbdt7YiJ4G+vCIG4PIKpE8k
 bdMMWOKGfkgYoc++ESSG1zIcgH1EywnyrAnZ3lqD0FA6uW3n3ka0ZHKRlCcMCDuwKGKE
 reug==
X-Gm-Message-State: APjAAAXnj7G4gAZPIC/MVBytx0u7WcK5KzBq9X632eMC7NOzPp25S/Xv
 zITpgUIQwvCIbxBxWaodkZZ2tNwDp7qz8w==
X-Google-Smtp-Source: APXvYqwlu91xSYTQC1Z/uqCcdeesQrJK8cC8deYiQZ/Bj9JWz4T5xcSEtucmU/VPBbGIvDFVnrQC9g==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr3961010wmg.38.1582290479513; 
 Fri, 21 Feb 2020 05:07:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/52] target/arm: Add _aa32_ to isar_feature functions testing
 32-bit ID registers
Date: Fri, 21 Feb 2020 13:07:02 +0000
Message-Id: <20200221130740.7583-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

Enforce a convention that an isar_feature function that tests a
32-bit ID register always has _aa32_ in its name, and one that
tests a 64-bit ID register always has _aa64_ in its name.
We already follow this except for three cases: thumb_div,
arm_div and jazelle, which all need _aa32_ adding.

(As noted in the comment, isar_feature_aa32_fp16_arith()
is an exception in that it currently tests ID_AA64PFR0_EL1,
but will switch to MVFR1 once we've properly implemented
FP16 for AArch32.)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-2-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 13 ++++++++++---
 target/arm/internals.h |  2 +-
 linux-user/elfload.c   |  4 ++--
 target/arm/cpu.c       |  6 ++++--
 target/arm/helper.c    |  2 +-
 target/arm/translate.c |  6 +++---
 6 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e943ffe8a9a..37d40e57901 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3324,20 +3324,27 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
 /* Shared between translate-sve.c and sve_helper.c.  */
 extern const uint64_t pred_esz_masks[4];
 
+/*
+ * Naming convention for isar_feature functions:
+ * Functions which test 32-bit ID registers should have _aa32_ in
+ * their name. Functions which test 64-bit ID registers should have
+ * _aa64_ in their name.
+ */
+
 /*
  * 32-bit feature tests via id registers.
  */
-static inline bool isar_feature_thumb_div(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_thumb_div(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
 }
 
-static inline bool isar_feature_arm_div(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_arm_div(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) > 1;
 }
 
-static inline bool isar_feature_jazelle(const ARMISARegisters *id)
+static inline bool isar_feature_aa32_jazelle(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 14328e3f7da..31aaa0eff87 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1091,7 +1091,7 @@ static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
     if ((features >> ARM_FEATURE_THUMB2) & 1) {
         valid |= CPSR_IT;
     }
-    if (isar_feature_jazelle(id)) {
+    if (isar_feature_aa32_jazelle(id)) {
         valid |= CPSR_J;
     }
     if (isar_feature_aa32_pan(id)) {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3080a16358..b1a895f24ce 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -475,8 +475,8 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPv3);
     GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
     GET_FEATURE(ARM_FEATURE_VFP4, ARM_HWCAP_ARM_VFPv4);
-    GET_FEATURE_ID(arm_div, ARM_HWCAP_ARM_IDIVA);
-    GET_FEATURE_ID(thumb_div, ARM_HWCAP_ARM_IDIVT);
+    GET_FEATURE_ID(aa32_arm_div, ARM_HWCAP_ARM_IDIVA);
+    GET_FEATURE_ID(aa32_thumb_div, ARM_HWCAP_ARM_IDIVT);
     /* All QEMU's VFPv3 CPUs have 32 registers, see VFP_DREG in translate.c.
      * Note that the ARM_HWCAP_ARM_VFPv3D16 bit is always the inverse of
      * ARM_HWCAP_ARM_VFPD32 (and so always clear for QEMU); it is unrelated
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index de733aceeb8..56f2ab865da 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1586,7 +1586,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
          * Security Extensions is ARM_FEATURE_EL3.
          */
-        assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(arm_div, cpu));
+        assert(!tcg_enabled() || no_aa32 ||
+               cpu_isar_feature(aa32_arm_div, cpu));
         set_feature(env, ARM_FEATURE_LPAE);
         set_feature(env, ARM_FEATURE_V7);
     }
@@ -1612,7 +1613,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
         if (!arm_feature(env, ARM_FEATURE_M)) {
-            assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(jazelle, cpu));
+            assert(!tcg_enabled() || no_aa32 ||
+                   cpu_isar_feature(aa32_jazelle, cpu));
             set_feature(env, ARM_FEATURE_AUXCR);
         }
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8d0f6eca27b..9c02d5d6b8e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7396,7 +7396,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         define_arm_cp_regs(cpu, lpae_cp_reginfo);
     }
-    if (cpu_isar_feature(jazelle, cpu)) {
+    if (cpu_isar_feature(aa32_jazelle, cpu)) {
         define_arm_cp_regs(cpu, jazelle_regs);
     }
     /* Slightly awkwardly, the OMAP and StrongARM cores need all of
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 20f89ace2fd..93f028f256b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -42,7 +42,7 @@
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
 #define ENABLE_ARCH_5TE   arm_dc_feature(s, ARM_FEATURE_V5)
-#define ENABLE_ARCH_5J    dc_isar_feature(jazelle, s)
+#define ENABLE_ARCH_5J    dc_isar_feature(aa32_jazelle, s)
 #define ENABLE_ARCH_6     arm_dc_feature(s, ARM_FEATURE_V6)
 #define ENABLE_ARCH_6K    arm_dc_feature(s, ARM_FEATURE_V6K)
 #define ENABLE_ARCH_6T2   arm_dc_feature(s, ARM_FEATURE_THUMB2)
@@ -9845,8 +9845,8 @@ static bool op_div(DisasContext *s, arg_rrr *a, bool u)
     TCGv_i32 t1, t2;
 
     if (s->thumb
-        ? !dc_isar_feature(thumb_div, s)
-        : !dc_isar_feature(arm_div, s)) {
+        ? !dc_isar_feature(aa32_thumb_div, s)
+        : !dc_isar_feature(aa32_arm_div, s)) {
         return false;
     }
 
-- 
2.20.1


