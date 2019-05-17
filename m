Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D16C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A609218DA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A609218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdkE-00071y-Fy
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:21:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiH-0005lR-0m
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiF-0006Ar-Lc
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hRdiF-0005nx-DX
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87248309B7B9;
	Fri, 17 May 2019 14:19:38 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C240C78576;
	Fri, 17 May 2019 14:19:35 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:19:18 +0200
Message-Id: <20190517141924.19024-4-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-1-vkuznets@redhat.com>
References: <20190517141924.19024-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 17 May 2019 14:19:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/9] i386/kvm: move Hyper-V CPUID filling to
 hyperv_handle_properties()
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

Let's consolidate Hyper-V features handling in hyperv_handle_properties()=
.
The change is necessary to support 'hv-passthrough' mode as we'll be just
copying CPUIDs from KVM instead of filling them in.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 163 +++++++++++++++++++++++++---------------------
 1 file changed, 90 insertions(+), 73 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6ead422efa..2b13757441 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1014,13 +1014,25 @@ static int hv_cpuid_check_and_set(CPUState *cs, s=
truct kvm_cpuid2 *cpuid,
     return 0;
 }
=20
-static int hyperv_handle_properties(CPUState *cs)
+/*
+ * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid=
_ent in
+ * case of success, errno < 0 in case of failure and 0 when no Hyper-V
+ * extentions are enabled.
+ */
+static int hyperv_handle_properties(CPUState *cs,
+                                    struct kvm_cpuid_entry2 *cpuid_ent)
 {
     X86CPU *cpu =3D X86_CPU(cs);
     CPUX86State *env =3D &cpu->env;
     struct kvm_cpuid2 *cpuid;
+    struct kvm_cpuid_entry2 *c;
+    uint32_t signature[3];
+    uint32_t cpuid_i =3D 0;
     int r =3D 0;
=20
+    if (!hyperv_enabled(cpu))
+        return 0;
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
         uint16_t evmcs_version;
=20
@@ -1069,9 +1081,80 @@ static int hyperv_handle_properties(CPUState *cs)
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work=
 */
     env->features[FEAT_HYPERV_EDX] |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAI=
LABLE;
=20
+    if (r) {
+        r =3D -ENOSYS;
+        goto free;
+    }
+
+    c =3D &cpuid_ent[cpuid_i++];
+    c->function =3D HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
+    if (!cpu->hyperv_vendor_id) {
+        memcpy(signature, "Microsoft Hv", 12);
+    } else {
+        size_t len =3D strlen(cpu->hyperv_vendor_id);
+
+        if (len > 12) {
+            error_report("hv-vendor-id truncated to 12 characters");
+            len =3D 12;
+        }
+        memset(signature, 0, 12);
+        memcpy(signature, cpu->hyperv_vendor_id, len);
+    }
+    c->eax =3D hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
+        HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
+    c->ebx =3D signature[0];
+    c->ecx =3D signature[1];
+    c->edx =3D signature[2];
+
+    c =3D &cpuid_ent[cpuid_i++];
+    c->function =3D HV_CPUID_INTERFACE;
+    memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
+    c->eax =3D signature[0];
+    c->ebx =3D 0;
+    c->ecx =3D 0;
+    c->edx =3D 0;
+
+    c =3D &cpuid_ent[cpuid_i++];
+    c->function =3D HV_CPUID_VERSION;
+    c->eax =3D 0x00001bbc;
+    c->ebx =3D 0x00060001;
+
+    c =3D &cpuid_ent[cpuid_i++];
+    c->function =3D HV_CPUID_FEATURES;
+    c->eax =3D env->features[FEAT_HYPERV_EAX];
+    c->ebx =3D env->features[FEAT_HYPERV_EBX];
+    c->edx =3D env->features[FEAT_HYPERV_EDX];
+
+    c =3D &cpuid_ent[cpuid_i++];
+    c->function =3D HV_CPUID_ENLIGHTMENT_INFO;
+    c->eax =3D env->features[FEAT_HV_RECOMM_EAX];
+    c->ebx =3D cpu->hyperv_spinlock_attempts;
+
+    c =3D &cpuid_ent[cpuid_i++];
+    c->function =3D HV_CPUID_IMPLEMENT_LIMITS;
+    c->eax =3D cpu->hv_max_vps;
+    c->ebx =3D 0x40;
+
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
+        __u32 function;
+
+        /* Create zeroed 0x40000006..0x40000009 leaves */
+        for (function =3D HV_CPUID_IMPLEMENT_LIMITS + 1;
+             function < HV_CPUID_NESTED_FEATURES; function++) {
+            c =3D &cpuid_ent[cpuid_i++];
+            c->function =3D function;
+        }
+
+        c =3D &cpuid_ent[cpuid_i++];
+        c->function =3D HV_CPUID_NESTED_FEATURES;
+        c->eax =3D env->features[FEAT_HV_NESTED_EAX];
+    }
+    r =3D cpuid_i;
+
+free:
     g_free(cpuid);
=20
-    return r ? -ENOSYS : 0;
+    return r;
 }
=20
 static int hyperv_init_vcpu(X86CPU *cpu)
@@ -1180,79 +1263,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
=20
     /* Paravirtualization CPUIDs */
-    if (hyperv_enabled(cpu)) {
-        c =3D &cpuid_data.entries[cpuid_i++];
-        c->function =3D HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
-        if (!cpu->hyperv_vendor_id) {
-            memcpy(signature, "Microsoft Hv", 12);
-        } else {
-            size_t len =3D strlen(cpu->hyperv_vendor_id);
-
-            if (len > 12) {
-                error_report("hv-vendor-id truncated to 12 characters");
-                len =3D 12;
-            }
-            memset(signature, 0, 12);
-            memcpy(signature, cpu->hyperv_vendor_id, len);
-        }
-        c->eax =3D hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
-            HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
-        c->ebx =3D signature[0];
-        c->ecx =3D signature[1];
-        c->edx =3D signature[2];
-
-        c =3D &cpuid_data.entries[cpuid_i++];
-        c->function =3D HV_CPUID_INTERFACE;
-        memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
-        c->eax =3D signature[0];
-        c->ebx =3D 0;
-        c->ecx =3D 0;
-        c->edx =3D 0;
-
-        c =3D &cpuid_data.entries[cpuid_i++];
-        c->function =3D HV_CPUID_VERSION;
-        c->eax =3D 0x00001bbc;
-        c->ebx =3D 0x00060001;
-
-        c =3D &cpuid_data.entries[cpuid_i++];
-        c->function =3D HV_CPUID_FEATURES;
-        r =3D hyperv_handle_properties(cs);
-        if (r) {
-            return r;
-        }
-        c->eax =3D env->features[FEAT_HYPERV_EAX];
-        c->ebx =3D env->features[FEAT_HYPERV_EBX];
-        c->edx =3D env->features[FEAT_HYPERV_EDX];
-
-        c =3D &cpuid_data.entries[cpuid_i++];
-        c->function =3D HV_CPUID_ENLIGHTMENT_INFO;
-
-        c->eax =3D env->features[FEAT_HV_RECOMM_EAX];
-        c->ebx =3D cpu->hyperv_spinlock_attempts;
-
-        c =3D &cpuid_data.entries[cpuid_i++];
-        c->function =3D HV_CPUID_IMPLEMENT_LIMITS;
-
-        c->eax =3D cpu->hv_max_vps;
-        c->ebx =3D 0x40;
-
+    r =3D hyperv_handle_properties(cs, cpuid_data.entries);
+    if (r < 0) {
+        return r;
+    } else if (r > 0) {
+        cpuid_i =3D r;
         kvm_base =3D KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall =3D true;
-
-        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
-            __u32 function;
-
-            /* Create zeroed 0x40000006..0x40000009 leaves */
-            for (function =3D HV_CPUID_IMPLEMENT_LIMITS + 1;
-                 function < HV_CPUID_NESTED_FEATURES; function++) {
-                c =3D &cpuid_data.entries[cpuid_i++];
-                c->function =3D function;
-            }
-
-            c =3D &cpuid_data.entries[cpuid_i++];
-            c->function =3D HV_CPUID_NESTED_FEATURES;
-            c->eax =3D env->features[FEAT_HV_NESTED_EAX];
-        }
     }
=20
     if (cpu->expose_kvm) {
--=20
2.20.1


