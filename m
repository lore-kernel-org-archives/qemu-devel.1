Received: from eggs.gnu.org ([209.51.188.92]:56551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsA-0002zo-ID
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzs9-0007CY-AR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzs9-00079J-3N
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so6474178wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:08 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:50 +0100
Message-Id: <20190125114155.32062-4-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 3/8] i386/kvm: move Hyper-V CPUID filling
 to hyperv_handle_properties()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Let's consolidate Hyper-V features handling in hyperv_handle_properties().
The change is necessary to support pass-through 'hv-all' mode as we'll be
just copying CPUIDs from KVM instead of filling them in.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 163 +++++++++++++++++++++++++---------------------
 1 file changed, 90 insertions(+), 73 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dc4574daff..ed55040d9e 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1038,13 +1038,25 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     return 1;
 }
 
-static int hyperv_handle_properties(CPUState *cs)
+/*
+ * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
+ * case of success, errno < 0 in case of failure and 0 when no Hyper-V
+ * extentions are enabled.
+ */
+static int hyperv_handle_properties(CPUState *cs,
+                                    struct kvm_cpuid_entry2 *cpuid_ent)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     struct kvm_cpuid2 *cpuid;
+    struct kvm_cpuid_entry2 *c;
+    uint32_t signature[3];
+    uint32_t cpuid_i = 0;
     int r = 0;
 
+    if (!hyperv_enabled(cpu))
+        return 0;
+
     if (cpu->hyperv_evmcs) {
         uint16_t evmcs_version;
 
@@ -1095,9 +1107,80 @@ static int hyperv_handle_properties(CPUState *cs)
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
+    if (r) {
+        r = -ENOSYS;
+        goto free;
+    }
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
+    if (!cpu->hyperv_vendor_id) {
+        memcpy(signature, "Microsoft Hv", 12);
+    } else {
+        size_t len = strlen(cpu->hyperv_vendor_id);
+
+        if (len > 12) {
+            error_report("hv-vendor-id truncated to 12 characters");
+            len = 12;
+        }
+        memset(signature, 0, 12);
+        memcpy(signature, cpu->hyperv_vendor_id, len);
+    }
+    c->eax = cpu->hyperv_evmcs ?
+        HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
+    c->ebx = signature[0];
+    c->ecx = signature[1];
+    c->edx = signature[2];
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_INTERFACE;
+    memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
+    c->eax = signature[0];
+    c->ebx = 0;
+    c->ecx = 0;
+    c->edx = 0;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_VERSION;
+    c->eax = 0x00001bbc;
+    c->ebx = 0x00060001;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_FEATURES;
+    c->eax = env->features[FEAT_HYPERV_EAX];
+    c->ebx = env->features[FEAT_HYPERV_EBX];
+    c->edx = env->features[FEAT_HYPERV_EDX];
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_ENLIGHTMENT_INFO;
+    c->eax = env->features[FEAT_HV_RECOMM_EAX];
+    c->ebx = cpu->hyperv_spinlock_attempts;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_IMPLEMENT_LIMITS;
+    c->eax = cpu->hv_max_vps;
+    c->ebx = 0x40;
+
+    if (cpu->hyperv_evmcs) {
+        __u32 function;
+
+        /* Create zeroed 0x40000006..0x40000009 leaves */
+        for (function = HV_CPUID_IMPLEMENT_LIMITS + 1;
+             function < HV_CPUID_NESTED_FEATURES; function++) {
+            c = &cpuid_ent[cpuid_i++];
+            c->function = function;
+        }
+
+        c = &cpuid_ent[cpuid_i++];
+        c->function = HV_CPUID_NESTED_FEATURES;
+        c->eax = env->features[FEAT_HV_NESTED_EAX];
+    }
+    r = cpuid_i;
+
+free:
     g_free(cpuid);
 
-    return r ? -ENOSYS : 0;
+    return r;
 }
 
 static int hyperv_init_vcpu(X86CPU *cpu)
@@ -1206,79 +1289,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     /* Paravirtualization CPUIDs */
-    if (hyperv_enabled(cpu)) {
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
-        if (!cpu->hyperv_vendor_id) {
-            memcpy(signature, "Microsoft Hv", 12);
-        } else {
-            size_t len = strlen(cpu->hyperv_vendor_id);
-
-            if (len > 12) {
-                error_report("hv-vendor-id truncated to 12 characters");
-                len = 12;
-            }
-            memset(signature, 0, 12);
-            memcpy(signature, cpu->hyperv_vendor_id, len);
-        }
-        c->eax = cpu->hyperv_evmcs ?
-            HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
-        c->ebx = signature[0];
-        c->ecx = signature[1];
-        c->edx = signature[2];
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_INTERFACE;
-        memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
-        c->eax = signature[0];
-        c->ebx = 0;
-        c->ecx = 0;
-        c->edx = 0;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_VERSION;
-        c->eax = 0x00001bbc;
-        c->ebx = 0x00060001;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_FEATURES;
-        r = hyperv_handle_properties(cs);
-        if (r) {
-            return r;
-        }
-        c->eax = env->features[FEAT_HYPERV_EAX];
-        c->ebx = env->features[FEAT_HYPERV_EBX];
-        c->edx = env->features[FEAT_HYPERV_EDX];
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_ENLIGHTMENT_INFO;
-
-        c->eax = env->features[FEAT_HV_RECOMM_EAX];
-        c->ebx = cpu->hyperv_spinlock_attempts;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_IMPLEMENT_LIMITS;
-
-        c->eax = cpu->hv_max_vps;
-        c->ebx = 0x40;
-
+    r = hyperv_handle_properties(cs, cpuid_data.entries);
+    if (r < 0) {
+        return r;
+    } else if (r > 0) {
+        cpuid_i = r;
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
-
-        if (cpu->hyperv_evmcs) {
-            __u32 function;
-
-            /* Create zeroed 0x40000006..0x40000009 leaves */
-            for (function = HV_CPUID_IMPLEMENT_LIMITS + 1;
-                 function < HV_CPUID_NESTED_FEATURES; function++) {
-                c = &cpuid_data.entries[cpuid_i++];
-                c->function = function;
-            }
-
-            c = &cpuid_data.entries[cpuid_i++];
-            c->function = HV_CPUID_NESTED_FEATURES;
-            c->eax = env->features[FEAT_HV_NESTED_EAX];
-        }
     }
 
     if (cpu->expose_kvm) {
-- 
2.20.1
