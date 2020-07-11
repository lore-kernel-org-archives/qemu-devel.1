Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB3C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0C3206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5XVsdU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0C3206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juCUF-0002h7-CO
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 06:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1juCT2-0000ay-Jd
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 06:10:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1juCSz-0008Et-UG
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 06:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594462245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1UiAD4gFaOW3zEEUp/Atpv/D7pvK1DiGqXGaa7CvaA=;
 b=D5XVsdU35KVMgDKf1G+OkI5YoToc5C0lnGhzFvVOALVvZ2/LQe5u9yqRkqoD9/C8ZaC/R4
 Vj/TgCgSTBCgREq+S/+6nLhVBECbQp35ICvtVDRhDgB2LB3b3F0MPwuuL+R1xA0qfy7h96
 Y40LZI5XDc9oBvixwJN0nF44liGFv/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-jD0tJPjLNh6zXQ71StZqHQ-1; Sat, 11 Jul 2020 06:10:43 -0400
X-MC-Unique: jD0tJPjLNh6zXQ71StZqHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C11107ACCA;
 Sat, 11 Jul 2020 10:10:42 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6D2C610F2;
 Sat, 11 Jul 2020 10:10:40 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH 3/3] hw/arm/virt: Implement kvm-steal-time
Date: Sat, 11 Jul 2020 12:10:33 +0200
Message-Id: <20200711101033.47371-4-drjones@redhat.com>
In-Reply-To: <20200711101033.47371-1-drjones@redhat.com>
References: <20200711101033.47371-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 06:10:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We add the kvm-steal-time CPU property and implement it for machvirt.
A tiny bit of refactoring was also done to allow pmu and pvtime to
use the same vcpu device helper functions.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 docs/system/arm/cpu-features.rst | 11 +++++
 hw/arm/virt.c                    | 33 ++++++++++++++-
 include/hw/arm/virt.h            |  2 +
 target/arm/cpu.c                 | 10 +++++
 target/arm/cpu.h                 |  4 ++
 target/arm/kvm.c                 | 20 +++++++++
 target/arm/kvm32.c               |  5 +++
 target/arm/kvm64.c               | 70 +++++++++++++++++++++++++++++---
 target/arm/kvm_arm.h             | 24 ++++++++++-
 target/arm/monitor.c             |  2 +-
 tests/qtest/arm-cpu-features.c   | 25 ++++++++++--
 11 files changed, 193 insertions(+), 13 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 2d5c06cd016b..4e590e6e9f54 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -200,6 +200,17 @@ the list of KVM VCPU features and their descriptions.
                            adjustment, also restoring the legacy (pre-5.0)
                            behavior.
 
+  kvm-steal-time           Since v5.1, kvm-steal-time is enabled by
+                           default when KVM is enabled, the feature is
+                           supported, and the guest is 64-bit.
+
+                           When kvm-steal-time is enabled a 64-bit guest
+                           can account for time its CPUs were not running
+                           due to the host not scheduling the corresponding
+                           VCPU threads.  The accounting statistics may
+                           influence the guest scheduler behavior and/or be
+                           exposed to the guest userspace.
+
 SVE CPU Properties
 ==================
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 63ef530933e5..21965a1665ca 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -151,6 +151,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
+    [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -1663,13 +1664,26 @@ static void finalize_gic_version(VirtMachineState *vms)
  */
 static void virt_cpu_post_init(VirtMachineState *vms)
 {
-    bool aarch64, pmu;
+    bool aarch64, pmu, steal_time;
     CPUState *cpu;
 
     aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
     pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
+    steal_time = object_property_get_bool(OBJECT(first_cpu),
+                                          "kvm-steal-time", NULL);
 
     if (kvm_enabled()) {
+        hwaddr pvtime_base = vms->memmap[VIRT_PVTIME].base;
+        hwaddr pvtime_size = vms->memmap[VIRT_PVTIME].size;
+
+        if (steal_time) {
+            MemoryRegion *pvtime = g_new(MemoryRegion, 1);
+
+            memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
+            memory_region_add_subregion(get_system_memory(), pvtime_base,
+                                        pvtime);
+        }
+
         CPU_FOREACH(cpu) {
             if (pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
@@ -1678,6 +1692,17 @@ static void virt_cpu_post_init(VirtMachineState *vms)
                 }
                 kvm_arm_pmu_init(cpu);
             }
+            if (steal_time) {
+                /*
+                 * We need 64 bytes for each CPU[*]. One 64k region gives
+                 * us up to 1024 CPUs, or some growing room for the pvtime
+                 * structure for less CPUs.
+                 *
+                 * [*] See Linux kernel arch/arm64/include/asm/pvclock-abi.h
+                 */
+                assert(pvtime_size >= MACHINE_GET_CLASS(vms)->max_cpus * 64);
+                kvm_arm_pvtime_init(cpu, pvtime_base + 64 * cpu->cpu_index);
+            }
         }
     } else {
         if (aarch64 && vms->highmem) {
@@ -1842,6 +1867,11 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
         }
 
+        if (vmc->kvm_no_steal_time &&
+            object_property_find(cpuobj, "kvm-steal-time", NULL)) {
+            object_property_set_bool(cpuobj, false, "kvm-steal-time", NULL);
+        }
+
         if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
             object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
@@ -2528,6 +2558,7 @@ static void virt_machine_5_0_options(MachineClass *mc)
     mc->numa_mem_supported = true;
     vmc->acpi_expose_flash = true;
     mc->auto_enable_numa_with_memdev = false;
+    vmc->kvm_no_steal_time = true;
 }
 DEFINE_VIRT_MACHINE(5, 0)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 54bcf17afd35..b5153afedcdf 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -80,6 +80,7 @@ enum {
     VIRT_PCDIMM_ACPI,
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
+    VIRT_PVTIME,
     VIRT_LOWMEMMAP_LAST,
 };
 
@@ -126,6 +127,7 @@ typedef struct {
     bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool acpi_expose_flash;
+    bool kvm_no_steal_time;
 } VirtMachineClass;
 
 typedef struct {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5050e1843a85..f894ee3fdee8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1308,6 +1308,16 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
+
+    if (kvm_enabled()) {
+#ifdef TARGET_AARCH64
+        kvm_arm_steal_time_finalize(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+#endif
+    }
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e8ed423ea1d..a4d4cb640c77 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -24,6 +24,7 @@
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "qapi/qapi-types-common.h"
 
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
@@ -859,6 +860,9 @@ struct ARMCPU {
     bool kvm_vtime_dirty;
     uint64_t kvm_vtime;
 
+    /* KVM steal time */
+    OnOffAuto kvm_steal_time;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378b5..093a290453f6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -192,6 +192,18 @@ static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_adjvtime = !value;
 }
 
+#ifdef TARGET_AARCH64
+static bool kvm_steal_time_get(Object *obj, Error **errp)
+{
+    return ARM_CPU(obj)->kvm_steal_time != ON_OFF_AUTO_OFF;
+}
+
+static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
+{
+    ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+#endif
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(Object *obj)
 {
@@ -207,6 +219,14 @@ void kvm_arm_add_vcpu_properties(Object *obj)
                                         "the virtual counter. VM stopped time "
                                         "will be counted.");
     }
+
+#ifdef TARGET_AARCH64
+    cpu->kvm_steal_time = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(obj, "kvm-steal-time", kvm_steal_time_get,
+                             kvm_steal_time_set);
+    object_property_set_description(obj, "kvm-steal-time",
+                                    "Set off to disable KVM steal time.");
+#endif
 }
 
 bool kvm_arm_pmu_supported(void)
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 0af46b41c847..d3f3195077fa 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -560,6 +560,11 @@ void kvm_arm_pmu_init(CPUState *cs)
     qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
 }
 
+void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
+}
+
 #define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
 #define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
 /*
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 116923790550..a5f4633f87c3 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -17,6 +17,7 @@
 #include <linux/kvm.h>
 
 #include "qemu-common.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
@@ -398,19 +399,20 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
     return NULL;
 }
 
-static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
+static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
+                                    const char *name)
 {
     int err;
 
     err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
     err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
@@ -427,7 +429,7 @@ void kvm_arm_pmu_init(CPUState *cs)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
     }
@@ -444,12 +446,29 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to set irq for PMU");
         abort();
     }
 }
 
+void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_PVTIME_CTRL,
+        .attr = KVM_ARM_VCPU_PVTIME_IPA,
+        .addr = (uint64_t)&ipa,
+    };
+
+    if (!ARM_CPU(cs)->kvm_steal_time) {
+        return;
+    }
+    if (!kvm_arm_set_device_attr(cs, &attr, "PVTIME IPA")) {
+        error_report("failed to init PVTIME IPA");
+        abort();
+    }
+}
+
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     uint64_t ret;
@@ -652,6 +671,47 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return true;
 }
 
+void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
+{
+    static bool has_steal_time;
+    static bool probed;
+    int fdarray[3];
+
+    if (!probed) {
+        probed = true;
+        if (kvm_check_extension(kvm_state, KVM_CAP_VCPU_ATTRIBUTES)) {
+            if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
+                error_report("Failed to create scratch VCPU");
+                abort();
+            }
+
+            has_steal_time = kvm_device_check_attr(fdarray[2],
+                                                   KVM_ARM_VCPU_PVTIME_CTRL,
+                                                   KVM_ARM_VCPU_PVTIME_IPA);
+
+            kvm_arm_destroy_scratch_host_vcpu(fdarray);
+        }
+    }
+
+    if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
+        if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+            cpu->kvm_steal_time = ON_OFF_AUTO_OFF;
+        } else {
+            cpu->kvm_steal_time = ON_OFF_AUTO_ON;
+        }
+    } else if (cpu->kvm_steal_time == ON_OFF_AUTO_ON) {
+        if (!has_steal_time) {
+            error_setg(errp, "'kvm-steal-time' cannot be enabled "
+                             "on this host");
+            return;
+        } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+            error_setg(errp, "'kvm-steal-time' cannot be enabled "
+                             "for AArch32 guests");
+            return;
+        }
+    }
+}
+
 bool kvm_arm_aarch32_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index adb38514bf20..21d776912b55 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -267,6 +267,16 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
  */
 void kvm_arm_add_vcpu_properties(Object *obj);
 
+/**
+ * kvm_arm_steal_time_finalize:
+ * @cpu: ARMCPU for which to finalize kvm-steal-time
+ * @errp: Pointer to Error* for error propagation
+ *
+ * Validate the kvm-steal-time property selection and set its default
+ * based on KVM support and guest configuration.
+ */
+void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
+
 /**
  * kvm_arm_aarch32_supported:
  *
@@ -340,6 +350,16 @@ int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
+
+/**
+ * kvm_arm_pvtime_init:
+ * @cs: CPUState
+ * @ipa: Per-vcpu guest physical base address of the pvtime structures
+ *
+ * Initializes PVTIME for the VCPU, setting the PVTIME IPA to @ipa.
+ */
+void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
+
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 #else
@@ -355,6 +375,7 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 }
 
 static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
+static inline void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp) {}
 
 static inline bool kvm_arm_aarch32_supported(void)
 {
@@ -383,9 +404,8 @@ static inline int kvm_arm_vgic_probe(void)
 
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
-
+static inline void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa) {}
 static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {}
-
 static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
 static inline void kvm_arm_put_virtual_time(CPUState *cs) {}
 #endif
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ba6e01abd037..bd3590604a71 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -103,7 +103,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve128", "sve256", "sve384", "sve512",
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
-    "kvm-no-adjvtime",
+    "kvm-no-adjvtime", "kvm-steal-time",
     NULL
 };
 
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index f7e062c1891e..91b181f38268 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -452,6 +452,7 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_set_feature(qts, "max", "pmu", true);
 
     assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
+    assert_has_not_feature(qts, "max", "kvm-steal-time");
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature_enabled(qts, "max", "aarch64");
@@ -493,6 +494,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
     assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        bool kvm_supports_steal_time;
         bool kvm_supports_sve;
         char max_name[8], name[8];
         uint32_t max_vq, vq;
@@ -500,6 +502,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         QDict *resp;
         char *error;
 
+        assert_error(qts, "cortex-a15",
+            "We cannot guarantee the CPU type 'cortex-a15' works "
+            "with KVM on this host", NULL);
+
         assert_has_feature_enabled(qts, "host", "aarch64");
 
         /* Enabling and disabling pmu should always work. */
@@ -507,16 +513,26 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         assert_set_feature(qts, "host", "pmu", false);
         assert_set_feature(qts, "host", "pmu", true);
 
-        assert_error(qts, "cortex-a15",
-            "We cannot guarantee the CPU type 'cortex-a15' works "
-            "with KVM on this host", NULL);
-
+        /*
+         * Some features would be enabled by default, but they're disabled
+         * because this instance of KVM doesn't support them. Test that the
+         * features are present, and, when enabled, issue further tests.
+         */
+        assert_has_feature(qts, "host", "kvm-steal-time");
         assert_has_feature(qts, "host", "sve");
+
         resp = do_query_no_props(qts, "host");
+        kvm_supports_steal_time = resp_get_feature(resp, "kvm-steal-time");
         kvm_supports_sve = resp_get_feature(resp, "sve");
         vls = resp_get_sve_vls(resp);
         qobject_unref(resp);
 
+        if (kvm_supports_steal_time) {
+            /* If we have steal-time then we should be able to toggle it. */
+            assert_set_feature(qts, "host", "kvm-steal-time", false);
+            assert_set_feature(qts, "host", "kvm-steal-time", true);
+        }
+
         if (kvm_supports_sve) {
             g_assert(vls != 0);
             max_vq = 64 - __builtin_clzll(vls);
@@ -577,6 +593,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
         assert_has_not_feature(qts, "host", "sve");
+        assert_has_not_feature(qts, "host", "kvm-steal-time");
     }
 
     qtest_quit(qts);
-- 
2.25.4


