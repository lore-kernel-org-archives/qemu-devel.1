Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A90ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39602082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39602082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVK1-0007XM-6C
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iLVHX-0005Ev-2o
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iLVHV-0004nY-J8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:39:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iLVHV-0004mu-B0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:39:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 48AE510F0C;
 Fri, 18 Oct 2019 16:39:11 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE6425C1B5;
 Fri, 18 Oct 2019 16:39:09 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V
 enlightenment
Date: Fri, 18 Oct 2019 18:39:08 +0200
Message-Id: <20191018163908.10246-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 18 Oct 2019 16:39:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hyper-V TLFS specifies this enlightenment as:
"NoNonArchitecturalCoreSharing - Indicates that a virtual processor will =
never
share a physical core with another virtual processor, except for virtual
processors that are reported as sibling SMT threads. This can be used as =
an
optimization to avoid the performance overhead of STIBP".

However, STIBP is not the only implication. It was found that Hyper-V on
KVM doesn't pass MD_CLEAR bit to its guests if it doesn't see
NoNonArchitecturalCoreSharing bit.

KVM reports NoNonArchitecturalCoreSharing in KVM_GET_SUPPORTED_HV_CPUID t=
o
indicate that SMT on the host is impossible (not supported of forcefully
disabled).

Implement NoNonArchitecturalCoreSharing support in QEMU as tristate:
'off' - the feature is disabled (default)
'on' - the feature is enabled. This is only safe if vCPUS are properly
 pinned and correct topology is exposed. As CPU pinning is done outside
 of QEMU the enablement decision will be made on a higher level.
'auto' - copy KVM setting. As during live migration SMT settings on the
source and destination host may differ this requires us to add a migratio=
n
blocker.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 docs/hyperv.txt            | 13 +++++++++++++
 target/i386/cpu.c          |  2 ++
 target/i386/cpu.h          |  2 ++
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 26 ++++++++++++++++++++++++++
 5 files changed, 44 insertions(+)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index 8fdf25c8291c..6518b716a958 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -184,6 +184,19 @@ enabled.
=20
 Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
=20
+3.17. hv-no-nonarch-coresharing=3Don/off/auto
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This enlightenment tells guest OS that virtual processors will never sha=
re a
+physical core unless they are reported as sibling SMT threads. This info=
rmation
+is required by Windows and Hyper-V guests to properly mitigate SMT relat=
ed CPU
+vulnerabilities.
+When the option is set to 'auto' QEMU will enable the feature only when =
KVM
+reports that non-architectural coresharing is impossible, this means tha=
t
+hyper-threading is not supported or completely disabled on the host. Thi=
s
+setting also prevents migration as SMT settings on the destination may d=
iffer.
+When the option is set to 'on' QEMU will always enable the feature, rega=
rdless
+of host setup. To keep guests secure, this can only be used in conjuncti=
on with
+exposing correct vCPU topology and vCPU pinning.
=20
 4. Development features
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 44f1bbdcac76..4086c0a16767 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6156,6 +6156,8 @@ static Property x86_cpu_properties[] =3D {
                       HYPERV_FEAT_IPI, 0),
     DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_STIMER_DIRECT, 0),
+    DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
+                            hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false=
),
=20
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index eaa5395aa539..9f47c1e2a52d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 #include "hyperv-proto.h"
 #include "exec/cpu-defs.h"
+#include "qapi/qapi-types-common.h"
=20
 /* The x86 has a strong memory model with some store-after-load re-order=
ing */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
@@ -1563,6 +1564,7 @@ struct X86CPU {
     bool hyperv_synic_kvm_only;
     uint64_t hyperv_features;
     bool hyperv_passthrough;
+    OnOffAuto hyperv_no_nonarch_cs;
=20
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index cffac10b45dc..056a305be38c 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -63,6 +63,7 @@
 #define HV_CLUSTER_IPI_RECOMMENDED          (1u << 10)
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
 #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
+#define HV_NO_NONARCH_CORESHARING           (1u << 18)
=20
 /*
  * Basic virtualized MSRs
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 11b9c854b543..ef606e51babe 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1208,6 +1208,16 @@ static int hyperv_handle_properties(CPUState *cs,
         }
     }
=20
+    if (cpu->hyperv_no_nonarch_cs =3D=3D ON_OFF_AUTO_ON) {
+        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_NO_NONARCH_CORESHARING=
;
+    } else if (cpu->hyperv_no_nonarch_cs =3D=3D ON_OFF_AUTO_AUTO) {
+        c =3D cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
+        if (c) {
+            env->features[FEAT_HV_RECOMM_EAX] |=3D
+                c->eax & HV_NO_NONARCH_CORESHARING;
+        }
+    }
+
     /* Features */
     r =3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
@@ -1321,6 +1331,7 @@ free:
 }
=20
 static Error *hv_passthrough_mig_blocker;
+static Error *hv_no_nonarch_cs_mig_blocker;
=20
 static int hyperv_init_vcpu(X86CPU *cpu)
 {
@@ -1340,6 +1351,21 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
     }
=20
+    if (cpu->hyperv_no_nonarch_cs =3D=3D ON_OFF_AUTO_AUTO &&
+        hv_no_nonarch_cs_mig_blocker =3D=3D NULL) {
+        error_setg(&hv_no_nonarch_cs_mig_blocker,
+                   "'hv-no-nonarch-coresharing=3Dauto' CPU flag prevents=
 migration"
+                   " use explicit 'hv-no-nonarch-coresharing=3Don' inste=
ad (but"
+                   " make sure SMT is disabled and/or that vCPUs are pro=
perly"
+                   " pinned)");
+        ret =3D migrate_add_blocker(hv_no_nonarch_cs_mig_blocker, &local=
_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(hv_no_nonarch_cs_mig_blocker);
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


