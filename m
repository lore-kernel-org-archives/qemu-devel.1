Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B486BC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFB621734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFB621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdqK-00041D-Iv
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:28:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiS-0005vg-CR
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiQ-0006Og-W9
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hRdiQ-00064B-Oe
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3167C0578FA;
	Fri, 17 May 2019 14:19:43 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC2DD78576;
	Fri, 17 May 2019 14:19:40 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:19:20 +0200
Message-Id: <20190517141924.19024-6-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-1-vkuznets@redhat.com>
References: <20190517141924.19024-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 17 May 2019 14:19:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/9] i386/kvm: implement 'hv-passthrough'
 mode
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

In many case we just want to give Windows guests all currently supported
Hyper-V enlightenments and that's where this new mode may come handy. We
pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.

hv_cpuid_check_and_set() is modified to also set cpu->hyperv_* flags as
we may want to check them later (and we actually do for hv_runtime,
hv_synic,...).

'hv-passthrough' is a development only feature, a migration blocker is
added to prevent issues while migrating between hosts with different
feature sets.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 docs/hyperv.txt   | 10 ++++++
 target/i386/cpu.c |  1 +
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 89 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index c423e0fca2..beadb2d0d4 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -175,6 +175,16 @@ without the feature to find out if enabling it is be=
neficial.
 Requires: hv-vapic
=20
=20
+4. Development features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+In some cases (e.g. during development) it may make sense to use QEMU in
+'pass-through' mode and give Windows guests all enlightenments currently
+supported by KVM. This pass-through mode is enabled by "hv-passthrough" =
CPU
+flag.
+Note: enabling this flag effectively prevents migration as supported fea=
tures
+may differ between target and destination.
+
+
 4. Useful links
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Hyper-V Top Level Functional specification and other information:
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9530b28d42..063551ef55 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5849,6 +5849,7 @@ static Property x86_cpu_properties[] =3D {
                       HYPERV_FEAT_EVMCS, 0),
     DEFINE_PROP_BIT64("hv-ipi", X86CPU, hyperv_features,
                       HYPERV_FEAT_IPI, 0),
+    DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false=
),
=20
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 11fa9e643e..1f1f8969b4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1401,6 +1401,7 @@ struct X86CPU {
     char *hyperv_vendor_id;
     bool hyperv_synic_kvm_only;
     uint64_t hyperv_features;
+    bool hyperv_passthrough;
=20
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2b13757441..e876dc6118 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -640,7 +640,7 @@ static bool hyperv_enabled(X86CPU *cpu)
     CPUState *cs =3D CPU(cpu);
     return kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0 &&
         ((cpu->hyperv_spinlock_attempts !=3D HYPERV_SPINLOCK_NEVER_RETRY=
) ||
-         cpu->hyperv_features);
+         cpu->hyperv_features || cpu->hyperv_passthrough);
 }
=20
 static int kvm_arch_set_tsc_khz(CPUState *cs)
@@ -986,10 +986,10 @@ static int hv_cpuid_check_and_set(CPUState *cs, str=
uct kvm_cpuid2 *cpuid,
 {
     X86CPU *cpu =3D X86_CPU(cs);
     CPUX86State *env =3D &cpu->env;
-    uint32_t r, fw, bits;;
+    uint32_t r, fw, bits;
     int i;
=20
-    if (!hyperv_feat_enabled(cpu, feature)) {
+    if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) =
{
         return 0;
     }
=20
@@ -1002,15 +1002,23 @@ static int hv_cpuid_check_and_set(CPUState *cs, s=
truct kvm_cpuid2 *cpuid,
         }
=20
         if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) !=3D bits) {
-            fprintf(stderr,
-                    "Hyper-V %s is not supported by kernel\n",
-                    kvm_hyperv_properties[feature].desc);
-            return 1;
+            if (hyperv_feat_enabled(cpu, feature)) {
+                fprintf(stderr,
+                        "Hyper-V %s is not supported by kernel\n",
+                        kvm_hyperv_properties[feature].desc);
+                return 1;
+            } else {
+                return 0;
+            }
         }
=20
         env->features[fw] |=3D bits;
     }
=20
+    if (cpu->hyperv_passthrough) {
+        cpu->hyperv_features |=3D BIT(feature);
+    }
+
     return 0;
 }
=20
@@ -1028,22 +1036,29 @@ static int hyperv_handle_properties(CPUState *cs,
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     uint32_t cpuid_i =3D 0;
-    int r =3D 0;
+    int r;
=20
     if (!hyperv_enabled(cpu))
         return 0;
=20
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ||
+        cpu->hyperv_passthrough) {
         uint16_t evmcs_version;
=20
-        if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
-                                (uintptr_t)&evmcs_version)) {
+        r =3D kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0=
,
+                                (uintptr_t)&evmcs_version);
+
+        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) && r) {
             fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
                     kvm_hyperv_properties[HYPERV_FEAT_EVMCS].desc);
             return -ENOSYS;
         }
-        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_ENLIGHTENED_VMCS_RECOM=
MENDED;
-        env->features[FEAT_HV_NESTED_EAX] =3D evmcs_version;
+
+        if (!r) {
+            env->features[FEAT_HV_RECOMM_EAX] |=3D
+                HV_ENLIGHTENED_VMCS_RECOMMENDED;
+            env->features[FEAT_HV_NESTED_EAX] =3D evmcs_version;
+        }
     }
=20
     if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_CPUID) > 0) {
@@ -1052,8 +1067,33 @@ static int hyperv_handle_properties(CPUState *cs,
         cpuid =3D get_supported_hv_cpuid_legacy(cs);
     }
=20
+    if (cpu->hyperv_passthrough) {
+        memcpy(cpuid_ent, &cpuid->entries[0],
+               cpuid->nent * sizeof(cpuid->entries[0]));
+
+        c =3D cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
+        if (c) {
+            env->features[FEAT_HYPERV_EAX] =3D c->eax;
+            env->features[FEAT_HYPERV_EBX] =3D c->ebx;
+            env->features[FEAT_HYPERV_EDX] =3D c->eax;
+        }
+        c =3D cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
+        if (c) {
+            env->features[FEAT_HV_RECOMM_EAX] =3D c->eax;
+
+            /* hv-spinlocks may have been overriden */
+            if (cpu->hyperv_spinlock_attempts !=3D HYPERV_SPINLOCK_NEVER=
_RETRY) {
+                c->ebx =3D cpu->hyperv_spinlock_attempts;
+            }
+        }
+        c =3D cpuid_find_entry(cpuid, HV_CPUID_NESTED_FEATURES, 0);
+        if (c) {
+            env->features[FEAT_HV_NESTED_EAX] =3D c->eax;
+        }
+    }
+
     /* Features */
-    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
+    r =3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TIME);
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_CRASH);
@@ -1086,6 +1126,12 @@ static int hyperv_handle_properties(CPUState *cs,
         goto free;
     }
=20
+    if (cpu->hyperv_passthrough) {
+        /* We already copied all feature words from KVM as is */
+        r =3D cpuid->nent;
+        goto free;
+    }
+
     c =3D &cpuid_ent[cpuid_i++];
     c->function =3D HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
     if (!cpu->hyperv_vendor_id) {
@@ -1157,11 +1203,26 @@ free:
     return r;
 }
=20
+static Error *hv_passthrough_mig_blocker;
+
 static int hyperv_init_vcpu(X86CPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
+    Error *local_err =3D NULL;
     int ret;
=20
+    if (cpu->hyperv_passthrough && hv_passthrough_mig_blocker =3D=3D NUL=
L) {
+        error_setg(&hv_passthrough_mig_blocker,
+                   "'hv-passthrough' CPU flag prevents migration, use ex=
plicit"
+                   " set of hv-* flags instead");
+        ret =3D migrate_add_blocker(hv_passthrough_mig_blocker, &local_e=
rr);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(hv_passthrough_mig_blocker);
+            return ret;
+        }
+    }
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) && !hv_vpindex_set=
table) {
         /*
          * the kernel doesn't support setting vp_index; assert that its =
value
--=20
2.20.1


