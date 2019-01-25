Received: from eggs.gnu.org ([209.51.188.92]:56543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzs9-0002zA-Lf
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzs7-00077L-NT
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzs7-00075V-Du
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so6403994wmt.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:07 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:49 +0100
Message-Id: <20190125114155.32062-3-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 2/8] i386/kvm: add support for
 KVM_GET_SUPPORTED_HV_CPUID
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

KVM now supports reporting supported Hyper-V features through CPUID
(KVM_GET_SUPPORTED_HV_CPUID ioctl). Going forward, this is going to be
the only way to announce new functionality and this has already happened
with Direct Mode stimers.

While we could just support KVM_GET_SUPPORTED_HV_CPUID for new features,
it seems to be beneficial to use it for all Hyper-V enlightenments when
possible. This was we can implement 'hv-all' pass-through mode giving the
guest all supported Hyper-V features even when QEMU knows nothing about
them.

Implementation-wise we create a new kvm_hyperv_properties structure
defining Hyper-V features, get_supported_hv_cpuid()/
get_supported_hv_cpuid_legacy() returning the supported CPUID set and
a bit over-engineered hv_cpuid_check_and_set() which we will also be
used to set cpu->hyperv_* properties for 'hv-all' mode.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 487 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 372 insertions(+), 115 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9af4542fb8..dc4574daff 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -691,141 +691,360 @@ static bool tsc_is_stable_and_known(CPUX86State *env)
         || env->user_tsc_khz;
 }
 
-static int hyperv_handle_properties(CPUState *cs)
+static struct {
+    const char *name;
+    const char *desc;
+    struct {
+        uint32_t fw;
+        uint32_t bits;
+    } flags[2];
+} kvm_hyperv_properties[] = {
+    {
+        .name = "hv-relaxed",
+        .desc = "relaxed timing",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_HYPERCALL_AVAILABLE},
+            {.fw = FEAT_HV_RECOMM_EAX,
+             .bits = HV_RELAXED_TIMING_RECOMMENDED}
+        }
+    },
+    {
+        .name = "hv-vapic",
+        .desc = "virtual APIC",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_HYPERCALL_AVAILABLE | HV_APIC_ACCESS_AVAILABLE},
+            {.fw = FEAT_HV_RECOMM_EAX,
+             .bits = HV_APIC_ACCESS_RECOMMENDED}
+        }
+    },
+    {
+        .name = "hv-time",
+        .desc = "clocksources",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_HYPERCALL_AVAILABLE | HV_TIME_REF_COUNT_AVAILABLE |
+             HV_REFERENCE_TSC_AVAILABLE},
+            {0}
+        }
+    },
+    {
+        .name = "hv-frequencies",
+        .desc = "frequency MSRs",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_ACCESS_FREQUENCY_MSRS},
+            {.fw = FEAT_HYPERV_EDX,
+             .bits = HV_FREQUENCY_MSRS_AVAILABLE}
+        }
+    },
+    {
+        .name = "hv-crash",
+        .desc = "crash MSRs",
+        .flags = {
+            {.fw = FEAT_HYPERV_EDX,
+             .bits = HV_GUEST_CRASH_MSR_AVAILABLE},
+            {0}
+        }
+    },
+    {
+        .name = "hv-reenlightenment",
+        .desc = "Reenlightenment MSRs",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_ACCESS_REENLIGHTENMENTS_CONTROL},
+            {0}
+        }
+    },
+    {
+        .name = "hv-reset",
+        .desc = "reset MSR",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_RESET_AVAILABLE},
+            {0}
+        }
+    },
+    {
+        .name = "hv-vpindex",
+        .desc = "VP_INDEX MSR",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_VP_INDEX_AVAILABLE},
+            {0}
+        }
+    },
+    {
+        .name = "hv-runtime",
+        .desc = "VP_RUNTIME MSR",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_VP_RUNTIME_AVAILABLE},
+            {0}
+        }
+    },
+    {
+        .name = "hv-synic",
+        .desc = "SynIC",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_SYNIC_AVAILABLE},
+            {0}
+        }
+    },
+    {
+        .name = "hv-stimer",
+        .desc = "timers",
+        .flags = {
+            {.fw = FEAT_HYPERV_EAX,
+             .bits = HV_SYNTIMERS_AVAILABLE},
+            {0}
+        }
+    },
+    {
+        .name = "hv-tlbflush",
+        .desc = "TLB flush support",
+        .flags = {
+            {.fw = FEAT_HV_RECOMM_EAX,
+             .bits = HV_REMOTE_TLB_FLUSH_RECOMMENDED |
+             HV_EX_PROCESSOR_MASKS_RECOMMENDED},
+            {0}
+        }
+    },
+    {
+        .name = "hv-ipi",
+        .desc = "IPI send support",
+        .flags = {
+            {.fw = FEAT_HV_RECOMM_EAX,
+             .bits = HV_CLUSTER_IPI_RECOMMENDED |
+             HV_EX_PROCESSOR_MASKS_RECOMMENDED},
+            {0}
+        }
+    },
+};
+
+static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
+{
+    struct kvm_cpuid2 *cpuid;
+    int r, size;
+
+    size = sizeof(*cpuid) + max * sizeof(*cpuid->entries);
+    cpuid = g_malloc0(size);
+    cpuid->nent = max;
+
+    r = kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
+    if (r == 0 && cpuid->nent >= max) {
+        r = -E2BIG;
+    }
+    if (r < 0) {
+        if (r == -E2BIG) {
+            g_free(cpuid);
+            return NULL;
+        } else {
+            fprintf(stderr, "KVM_GET_SUPPORTED_HV_CPUID failed: %s\n",
+                    strerror(-r));
+            exit(1);
+        }
+    }
+    return cpuid;
+}
+
+/*
+ * Run KVM_GET_SUPPORTED_HV_CPUID ioctl(), allocating a buffer large enough
+ * for all entries.
+ */
+static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
+{
+    struct kvm_cpuid2 *cpuid;
+    int max = 7; /* 0x40000000..0x40000005, 0x4000000A */
+
+    while ((cpuid = try_get_hv_cpuid(cs, max)) == NULL) {
+        max++;
+    }
+    return cpuid;
+}
+
+/*
+ * When KVM_GET_SUPPORTED_HV_CPUID is not supported we fill CPUID feature
+ * leaves from KVM_CAP_HYPERV* and present MSRs data.
+ */
+static struct kvm_cpuid2 *get_supported_hv_cpuid_legacy(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
+    struct kvm_cpuid2 *cpuid;
+    struct kvm_cpuid_entry2 *entry_feat, *entry_recomm;
+
+    /* HV_CPUID_FEATURES, HV_CPUID_ENLIGHTMENT_INFO */
+    cpuid = g_malloc0(sizeof(*cpuid) + 2 * sizeof(*cpuid->entries));
+    cpuid->nent = 2;
+
+    /* HV_CPUID_VENDOR_AND_MAX_FUNCTIONS */
+    entry_feat = &cpuid->entries[0];
+    entry_feat->function = HV_CPUID_FEATURES;
+
+    entry_recomm = &cpuid->entries[1];
+    entry_recomm->function = HV_CPUID_ENLIGHTMENT_INFO;
 
-    if (cpu->hyperv_relaxed_timing) {
-        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0) {
+        entry_feat->eax |= HV_HYPERCALL_AVAILABLE;
+        entry_feat->eax |= HV_APIC_ACCESS_AVAILABLE;
+        entry_feat->edx |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
+        entry_recomm->eax |= HV_RELAXED_TIMING_RECOMMENDED;
+        entry_recomm->eax |= HV_APIC_ACCESS_RECOMMENDED;
     }
-    if (cpu->hyperv_vapic) {
-        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= HV_APIC_ACCESS_AVAILABLE;
+
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) > 0) {
+        entry_feat->eax |= HV_TIME_REF_COUNT_AVAILABLE;
+        entry_feat->eax |= HV_REFERENCE_TSC_AVAILABLE;
     }
-    if (cpu->hyperv_time) {
-        if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <= 0) {
-            fprintf(stderr, "Hyper-V clocksources "
-                    "(requested by 'hv-time' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
+
+    if (has_msr_hv_frequencies) {
+        entry_feat->eax |= HV_ACCESS_FREQUENCY_MSRS;
+        entry_feat->edx |= HV_FREQUENCY_MSRS_AVAILABLE;
     }
-    if (cpu->hyperv_frequencies) {
-        if (!has_msr_hv_frequencies) {
-            fprintf(stderr, "Hyper-V frequency MSRs "
-                    "(requested by 'hv-frequencies' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
-        env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
+
+    if (has_msr_hv_crash) {
+        entry_feat->edx |= HV_GUEST_CRASH_MSR_AVAILABLE;
     }
-    if (cpu->hyperv_crash) {
-        if (!has_msr_hv_crash) {
-            fprintf(stderr, "Hyper-V crash MSRs "
-                    "(requested by 'hv-crash' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
+
+    if (has_msr_hv_reenlightenment) {
+        entry_feat->eax |= HV_ACCESS_REENLIGHTENMENTS_CONTROL;
     }
-    if (cpu->hyperv_reenlightenment) {
-        if (!has_msr_hv_reenlightenment) {
-            fprintf(stderr,
-                    "Hyper-V Reenlightenment MSRs "
-                    "(requested by 'hv-reenlightenment' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_REENLIGHTENMENTS_CONTROL;
+
+    if (has_msr_hv_reset) {
+        entry_feat->eax |= HV_RESET_AVAILABLE;
     }
-    env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-    if (cpu->hyperv_reset) {
-        if (!has_msr_hv_reset) {
-            fprintf(stderr, "Hyper-V reset MSR "
-                    "(requested by 'hv-reset' cpu flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |= HV_RESET_AVAILABLE;
+
+    if (has_msr_hv_vpindex) {
+        entry_feat->eax |= HV_VP_INDEX_AVAILABLE;
     }
-    if (cpu->hyperv_vpindex) {
-        if (!has_msr_hv_vpindex) {
-            fprintf(stderr, "Hyper-V VP_INDEX MSR "
-                    "(requested by 'hv-vpindex' cpu flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |= HV_VP_INDEX_AVAILABLE;
+
+    if (has_msr_hv_runtime) {
+        entry_feat->eax |= HV_VP_RUNTIME_AVAILABLE;
     }
-    if (cpu->hyperv_runtime) {
-        if (!has_msr_hv_runtime) {
-            fprintf(stderr, "Hyper-V VP_RUNTIME MSR "
-                    "(requested by 'hv-runtime' cpu flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
+
+    if (has_msr_hv_synic) {
+        unsigned int cap = cpu->hyperv_synic_kvm_only ?
+            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
+
+        if (kvm_check_extension(cs->kvm_state, cap) > 0) {
+            entry_feat->eax |= HV_SYNIC_AVAILABLE;
         }
-        env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
-    if (cpu->hyperv_synic) {
-        unsigned int cap = KVM_CAP_HYPERV_SYNIC;
-        if (!cpu->hyperv_synic_kvm_only) {
-            if (!cpu->hyperv_vpindex) {
-                fprintf(stderr, "Hyper-V SynIC "
-                        "(requested by 'hv-synic' cpu flag) "
-                        "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
-            return -ENOSYS;
-            }
-            cap = KVM_CAP_HYPERV_SYNIC2;
-        }
 
-        if (!has_msr_hv_synic || !kvm_check_extension(cs->kvm_state, cap)) {
-            fprintf(stderr, "Hyper-V SynIC (requested by 'hv-synic' cpu flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
-        }
+    if (has_msr_hv_stimer) {
+        entry_feat->eax |= HV_SYNTIMERS_AVAILABLE;
+    }
 
-        env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
+    if (kvm_check_extension(cs->kvm_state,
+                            KVM_CAP_HYPERV_TLBFLUSH) > 0) {
+        entry_recomm->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
+        entry_recomm->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
     }
-    if (cpu->hyperv_stimer) {
-        if (!has_msr_hv_stimer) {
-            fprintf(stderr, "Hyper-V timers aren't supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |= HV_SYNTIMERS_AVAILABLE;
+
+    if (kvm_check_extension(cs->kvm_state,
+                            KVM_CAP_HYPERV_SEND_IPI) > 0) {
+        entry_recomm->eax |= HV_CLUSTER_IPI_RECOMMENDED;
+        entry_recomm->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
     }
-    if (cpu->hyperv_relaxed_timing) {
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_RELAXED_TIMING_RECOMMENDED;
+
+    return cpuid;
+}
+
+static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r)
+{
+    struct kvm_cpuid_entry2 *entry;
+    uint32_t func;
+    int reg;
+
+    switch (fw) {
+    case FEAT_HYPERV_EAX:
+        reg = R_EAX;
+        func = HV_CPUID_FEATURES;
+        break;
+    case FEAT_HYPERV_EDX:
+        reg = R_EDX;
+        func = HV_CPUID_FEATURES;
+        break;
+    case FEAT_HV_RECOMM_EAX:
+        reg = R_EAX;
+        func = HV_CPUID_ENLIGHTMENT_INFO;
+        break;
+    default:
+        return -EINVAL;
     }
-    if (cpu->hyperv_vapic) {
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_APIC_ACCESS_RECOMMENDED;
-    }
-    if (cpu->hyperv_tlbflush) {
-        if (kvm_check_extension(cs->kvm_state,
-                                KVM_CAP_HYPERV_TLBFLUSH) <= 0) {
-            fprintf(stderr, "Hyper-V TLB flush support "
-                    "(requested by 'hv-tlbflush' cpu flag) "
-                    " is not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
+
+    entry = cpuid_find_entry(cpuid, func, 0);
+    if (!entry) {
+        return -ENOENT;
     }
-    if (cpu->hyperv_ipi) {
-        if (kvm_check_extension(cs->kvm_state,
-                                KVM_CAP_HYPERV_SEND_IPI) <= 0) {
-            fprintf(stderr, "Hyper-V IPI send support "
-                    "(requested by 'hv-ipi' cpu flag) "
-                    " is not supported by kernel\n");
-            return -ENOSYS;
+
+    switch (reg) {
+    case R_EAX:
+        *r = entry->eax;
+        break;
+    case R_EDX:
+        *r = entry->edx;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
+                                  const char *name, bool flag)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint32_t r, fw, bits;;
+    int i, j;
+
+    if (!flag) {
+        return 0;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties); i++) {
+        if (strcmp(kvm_hyperv_properties[i].name, name)) {
+            continue;
         }
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_CLUSTER_IPI_RECOMMENDED;
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
+
+        for (j = 0; j < ARRAY_SIZE(kvm_hyperv_properties[i].flags); j++) {
+            fw = kvm_hyperv_properties[i].flags[j].fw;
+            bits = kvm_hyperv_properties[i].flags[j].bits;
+
+            if (!fw) {
+                continue;
+            }
+
+            if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) != bits) {
+                fprintf(stderr,
+                        "Hyper-V %s (requested by '%s' cpu flag) "
+                        "is not supported by kernel\n",
+                        kvm_hyperv_properties[i].desc,
+                        kvm_hyperv_properties[i].name);
+                return 1;
+            }
+
+            env->features[fw] |= bits;
+        }
+
+        return 0;
     }
+
+    /* the requested feature is undefined in kvm_hyperv_properties */
+    return 1;
+}
+
+static int hyperv_handle_properties(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    struct kvm_cpuid2 *cpuid;
+    int r = 0;
+
     if (cpu->hyperv_evmcs) {
         uint16_t evmcs_version;
 
@@ -840,7 +1059,45 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
     }
 
-    return 0;
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_CPUID) > 0) {
+        cpuid = get_supported_hv_cpuid(cs);
+    } else {
+        cpuid = get_supported_hv_cpuid_legacy(cs);
+    }
+
+    /* Features */
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-relaxed",
+                                cpu->hyperv_relaxed_timing);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-vapic", cpu->hyperv_vapic);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-time", cpu->hyperv_time);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-frequencies",
+                                cpu->hyperv_frequencies);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-crash", cpu->hyperv_crash);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-reenlightenment",
+                                cpu->hyperv_reenlightenment);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-reset", cpu->hyperv_reset);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-vpindex", cpu->hyperv_vpindex);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-runtime", cpu->hyperv_runtime);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-synic", cpu->hyperv_synic);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-stimer", cpu->hyperv_stimer);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-tlbflush", cpu->hyperv_tlbflush);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-ipi", cpu->hyperv_ipi);
+
+    /* Dependencies */
+    if (cpu->hyperv_synic && !cpu->hyperv_synic_kvm_only &&
+        !cpu->hyperv_vpindex) {
+        fprintf(stderr, "Hyper-V SynIC "
+                "(requested by 'hv-synic' cpu flag) "
+                "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
+        r |= 1;
+    }
+
+    /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
+    env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
+
+    g_free(cpuid);
+
+    return r ? -ENOSYS : 0;
 }
 
 static int hyperv_init_vcpu(X86CPU *cpu)
-- 
2.20.1
