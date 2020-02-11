Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCCAC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD60D20661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZW8DFMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD60D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZXP-0002tG-St
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTh-0005hH-8I
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTc-00040x-KA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:38 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTc-0003wQ-CY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id r11so10241721wrq.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R0OwC1B8BgXBSOjTXwBE9Hi1bALQDEZkRmOqTJGQEkU=;
 b=PZW8DFMjqw47iAcPzf9b6l+9mIHS/WpeJZSmWqIcZpepD4P2HStYpdDsgyZlGnn5IL
 dyg3r7eyz4DKGAzTHTvbEZQXWtHdhgvNuCPGUYcxMEH3E6OV8YJZaO61IwAuuJPN0w8L
 8Q9Mo1dhktWx09bjhzVQgIqy+b8xMLs+TTP1zFgFstSjOq/vgNWuxoRPXugskkhfXC/N
 CvJ3rkOYNdsql8AF83qejZqSpPYO4SonZ+rczkba4+qz318rV6WBDWFqsOrId7JyS0jY
 IibxKQgnPE3G06T+xg3nQ1auaATZCssTK1W1a9cBrWtvN3dpYrjmtiZrzArCieJHnM1H
 eADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R0OwC1B8BgXBSOjTXwBE9Hi1bALQDEZkRmOqTJGQEkU=;
 b=NL0TqVpviVw13nZsaxfXfVayRZECeIbuLsmm5zg+auX0ypwhGOEn/adoVEHt8vYZB7
 oBZtPsflLVhkhvK8IBLHVPs+RSIFT2upty1PQ746OtYKdzCZZzQr3BacXnjNf6KwosJL
 03psg36SENHt9pyXqAeB7cloxBjNFT4f7hvgVwzkJw43wXaxWjVoS+vAHqellXXwQlg+
 JlDC78X3fDDFUoc+hwhgGN2UIkDupMnNChHbBq4szZ5fzK0enrtM6saBGaEvf8etq5Xb
 t9fLaibrkCPcS0nlzksx6u7BBq0BZZVpF2mxx+ar98c5yfYlOT2rsO8/j7dNWMV4QZFB
 Zd9Q==
X-Gm-Message-State: APjAAAW28BbEN+fMfIWtGK/8ogiuLpmu8jJPOXojjgZa6XftZ5yXQreY
 AtnsBFPj9Tr45Sia408jlmE/P6Fv3Gk=
X-Google-Smtp-Source: APXvYqxLA7Q9DtUeELb9DKZG7XJpa9FuC0Dmuz3n7MCzWRV9YkFBFQUZgF+87MlVqoVQ2CfvSLkWng==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr9323802wrw.373.1581442651064; 
 Tue, 11 Feb 2020 09:37:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/13] target/arm: Add _aa32_ to isar_feature functions
 testing 32-bit ID registers
Date: Tue, 11 Feb 2020 17:37:14 +0000
Message-Id: <20200211173726.22541-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 13 ++++++++++---
 linux-user/elfload.c   |  4 ++--
 target/arm/cpu.c       |  6 ++++--
 target/arm/helper.c    |  2 +-
 target/arm/translate.c |  6 +++---
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 608fcbd0b75..ad2f0e172a7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3396,20 +3396,27 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
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
index f86e71a260d..5712082c0b9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1470,7 +1470,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
          * Security Extensions is ARM_FEATURE_EL3.
          */
-        assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(arm_div, cpu));
+        assert(!tcg_enabled() || no_aa32 ||
+               cpu_isar_feature(aa32_arm_div, cpu));
         set_feature(env, ARM_FEATURE_LPAE);
         set_feature(env, ARM_FEATURE_V7);
     }
@@ -1496,7 +1497,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
index 19a57a17da5..ddfd0183d98 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6781,7 +6781,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         define_arm_cp_regs(cpu, lpae_cp_reginfo);
     }
-    if (cpu_isar_feature(jazelle, cpu)) {
+    if (cpu_isar_feature(aa32_jazelle, cpu)) {
         define_arm_cp_regs(cpu, jazelle_regs);
     }
     /* Slightly awkwardly, the OMAP and StrongARM cores need all of
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2f4aea927f1..052992037cc 100644
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
@@ -9850,8 +9850,8 @@ static bool op_div(DisasContext *s, arg_rrr *a, bool u)
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


