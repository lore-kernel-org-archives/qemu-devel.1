Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB9ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE42F20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgdQDlmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE42F20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgh8-0000TR-QR
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyC-00086i-7e
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyA-00010U-LQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyA-00010A-Dy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id p21so2100866wmg.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YX5kAV2V+51rIRAoIJH8dk7lXcJe17TkZW9vBLdbmdY=;
 b=zgdQDlmI2ot3n40f+DLOr+5xsOXSL/83GFPGtC7ZlYuqaVhTwCEN/nsMk+emHyS0Dc
 Ek6nzWFKjzxJRB14MvNmM3gcUHk1Wri1xIlBmHgvPLqkbk+7Qfvxnxk/YFRtRSUpxlWu
 /cMA+jm+Tds5TSuVuIMXMjskRctXVkIhXz60J5pPE1dDzOBxAGIjW6fPwZNsvTpccb6o
 SXb/oW2oflRqc4OA/MxBs557+2fTMfSR8OJ8OUvhRKDoDhs9u3tuZVnP9xlEiiuOeonN
 1elnCEkS1rty0hBzNOFtrlalDlrHusd98zFdK1VOdE3c7x1GPp+cNvtGzdRlrSvh9MNa
 M1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YX5kAV2V+51rIRAoIJH8dk7lXcJe17TkZW9vBLdbmdY=;
 b=hpzleNZ/Rp9F58OfivcQcisRnZeZO53fRwuixJ7RYyURYwSEMt0D3nwW+hLuecbpYO
 kYPQlaq6EydWnKhxqyUs9qGt58URE5WIlly0hjPX2tI3XRuMp3/SWG6RjxgT8hnMWK2k
 ebUQgiOJ9k7KstzbcjGhTcRQf6kLcrJ4lVs0nVBU19vF1DCqmp+2V+1eFOEHB8vWRCdD
 1iblvweO7owbnWpiaHvpYR+u+/n5ze7VQltLDEGe/X9wFhi9hqQ/MM7aRV3wsx/S3zXF
 gX8kJYVgzjYkc8TqHoo5J5r5MMQh/0A9lJreoi2chNsP4qVP62/ZqN+R1RSnuoJLgqxA
 oLqA==
X-Gm-Message-State: APjAAAVonriTWatGcBa4/vy24WoQmmSautAhhkI845HSfpEM20LLHSg1
 XX2K5Lq5uwSbIjAJRLT4gwDuTpyr6VE=
X-Google-Smtp-Source: APXvYqxfa0RjSE0fKc2ugPraEPK85a0Cgrck4/0stnzaaDlAznGAWeAssdKk6AdHEC5KkL2e03AFgw==
X-Received: by 2002:a1c:5587:: with SMTP id j129mr5669423wmb.15.1571934492938; 
 Thu, 24 Oct 2019 09:28:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/51] target/arm: Allow SVE to be disabled via a CPU property
Date: Thu, 24 Oct 2019 17:27:10 +0100
Message-Id: <20191024162724.31675-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

From: Andrew Jones <drjones@redhat.com>

Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
a CPU property") we can disable the 'max' cpu model's VFP and neon
features, but there's no way to disable SVE. Add the 'sve=on|off'
property to give it that flexibility. We also rename
cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
to follow the typical *_get/set_<property-name> pattern.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Beata Michalska <beata.michalska@linaro.org>
Message-id: 20191024121808.9612-4-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c         |  3 ++-
 target/arm/cpu64.c       | 52 ++++++++++++++++++++++++++++++++++------
 target/arm/monitor.c     |  2 +-
 tests/arm-cpu-features.c |  1 +
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab3e1a03616..72a27ec4b0e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -200,7 +200,8 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
         env->cp15.cptr_el[3] |= CPTR_EZ;
         /* with maximum vector length */
-        env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
+        env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
+                             cpu->sve_max_vq - 1 : 0;
         env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
         /*
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d7f5bf610a7..89a8ae77fe8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -256,15 +256,23 @@ static void aarch64_a72_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
 }
 
-static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
+    uint32_t value;
+
+    /* All vector lengths are disabled when SVE is off. */
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        value = 0;
+    } else {
+        value = cpu->sve_max_vq;
+    }
+    visit_type_uint32(v, name, &value, errp);
 }
 
-static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     Error *err = NULL;
@@ -279,6 +287,34 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
     error_propagate(errp, err);
 }
 
+static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    bool value = cpu_isar_feature(aa64_sve, cpu);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    Error *err = NULL;
+    bool value;
+    uint64_t t;
+
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    t = cpu->isar.id_aa64pfr0;
+    t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
+    cpu->isar.id_aa64pfr0 = t;
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -391,8 +427,10 @@ static void aarch64_max_initfn(Object *obj)
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
-        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
-                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
+        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
+                            cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
+        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
+                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
     }
 }
 
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 560970de7f5..2209b27b9a0 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -97,7 +97,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
  * then the order that considers those dependencies must be used.
  */
 static const char *cpu_model_advertised_features[] = {
-    "aarch64", "pmu",
+    "aarch64", "pmu", "sve",
     NULL
 };
 
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index c59fcf409c8..6342cd2e4ec 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -179,6 +179,7 @@ static void test_query_cpu_model_expansion(const void *data)
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature(qts, "max", "aarch64");
+        assert_has_feature(qts, "max", "sve");
         assert_has_feature(qts, "cortex-a57", "pmu");
         assert_has_feature(qts, "cortex-a57", "aarch64");
 
-- 
2.20.1


