Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE1AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3D420578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3D420578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcB7m-00061c-U7
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxi-0002hK-U1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxb-0005Rd-DI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1781FAD21;
 Mon,  9 Nov 2020 17:28:06 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v1 09/10] i386: split cpu.c and defer x86 models registration
Date: Mon,  9 Nov 2020 18:27:54 +0100
Message-Id: <20201109172755.16500-10-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109172755.16500-1-cfontana@suse.de>
References: <20201109172755.16500-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 21:17:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Cameron Esfahani <dirty@apple.com>, haxm-team@intel.com,
 Claudio Fontana <cfontana@suse.de>, Anthony Perard <anthony.perard@citrix.com>,
 Bruce Rogers <brogers@suse.com>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

split cpu.c into:

cpu.c            cpuid and common x86 cpu functionality
host-cpu.c       host x86 cpu functions and "host" cpu type
kvm-cpu-type.c   KVM x86 cpu type
hvf-cpu-type.c   HVF x86 cpu type
tcg-cpu-type.c   TCG x86 cpu type

Defer the x86 models registration to MODULE_INIT_ACCEL_CPU,
so that accel-specific types can be used as parent types for all
cpu models. Use the generic TYPE_X86_CPU only if no
accel-specific specialization is enabled.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 bsd-user/main.c                      |   4 +
 hw/i386/pc_piix.c                    |   1 +
 linux-user/main.c                    |  10 +-
 softmmu/vl.c                         |   2 +-
 target/i386/accel/hvf/hvf-cpu-type.c |  78 +++++
 target/i386/accel/hvf/meson.build    |   1 +
 target/i386/accel/kvm/kvm-cpu-type.c | 161 ++++++++++
 target/i386/accel/kvm/kvm-cpu-type.h |  41 +++
 target/i386/accel/kvm/kvm.c          |   3 +-
 target/i386/accel/kvm/meson.build    |   7 +-
 target/i386/accel/tcg/meson.build    |   3 +-
 target/i386/accel/tcg/tcg-cpu-type.c | 176 +++++++++++
 target/i386/accel/tcg/tcg-cpu-type.h |  25 ++
 target/i386/cpu.c                    | 454 +++++----------------------
 target/i386/cpu.h                    |  26 +-
 target/i386/host-cpu.c               | 201 ++++++++++++
 target/i386/host-cpu.h               |  21 ++
 target/i386/meson.build              |   8 +-
 target/i386/tcg-cpu.c                |  71 -----
 target/i386/tcg-cpu.h                |  15 -
 20 files changed, 834 insertions(+), 474 deletions(-)
 create mode 100644 target/i386/accel/hvf/hvf-cpu-type.c
 create mode 100644 target/i386/accel/kvm/kvm-cpu-type.c
 create mode 100644 target/i386/accel/kvm/kvm-cpu-type.h
 create mode 100644 target/i386/accel/tcg/tcg-cpu-type.c
 create mode 100644 target/i386/accel/tcg/tcg-cpu-type.h
 create mode 100644 target/i386/host-cpu.c
 create mode 100644 target/i386/host-cpu.h
 delete mode 100644 target/i386/tcg-cpu.c
 delete mode 100644 target/i386/tcg-cpu.h

diff --git a/bsd-user/main.c b/bsd-user/main.c
index ac40d79bfa..48dd4b8ba5 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -911,6 +911,10 @@ int main(int argc, char **argv)
 
     /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
+    /*
+     * TCG has been initialized, now it is time to register the cpu models.
+     */
+    module_call_init(MODULE_INIT_ACCEL_CPU);
 
     cpu_type = parse_cpu_option(cpu_model);
     cpu = cpu_create(cpu_type);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 13d1628f13..a59c3e1457 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -64,6 +64,7 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
+#include "accel/kvm/kvm-cpu-type.h"
 
 #define MAX_IDE_BUS 2
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 75c9785157..86ebd5db5e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -699,14 +699,18 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+    /* init tcg before creating CPUs and to get qemu_host_page_size */
+    tcg_exec_init(0);
+    /*
+     * TCG has been initialized, now it is time to register the cpu models.
+     */
+    module_call_init(MODULE_INIT_ACCEL_CPU);
+
     if (cpu_model == NULL) {
         cpu_model = cpu_get_model(get_elf_eflags(execfd));
     }
     cpu_type = parse_cpu_option(cpu_model);
 
-    /* init tcg before creating CPUs and to get qemu_host_page_size */
-    tcg_exec_init(0);
-
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
     cpu_reset(cpu);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 6a6363902d..47cc938cef 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4176,7 +4176,7 @@ void qemu_init(int argc, char **argv, char **envp)
 
     /*
      * accelerator has been chosen and initialized, now it is time to
-     * register the cpu accel interface.
+     * register the cpu models, and the cpu accel interface.
      */
     module_call_init(MODULE_INIT_ACCEL_CPU);
 
diff --git a/target/i386/accel/hvf/hvf-cpu-type.c b/target/i386/accel/hvf/hvf-cpu-type.c
new file mode 100644
index 0000000000..dfe4ec4e9e
--- /dev/null
+++ b/target/i386/accel/hvf/hvf-cpu-type.c
@@ -0,0 +1,78 @@
+/*
+ * x86 HVF CPU type initialization
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "host-cpu.h"
+#include "hvf-cpu-type.h"
+#include "qapi/error.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+#include "sysemu/hvf.h"
+
+
+static void hvf_cpu_common_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = host_cpu_realizefn;
+}
+
+static void hvf_cpu_max_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+
+    host_cpu_max_initfn(cpu);
+
+    env->cpuid_min_level =
+        hvf_get_supported_cpuid(0x0, 0, R_EAX);
+    env->cpuid_min_xlevel =
+        hvf_get_supported_cpuid(0x80000000, 0, R_EAX);
+    env->cpuid_min_xlevel2 =
+        hvf_get_supported_cpuid(0xC0000000, 0, R_EAX);
+}
+
+static void hvf_cpu_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+
+    host_cpu_initfn(obj);
+
+    /* Special cases not set in the X86CPUDefinition structs: */
+    /* TODO: in-kernel irqchip for hvf */
+
+    if (cpu->max_features) {
+        hvf_cpu_max_initfn(obj);
+    }
+}
+
+static const TypeInfo hvf_cpu_type_info = {
+    .name = X86_CPU_TYPE_NAME("hvf"),
+    .parent = TYPE_X86_CPU,
+
+    .instance_init = hvf_cpu_initfn,
+    .class_init = hvf_cpu_common_class_init,
+};
+
+static void hvf_cpu_register_base_type(void)
+{
+    type_register_static(&hvf_cpu_type_info);
+}
+
+type_init(hvf_cpu_register_base_type);
+
+void hvf_cpu_type_init(void)
+{
+    if (hvf_enabled()) {
+        x86_cpu_register_cpu_models(X86_CPU_TYPE_NAME("hvf"));
+    }
+}
+
+accel_cpu_init(hvf_cpu_type_init);
diff --git a/target/i386/accel/hvf/meson.build b/target/i386/accel/hvf/meson.build
index 409c9a3f14..785dee72fc 100644
--- a/target/i386/accel/hvf/meson.build
+++ b/target/i386/accel/hvf/meson.build
@@ -10,4 +10,5 @@ i386_softmmu_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'x86_mmu.c',
   'x86_task.c',
   'x86hvf.c',
+  'hvf-cpu-type.c',
 ))
diff --git a/target/i386/accel/kvm/kvm-cpu-type.c b/target/i386/accel/kvm/kvm-cpu-type.c
new file mode 100644
index 0000000000..f696f21e2b
--- /dev/null
+++ b/target/i386/accel/kvm/kvm-cpu-type.c
@@ -0,0 +1,161 @@
+/*
+ * x86 KVM CPU type initialization
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "host-cpu.h"
+#include "kvm-cpu-type.h"
+#include "qapi/error.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+
+#include "kvm_i386.h"
+
+/* this information overloads the TYPE_X86_CPU type in x86-cpu.c */
+
+static void kvm_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(dev);
+    CPUX86State *env = &cpu->env;
+
+    /*
+     * also for KVM the realize order is important, since
+     * x86_cpu_realize() checks if nothing else has been set by the user,
+     * or by the specialized x86 cpus (KVM, HVF) in
+     * cpu->ucode_rev and cpu->phys_bits.
+     *
+     * So it's kvm_cpu -> host_cpu -> x86_cpu
+     */
+    if (cpu->max_features) {
+        if (enable_cpu_pm && kvm_has_waitpkg()) {
+            env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
+        }
+        if (cpu->ucode_rev == 0) {
+            cpu->ucode_rev =
+                kvm_arch_get_supported_msr_feature(kvm_state,
+                                                   MSR_IA32_UCODE_REV);
+        }
+    }
+    host_cpu_realizefn(dev, errp);
+}
+
+static void kvm_cpu_common_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    dc->realize = kvm_cpu_realizefn;
+}
+
+/*
+ * KVM-specific features that are automatically added/removed
+ * from all CPU models when KVM is enabled.
+ */
+static PropValue kvm_default_props[] = {
+    { "kvmclock", "on" },
+    { "kvm-nopiodelay", "on" },
+    { "kvm-asyncpf", "on" },
+    { "kvm-steal-time", "on" },
+    { "kvm-pv-eoi", "on" },
+    { "kvmclock-stable-bit", "on" },
+    { "x2apic", "on" },
+    { "acpi", "off" },
+    { "monitor", "off" },
+    { "svm", "off" },
+    { NULL, NULL },
+};
+
+void x86_cpu_change_kvm_default(const char *prop, const char *value)
+{
+    PropValue *pv;
+    for (pv = kvm_default_props; pv->prop; pv++) {
+        if (!strcmp(pv->prop, prop)) {
+            pv->value = value;
+            break;
+        }
+    }
+
+    /*
+     * It is valid to call this function only for properties that
+     * are already present in the kvm_default_props table.
+     */
+    assert(pv->prop);
+}
+
+static bool lmce_supported(void)
+{
+    uint64_t mce_cap = 0;
+
+    if (kvm_ioctl(kvm_state, KVM_X86_GET_MCE_CAP_SUPPORTED, &mce_cap) < 0) {
+        return false;
+    }
+    return !!(mce_cap & MCG_LMCE_P);
+}
+
+static void kvm_cpu_max_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    CPUX86State *env = &cpu->env;
+    KVMState *s = kvm_state;
+
+    host_cpu_max_initfn(cpu);
+
+    if (lmce_supported()) {
+        object_property_set_bool(OBJECT(cpu), "lmce", true, &error_abort);
+    }
+
+    env->cpuid_min_level =
+        kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
+    env->cpuid_min_xlevel =
+        kvm_arch_get_supported_cpuid(s, 0x80000000, 0, R_EAX);
+    env->cpuid_min_xlevel2 =
+        kvm_arch_get_supported_cpuid(s, 0xC0000000, 0, R_EAX);
+}
+
+static void kvm_cpu_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+
+    host_cpu_initfn(obj);
+
+    if (!kvm_irqchip_in_kernel()) {
+        x86_cpu_change_kvm_default("x2apic", "off");
+    }
+
+    /* Special cases not set in the X86CPUDefinition structs: */
+
+    x86_cpu_apply_props(cpu, kvm_default_props);
+
+    if (cpu->max_features) {
+        kvm_cpu_max_initfn(obj);
+    }
+}
+
+static const TypeInfo kvm_cpu_type_info = {
+    .name = X86_CPU_TYPE_NAME("kvm"),
+    .parent = TYPE_X86_CPU,
+
+    .instance_init = kvm_cpu_initfn,
+    .class_init = kvm_cpu_common_class_init,
+};
+
+static void kvm_cpu_register_base_type(void)
+{
+    type_register_static(&kvm_cpu_type_info);
+}
+
+type_init(kvm_cpu_register_base_type);
+
+void kvm_cpu_type_init(void)
+{
+    if (kvm_enabled()) {
+        x86_cpu_register_cpu_models(X86_CPU_TYPE_NAME("kvm"));
+        host_cpu_type_init();
+    }
+}
+
+accel_cpu_init(kvm_cpu_type_init);
diff --git a/target/i386/accel/kvm/kvm-cpu-type.h b/target/i386/accel/kvm/kvm-cpu-type.h
new file mode 100644
index 0000000000..2448f49222
--- /dev/null
+++ b/target/i386/accel/kvm/kvm-cpu-type.h
@@ -0,0 +1,41 @@
+/*
+ * i386 KVM CPU type initialization
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef KVM_CPU_TYPE_H
+#define KVM_CPU_TYPE_H
+
+#ifdef CONFIG_KVM
+void kvm_cpu_type_init(void);
+
+/*
+ * Change the value of a KVM-specific default
+ *
+ * If value is NULL, no default will be set and the original
+ * value from the CPU model table will be kept.
+ *
+ * It is valid to call this function only for properties that
+ * are already present in the kvm_default_props table.
+ */
+void x86_cpu_change_kvm_default(const char *prop, const char *value);
+
+#else /* CONFIG_KVM */
+#define x86_cpu_change_kvm_default(a, b)
+#endif /* CONFIG_KVM */
+
+#endif /* KVM_CPU_TYPE_H */
diff --git a/target/i386/accel/kvm/kvm.c b/target/i386/accel/kvm/kvm.c
index cf46259534..829730d3c2 100644
--- a/target/i386/accel/kvm/kvm.c
+++ b/target/i386/accel/kvm/kvm.c
@@ -22,6 +22,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 
 #include "cpu.h"
+#include "host-cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm_int.h"
@@ -285,7 +286,7 @@ static bool host_tsx_broken(void)
     int family, model, stepping;\
     char vendor[CPUID_VENDOR_SZ + 1];
 
-    host_vendor_fms(vendor, &family, &model, &stepping);
+    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
 
     /* Check if we are running on a Haswell host known to have broken TSX */
     return !strcmp(vendor, CPUID_VENDOR_INTEL) &&
diff --git a/target/i386/accel/kvm/meson.build b/target/i386/accel/kvm/meson.build
index 1d66559187..b6b32166b4 100644
--- a/target/i386/accel/kvm/meson.build
+++ b/target/i386/accel/kvm/meson.build
@@ -1,3 +1,8 @@
 i386_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-i386_softmmu_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
+
+i386_softmmu_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'kvm.c',
+  'kvm-cpu-type.c',
+))
+
 i386_softmmu_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
diff --git a/target/i386/accel/tcg/meson.build b/target/i386/accel/tcg/meson.build
index 02794226c2..211ecef5f9 100644
--- a/target/i386/accel/tcg/meson.build
+++ b/target/i386/accel/tcg/meson.build
@@ -10,4 +10,5 @@ i386_ss.add(when: 'CONFIG_TCG', if_true: files(
   'seg_helper.c',
   'smm_helper.c',
   'svm_helper.c',
-  'translate.c'), if_false: files('tcg-stub.c'))
+  'translate.c',
+  'tcg-cpu-type.c'), if_false: files('tcg-stub.c'))
diff --git a/target/i386/accel/tcg/tcg-cpu-type.c b/target/i386/accel/tcg/tcg-cpu-type.c
new file mode 100644
index 0000000000..f0ee4ef5f7
--- /dev/null
+++ b/target/i386/accel/tcg/tcg-cpu-type.c
@@ -0,0 +1,176 @@
+/*
+ * i386 TCG cpu class initialization
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "cpu.h"
+#include "tcg-cpu-type.h"
+
+#include "helper-tcg.h"
+#include "sysemu/sysemu.h"
+
+#ifndef CONFIG_USER_ONLY
+#include "exec/address-spaces.h"
+#endif
+
+/* Frob eflags into and out of the CPU temporary format.  */
+
+static void x86_cpu_exec_enter(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    CC_SRC = env->eflags & (CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
+    env->df = 1 - (2 * ((env->eflags >> 10) & 1));
+    CC_OP = CC_OP_EFLAGS;
+    env->eflags &= ~(DF_MASK | CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
+}
+
+static void x86_cpu_exec_exit(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    env->eflags = cpu_compute_eflags(env);
+}
+
+static void x86_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    cpu->env.eip = tb->pc - tb->cs_base;
+}
+
+#ifndef CONFIG_USER_ONLY
+
+static void x86_cpu_machine_done(Notifier *n, void *unused)
+{
+    X86CPU *cpu = container_of(n, X86CPU, machine_done);
+    MemoryRegion *smram =
+        (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
+
+    if (smram) {
+        cpu->smram = g_new(MemoryRegion, 1);
+        memory_region_init_alias(cpu->smram, OBJECT(cpu), "smram",
+                                 smram, 0, 4 * GiB);
+        memory_region_set_enabled(cpu->smram, true);
+        memory_region_add_subregion_overlap(cpu->cpu_as_root, 0,
+                                            cpu->smram, 1);
+    }
+}
+
+static void tcg_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(dev);
+    CPUState *cs = CPU(dev);
+
+    /*
+     * also for TCG the realize order is important,
+     * as the memory regions initialized here are needed
+     * in x86_cpu_realizefn()
+     */
+    cpu->cpu_as_mem = g_new(MemoryRegion, 1);
+    cpu->cpu_as_root = g_new(MemoryRegion, 1);
+
+    /* Outer container... */
+    memory_region_init(cpu->cpu_as_root, OBJECT(cpu), "memory", ~0ull);
+    memory_region_set_enabled(cpu->cpu_as_root, true);
+
+    /*
+     * ... with two regions inside: normal system memory with low
+     * priority, and...
+     */
+    memory_region_init_alias(cpu->cpu_as_mem, OBJECT(cpu), "memory",
+                             get_system_memory(), 0, ~0ull);
+    memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cpu_as_mem, 0);
+    memory_region_set_enabled(cpu->cpu_as_mem, true);
+
+    cs->num_ases = 2;
+    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
+    cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
+
+    /* ... SMRAM with higher priority, linked from /machine/smram.  */
+    cpu->machine_done.notify = x86_cpu_machine_done;
+    qemu_add_machine_init_done_notifier(&cpu->machine_done);
+
+    /* call the generic x86_cpu_realizefn() after regions initialized */
+    x86_cpu_realizefn(dev, errp);
+}
+#endif /* !CONFIG_USER_ONLY */
+
+static void tcg_cpu_common_class_init(ObjectClass *oc, void *data)
+{
+    CPUClass *cc = CPU_CLASS(oc);
+#ifndef CONFIG_USER_ONLY
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = tcg_cpu_realizefn;
+#endif /* !CONFIG_USER_ONLY */
+
+    cc->do_interrupt = x86_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
+    cc->synchronize_from_tb = x86_cpu_synchronize_from_tb;
+    cc->cpu_exec_enter = x86_cpu_exec_enter;
+    cc->cpu_exec_exit = x86_cpu_exec_exit;
+    cc->tcg_initialize = tcg_x86_init;
+    cc->tlb_fill = x86_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
+    cc->debug_excp_handler = breakpoint_handler;
+#endif /* !CONFIG_USER_ONLY */
+}
+
+/*
+ * TCG-specific defaults that override all CPU models when using TCG
+ */
+static PropValue tcg_default_props[] = {
+    { "vme", "off" },
+    { NULL, NULL },
+};
+
+static void tcg_cpu_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+
+    /* Special cases not set in the X86CPUDefinition structs: */
+    x86_cpu_apply_props(cpu, tcg_default_props);
+}
+
+static const TypeInfo tcg_cpu_type_info = {
+    .name = X86_CPU_TYPE_NAME("tcg"),
+    .parent = TYPE_X86_CPU,
+
+    .instance_init = tcg_cpu_initfn,
+    .class_init = tcg_cpu_common_class_init,
+};
+
+static void tcg_cpu_register_base_type(void)
+{
+    type_register_static(&tcg_cpu_type_info);
+}
+
+type_init(tcg_cpu_register_base_type);
+
+void tcg_cpu_type_init(void)
+{
+    if (tcg_enabled()) {
+        x86_cpu_register_cpu_models(X86_CPU_TYPE_NAME("tcg"));
+    }
+}
+
+accel_cpu_init(tcg_cpu_type_init);
diff --git a/target/i386/accel/tcg/tcg-cpu-type.h b/target/i386/accel/tcg/tcg-cpu-type.h
new file mode 100644
index 0000000000..d741a8f6be
--- /dev/null
+++ b/target/i386/accel/tcg/tcg-cpu-type.h
@@ -0,0 +1,25 @@
+/*
+ * i386 TCG CPU type initialization
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TCG_CPU_TYPE_H
+#define TCG_CPU_TYPE_H
+
+void tcg_cpu_type_init(void);
+
+#endif /* TCG_CPU_TYPE_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b185789d88..b547c9d39d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -22,9 +22,7 @@
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
 #include "qemu/qemu-print.h"
-
 #include "cpu.h"
-#include "tcg-cpu.h"
 #include "helper-tcg.h"
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
@@ -34,27 +32,17 @@
 #include "sysemu/xen.h"
 #include "accel/kvm/kvm_i386.h"
 #include "sev_i386.h"
-
-#include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "qemu/option.h"
-#include "qemu/config-file.h"
-#include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
-#include "sysemu/arch_init.h"
 #include "qapi/qapi-commands-machine-target.h"
-
 #include "standard-headers/asm-x86/kvm_para.h"
-
-#include "sysemu/sysemu.h"
-#include "sysemu/tcg.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
+
 #ifndef CONFIG_USER_ONLY
 #include "exec/address-spaces.h"
 #include "hw/i386/apic_internal.h"
@@ -594,8 +582,8 @@ static CPUCacheInfo legacy_l3_cache = {
 #define INTEL_PT_CYCLE_BITMAP    0x1fff         /* Support 0,2^(0~11) */
 #define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16K,32K,64K */
 
-static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
-                                     uint32_t vendor2, uint32_t vendor3)
+void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
+                              uint32_t vendor2, uint32_t vendor3)
 {
     int i;
     for (i = 0; i < 4; i++) {
@@ -1563,25 +1551,6 @@ void host_cpuid(uint32_t function, uint32_t count,
         *edx = vec[3];
 }
 
-void host_vendor_fms(char *vendor, int *family, int *model, int *stepping)
-{
-    uint32_t eax, ebx, ecx, edx;
-
-    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
-    x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
-
-    host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
-    if (family) {
-        *family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
-    }
-    if (model) {
-        *model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
-    }
-    if (stepping) {
-        *stepping = eax & 0x0F;
-    }
-}
-
 /* CPU class name definitions: */
 
 /* Return type name for a given CPU model name
@@ -1606,10 +1575,6 @@ static char *x86_cpu_class_get_model_name(X86CPUClass *cc)
                      strlen(class_name) - strlen(X86_CPU_TYPE_SUFFIX));
 }
 
-typedef struct PropValue {
-    const char *prop, *value;
-} PropValue;
-
 typedef struct X86CPUVersionDefinition {
     X86CPUVersion version;
     const char *alias;
@@ -4106,31 +4071,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
     },
 };
 
-/* KVM-specific features that are automatically added/removed
- * from all CPU models when KVM is enabled.
- */
-static PropValue kvm_default_props[] = {
-    { "kvmclock", "on" },
-    { "kvm-nopiodelay", "on" },
-    { "kvm-asyncpf", "on" },
-    { "kvm-steal-time", "on" },
-    { "kvm-pv-eoi", "on" },
-    { "kvmclock-stable-bit", "on" },
-    { "x2apic", "on" },
-    { "acpi", "off" },
-    { "monitor", "off" },
-    { "svm", "off" },
-    { NULL, NULL },
-};
-
-/* TCG-specific defaults that override all CPU models when using TCG
- */
-static PropValue tcg_default_props[] = {
-    { "vme", "off" },
-    { NULL, NULL },
-};
-
-
 /*
  * We resolve CPU model aliases using -v1 when using "-machine
  * none", but this is just for compatibility while libvirt isn't
@@ -4172,61 +4112,6 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     return v;
 }
 
-void x86_cpu_change_kvm_default(const char *prop, const char *value)
-{
-    PropValue *pv;
-    for (pv = kvm_default_props; pv->prop; pv++) {
-        if (!strcmp(pv->prop, prop)) {
-            pv->value = value;
-            break;
-        }
-    }
-
-    /* It is valid to call this function only for properties that
-     * are already present in the kvm_default_props table.
-     */
-    assert(pv->prop);
-}
-
-static bool lmce_supported(void)
-{
-    uint64_t mce_cap = 0;
-
-#ifdef CONFIG_KVM
-    if (kvm_ioctl(kvm_state, KVM_X86_GET_MCE_CAP_SUPPORTED, &mce_cap) < 0) {
-        return false;
-    }
-#endif
-
-    return !!(mce_cap & MCG_LMCE_P);
-}
-
-#define CPUID_MODEL_ID_SZ 48
-
-/**
- * cpu_x86_fill_model_id:
- * Get CPUID model ID string from host CPU.
- *
- * @str should have at least CPUID_MODEL_ID_SZ bytes
- *
- * The function does NOT add a null terminator to the string
- * automatically.
- */
-static int cpu_x86_fill_model_id(char *str)
-{
-    uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
-    int i;
-
-    for (i = 0; i < 3; i++) {
-        host_cpuid(0x80000002 + i, 0, &eax, &ebx, &ecx, &edx);
-        memcpy(str + i * 16 +  0, &eax, 4);
-        memcpy(str + i * 16 +  4, &ebx, 4);
-        memcpy(str + i * 16 +  8, &ecx, 4);
-        memcpy(str + i * 16 + 12, &edx, 4);
-    }
-    return 0;
-}
-
 static Property max_x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
     DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
@@ -4246,98 +4131,38 @@ static void max_x86_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, max_x86_cpu_properties);
 }
 
-static void max_x86_cpu_initfn(Object *obj)
+void max_x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
-    CPUX86State *env = &cpu->env;
-    KVMState *s = kvm_state;
 
     /* We can't fill the features array here because we don't know yet if
      * "migratable" is true or false.
      */
     cpu->max_features = true;
-
-    if (accel_uses_host_cpuid()) {
-        char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
-        char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
-        int family, model, stepping;
-
-        host_vendor_fms(vendor, &family, &model, &stepping);
-        cpu_x86_fill_model_id(model_id);
-
-        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
-        object_property_set_int(OBJECT(cpu), "family", family, &error_abort);
-        object_property_set_int(OBJECT(cpu), "model", model, &error_abort);
-        object_property_set_int(OBJECT(cpu), "stepping", stepping,
-                                &error_abort);
-        object_property_set_str(OBJECT(cpu), "model-id", model_id,
-                                &error_abort);
-
-        if (kvm_enabled()) {
-            env->cpuid_min_level =
-                kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
-            env->cpuid_min_xlevel =
-                kvm_arch_get_supported_cpuid(s, 0x80000000, 0, R_EAX);
-            env->cpuid_min_xlevel2 =
-                kvm_arch_get_supported_cpuid(s, 0xC0000000, 0, R_EAX);
-        } else {
-            env->cpuid_min_level =
-                hvf_get_supported_cpuid(0x0, 0, R_EAX);
-            env->cpuid_min_xlevel =
-                hvf_get_supported_cpuid(0x80000000, 0, R_EAX);
-            env->cpuid_min_xlevel2 =
-                hvf_get_supported_cpuid(0xC0000000, 0, R_EAX);
-        }
-
-        if (lmce_supported()) {
-            object_property_set_bool(OBJECT(cpu), "lmce", true, &error_abort);
-        }
-    } else {
-        object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
-                                &error_abort);
-        object_property_set_int(OBJECT(cpu), "family", 6, &error_abort);
-        object_property_set_int(OBJECT(cpu), "model", 6, &error_abort);
-        object_property_set_int(OBJECT(cpu), "stepping", 3, &error_abort);
-        object_property_set_str(OBJECT(cpu), "model-id",
-                                "QEMU TCG CPU version " QEMU_HW_VERSION,
-                                &error_abort);
-    }
-
     object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
+
+    /*
+     * these defaults are used for TCG and all other accelerators
+     * besides KVM and HVF, which overwrite these values
+     */
+    object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
+                            &error_abort);
+    object_property_set_int(OBJECT(cpu), "family", 6, &error_abort);
+    object_property_set_int(OBJECT(cpu), "model", 6, &error_abort);
+    object_property_set_int(OBJECT(cpu), "stepping", 3, &error_abort);
+    object_property_set_str(OBJECT(cpu), "model-id",
+                            "QEMU TCG CPU version " QEMU_HW_VERSION,
+                            &error_abort);
 }
 
-static const TypeInfo max_x86_cpu_type_info = {
+static TypeInfo max_x86_cpu_type_info = {
     .name = X86_CPU_TYPE_NAME("max"),
-    .parent = TYPE_X86_CPU,
-    .instance_init = max_x86_cpu_initfn,
+    .parent = NULL, /* set by x86_cpu_register_cpu_models */
+
     .class_init = max_x86_cpu_class_init,
+    .instance_init = max_x86_cpu_initfn,
 };
 
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
-{
-    X86CPUClass *xcc = X86_CPU_CLASS(oc);
-
-    xcc->host_cpuid_required = true;
-    xcc->ordering = 8;
-
-#if defined(CONFIG_KVM)
-    xcc->model_description =
-        "KVM processor with all supported host features ";
-#elif defined(CONFIG_HVF)
-    xcc->model_description =
-        "HVF processor with all supported host features ";
-#endif
-}
-
-static const TypeInfo host_x86_cpu_type_info = {
-    .name = X86_CPU_TYPE_NAME("host"),
-    .parent = X86_CPU_TYPE_NAME("max"),
-    .class_init = host_x86_cpu_class_init,
-};
-
-#endif
-
 static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
 {
     assert(f->type == CPUID_FEATURE_WORD || f->type == MSR_FEATURE_WORD);
@@ -5063,7 +4888,7 @@ static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
     return r;
 }
 
-static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
+void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
 {
     PropValue *pv;
     for (pv = props; pv->prop; pv++) {
@@ -5110,8 +4935,6 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
 {
     X86CPUDefinition *def = model->cpudef;
     CPUX86State *env = &cpu->env;
-    const char *vendor;
-    char host_vendor[CPUID_VENDOR_SZ + 1];
     FeatureWord w;
 
     /*NOTE: any property set by this function should be returned by
@@ -5138,18 +4961,6 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
     /* legacy-cache defaults to 'off' if CPU model provides cache info */
     cpu->legacy_cache = !def->cache_info;
 
-    /* Special cases not set in the X86CPUDefinition structs: */
-    /* TODO: in-kernel irqchip for hvf */
-    if (kvm_enabled()) {
-        if (!kvm_irqchip_in_kernel()) {
-            x86_cpu_change_kvm_default("x2apic", "off");
-        }
-
-        x86_cpu_apply_props(cpu, kvm_default_props);
-    } else if (tcg_enabled()) {
-        x86_cpu_apply_props(cpu, tcg_default_props);
-    }
-
     env->features[FEAT_1_ECX] |= CPUID_EXT_HYPERVISOR;
 
     /* sysenter isn't supported in compatibility mode on AMD,
@@ -5159,15 +4970,12 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
      * KVM's sysenter/syscall emulation in compatibility mode and
      * when doing cross vendor migration
      */
-    vendor = def->vendor;
-    if (accel_uses_host_cpuid()) {
-        uint32_t  ebx = 0, ecx = 0, edx = 0;
-        host_cpuid(0, 0, NULL, &ebx, &ecx, &edx);
-        x86_cpu_vendor_words2str(host_vendor, ebx, edx, ecx);
-        vendor = host_vendor;
-    }
 
-    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
+    /*
+     * vendor property is set here but then overloaded with the
+     * host cpu vendor for KVM and HVF.
+     */
+    object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
 
     x86_cpu_apply_version_props(cpu, model);
 
@@ -5400,12 +5208,13 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
     cc->deprecation_note = model->cpudef->deprecation_note;
 }
 
-static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
+static void x86_register_cpu_model_type(const char *name, X86CPUModel *model,
+                                        const char *parent_type)
 {
     g_autofree char *typename = x86_cpu_type_name(name);
     TypeInfo ti = {
         .name = typename,
-        .parent = TYPE_X86_CPU,
+        .parent = parent_type,
         .class_init = x86_cpu_cpudef_class_init,
         .class_data = model,
     };
@@ -5413,7 +5222,8 @@ static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
     type_register(&ti);
 }
 
-static void x86_register_cpudef_types(X86CPUDefinition *def)
+static void x86_register_cpudef(X86CPUDefinition *def,
+                                const char *parent_type)
 {
     X86CPUModel *m;
     const X86CPUVersionDefinition *vdef;
@@ -5430,7 +5240,7 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
     m->cpudef = def;
     m->version = CPU_VERSION_AUTO;
     m->is_alias = true;
-    x86_register_cpu_model_type(def->name, m);
+    x86_register_cpu_model_type(def->name, m, parent_type);
 
     /* Versioned models: */
 
@@ -5441,14 +5251,14 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
         m->cpudef = def;
         m->version = vdef->version;
         m->note = vdef->note;
-        x86_register_cpu_model_type(name, m);
+        x86_register_cpu_model_type(name, m, parent_type);
 
         if (vdef->alias) {
             X86CPUModel *am = g_new0(X86CPUModel, 1);
             am->cpudef = def;
             am->version = vdef->version;
             am->is_alias = true;
-            x86_register_cpu_model_type(vdef->alias, am);
+            x86_register_cpu_model_type(vdef->alias, am, parent_type);
         }
     }
 
@@ -6192,53 +6002,12 @@ static void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
         apic_mmio_map_once = true;
      }
 }
-
-static void x86_cpu_machine_done(Notifier *n, void *unused)
-{
-    X86CPU *cpu = container_of(n, X86CPU, machine_done);
-    MemoryRegion *smram =
-        (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
-
-    if (smram) {
-        cpu->smram = g_new(MemoryRegion, 1);
-        memory_region_init_alias(cpu->smram, OBJECT(cpu), "smram",
-                                 smram, 0, 4 * GiB);
-        memory_region_set_enabled(cpu->smram, true);
-        memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->smram, 1);
-    }
-}
 #else
 static void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
 {
 }
 #endif
 
-/* Note: Only safe for use on x86(-64) hosts */
-static uint32_t x86_host_phys_bits(void)
-{
-    uint32_t eax;
-    uint32_t host_phys_bits;
-
-    host_cpuid(0x80000000, 0, &eax, NULL, NULL, NULL);
-    if (eax >= 0x80000008) {
-        host_cpuid(0x80000008, 0, &eax, NULL, NULL, NULL);
-        /* Note: According to AMD doc 25481 rev 2.34 they have a field
-         * at 23:16 that can specify a maximum physical address bits for
-         * the guest that can override this value; but I've not seen
-         * anything with that set.
-         */
-        host_phys_bits = eax & 0xff;
-    } else {
-        /* It's an odd 64 bit machine that doesn't have the leaf for
-         * physical address bits; fall back to 36 that's most older
-         * Intel.
-         */
-        host_phys_bits = 36;
-    }
-
-    return host_phys_bits;
-}
-
 static void x86_cpu_adjust_level(X86CPU *cpu, uint32_t *min, uint32_t value)
 {
     if (*min < value) {
@@ -6512,7 +6281,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     }
 }
 
-static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
+void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     X86CPU *cpu = X86_CPU(dev);
@@ -6521,27 +6290,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     static bool ht_warned;
 
-    if (xcc->host_cpuid_required) {
-        if (!accel_uses_host_cpuid()) {
-            g_autofree char *name = x86_cpu_class_get_model_name(xcc);
-            error_setg(&local_err, "CPU model '%s' requires KVM", name);
-            goto out;
-        }
-    }
+    /*
+     * For accelerators that specialize the x86 cpu,
+     * this common code must be called after the accelerator-specific realizefn.
+     */
 
-    if (cpu->max_features && accel_uses_host_cpuid()) {
-        if (enable_cpu_pm) {
-            host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
-                       &cpu->mwait.ecx, &cpu->mwait.edx);
-            env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
-            if (kvm_enabled() && kvm_has_waitpkg()) {
-                env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
-            }
-        }
-        if (kvm_enabled() && cpu->ucode_rev == 0) {
-            cpu->ucode_rev = kvm_arch_get_supported_msr_feature(kvm_state,
-                                                                MSR_IA32_UCODE_REV);
-        }
+    if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
+        g_autofree char *name = x86_cpu_class_get_model_name(xcc);
+        error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
+        goto out;
     }
 
     if (cpu->ucode_rev == 0) {
@@ -6593,39 +6350,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * consumer AMD devices but nothing else.
      */
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
-        if (accel_uses_host_cpuid()) {
-            uint32_t host_phys_bits = x86_host_phys_bits();
-            static bool warned;
-
-            /* Print a warning if the user set it to a value that's not the
-             * host value.
-             */
-            if (cpu->phys_bits != host_phys_bits && cpu->phys_bits != 0 &&
-                !warned) {
-                warn_report("Host physical bits (%u)"
-                            " does not match phys-bits property (%u)",
-                            host_phys_bits, cpu->phys_bits);
-                warned = true;
-            }
-
-            if (cpu->host_phys_bits) {
-                /* The user asked for us to use the host physical bits */
-                cpu->phys_bits = host_phys_bits;
-                if (cpu->host_phys_bits_limit &&
-                    cpu->phys_bits > cpu->host_phys_bits_limit) {
-                    cpu->phys_bits = cpu->host_phys_bits_limit;
-                }
-            }
-
-            if (cpu->phys_bits &&
-                (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
-                cpu->phys_bits < 32)) {
-                error_setg(errp, "phys-bits should be between 32 and %u "
-                                 " (but is %u)",
-                                 TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
-                return;
-            }
-        } else {
+        if (!accel_uses_host_cpuid()) {
             if (cpu->phys_bits && cpu->phys_bits != TCG_PHYS_ADDR_BITS) {
                 error_setg(errp, "TCG only supports phys-bits=%u",
                                   TCG_PHYS_ADDR_BITS);
@@ -6633,8 +6358,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             }
         }
         /* 0 means it was not explicitly set by the user (or by machine
-         * compat_props or by the host code above). In this case, the default
-         * is the value used by TCG (40).
+         * compat_props or by the host code in host-cpu.c).
+         * In this case, the default is the value used by TCG (40).
          */
         if (cpu->phys_bits == 0) {
             cpu->phys_bits = TCG_PHYS_ADDR_BITS;
@@ -6704,32 +6429,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     mce_init(cpu);
 
-#ifndef CONFIG_USER_ONLY
-    if (tcg_enabled()) {
-        cpu->cpu_as_mem = g_new(MemoryRegion, 1);
-        cpu->cpu_as_root = g_new(MemoryRegion, 1);
-
-        /* Outer container... */
-        memory_region_init(cpu->cpu_as_root, OBJECT(cpu), "memory", ~0ull);
-        memory_region_set_enabled(cpu->cpu_as_root, true);
-
-        /* ... with two regions inside: normal system memory with low
-         * priority, and...
-         */
-        memory_region_init_alias(cpu->cpu_as_mem, OBJECT(cpu), "memory",
-                                 get_system_memory(), 0, ~0ull);
-        memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cpu_as_mem, 0);
-        memory_region_set_enabled(cpu->cpu_as_mem, true);
-
-        cs->num_ases = 2;
-        cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
-        cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
-
-        /* ... SMRAM with higher priority, linked from /machine/smram.  */
-        cpu->machine_done.notify = x86_cpu_machine_done;
-        qemu_add_machine_init_done_notifier(&cpu->machine_done);
-    }
-#endif
+    /* XXX this is the place for tcg region initialization XXX */
 
     qemu_init_vcpu(cs);
 
@@ -6932,7 +6632,7 @@ static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static void x86_cpu_initfn(Object *obj)
+void x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
@@ -7230,7 +6930,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
+void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
@@ -7249,10 +6949,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->has_work = x86_cpu_has_work;
 
-#ifdef CONFIG_TCG
-    tcg_cpu_common_class_init(cc);
-#endif /* CONFIG_TCG */
-
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
     cc->gdb_read_register = x86_cpu_gdb_read_register;
@@ -7341,25 +7037,49 @@ static void x86_cpu_base_class_init(ObjectClass *oc, void *data)
     xcc->ordering = 8;
 }
 
-static const TypeInfo x86_base_cpu_type_info = {
-        .name = X86_CPU_TYPE_NAME("base"),
-        .parent = TYPE_X86_CPU,
-        .class_init = x86_cpu_base_class_init,
+static TypeInfo x86_base_cpu_type_info = {
+    .name = X86_CPU_TYPE_NAME("base"),
+    .parent = NULL, /* set by x86_cpu_register_cpu_models */
+
+    .class_init = x86_cpu_base_class_init,
 };
 
-static void x86_cpu_register_types(void)
+/*
+ * x86 cpu types are only registered once accelerator is determined,
+ * passing the parent cpu type as an argument here.
+ */
+void x86_cpu_register_cpu_models(const char *parent_type)
 {
     int i;
 
-    type_register_static(&x86_cpu_type_info);
     for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
-        x86_register_cpudef_types(&builtin_x86_defs[i]);
+        x86_register_cpudef(&builtin_x86_defs[i], parent_type);
+    }
+    max_x86_cpu_type_info.parent = parent_type;
+    type_register(&max_x86_cpu_type_info);
+
+    x86_base_cpu_type_info.parent = parent_type;
+    type_register(&x86_base_cpu_type_info);
+}
+
+static void x86_cpu_register_base_type(void)
+{
+    type_register_static(&x86_cpu_type_info);
+}
+
+type_init(x86_cpu_register_base_type);
+
+/*
+ * generic initializer if no other specialization.
+ */
+static void x86_cpu_type_init(void)
+{
+    /*
+     * I would like something better than this check.
+     */
+    if (!tcg_enabled() && !kvm_enabled() && !hvf_enabled()) {
+        x86_cpu_register_cpu_models(TYPE_X86_CPU);
     }
-    type_register_static(&max_x86_cpu_type_info);
-    type_register_static(&x86_base_cpu_type_info);
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-    type_register_static(&host_x86_cpu_type_info);
-#endif
 }
 
-type_init(x86_cpu_register_types)
+accel_cpu_init(x86_cpu_type_init);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f1bce16b53..9232672eb2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1905,13 +1905,26 @@ int cpu_x86_signal_handler(int host_signum, void *pinfo,
                            void *puc);
 
 /* cpu.c */
+void x86_cpu_register_cpu_models(const char *parent_type);
+
+void x86_cpu_initfn(Object *obj);
+void max_x86_cpu_initfn(Object *obj);
+void x86_cpu_realizefn(DeviceState *dev, Error **errp);
+void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
+                              uint32_t vendor2, uint32_t vendor3);
+void x86_cpu_common_class_init(ObjectClass *oc, void *data);
+typedef struct PropValue {
+    const char *prop, *value;
+} PropValue;
+void x86_cpu_apply_props(X86CPU *cpu, PropValue *props);
+
+/* cpu.c other functions (cpuid) */
 void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx);
 void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
-void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
@@ -2111,17 +2124,6 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
 void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
-
-/* Change the value of a KVM-specific default
- *
- * If value is NULL, no default will be set and the original
- * value from the CPU model table will be kept.
- *
- * It is valid to call this function only for properties that
- * are already present in the kvm_default_props table.
- */
-void x86_cpu_change_kvm_default(const char *prop, const char *value);
-
 /* Special values for X86CPUVersion: */
 
 /* Resolve to latest CPU version */
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
new file mode 100644
index 0000000000..65a0119f4b
--- /dev/null
+++ b/target/i386/host-cpu.c
@@ -0,0 +1,201 @@
+/*
+ * x86 host CPU functions, and "host" cpu type initialization
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "host-cpu.h"
+#include "qapi/error.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+
+/* Note: Only safe for use on x86(-64) hosts */
+static uint32_t host_cpu_phys_bits(void)
+{
+    uint32_t eax;
+    uint32_t host_phys_bits;
+
+    host_cpuid(0x80000000, 0, &eax, NULL, NULL, NULL);
+    if (eax >= 0x80000008) {
+        host_cpuid(0x80000008, 0, &eax, NULL, NULL, NULL);
+        /*
+         * Note: According to AMD doc 25481 rev 2.34 they have a field
+         * at 23:16 that can specify a maximum physical address bits for
+         * the guest that can override this value; but I've not seen
+         * anything with that set.
+         */
+        host_phys_bits = eax & 0xff;
+    } else {
+        /*
+         * It's an odd 64 bit machine that doesn't have the leaf for
+         * physical address bits; fall back to 36 that's most older
+         * Intel.
+         */
+        host_phys_bits = 36;
+    }
+
+    return host_phys_bits;
+}
+
+static void host_cpu_enable_cpu_pm(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
+               &cpu->mwait.ecx, &cpu->mwait.edx);
+    env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
+}
+
+static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu, Error **errp)
+{
+    uint32_t host_phys_bits = host_cpu_phys_bits();
+    uint32_t phys_bits = cpu->phys_bits;
+    static bool warned;
+
+    /*
+     * Print a warning if the user set it to a value that's not the
+     * host value.
+     */
+    if (phys_bits != host_phys_bits && phys_bits != 0 &&
+        !warned) {
+        warn_report("Host physical bits (%u)"
+                    " does not match phys-bits property (%u)",
+                    host_phys_bits, phys_bits);
+        warned = true;
+    }
+
+    if (cpu->host_phys_bits) {
+        /* The user asked for us to use the host physical bits */
+        phys_bits = host_phys_bits;
+        if (cpu->host_phys_bits_limit &&
+            phys_bits > cpu->host_phys_bits_limit) {
+            phys_bits = cpu->host_phys_bits_limit;
+        }
+    }
+
+    if (phys_bits &&
+        (phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
+         phys_bits < 32)) {
+        error_setg(errp, "phys-bits should be between 32 and %u "
+                   " (but is %u)",
+                   TARGET_PHYS_ADDR_SPACE_BITS, phys_bits);
+    }
+
+    return phys_bits;
+}
+
+void host_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(dev);
+    CPUX86State *env = &cpu->env;
+
+    if (cpu->max_features && enable_cpu_pm) {
+        host_cpu_enable_cpu_pm(cpu);
+    }
+    if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+        cpu->phys_bits = host_cpu_adjust_phys_bits(cpu, errp);
+    }
+    x86_cpu_realizefn(dev, errp);
+}
+
+#define CPUID_MODEL_ID_SZ 48
+/**
+ * cpu_x86_fill_model_id:
+ * Get CPUID model ID string from host CPU.
+ *
+ * @str should have at least CPUID_MODEL_ID_SZ bytes
+ *
+ * The function does NOT add a null terminator to the string
+ * automatically.
+ */
+static int host_cpu_fill_model_id(char *str)
+{
+    uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
+    int i;
+
+    for (i = 0; i < 3; i++) {
+        host_cpuid(0x80000002 + i, 0, &eax, &ebx, &ecx, &edx);
+        memcpy(str + i * 16 +  0, &eax, 4);
+        memcpy(str + i * 16 +  4, &ebx, 4);
+        memcpy(str + i * 16 +  8, &ecx, 4);
+        memcpy(str + i * 16 + 12, &edx, 4);
+    }
+    return 0;
+}
+
+void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
+{
+    uint32_t eax, ebx, ecx, edx;
+
+    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
+    x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
+
+    host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
+    if (family) {
+        *family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
+    }
+    if (model) {
+        *model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
+    }
+    if (stepping) {
+        *stepping = eax & 0x0F;
+    }
+}
+
+void host_cpu_initfn(Object *obj)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    uint32_t ebx = 0, ecx = 0, edx = 0;
+    char vendor[CPUID_VENDOR_SZ + 1];
+
+    host_cpuid(0, 0, NULL, &ebx, &ecx, &edx);
+    x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
+
+    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
+}
+
+void host_cpu_max_initfn(X86CPU *cpu)
+{
+    char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
+    char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
+    int family, model, stepping;
+
+    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
+    host_cpu_fill_model_id(model_id);
+
+    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
+    object_property_set_int(OBJECT(cpu), "family", family, &error_abort);
+    object_property_set_int(OBJECT(cpu), "model", model, &error_abort);
+    object_property_set_int(OBJECT(cpu), "stepping", stepping,
+                            &error_abort);
+    object_property_set_str(OBJECT(cpu), "model-id", model_id,
+                            &error_abort);
+}
+
+static void host_cpu_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+
+    xcc->host_cpuid_required = true;
+    xcc->ordering = 8;
+    xcc->model_description =
+        g_strdup_printf("%s processor with all supported host features ",
+                        ACCEL_GET_CLASS(current_accel())->name);
+}
+
+static const TypeInfo host_cpu_type_info = {
+    .name = X86_CPU_TYPE_NAME("host"),
+    .parent = X86_CPU_TYPE_NAME("max"),
+
+    .class_init = host_cpu_class_init,
+};
+
+void host_cpu_type_init(void)
+{
+    type_register(&host_cpu_type_info);
+}
diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
new file mode 100644
index 0000000000..e9d4726833
--- /dev/null
+++ b/target/i386/host-cpu.h
@@ -0,0 +1,21 @@
+/*
+ * x86 host CPU type initialization
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HOST_CPU_TYPE_H
+#define HOST_CPU_TYPE_H
+
+void host_cpu_type_init(void);
+
+void host_cpu_initfn(Object *obj);
+void host_cpu_realizefn(DeviceState *dev, Error **errp);
+void host_cpu_max_initfn(X86CPU *cpu);
+
+void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping);
+
+#endif /* HOST_CPU_TYPE_H */
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 50c8fba6cb..c84b0d6965 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -6,8 +6,12 @@ i386_ss.add(files(
   'xsave_helper.c',
   'cpu-dump.c',
 ))
-i386_ss.add(when: 'CONFIG_TCG', if_true: files('tcg-cpu.c'))
-i386_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-stub.c'))
+
+i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'sev.c'), if_false: files('sev-stub.c'))
+
+# x86 cpu type
+i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_HVF', if_true: files('host-cpu.c'))
 
 i386_softmmu_ss = ss.source_set()
 i386_softmmu_ss.add(files(
diff --git a/target/i386/tcg-cpu.c b/target/i386/tcg-cpu.c
deleted file mode 100644
index 628dd29fe7..0000000000
--- a/target/i386/tcg-cpu.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * i386 TCG cpu class initialization
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "tcg-cpu.h"
-#include "exec/exec-all.h"
-#include "sysemu/runstate.h"
-#include "helper-tcg.h"
-
-#if !defined(CONFIG_USER_ONLY)
-#include "hw/i386/apic.h"
-#endif
-
-/* Frob eflags into and out of the CPU temporary format.  */
-
-static void x86_cpu_exec_enter(CPUState *cs)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    CC_SRC = env->eflags & (CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
-    env->df = 1 - (2 * ((env->eflags >> 10) & 1));
-    CC_OP = CC_OP_EFLAGS;
-    env->eflags &= ~(DF_MASK | CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
-}
-
-static void x86_cpu_exec_exit(CPUState *cs)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    env->eflags = cpu_compute_eflags(env);
-}
-
-static void x86_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
-{
-    X86CPU *cpu = X86_CPU(cs);
-
-    cpu->env.eip = tb->pc - tb->cs_base;
-}
-
-void tcg_cpu_common_class_init(CPUClass *cc)
-{
-    cc->do_interrupt = x86_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
-    cc->synchronize_from_tb = x86_cpu_synchronize_from_tb;
-    cc->cpu_exec_enter = x86_cpu_exec_enter;
-    cc->cpu_exec_exit = x86_cpu_exec_exit;
-    cc->tcg_initialize = tcg_x86_init;
-    cc->tlb_fill = x86_cpu_tlb_fill;
-#ifndef CONFIG_USER_ONLY
-    cc->debug_excp_handler = breakpoint_handler;
-#endif
-}
diff --git a/target/i386/tcg-cpu.h b/target/i386/tcg-cpu.h
deleted file mode 100644
index 81f02e562e..0000000000
--- a/target/i386/tcg-cpu.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * i386 TCG CPU class initialization
- *
- * Copyright 2020 SUSE LLC
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef TCG_CPU_H
-#define TCG_CPU_H
-
-void tcg_cpu_common_class_init(CPUClass *cc);
-
-#endif /* TCG_CPU_H */
-- 
2.26.2


