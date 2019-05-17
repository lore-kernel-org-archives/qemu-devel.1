Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A8C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3483A2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3483A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49373 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdn0-0000u8-Ce
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:24:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiH-0005lx-NQ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiF-0006Ax-Ma
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hRdiF-0005wn-DZ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A34E307D913;
	Fri, 17 May 2019 14:19:35 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B3E0178578;
	Fri, 17 May 2019 14:19:30 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:19:17 +0200
Message-Id: <20190517141924.19024-3-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-1-vkuznets@redhat.com>
References: <20190517141924.19024-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 17 May 2019 14:19:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/9] i386/kvm: add support for
 KVM_GET_SUPPORTED_HV_CPUID
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM now supports reporting supported Hyper-V features through CPUID
(KVM_GET_SUPPORTED_HV_CPUID ioctl). Going forward, this is going to be
the only way to announce new functionality and this has already happened
with Direct Mode stimers.

While we could just support KVM_GET_SUPPORTED_HV_CPUID for new features,
it seems to be beneficial to use it for all Hyper-V enlightenments when
possible. This way we can implement 'hv-all' pass-through mode giving the
guest all supported Hyper-V features even when QEMU knows nothing about
them.

Implementation-wise we create a new kvm_hyperv_properties structure
defining Hyper-V features, get_supported_hv_cpuid()/
get_supported_hv_cpuid_legacy() returning the supported CPUID set and
a bit over-engineered hv_cpuid_check_and_set() which we will also be
used to set cpu->hyperv_* properties for 'hv-all' mode.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 474 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 356 insertions(+), 118 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3daac1e4f4..6ead422efa 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -684,156 +684,394 @@ static bool tsc_is_stable_and_known(CPUX86State *=
env)
         || env->user_tsc_khz;
 }
=20
-static int hyperv_handle_properties(CPUState *cs)
+static struct {
+    const char *desc;
+    struct {
+        uint32_t fw;
+        uint32_t bits;
+    } flags[2];
+} kvm_hyperv_properties[] =3D {
+    [HYPERV_FEAT_RELAXED] =3D {
+        .desc =3D "relaxed timing (hv-relaxed)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_HYPERCALL_AVAILABLE},
+            {.fw =3D FEAT_HV_RECOMM_EAX,
+             .bits =3D HV_RELAXED_TIMING_RECOMMENDED}
+        }
+    },
+    [HYPERV_FEAT_VAPIC] =3D {
+        .desc =3D "virtual APIC (hv-vapic)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_HYPERCALL_AVAILABLE | HV_APIC_ACCESS_AVAILABLE=
},
+            {.fw =3D FEAT_HV_RECOMM_EAX,
+             .bits =3D HV_APIC_ACCESS_RECOMMENDED}
+        }
+    },
+    [HYPERV_FEAT_TIME] =3D {
+        .desc =3D "clocksources (hv-time)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_HYPERCALL_AVAILABLE | HV_TIME_REF_COUNT_AVAILA=
BLE |
+             HV_REFERENCE_TSC_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_CRASH] =3D {
+        .desc =3D "crash MSRs (hv-crash)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EDX,
+             .bits =3D HV_GUEST_CRASH_MSR_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_RESET] =3D {
+        .desc =3D "reset MSR (hv-reset)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_RESET_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_VPINDEX] =3D {
+        .desc =3D "VP_INDEX MSR (hv-vpindex)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_VP_INDEX_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_RUNTIME] =3D {
+        .desc =3D "VP_RUNTIME MSR (hv-runtime)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_VP_RUNTIME_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_SYNIC] =3D {
+        .desc =3D "synthetic interrupt controller (hv-synic)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_SYNIC_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_STIMER] =3D {
+        .desc =3D "synthetic timers (hv-stimer)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_SYNTIMERS_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_FREQUENCIES] =3D {
+        .desc =3D "frequency MSRs (hv-frequencies)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_ACCESS_FREQUENCY_MSRS},
+            {.fw =3D FEAT_HYPERV_EDX,
+             .bits =3D HV_FREQUENCY_MSRS_AVAILABLE}
+        }
+    },
+    [HYPERV_FEAT_REENLIGHTENMENT] =3D {
+        .desc =3D "reenlightenment MSRs (hv-reenlightenment)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EAX,
+             .bits =3D HV_ACCESS_REENLIGHTENMENTS_CONTROL}
+        }
+    },
+    [HYPERV_FEAT_TLBFLUSH] =3D {
+        .desc =3D "paravirtualized TLB flush (hv-tlbflush)",
+        .flags =3D {
+            {.fw =3D FEAT_HV_RECOMM_EAX,
+             .bits =3D HV_REMOTE_TLB_FLUSH_RECOMMENDED |
+             HV_EX_PROCESSOR_MASKS_RECOMMENDED}
+        }
+    },
+    [HYPERV_FEAT_EVMCS] =3D {
+        .desc =3D "enlightened VMCS (hv-evmcs)",
+        .flags =3D {
+            {.fw =3D FEAT_HV_RECOMM_EAX,
+             .bits =3D HV_ENLIGHTENED_VMCS_RECOMMENDED}
+        }
+    },
+    [HYPERV_FEAT_IPI] =3D {
+        .desc =3D "paravirtualized IPI (hv-ipi)",
+        .flags =3D {
+            {.fw =3D FEAT_HV_RECOMM_EAX,
+             .bits =3D HV_CLUSTER_IPI_RECOMMENDED |
+             HV_EX_PROCESSOR_MASKS_RECOMMENDED}
+        }
+    },
+};
+
+static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
+{
+    struct kvm_cpuid2 *cpuid;
+    int r, size;
+
+    size =3D sizeof(*cpuid) + max * sizeof(*cpuid->entries);
+    cpuid =3D g_malloc0(size);
+    cpuid->nent =3D max;
+
+    r =3D kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
+    if (r =3D=3D 0 && cpuid->nent >=3D max) {
+        r =3D -E2BIG;
+    }
+    if (r < 0) {
+        if (r =3D=3D -E2BIG) {
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
+ * Run KVM_GET_SUPPORTED_HV_CPUID ioctl(), allocating a buffer large eno=
ugh
+ * for all entries.
+ */
+static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
+{
+    struct kvm_cpuid2 *cpuid;
+    int max =3D 7; /* 0x40000000..0x40000005, 0x4000000A */
+
+    /*
+     * When the buffer is too small, KVM_GET_SUPPORTED_HV_CPUID fails wi=
th
+     * -E2BIG, however, it doesn't report back the right size. Keep incr=
easing
+     * it and re-trying until we succeed.
+     */
+    while ((cpuid =3D try_get_hv_cpuid(cs, max)) =3D=3D NULL) {
+        max++;
+    }
+    return cpuid;
+}
+
+/*
+ * When KVM_GET_SUPPORTED_HV_CPUID is not supported we fill CPUID featur=
e
+ * leaves from KVM_CAP_HYPERV* and present MSRs data.
+ */
+static struct kvm_cpuid2 *get_supported_hv_cpuid_legacy(CPUState *cs)
 {
     X86CPU *cpu =3D X86_CPU(cs);
-    CPUX86State *env =3D &cpu->env;
+    struct kvm_cpuid2 *cpuid;
+    struct kvm_cpuid_entry2 *entry_feat, *entry_recomm;
+
+    /* HV_CPUID_FEATURES, HV_CPUID_ENLIGHTMENT_INFO */
+    cpuid =3D g_malloc0(sizeof(*cpuid) + 2 * sizeof(*cpuid->entries));
+    cpuid->nent =3D 2;
+
+    /* HV_CPUID_VENDOR_AND_MAX_FUNCTIONS */
+    entry_feat =3D &cpuid->entries[0];
+    entry_feat->function =3D HV_CPUID_FEATURES;
=20
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
-        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
+    entry_recomm =3D &cpuid->entries[1];
+    entry_recomm->function =3D HV_CPUID_ENLIGHTMENT_INFO;
+    entry_recomm->ebx =3D cpu->hyperv_spinlock_attempts;
+
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0) {
+        entry_feat->eax |=3D HV_HYPERCALL_AVAILABLE;
+        entry_feat->eax |=3D HV_APIC_ACCESS_AVAILABLE;
+        entry_feat->edx |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
+        entry_recomm->eax |=3D HV_RELAXED_TIMING_RECOMMENDED;
+        entry_recomm->eax |=3D HV_APIC_ACCESS_RECOMMENDED;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
-        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |=3D HV_APIC_ACCESS_AVAILABLE;
+
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) > 0) {
+        entry_feat->eax |=3D HV_TIME_REF_COUNT_AVAILABLE;
+        entry_feat->eax |=3D HV_REFERENCE_TSC_AVAILABLE;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TIME)) {
-        if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <=3D=
 0) {
-            fprintf(stderr, "Hyper-V clocksources "
-                    "(requested by 'hv-time' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |=3D HV_HYPERCALL_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |=3D HV_TIME_REF_COUNT_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |=3D HV_REFERENCE_TSC_AVAILABLE;
+
+    if (has_msr_hv_frequencies) {
+        entry_feat->eax |=3D HV_ACCESS_FREQUENCY_MSRS;
+        entry_feat->edx |=3D HV_FREQUENCY_MSRS_AVAILABLE;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_FREQUENCIES)) {
-        if (!has_msr_hv_frequencies) {
-            fprintf(stderr, "Hyper-V frequency MSRs "
-                    "(requested by 'hv-frequencies' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |=3D HV_ACCESS_FREQUENCY_MSRS;
-        env->features[FEAT_HYPERV_EDX] |=3D HV_FREQUENCY_MSRS_AVAILABLE;
+
+    if (has_msr_hv_crash) {
+        entry_feat->edx |=3D HV_GUEST_CRASH_MSR_AVAILABLE;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_CRASH)) {
-        if (!has_msr_hv_crash) {
-            fprintf(stderr, "Hyper-V crash MSRs "
-                    "(requested by 'hv-crash' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EDX] |=3D HV_GUEST_CRASH_MSR_AVAILABLE=
;
+
+    if (has_msr_hv_reenlightenment) {
+        entry_feat->eax |=3D HV_ACCESS_REENLIGHTENMENTS_CONTROL;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_REENLIGHTENMENT)) {
-        if (!has_msr_hv_reenlightenment) {
-            fprintf(stderr,
-                    "Hyper-V Reenlightenment MSRs "
-                    "(requested by 'hv-reenlightenment' cpu flag) "
-                    "are not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |=3D HV_ACCESS_REENLIGHTENMENTS_C=
ONTROL;
+
+    if (has_msr_hv_reset) {
+        entry_feat->eax |=3D HV_RESET_AVAILABLE;
     }
-    env->features[FEAT_HYPERV_EDX] |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAI=
LABLE;
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RESET)) {
-        if (!has_msr_hv_reset) {
-            fprintf(stderr, "Hyper-V reset MSR "
-                    "(requested by 'hv-reset' cpu flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |=3D HV_RESET_AVAILABLE;
+
+    if (has_msr_hv_vpindex) {
+        entry_feat->eax |=3D HV_VP_INDEX_AVAILABLE;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
-        if (!has_msr_hv_vpindex) {
-            fprintf(stderr, "Hyper-V VP_INDEX MSR "
-                    "(requested by 'hv-vpindex' cpu flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |=3D HV_VP_INDEX_AVAILABLE;
+
+    if (has_msr_hv_runtime) {
+        entry_feat->eax |=3D HV_VP_RUNTIME_AVAILABLE;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RUNTIME)) {
-        if (!has_msr_hv_runtime) {
-            fprintf(stderr, "Hyper-V VP_RUNTIME MSR "
-                    "(requested by 'hv-runtime' cpu flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
+
+    if (has_msr_hv_synic) {
+        unsigned int cap =3D cpu->hyperv_synic_kvm_only ?
+            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
+
+        if (kvm_check_extension(cs->kvm_state, cap) > 0) {
+            entry_feat->eax |=3D HV_SYNIC_AVAILABLE;
         }
-        env->features[FEAT_HYPERV_EAX] |=3D HV_VP_RUNTIME_AVAILABLE;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
-        unsigned int cap =3D KVM_CAP_HYPERV_SYNIC;
-        if (!cpu->hyperv_synic_kvm_only) {
-            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
-                fprintf(stderr, "Hyper-V SynIC "
-                        "(requested by 'hv-synic' cpu flag) "
-                        "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
-            return -ENOSYS;
-            }
-            cap =3D KVM_CAP_HYPERV_SYNIC2;
-        }
=20
-        if (!has_msr_hv_synic || !kvm_check_extension(cs->kvm_state, cap=
)) {
-            fprintf(stderr, "Hyper-V SynIC (requested by 'hv-synic' cpu =
flag) "
-                    "is not supported by kernel\n");
-            return -ENOSYS;
-        }
+    if (has_msr_hv_stimer) {
+        entry_feat->eax |=3D HV_SYNTIMERS_AVAILABLE;
+    }
=20
-        env->features[FEAT_HYPERV_EAX] |=3D HV_SYNIC_AVAILABLE;
+    if (kvm_check_extension(cs->kvm_state,
+                            KVM_CAP_HYPERV_TLBFLUSH) > 0) {
+        entry_recomm->eax |=3D HV_REMOTE_TLB_FLUSH_RECOMMENDED;
+        entry_recomm->eax |=3D HV_EX_PROCESSOR_MASKS_RECOMMENDED;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_STIMER)) {
-        if (!has_msr_hv_stimer) {
-            fprintf(stderr, "Hyper-V timers aren't supported by kernel\n=
");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HYPERV_EAX] |=3D HV_SYNTIMERS_AVAILABLE;
+
+    if (kvm_check_extension(cs->kvm_state,
+                            KVM_CAP_HYPERV_ENLIGHTENED_VMCS) > 0) {
+        entry_recomm->eax |=3D HV_ENLIGHTENED_VMCS_RECOMMENDED;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_RELAXED)) {
-        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_RELAXED_TIMING_RECOMME=
NDED;
+
+    if (kvm_check_extension(cs->kvm_state,
+                            KVM_CAP_HYPERV_SEND_IPI) > 0) {
+        entry_recomm->eax |=3D HV_CLUSTER_IPI_RECOMMENDED;
+        entry_recomm->eax |=3D HV_EX_PROCESSOR_MASKS_RECOMMENDED;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
-        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_APIC_ACCESS_RECOMMENDE=
D;
-    }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_TLBFLUSH)) {
-        if (kvm_check_extension(cs->kvm_state,
-                                KVM_CAP_HYPERV_TLBFLUSH) <=3D 0) {
-            fprintf(stderr, "Hyper-V TLB flush support "
-                    "(requested by 'hv-tlbflush' cpu flag) "
-                    " is not supported by kernel\n");
-            return -ENOSYS;
-        }
-        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_REMOTE_TLB_FLUSH_RECOM=
MENDED;
-        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_EX_PROCESSOR_MASKS_REC=
OMMENDED;
+
+    return cpuid;
+}
+
+static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r=
)
+{
+    struct kvm_cpuid_entry2 *entry;
+    uint32_t func;
+    int reg;
+
+    switch (fw) {
+    case FEAT_HYPERV_EAX:
+        reg =3D R_EAX;
+        func =3D HV_CPUID_FEATURES;
+        break;
+    case FEAT_HYPERV_EDX:
+        reg =3D R_EDX;
+        func =3D HV_CPUID_FEATURES;
+        break;
+    case FEAT_HV_RECOMM_EAX:
+        reg =3D R_EAX;
+        func =3D HV_CPUID_ENLIGHTMENT_INFO;
+        break;
+    default:
+        return -EINVAL;
     }
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_IPI)) {
-        if (kvm_check_extension(cs->kvm_state,
-                                KVM_CAP_HYPERV_SEND_IPI) <=3D 0) {
-            fprintf(stderr, "Hyper-V IPI send support "
-                    "(requested by 'hv-ipi' cpu flag) "
-                    " is not supported by kernel\n");
-            return -ENOSYS;
+
+    entry =3D cpuid_find_entry(cpuid, func, 0);
+    if (!entry) {
+        return -ENOENT;
+    }
+
+    switch (reg) {
+    case R_EAX:
+        *r =3D entry->eax;
+        break;
+    case R_EDX:
+        *r =3D entry->edx;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid=
,
+                                  int feature)
+{
+    X86CPU *cpu =3D X86_CPU(cs);
+    CPUX86State *env =3D &cpu->env;
+    uint32_t r, fw, bits;;
+    int i;
+
+    if (!hyperv_feat_enabled(cpu, feature)) {
+        return 0;
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); =
i++) {
+        fw =3D kvm_hyperv_properties[feature].flags[i].fw;
+        bits =3D kvm_hyperv_properties[feature].flags[i].bits;
+
+        if (!fw) {
+            continue;
         }
-        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_CLUSTER_IPI_RECOMMENDE=
D;
-        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_EX_PROCESSOR_MASKS_REC=
OMMENDED;
+
+        if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) !=3D bits) {
+            fprintf(stderr,
+                    "Hyper-V %s is not supported by kernel\n",
+                    kvm_hyperv_properties[feature].desc);
+            return 1;
+        }
+
+        env->features[fw] |=3D bits;
     }
+
+    return 0;
+}
+
+static int hyperv_handle_properties(CPUState *cs)
+{
+    X86CPU *cpu =3D X86_CPU(cs);
+    CPUX86State *env =3D &cpu->env;
+    struct kvm_cpuid2 *cpuid;
+    int r =3D 0;
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
         uint16_t evmcs_version;
=20
         if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
                                 (uintptr_t)&evmcs_version)) {
-            fprintf(stderr, "Hyper-V Enlightened VMCS "
-                    "(requested by 'hv-evmcs' cpu flag) "
-                    "is not supported by kernel\n");
+            fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
+                    kvm_hyperv_properties[HYPERV_FEAT_EVMCS].desc);
             return -ENOSYS;
         }
         env->features[FEAT_HV_RECOMM_EAX] |=3D HV_ENLIGHTENED_VMCS_RECOM=
MENDED;
         env->features[FEAT_HV_NESTED_EAX] =3D evmcs_version;
     }
=20
-    return 0;
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_CPUID) > 0) {
+        cpuid =3D get_supported_hv_cpuid(cs);
+    } else {
+        cpuid =3D get_supported_hv_cpuid_legacy(cs);
+    }
+
+    /* Features */
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TIME);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_CRASH);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RESET);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VPINDEX);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RUNTIME);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_SYNIC);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_FREQUENCIES);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_REENLIGHTENMENT=
);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TLBFLUSH);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
+
+    /* Dependencies */
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
+        !cpu->hyperv_synic_kvm_only &&
+        !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
+        fprintf(stderr, "Hyper-V %s requires %s\n",
+                kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
+                kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
+        r |=3D 1;
+    }
+
+    /* Not exposed by KVM but needed to make CPU hotplug in Windows work=
 */
+    env->features[FEAT_HYPERV_EDX] |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAI=
LABLE;
+
+    g_free(cpuid);
+
+    return r ? -ENOSYS : 0;
 }
=20
 static int hyperv_init_vcpu(X86CPU *cpu)
--=20
2.20.1


