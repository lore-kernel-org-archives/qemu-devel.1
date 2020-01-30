Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9585C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756F32082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyOxrW9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756F32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCgX-0002Z6-LC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUI-0005ro-AD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUD-0003Kc-D1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:14 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCUD-0003IX-61
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id g1so4391158wmh.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yYQ5BYIuCiaN8opJusprrK6w/aeyK1rwcNEnRe/cSCw=;
 b=oyOxrW9u4IjPnX4sSy1hZOcplAMrBTHc7GORRMkkDnG3+FDyIKMhf/5oXQ6ej/l6ce
 fuwb85ADImaVHmRSI8lQb4EomVLzC1fk1kzQC/PhXDwBnDIOh1mOtkkkfwZlJZGL0q38
 RGT/zykX/tqUKFTQA3ywlVgT5Z4EJk6rwsUniCOj9gpUj8CqqR2hx06BhU2VeygHGTVW
 X3Od8YPbauJi3sPtJ9a9KqvD04Pyh7MqvPS312JMEPuUsuRk+rs6T3Qpe1wcKgDwxTxz
 bdSnFrjeHvufnEvbyDNhnHZ3Twly2mB52cQiq1heIarTpcdGmOfVXvi1CEUfN9JEsp7N
 wCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yYQ5BYIuCiaN8opJusprrK6w/aeyK1rwcNEnRe/cSCw=;
 b=MayR77+Zl4SyCfpShrH4JitOFk3ielaMllC0R0aX7wnLzsF/1o3KmolR/ly5AwS6tA
 kaz+/fLBB4cKVjhTTI9bvlpugUcJGcF/Ti30OWdeXgHjIH6VsQ7vUZxw2YCXYhhHL3Aq
 X5Rkr/pP/DF/dmhz6WNYnQZjNwZS9HQD7s+sILcpaKS97rY22MA3jwRmrV39co1Rrx0A
 dpjNISEWq4IL3cUiohdTmMXcNwBjHytsoa4A6zowQcr96PG+VeB9FPBml0FJTtwPtfbh
 MOovWdpJziTxQh5HNifRS5IvQ6X5rFbjZhe9Pc0SOg35kayP9vFVuKrqf0Zzlf10b+yR
 pQUA==
X-Gm-Message-State: APjAAAXst4NwN9i0O3qdHTfbuMwbLCPqcnnS4HvI7IFkEbPgHFK++/cX
 qPeHgP1tfEllIPxAqom8xuFGJ9pKv5GFkQ==
X-Google-Smtp-Source: APXvYqxwBrD6CpdWoju5wFhAMYRS2T/5G2Z8oCfIUznpMFNxP0bOOu0NYz4vSYaRN2U1qCjnLum0Gw==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr6311526wmi.178.1580400967189; 
 Thu, 30 Jan 2020 08:16:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.16.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:16:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] target/arm/cpu: Add the kvm-no-adjvtime CPU property
Date: Thu, 30 Jan 2020 16:15:33 +0000
Message-Id: <20200130161533.8180-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
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

kvm-no-adjvtime is a KVM specific CPU property and a first of its
kind. To accommodate it we also add kvm_arm_add_vcpu_properties()
and a KVM specific CPU properties description to the CPU features
document.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200120101023.16030-7-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h          |  1 +
 target/arm/kvm_arm.h           | 11 ++++++++++
 hw/arm/virt.c                  |  8 ++++++++
 target/arm/cpu.c               |  2 ++
 target/arm/cpu64.c             |  1 +
 target/arm/kvm.c               | 28 +++++++++++++++++++++++++
 target/arm/monitor.c           |  1 +
 tests/qtest/arm-cpu-features.c |  4 ++++
 docs/arm-cpu-features.rst      | 37 +++++++++++++++++++++++++++++++++-
 9 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 38f0c33c77c..71508bf40c3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -109,6 +109,7 @@ typedef struct {
     bool smbios_old_sys_ver;
     bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
+    bool kvm_no_adjvtime;
 } VirtMachineClass;
 
 typedef struct {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 01a9a182785..ae9e075d754 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -255,6 +255,15 @@ void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/**
+ * kvm_arm_add_vcpu_properties:
+ * @obj: The CPU object to add the properties to
+ *
+ * Add all KVM specific CPU properties to the CPU object. These
+ * are the CPU properties with "kvm-" prefixed names.
+ */
+void kvm_arm_add_vcpu_properties(Object *obj);
+
 /**
  * kvm_arm_aarch32_supported:
  * @cs: CPUState
@@ -345,6 +354,8 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->host_cpu_probe_failed = true;
 }
 
+static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
+
 static inline bool kvm_arm_aarch32_supported(CPUState *cs)
 {
     return false;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 91d4b838b2e..f788fe27d63 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1663,6 +1663,11 @@ static void machvirt_init(MachineState *machine)
             }
         }
 
+        if (vmc->kvm_no_adjvtime &&
+            object_property_find(cpuobj, "kvm-no-adjvtime", NULL)) {
+            object_property_set_bool(cpuobj, true, "kvm-no-adjvtime", NULL);
+        }
+
         if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
             object_property_set_bool(cpuobj, false, "pmu", NULL);
         }
@@ -2153,8 +2158,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
 
 static void virt_machine_4_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_5_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    vmc->kvm_no_adjvtime = true;
 }
 DEFINE_VIRT_MACHINE(4, 2)
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 06907b36d7d..f86e71a260d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2551,6 +2551,7 @@ static void arm_max_initfn(Object *obj)
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
+        kvm_arm_add_vcpu_properties(obj);
     } else {
         cortex_a15_initfn(obj);
 
@@ -2743,6 +2744,7 @@ static void arm_host_initfn(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
     }
+    kvm_arm_add_vcpu_properties(obj);
     arm_cpu_post_init(obj);
 }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 61fd0ade29a..2d97bf45e1e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -605,6 +605,7 @@ static void aarch64_max_initfn(Object *obj)
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
+        kvm_arm_add_vcpu_properties(obj);
     } else {
         uint64_t t;
         uint32_t u;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e36ab0b38bf..85860e6f954 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -17,6 +17,8 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qom/object.h"
+#include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
@@ -179,6 +181,32 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features = arm_host_cpu_features.features;
 }
 
+static bool kvm_no_adjvtime_get(Object *obj, Error **errp)
+{
+    return !ARM_CPU(obj)->kvm_adjvtime;
+}
+
+static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
+{
+    ARM_CPU(obj)->kvm_adjvtime = !value;
+}
+
+/* KVM VCPU properties should be prefixed with "kvm-". */
+void kvm_arm_add_vcpu_properties(Object *obj)
+{
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    ARM_CPU(obj)->kvm_adjvtime = true;
+    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
+                             kvm_no_adjvtime_set, &error_abort);
+    object_property_set_description(obj, "kvm-no-adjvtime",
+                                    "Set on to disable the adjustment of "
+                                    "the virtual counter. VM stopped time "
+                                    "will be counted.", &error_abort);
+}
+
 bool kvm_arm_pmu_supported(CPUState *cpu)
 {
     return kvm_check_extension(cpu->kvm_state, KVM_CAP_ARM_PMU_V3);
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index fa054f8a369..9725dfff16d 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -103,6 +103,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve128", "sve256", "sve384", "sve512",
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
+    "kvm-no-adjvtime",
     NULL
 };
 
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index a039e3c8d72..46921736766 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -428,6 +428,8 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_has_feature_enabled(qts, "cortex-a15", "pmu");
     assert_has_not_feature(qts, "cortex-a15", "aarch64");
 
+    assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
+
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature_enabled(qts, "max", "aarch64");
         assert_has_feature_enabled(qts, "max", "sve");
@@ -462,6 +464,8 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         return;
     }
 
+    assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
+
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
         char max_name[8], name[8];
diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index 9b537a75e69..dbf3b7cf42c 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -31,7 +31,9 @@ supporting the feature or only supporting the feature under certain
 configurations.  For example, the `aarch64` CPU feature, which, when
 disabled, enables the optional AArch32 CPU feature, is only supported
 when using the KVM accelerator and when running on a host CPU type that
-supports the feature.
+supports the feature.  While `aarch64` currently only works with KVM,
+it could work with TCG.  CPU features that are specific to KVM are
+prefixed with "kvm-" and are described in "KVM VCPU Features".
 
 CPU Feature Probing
 ===================
@@ -171,6 +173,39 @@ disabling many SVE vector lengths would be quite verbose, the `sve<N>` CPU
 properties have special semantics (see "SVE CPU Property Parsing
 Semantics").
 
+KVM VCPU Features
+=================
+
+KVM VCPU features are CPU features that are specific to KVM, such as
+paravirt features or features that enable CPU virtualization extensions.
+The features' CPU properties are only available when KVM is enabled and
+are named with the prefix "kvm-".  KVM VCPU features may be probed,
+enabled, and disabled in the same way as other CPU features.  Below is
+the list of KVM VCPU features and their descriptions.
+
+  kvm-no-adjvtime          By default kvm-no-adjvtime is disabled.  This
+                           means that by default the virtual time
+                           adjustment is enabled (vtime is *not not*
+                           adjusted).
+
+                           When virtual time adjustment is enabled each
+                           time the VM transitions back to running state
+                           the VCPU's virtual counter is updated to ensure
+                           stopped time is not counted.  This avoids time
+                           jumps surprising guest OSes and applications,
+                           as long as they use the virtual counter for
+                           timekeeping.  However it has the side effect of
+                           the virtual and physical counters diverging.
+                           All timekeeping based on the virtual counter
+                           will appear to lag behind any timekeeping that
+                           does not subtract VM stopped time.  The guest
+                           may resynchronize its virtual counter with
+                           other time sources as needed.
+
+                           Enable kvm-no-adjvtime to disable virtual time
+                           adjustment, also restoring the legacy (pre-5.0)
+                           behavior.
+
 SVE CPU Properties
 ==================
 
-- 
2.20.1


