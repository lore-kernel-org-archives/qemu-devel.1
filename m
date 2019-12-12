Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5DD22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3ndChPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5DD22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTBi-00074Z-Nh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ifSLX-0002S0-Bp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ifSLV-0003Bz-Js
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ifSLV-0003B5-Fj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576172029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p89rsIiZEknzKudPE9sULObTiNHU6cO6PEn+xslTix4=;
 b=P3ndChPyKWPYAfk8sqWxdZZIHGwtkBIa5Jn7W87ojAm6K5f/aHODDCB5euJgDBeGpG+DBp
 GrY56Faclx4/Ub9UzgGCvknzoQYfY7EDKtt4pouVrOhLfKOgqPwQubPgMiiu3KX1hDv1KA
 p+cIf98MS1ozMkb7EC1s9FDhUsrqS6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-qCLQr4uSMVWCSCAc0HmYAg-1; Thu, 12 Dec 2019 12:33:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4742418543A0;
 Thu, 12 Dec 2019 17:33:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A2621C955;
 Thu, 12 Dec 2019 17:33:43 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v2 5/5] target/arm/cpu: Add the kvm-no-adjvtime CPU
 property
Date: Thu, 12 Dec 2019 18:33:20 +0100
Message-Id: <20191212173320.11610-6-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-1-drjones@redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qCLQr4uSMVWCSCAc0HmYAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kvm-no-adjvtime is a KVM specific CPU property and a first of its kind.
To accommodate it we also add kvm_arm_add_vcpu_properties() and a
KVM specific CPU properties description to the CPU features document.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 docs/arm-cpu-features.rst | 31 ++++++++++++++++++++++++++++++-
 hw/arm/virt.c             |  8 ++++++++
 include/hw/arm/virt.h     |  1 +
 target/arm/cpu.c          |  2 ++
 target/arm/cpu64.c        |  1 +
 target/arm/kvm.c          | 28 ++++++++++++++++++++++++++++
 target/arm/kvm_arm.h      | 11 +++++++++++
 target/arm/monitor.c      |  1 +
 tests/arm-cpu-features.c  |  4 ++++
 9 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index 1b367e22e16e..641ec9cb8f4a 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -31,7 +31,9 @@ supporting the feature or only supporting the feature und=
er certain
 configurations.  For example, the `aarch64` CPU feature, which, when
 disabled, enables the optional AArch32 CPU feature, is only supported
 when using the KVM accelerator and when running on a host CPU type that
-supports the feature.
+supports the feature.  While `aarch64` currently only works with KVM,
+it could work with TCG.  CPU features that are specific to KVM are
+prefixed with "kvm-" and are described in "KVM VCPU Features".
=20
 CPU Feature Probing
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -171,6 +173,33 @@ disabling many SVE vector lengths would be quite verbo=
se, the `sve<N>` CPU
 properties have special semantics (see "SVE CPU Property Parsing
 Semantics").
=20
+KVM VCPU Features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+KVM VCPU features are CPU features that are specific to KVM, such as
+paravirt features or features that enable CPU virtualization extensions.
+The features' CPU properties are only available when KVM is enabled and
+are named with the prefix "kvm-".  KVM VCPU features may be probed,
+enabled, and disabled in the same way as other CPU features.  Below is the
+list of KVM VCPU features and their descriptions.
+
+  kvm-no-adjvtime          When disabled, each time the VM transitions
+                           back to running state from the paused state the
+                           VCPU's vitual counter is updated to ensure the
+                           stopped time is not counted.  This avoids time
+                           jumps surprising guest OSes and applications,
+                           as long as they use the virtual counter for
+                           timekeeping, but has the side effect of the
+                           virtual and physical counters diverging.  All
+                           timekeeping based on the virtual counter will
+                           appear to lag behind any timekeeping that does
+                           not subtract VM stopped time.  The guest may
+                           resynchronize its virtual counter with other
+                           time sources as needed.  Enabling this KVM VCPU
+                           feature provides the legacy behavior, which is
+                           to also count stopped time with the virtual
+                           counter.
+
 SVE CPU Properties
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cb7041e9677a..e9a08eb883bf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1664,6 +1664,11 @@ static void machvirt_init(MachineState *machine)
             }
         }
=20
+        if (vmc->kvm_no_adjvtime &&
+            object_property_find(cpuobj, "kvm-no-adjvtime", NULL)) {
+            object_property_set_bool(cpuobj, true, "kvm-no-adjvtime", NULL=
);
+        }
+
         if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
             object_property_set_bool(cpuobj, false, "pmu", NULL);
         }
@@ -2154,8 +2159,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
=20
 static void virt_machine_4_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_5_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    vmc->kvm_no_adjvtime =3D true;
 }
 DEFINE_VIRT_MACHINE(4, 2)
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0b41083e9d5c..80e00161b8f2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -109,6 +109,7 @@ typedef struct {
     bool smbios_old_sys_ver;
     bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
+    bool kvm_no_adjvtime;
 } VirtMachineClass;
=20
 typedef struct {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339bf9..53c73c25a67f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2482,6 +2482,7 @@ static void arm_max_initfn(Object *obj)
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
+        kvm_arm_add_vcpu_properties(obj);
     } else {
         cortex_a15_initfn(obj);
=20
@@ -2673,6 +2674,7 @@ static void arm_host_initfn(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
     }
+    kvm_arm_add_vcpu_properties(obj);
     arm_cpu_post_init(obj);
 }
=20
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a39d6fcea34f..3cd416db8089 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -605,6 +605,7 @@ static void aarch64_max_initfn(Object *obj)
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
+        kvm_arm_add_vcpu_properties(obj);
     } else {
         uint64_t t;
         uint32_t u;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a55fe7d7aefd..7666b250ab96 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -17,6 +17,8 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qom/object.h"
+#include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
@@ -179,6 +181,32 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features =3D arm_host_cpu_features.features;
 }
=20
+static bool kvm_no_adjvtime_get(Object *obj, Error **errp)
+{
+    return !ARM_CPU(obj)->kvm_adjvtime;
+}
+
+static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
+{
+    ARM_CPU(obj)->kvm_adjvtime =3D !value;
+}
+
+/* KVM VCPU properties should be prefixed with "kvm-". */
+void kvm_arm_add_vcpu_properties(Object *obj)
+{
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    ARM_CPU(obj)->kvm_adjvtime =3D true;
+    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
+                             kvm_no_adjvtime_set, &error_abort);
+    object_property_set_description(obj, "kvm-no-adjvtime",
+                                    "Set on to disable the adjustment of "
+                                    "the virtual counter. VM stopped time =
"
+                                    "will be counted.", &error_abort);
+}
+
 bool kvm_arm_pmu_supported(CPUState *cpu)
 {
     KVMState *s =3D KVM_STATE(current_machine->accelerator);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 16b53e45377d..7d76f26beaca 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -232,6 +232,15 @@ void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *=
map);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
=20
+/**
+ * void kvm_arm_add_vcpu_properties:
+ * @obj: The CPU object to add the properties to
+ *
+ * Add all KVM specific CPU properties to the CPU object. These
+ * are the CPU properties with "kvm-" prefixed names.
+ */
+void kvm_arm_add_vcpu_properties(Object *obj);
+
 /**
  * void kvm_arm_get_virtual_time:
  * @cs: CPUState
@@ -319,6 +328,8 @@ static inline void kvm_arm_set_cpu_features_from_host(A=
RMCPU *cpu)
     cpu->host_cpu_probe_failed =3D true;
 }
=20
+static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
+
 static inline bool kvm_arm_aarch32_supported(CPUState *cs)
 {
     return false;
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index fa054f8a369c..9725dfff16d4 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -103,6 +103,7 @@ static const char *cpu_model_advertised_features[] =3D =
{
     "sve128", "sve256", "sve384", "sve512",
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
+    "kvm-no-adjvtime",
     NULL
 };
=20
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 06ed05e934e6..738e49447377 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -435,6 +435,8 @@ static void test_query_cpu_model_expansion(const void *=
data)
     assert_has_feature_enabled(qts, "cortex-a15", "pmu");
     assert_has_not_feature(qts, "cortex-a15", "aarch64");
=20
+    assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
+
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature_enabled(qts, "max", "aarch64");
         assert_has_feature_enabled(qts, "max", "sve");
@@ -469,6 +471,8 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
         return;
     }
=20
+    assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
+
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
         char max_name[8], name[8];
--=20
2.21.0


