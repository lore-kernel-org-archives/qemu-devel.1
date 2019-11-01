Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C7CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A2E2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdFZMrdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A2E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQShK-0003E2-QC
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSey-0001An-HG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSet-0000Gh-Un
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSet-0000CD-O8
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q70so8591979wme.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H7ILofrJ53o7sIXI9sIMKbof/7pxu+txIzjGatMT/v8=;
 b=xdFZMrdfTOumkKySVLyCi0ZJ6S2aiMoPM/Rnn51f3jkOIDFIN1GeoEBp73X8/pYMp3
 Rr1/mSwJguO5TxJ2JDkBtNUz28/BUAnxdJFzOEwZH9fY6jvefZsHRMAP7euwkoF0SnCa
 qJGSf3WEPbxXlh2rtIMeB+Z5seLhnPxKN3uEAzUXOeOfcmPB1JA1bYzJ1hzCIvWANN7p
 Ppg0GBXiFv3mkcC8ukwIhc2VE/u8LNeVZXQcy09qBaPD/8gkjPPkrM1hpGkdpCeHnBVF
 qJ4TF80GmTuKRs0P8lGPucUadRFh5piGFlgNHHAb8lu8BHDzem87cXDZjHh5UkRbg/qC
 OGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H7ILofrJ53o7sIXI9sIMKbof/7pxu+txIzjGatMT/v8=;
 b=RlRd/etbYqJxTchz/ybejT+wgGP8CITwBFDnhJuGeVuMMMAlN554SIDGxqkRcc8G+b
 kK/zuCrFZZaX7th5+rajTxULl3FOTyPeMsxhMaoItFUZZ7ihqwAEGavYhqK3Go6zs2EE
 3S5dA9JWt8W+x2ouKW6do39tsPdOnNEC6tL379IC2f9KwygFhn/DoYN/vxBaw0yfKHZJ
 WlZv999R3s57sGpzSYGVhW0rKVyW2ah/7WfRaNFxw/5WntrXmvGuXhevsaGYzcQh66HS
 EPX0/w5NBUEQwveWNVa8/mUO+jADtUmiyV+ALQVcWtXrJQg2oJnJJFUPabMs0xUs2mSH
 aUVw==
X-Gm-Message-State: APjAAAUkO04K7pdOHCoVCQLghtrNOgCS4IeA2XtwP48c4ao0ElunUwLp
 A27GcAj+CzEok1f1HRe6Z7qIS/rllxtNxz5g
X-Google-Smtp-Source: APXvYqwS1+O5lTc6zWVNDDxJBvYjDYX/bcKJTDHr19WfPAGFazm8SNqRUX0pbyALDn/IxHKjd6GGUA==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr2271761wmc.19.1572598310410; 
 Fri, 01 Nov 2019 01:51:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d20sm8818922wra.4.2019.11.01.01.51.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] target/arm/kvm64: max cpu: Enable SVE when available
Date: Fri,  1 Nov 2019 08:51:35 +0000
Message-Id: <20191101085140.5205-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101085140.5205-1-peter.maydell@linaro.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Andrew Jones <drjones@redhat.com>

Enable SVE in the KVM guest when the 'max' cpu type is configured
and KVM supports it. KVM SVE requires use of the new finalize
vcpu ioctl, so we add that now too. For starters SVE can only be
turned on or off, getting all vector lengths the host CPU supports
when on. We'll add the other SVE CPU properties in later patches.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Beata Michalska <beata.michalska@linaro.org>
Message-id: 20191031142734.8590-7-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h     | 27 +++++++++++++++++++++++++++
 target/arm/cpu64.c       | 17 ++++++++++++++---
 target/arm/kvm.c         |  5 +++++
 target/arm/kvm64.c       | 20 +++++++++++++++++++-
 tests/arm-cpu-features.c |  4 ++++
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b4e19457a09..7c12f1501a8 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -27,6 +27,20 @@
  */
 int kvm_arm_vcpu_init(CPUState *cs);
 
+/**
+ * kvm_arm_vcpu_finalize
+ * @cs: CPUState
+ * @feature: int
+ *
+ * Finalizes the configuration of the specified VCPU feature by
+ * invoking the KVM_ARM_VCPU_FINALIZE ioctl. Features requiring
+ * this are documented in the "KVM_ARM_VCPU_FINALIZE" section of
+ * KVM's API documentation.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+int kvm_arm_vcpu_finalize(CPUState *cs, int feature);
+
 /**
  * kvm_arm_register_device:
  * @mr: memory region for this device
@@ -225,6 +239,14 @@ bool kvm_arm_aarch32_supported(CPUState *cs);
  */
 bool kvm_arm_pmu_supported(CPUState *cs);
 
+/**
+ * bool kvm_arm_sve_supported:
+ * @cs: CPUState
+ *
+ * Returns true if the KVM VCPU can enable SVE and false otherwise.
+ */
+bool kvm_arm_sve_supported(CPUState *cs);
+
 /**
  * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
  * IPA address space supported by KVM
@@ -276,6 +298,11 @@ static inline bool kvm_arm_pmu_supported(CPUState *cs)
     return false;
 }
 
+static inline bool kvm_arm_sve_supported(CPUState *cs)
+{
+    return false;
+}
+
 static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     return -ENOENT;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 34b0ba2cf6f..a771a28daa5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -493,6 +493,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+        error_setg(errp, "'sve' feature not supported by KVM on this host");
+        return;
+    }
+
     t = cpu->isar.id_aa64pfr0;
     t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
     cpu->isar.id_aa64pfr0 = t;
@@ -507,11 +512,16 @@ static void aarch64_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     uint32_t vq;
+    uint64_t t;
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
+        if (kvm_arm_sve_supported(CPU(cpu))) {
+            t = cpu->isar.id_aa64pfr0;
+            t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
+            cpu->isar.id_aa64pfr0 = t;
+        }
     } else {
-        uint64_t t;
         uint32_t u;
         aarch64_a57_initfn(obj);
 
@@ -612,8 +622,6 @@ static void aarch64_max_initfn(Object *obj)
 
         object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
                             cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
-        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
-                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
 
         for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
             char name[8];
@@ -622,6 +630,9 @@ static void aarch64_max_initfn(Object *obj)
                                 cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
         }
     }
+
+    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
+                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
 }
 
 struct ARMCPUInfo {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b473c63edb1..f07332bbda3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -51,6 +51,11 @@ int kvm_arm_vcpu_init(CPUState *cs)
     return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
 }
 
+int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
+{
+    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
+}
+
 void kvm_arm_init_serror_injection(CPUState *cs)
 {
     cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 4c0b11d105a..850da1b5e6a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -602,6 +602,13 @@ bool kvm_arm_aarch32_supported(CPUState *cpu)
     return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
 }
 
+bool kvm_arm_sve_supported(CPUState *cpu)
+{
+    KVMState *s = KVM_STATE(current_machine->accelerator);
+
+    return kvm_check_extension(s, KVM_CAP_ARM_SVE);
+}
+
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
 int kvm_arch_init_vcpu(CPUState *cs)
@@ -630,13 +637,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
     }
     if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
-            cpu->has_pmu = false;
+        cpu->has_pmu = false;
     }
     if (cpu->has_pmu) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
     } else {
         unset_feature(&env->features, ARM_FEATURE_PMU);
     }
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        assert(kvm_arm_sve_supported(cs));
+        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
+    }
 
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cs);
@@ -644,6 +655,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
+        if (ret) {
+            return ret;
+        }
+    }
+
     /*
      * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
      * Currently KVM has its own idea about MPIDR assignment, so we
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 7fd01f0ea3f..015b511c87e 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -417,12 +417,16 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         assert_has_feature(qts, "host", "aarch64");
         assert_has_feature(qts, "host", "pmu");
 
+        assert_has_feature(qts, "max", "sve");
+
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
             "with KVM on this host", NULL);
     } else {
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
+
+        assert_has_not_feature(qts, "max", "sve");
     }
 
     qtest_quit(qts);
-- 
2.20.1


