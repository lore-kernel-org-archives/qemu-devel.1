Received: from eggs.gnu.org ([2001:4830:134:3::10]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdAl5-0001kC-Uc
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdAl2-0008FK-Vw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:11 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:26999 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cdAl2-0008Ed-Ge
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:08 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 13 Feb 2017 10:09:00 +0300
Message-Id: <1486969742-16539-2-git-send-email-den@openvz.org>
In-Reply-To: <1486969742-16539-1-git-send-email-den@openvz.org>
References: <1486969742-16539-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH v3 1/3] i386/cpu: add crash-information QOM
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Windows reports BSOD parameters through Hyper-V crash MSRs. This
information is very useful for initial crash analysis and thus
it would be nice to have a way to fetch it.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/sysemu/kvm.h |  2 ++
 kvm-all.c            |  1 +
 qapi-schema.json     | 24 +++++++++++++++++++++++
 stubs/Makefile.objs  |  1 +
 stubs/kvm-crash.c    |  8 ++++++++
 target/i386/cpu.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h    |  3 +++
 target/i386/kvm.c    | 41 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 134 insertions(+)
 create mode 100644 stubs/kvm-crash.c

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3045ee7..02a363d 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -527,4 +527,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
  */
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 int kvm_get_max_memslots(void);
+
+void kvm_arch_save_crash_info(CPUState *cpu);
 #endif
diff --git a/kvm-all.c b/kvm-all.c
index a27c880..abfe92d 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2000,6 +2000,7 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = EXCP_INTERRUPT;
                 break;
             case KVM_SYSTEM_EVENT_CRASH:
+                kvm_arch_save_crash_info(cpu);
                 qemu_mutex_lock_iothread();
                 qemu_system_guest_panicked();
                 qemu_mutex_unlock_iothread();
diff --git a/qapi-schema.json b/qapi-schema.json
index cbdffdd..9cb6ac5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5846,6 +5846,30 @@
   'data': [ 'pause', 'poweroff' ] }
 
 ##
+# @GuestPanicInformation:
+#
+# Information about a guest panic
+#
+# Since: 2.9
+##
+{'union': 'GuestPanicInformation',
+ 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
+
+##
+# @GuestPanicInformationHyperV:
+#
+# Hyper-V specific guest panic information (HV crash MSRs)
+#
+# Since: 2.9
+##
+{'struct': 'GuestPanicInformationHyperV',
+ 'data': { 'arg1': 'uint64',
+           'arg2': 'uint64',
+           'arg3': 'uint64',
+           'arg4': 'uint64',
+           'arg5': 'uint64' } }
+
+##
 # @rtc-reset-reinjection:
 #
 # This command will reset the RTC interrupt reinjection backlog.
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index a187295..3b1632a 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -35,3 +35,4 @@ stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
+stub-obj-y += kvm-crash.o
diff --git a/stubs/kvm-crash.c b/stubs/kvm-crash.c
new file mode 100644
index 0000000..b2f502d
--- /dev/null
+++ b/stubs/kvm-crash.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/kvm.h"
+
+void kvm_arch_save_crash_info(CPUState *cs)
+{
+    return;
+}
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eb49980..275e236 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3495,6 +3495,57 @@ static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
     x86_cpu_register_bit_prop(cpu, name, &cpu->env.features[w], bitnr);
 }
 
+static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    GuestPanicInformation *panic_info = NULL;
+
+    if (env->features[FEAT_HYPERV_EDX] & HV_X64_GUEST_CRASH_MSR_AVAILABLE) {
+        GuestPanicInformationHyperV *panic_info_hv =
+            g_malloc0(sizeof(GuestPanicInformationHyperV));
+        panic_info = g_malloc0(sizeof(GuestPanicInformation));
+
+        panic_info->type = GUEST_PANIC_INFORMATION_KIND_HYPER_V;
+        panic_info->u.hyper_v.data = panic_info_hv;
+
+        assert(HV_X64_MSR_CRASH_PARAMS >= 5);
+        panic_info_hv->arg1 = cpu->hv_msr_crash_params[0];
+        panic_info_hv->arg2 = cpu->hv_msr_crash_params[1];
+        panic_info_hv->arg3 = cpu->hv_msr_crash_params[2];
+        panic_info_hv->arg4 = cpu->hv_msr_crash_params[3];
+        panic_info_hv->arg5 = cpu->hv_msr_crash_params[4];
+    }
+
+    return panic_info;
+}
+static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    CPUState *cs = CPU(obj);
+    GuestPanicInformation *panic_info;
+
+    if (!cs->crash_occurred) {
+        error_setg(errp, "No crash occured");
+        return;
+    }
+
+    panic_info = x86_cpu_get_crash_info(cs);
+    if (panic_info == NULL) {
+        error_setg(errp, "No crash information");
+        return;
+    }
+
+    visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
+                                     errp);
+
+    if (panic_info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
+        g_free(panic_info->u.hyper_v.data);
+    }
+    g_free(panic_info);
+}
+
 static void x86_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -3530,6 +3581,9 @@ static void x86_cpu_initfn(Object *obj)
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features, NULL);
 
+    object_property_add(obj, "crash-information", "GuestPanicInformation",
+                        x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
+
     cpu->hyperv_spinlock_attempts = HYPERV_SPINLOCK_NEVER_RETRY;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4d788d5..38c8da9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1258,6 +1258,9 @@ struct X86CPU {
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
+    /* Hyper-V crash MSRs */
+    uint64_t hv_msr_crash_params[HV_X64_MSR_CRASH_PARAMS];
+
     /* in order to simplify APIC support, we leave this pointer to the
        user */
     struct DeviceState *apic_state;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 27fd050..2427c4a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2054,6 +2054,36 @@ static int kvm_get_sregs(X86CPU *cpu)
     return 0;
 }
 
+static int kvm_read_msr_hv_crash(X86CPU *cpu, uint64_t *buf)
+{
+    int i, ret;
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[HV_X64_MSR_CRASH_PARAMS];
+    } msr_data;
+
+    if (!has_msr_hv_crash) {
+        return -ENOSYS;
+    }
+
+    for (i = 0; i < HV_X64_MSR_CRASH_PARAMS; i++) {
+        msr_data.entries[i].index = HV_X64_MSR_CRASH_P0 + i;
+    }
+    msr_data.info.nmsrs = HV_X64_MSR_CRASH_PARAMS;
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    for (i = 0; i < ret; i++) {
+        const struct kvm_msr_entry *msr = msr_data.entries + i;
+        buf[msr->index - HV_X64_MSR_CRASH_P0] = msr->data;
+    }
+
+    return 0;
+}
+
 static int kvm_get_msrs(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
@@ -2801,6 +2831,17 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+void kvm_arch_save_crash_info(CPUState *cs)
+{
+    if (has_msr_hv_crash) {
+        X86CPU *cpu = X86_CPU(cs);
+        int ret = kvm_read_msr_hv_crash(cpu, cpu->hv_msr_crash_params);
+        if (ret < 0) {
+            fprintf(stderr, "Failed to get HV crash parameters\n");
+        }
+    }
+}
+
 void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.7.4
