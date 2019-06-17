Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B28C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5AC20833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5aGOuOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5AC20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsv4-0007lZ-NN
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiG-0003SR-6O
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiE-000800-Am
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiE-0007yl-1Y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id n4so10191715wrw.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5kyplZ9y5jGQlctb0ystayBsPFLBex7wmEn4fkno4/4=;
 b=x5aGOuOpvI+iuvYvGPX/pSzlQgFpCSCLmv1u+UqQBllf4e5QmNFe7ioVdLoRihJWQZ
 8+sfrDHNvobDO2EULQmfLOq44evqnsarcig4Z4zZcaxs4DbeCKHZIKXcp0marlkY9DWu
 px31tDhA993QdIkRy/r36aJhHxhFMNzQF/HWO8mh3NBUlrTmqZ5E6bDRZrllxGuGNZ6/
 rXsxNpTSTccLG+yLZwM80oAT0GwjPzyOPxGQaKoUQxG7Voie/Z/652y9rvDXmvB64bdx
 NYLIWm30wN+BjWi627f69nTmBXAFJEbcfM9TGry/TUln5zJX1np2aemc+XdRTfE7wgtk
 NICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5kyplZ9y5jGQlctb0ystayBsPFLBex7wmEn4fkno4/4=;
 b=rWpoo0qUuQ+34L21KSrRZ0iTt+vRmYTjdCyeNdxM/HkieGsX9XfCK8UcqDXCXUr9Y3
 VaryPF3qRKNJ4E6MavQVaTHne5OnRmvDOP+1tgf4NazoEAQwHb/pPghMBOmi5yv57ucw
 rsTGWxNSD/vLFD1J9d6cIo5Xv1ei0eO0Zck0zWunNpGXa/9uOVZHqYbhET0Fe1w+Gf+r
 Dmn95Yg+VsTZ75H54J2aqCtMbbVrcXvVYbECVI3lPCBK7QolBBFYGYI1N7N8aY1wcg0M
 JFnidG4gDsznjNlfQBpvGir9a4DZqAAHhAtIAGtNPlPBCEd2kk7QlXeqEHNnk7lILrP9
 +zEw==
X-Gm-Message-State: APjAAAVOLgeeIYZXQnF0PeNdI5K3wmJXfjO6m5QTdjkwALOYgRlavGPY
 okZNc3k/ZzYHlSeTfBnfH2GRJhJhsLI8pg==
X-Google-Smtp-Source: APXvYqw0X2sJLmNDv9TVaLZmpvYH9DL1Qt9BaonzNYKR6IUlpdqGas5aeRKl2WJVxAalNz1jNVAa1w==
X-Received: by 2002:adf:de02:: with SMTP id b2mr538941wrm.349.1560782060231;
 Mon, 17 Jun 2019 07:34:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:53 +0100
Message-Id: <20190617143412.5734-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 05/24] target/arm: Allow VFP and Neon to be
 disabled via a CPU property
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

Allow VFP and neon to be disabled via a CPU property. As with
the "pmu" property, we only allow these features to be removed
from CPUs which have it by default, not added to CPUs which
don't have it.

The primary motivation here is to be able to optionally
create Cortex-M33 CPUs with no FPU, but we provide switches
for both VFP and Neon because the two interact:
 * AArch64 can't have one without the other
 * Some ID register fields only change if both are disabled

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190517174046.11146-2-peter.maydell@linaro.org
---
 target/arm/cpu.h |   4 ++
 target/arm/cpu.c | 150 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 148 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 92298624215..cf2496aeeec 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -786,6 +786,10 @@ struct ARMCPU {
     bool has_el3;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
+    /* CPU has VFP */
+    bool has_vfp;
+    /* CPU has Neon */
+    bool has_neon;
 
     /* CPU has memory protection unit */
     bool has_mpu;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2335659a852..af879d5311e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -763,6 +763,12 @@ static Property arm_cpu_cfgend_property =
 static Property arm_cpu_has_pmu_property =
             DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
 
+static Property arm_cpu_has_vfp_property =
+            DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
+
+static Property arm_cpu_has_neon_property =
+            DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
+
 static Property arm_cpu_has_mpu_property =
             DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
 
@@ -803,6 +809,13 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
         set_feature(&cpu->env, ARM_FEATURE_PMSA);
     }
+    /* Similarly for the VFP feature bits */
+    if (arm_feature(&cpu->env, ARM_FEATURE_VFP4)) {
+        set_feature(&cpu->env, ARM_FEATURE_VFP3);
+    }
+    if (arm_feature(&cpu->env, ARM_FEATURE_VFP3)) {
+        set_feature(&cpu->env, ARM_FEATURE_VFP);
+    }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
@@ -847,6 +860,27 @@ void arm_cpu_post_init(Object *obj)
                                  &error_abort);
     }
 
+    /*
+     * Allow user to turn off VFP and Neon support, but only for TCG --
+     * KVM does not currently allow us to lie to the guest about its
+     * ID/feature registers, so the guest always sees what the host has.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        cpu->has_vfp = true;
+        if (!kvm_enabled()) {
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property,
+                                     &error_abort);
+        }
+    }
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
+        cpu->has_neon = true;
+        if (!kvm_enabled()) {
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property,
+                                     &error_abort);
+        }
+    }
+
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property,
                                  &error_abort);
@@ -956,6 +990,116 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
+        cpu->has_vfp != cpu->has_neon) {
+        /*
+         * This is an architectural requirement for AArch64; AArch32 is
+         * more flexible and permits VFP-no-Neon and Neon-no-VFP.
+         */
+        error_setg(errp,
+                   "AArch64 CPUs must have both VFP and Neon or neither");
+        return;
+    }
+
+    if (!cpu->has_vfp) {
+        uint64_t t;
+        uint32_t u;
+
+        unset_feature(env, ARM_FEATURE_VFP);
+        unset_feature(env, ARM_FEATURE_VFP3);
+        unset_feature(env, ARM_FEATURE_VFP4);
+
+        t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
+        cpu->isar.id_aa64isar1 = t;
+
+        t = cpu->isar.id_aa64pfr0;
+        t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
+        cpu->isar.id_aa64pfr0 = t;
+
+        u = cpu->isar.id_isar6;
+        u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
+        cpu->isar.id_isar6 = u;
+
+        u = cpu->isar.mvfr0;
+        u = FIELD_DP32(u, MVFR0, FPSP, 0);
+        u = FIELD_DP32(u, MVFR0, FPDP, 0);
+        u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
+        u = FIELD_DP32(u, MVFR0, FPDIVIDE, 0);
+        u = FIELD_DP32(u, MVFR0, FPSQRT, 0);
+        u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
+        u = FIELD_DP32(u, MVFR0, FPROUND, 0);
+        cpu->isar.mvfr0 = u;
+
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, FPFTZ, 0);
+        u = FIELD_DP32(u, MVFR1, FPDNAN, 0);
+        u = FIELD_DP32(u, MVFR1, FPHP, 0);
+        cpu->isar.mvfr1 = u;
+
+        u = cpu->isar.mvfr2;
+        u = FIELD_DP32(u, MVFR2, FPMISC, 0);
+        cpu->isar.mvfr2 = u;
+    }
+
+    if (!cpu->has_neon) {
+        uint64_t t;
+        uint32_t u;
+
+        unset_feature(env, ARM_FEATURE_NEON);
+
+        t = cpu->isar.id_aa64isar0;
+        t = FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
+        cpu->isar.id_aa64isar0 = t;
+
+        t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
+        cpu->isar.id_aa64isar1 = t;
+
+        t = cpu->isar.id_aa64pfr0;
+        t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
+        cpu->isar.id_aa64pfr0 = t;
+
+        u = cpu->isar.id_isar5;
+        u = FIELD_DP32(u, ID_ISAR5, RDM, 0);
+        u = FIELD_DP32(u, ID_ISAR5, VCMA, 0);
+        cpu->isar.id_isar5 = u;
+
+        u = cpu->isar.id_isar6;
+        u = FIELD_DP32(u, ID_ISAR6, DP, 0);
+        u = FIELD_DP32(u, ID_ISAR6, FHM, 0);
+        cpu->isar.id_isar6 = u;
+
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
+        cpu->isar.mvfr1 = u;
+
+        u = cpu->isar.mvfr2;
+        u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
+        cpu->isar.mvfr2 = u;
+    }
+
+    if (!cpu->has_neon && !cpu->has_vfp) {
+        uint64_t t;
+        uint32_t u;
+
+        t = cpu->isar.id_aa64isar0;
+        t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 0);
+        cpu->isar.id_aa64isar0 = t;
+
+        t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
+        cpu->isar.id_aa64isar1 = t;
+
+        u = cpu->isar.mvfr0;
+        u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
+        cpu->isar.mvfr0 = u;
+    }
+
     /* Some features automatically imply others: */
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M)) {
@@ -1016,12 +1160,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_V5)) {
         set_feature(env, ARM_FEATURE_V4T);
     }
-    if (arm_feature(env, ARM_FEATURE_VFP4)) {
-        set_feature(env, ARM_FEATURE_VFP3);
-    }
-    if (arm_feature(env, ARM_FEATURE_VFP3)) {
-        set_feature(env, ARM_FEATURE_VFP);
-    }
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         set_feature(env, ARM_FEATURE_V7MP);
         set_feature(env, ARM_FEATURE_PXN);
-- 
2.20.1


