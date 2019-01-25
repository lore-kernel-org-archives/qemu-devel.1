Received: from eggs.gnu.org ([209.51.188.92]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsC-00031O-Ep
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsA-0007Ep-S7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzsA-0007DH-If
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so6293812wmf.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:10 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:51 +0100
Message-Id: <20190125114155.32062-5-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 4/8] i386/kvm: Implement 'hv-all'
 pass-through mode
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

In many case we just want to give Windows guests all currently supported
Hyper-V enlightenments and that's where this new mode may come handy. We
pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.

hv_cpuid_check_and_set() is modified to also set cpu->hyperv_* flags as
we may want to check them later (and we actually do for hv_runtime,
hv_synic,...).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c |   1 +
 target/i386/cpu.h |   1 +
 target/i386/kvm.c | 133 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 107 insertions(+), 28 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f5412592d..b776be5223 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5771,6 +5771,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
     DEFINE_PROP_BOOL("hv-evmcs", X86CPU, hyperv_evmcs, false),
     DEFINE_PROP_BOOL("hv-ipi", X86CPU, hyperv_ipi, false),
+    DEFINE_PROP_BOOL("hv-all", X86CPU, hyperv_all, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 59656a70e6..9b5c2715cc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1397,6 +1397,7 @@ struct X86CPU {
     bool hyperv_tlbflush;
     bool hyperv_evmcs;
     bool hyperv_ipi;
+    bool hyperv_all;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ed55040d9e..b373b4ac06 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -647,7 +647,8 @@ static bool hyperv_enabled(X86CPU *cpu)
             cpu->hyperv_stimer ||
             cpu->hyperv_reenlightenment ||
             cpu->hyperv_tlbflush ||
-            cpu->hyperv_ipi);
+            cpu->hyperv_ipi ||
+            cpu->hyperv_all);
 }
 
 static int kvm_arch_set_tsc_khz(CPUState *cs)
@@ -995,14 +996,15 @@ static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r)
 }
 
 static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
-                                  const char *name, bool flag)
+                                  const char *name, bool *flag)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     uint32_t r, fw, bits;;
     int i, j;
+    bool present;
 
-    if (!flag) {
+    if (!*flag && !cpu->hyperv_all) {
         return 0;
     }
 
@@ -1011,6 +1013,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
             continue;
         }
 
+        present = true;
         for (j = 0; j < ARRAY_SIZE(kvm_hyperv_properties[i].flags); j++) {
             fw = kvm_hyperv_properties[i].flags[j].fw;
             bits = kvm_hyperv_properties[i].flags[j].bits;
@@ -1020,17 +1023,26 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
             }
 
             if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) != bits) {
-                fprintf(stderr,
-                        "Hyper-V %s (requested by '%s' cpu flag) "
-                        "is not supported by kernel\n",
-                        kvm_hyperv_properties[i].desc,
-                        kvm_hyperv_properties[i].name);
-                return 1;
+                if (*flag) {
+                    fprintf(stderr,
+                            "Hyper-V %s (requested by '%s' cpu flag) "
+                            "is not supported by kernel\n",
+                            kvm_hyperv_properties[i].desc,
+                            kvm_hyperv_properties[i].name);
+                    return 1;
+                } else {
+                    present = false;
+                    break;
+                }
             }
 
             env->features[fw] |= bits;
         }
 
+        if (cpu->hyperv_all && present) {
+            *flag = true;
+        }
+
         return 0;
     }
 
@@ -1038,6 +1050,43 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     return 1;
 }
 
+static int hv_report_missing_dep(X86CPU *cpu, const char *name,
+                                 const char *dep_name)
+{
+    int i, j, nprops = sizeof(kvm_hyperv_properties);
+
+    for (i = 0; i < nprops; i++) {
+        if (!strcmp(kvm_hyperv_properties[i].name, name)) {
+            break;
+        }
+    }
+    for (j = 0; j < nprops; j++) {
+        if (!strcmp(kvm_hyperv_properties[j].name, dep_name)) {
+            break;
+        }
+    }
+
+    /*
+     * Internal error: either feature or its dependency is not in
+     * kvm_hyperv_properties!
+     */
+    if (i == nprops || j == nprops) {
+        return 1;
+    }
+
+    if (cpu->hyperv_all) {
+        fprintf(stderr, "Hyper-V %s (requested by 'hv-all' cpu flag) "
+                "requires %s (is not supported by kernel)\n",
+                kvm_hyperv_properties[i].desc, kvm_hyperv_properties[j].desc);
+    } else {
+        fprintf(stderr, "Hyper-V %s (requested by '%s' cpu flag) "
+                "requires %s ('%s')\n", kvm_hyperv_properties[i].desc,
+                name, kvm_hyperv_properties[j].desc, dep_name);
+    }
+
+    return 1;
+}
+
 /*
  * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
  * case of success, errno < 0 in case of failure and 0 when no Hyper-V
@@ -1077,32 +1126,54 @@ static int hyperv_handle_properties(CPUState *cs,
         cpuid = get_supported_hv_cpuid_legacy(cs);
     }
 
+    if (cpu->hyperv_all) {
+        memcpy(cpuid_ent, &cpuid->entries[0],
+               cpuid->nent * sizeof(cpuid->entries[0]));
+
+        c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
+        if (c) {
+            env->features[FEAT_HYPERV_EAX] = c->eax;
+            env->features[FEAT_HYPERV_EBX] = c->ebx;
+            env->features[FEAT_HYPERV_EDX] = c->eax;
+        }
+        c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
+        if (c) {
+            env->features[FEAT_HV_RECOMM_EAX] = c->eax;
+
+            /* hv-spinlocks may have been overriden */
+            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) {
+                c->ebx = cpu->hyperv_spinlock_attempts;
+            }
+        }
+        c = cpuid_find_entry(cpuid, HV_CPUID_NESTED_FEATURES, 0);
+        if (c) {
+            env->features[FEAT_HV_NESTED_EAX] = c->eax;
+        }
+    }
+
     /* Features */
     r |= hv_cpuid_check_and_set(cs, cpuid, "hv-relaxed",
-                                cpu->hyperv_relaxed_timing);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-vapic", cpu->hyperv_vapic);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-time", cpu->hyperv_time);
+                                &cpu->hyperv_relaxed_timing);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-vapic", &cpu->hyperv_vapic);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-time", &cpu->hyperv_time);
     r |= hv_cpuid_check_and_set(cs, cpuid, "hv-frequencies",
-                                cpu->hyperv_frequencies);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-crash", cpu->hyperv_crash);
+                                &cpu->hyperv_frequencies);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-crash", &cpu->hyperv_crash);
     r |= hv_cpuid_check_and_set(cs, cpuid, "hv-reenlightenment",
-                                cpu->hyperv_reenlightenment);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-reset", cpu->hyperv_reset);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-vpindex", cpu->hyperv_vpindex);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-runtime", cpu->hyperv_runtime);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-synic", cpu->hyperv_synic);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-stimer", cpu->hyperv_stimer);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-tlbflush", cpu->hyperv_tlbflush);
-    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-ipi", cpu->hyperv_ipi);
+                                &cpu->hyperv_reenlightenment);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-reset", &cpu->hyperv_reset);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-vpindex", &cpu->hyperv_vpindex);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-runtime", &cpu->hyperv_runtime);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-synic", &cpu->hyperv_synic);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-stimer", &cpu->hyperv_stimer);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-tlbflush",
+                                &cpu->hyperv_tlbflush);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-ipi", &cpu->hyperv_ipi);
 
     /* Dependencies */
     if (cpu->hyperv_synic && !cpu->hyperv_synic_kvm_only &&
-        !cpu->hyperv_vpindex) {
-        fprintf(stderr, "Hyper-V SynIC "
-                "(requested by 'hv-synic' cpu flag) "
-                "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
-        r |= 1;
-    }
+        !cpu->hyperv_vpindex)
+        r |= hv_report_missing_dep(cpu, "hv-synic", "hv-vpindex");
 
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
@@ -1112,6 +1183,12 @@ static int hyperv_handle_properties(CPUState *cs,
         goto free;
     }
 
+    if (cpu->hyperv_all) {
+        /* We already copied all feature words from KVM as is */
+        r = cpuid->nent;
+        goto free;
+    }
+
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
     if (!cpu->hyperv_vendor_id) {
-- 
2.20.1
