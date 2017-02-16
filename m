Received: from eggs.gnu.org ([2001:4830:134:3::10]:52086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN70-00049u-Ri
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6x-0008Nc-M4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:46 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6x-0008NG-Ah
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:43 -0500
Received: by mail-wr0-x242.google.com with SMTP id q39so2265576wrb.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:44 +0100
Message-Id: <1487255507-106654-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/23] i386/cpu: add crash-information QOM
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Windows reports BSOD parameters through Hyper-V crash MSRs. This
information is very useful for initial crash analysis and thus
it would be nice to have a way to fetch it.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-Id: <1487053524-18674-2-git-send-email-den@openvz.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 kvm-all.c         |  1 +
 qapi-schema.json  | 24 ++++++++++++++++++++++++
 target/i386/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/kvm-all.c b/kvm-all.c
index a27c880..64f46c8 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2000,6 +2000,7 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = EXCP_INTERRUPT;
                 break;
             case KVM_SYSTEM_EVENT_CRASH:
+                kvm_cpu_synchronize_state(cpu);
                 qemu_mutex_lock_iothread();
                 qemu_system_guest_panicked();
                 qemu_mutex_unlock_iothread();
diff --git a/qapi-schema.json b/qapi-schema.json
index 5edb08d..baa0d26 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5871,6 +5871,30 @@
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eb49980..71aa91f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3495,6 +3495,53 @@ static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
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
+        panic_info_hv->arg1 = env->msr_hv_crash_params[0];
+        panic_info_hv->arg2 = env->msr_hv_crash_params[1];
+        panic_info_hv->arg3 = env->msr_hv_crash_params[2];
+        panic_info_hv->arg4 = env->msr_hv_crash_params[3];
+        panic_info_hv->arg5 = env->msr_hv_crash_params[4];
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
+    qapi_free_GuestPanicInformation(panic_info);
+}
+
 static void x86_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -3530,6 +3577,9 @@ static void x86_cpu_initfn(Object *obj)
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features, NULL);
 
+    object_property_add(obj, "crash-information", "GuestPanicInformation",
+                        x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
+
     cpu->hyperv_spinlock_attempts = HYPERV_SPINLOCK_NEVER_RETRY;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-- 
1.8.3.1
