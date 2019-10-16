Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F9BFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7FB218DE
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7FB218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKkSl-0002K1-9N
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 10:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iKkNh-0005ID-7W
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iKkNf-0000m4-HX
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:34:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iKkNb-0000k0-HV; Wed, 16 Oct 2019 10:34:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA32E18CB90C;
 Wed, 16 Oct 2019 14:34:22 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3761F19C68;
 Wed, 16 Oct 2019 14:34:21 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v1 5/5] target/arm/cpu: Add the kvm-adjvtime CPU property
Date: Wed, 16 Oct 2019 16:34:10 +0200
Message-Id: <20191016143410.5023-6-drjones@redhat.com>
In-Reply-To: <20191016143410.5023-1-drjones@redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 16 Oct 2019 14:34:22 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 bijan.mottahedeh@oracle.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kvm-adjvtime is a KVM specific CPU property and a first of its kind.
To accommodate it we also add kvm_arm_add_vcpu_properties() and a
KVM specific CPU properties description to the CPU features document.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/arm-cpu-features.rst | 27 ++++++++++++++++++++++++++-
 target/arm/cpu.c          |  2 ++
 target/arm/cpu64.c        |  1 +
 target/arm/kvm.c          | 27 +++++++++++++++++++++++++++
 target/arm/kvm_arm.h      | 11 +++++++++++
 target/arm/monitor.c      |  1 +
 tests/arm-cpu-features.c  |  4 ++++
 7 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index 1b367e22e16e..5c317296845f 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -31,7 +31,9 @@ supporting the feature or only supporting the feature u=
nder certain
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
@@ -171,6 +173,29 @@ disabling many SVE vector lengths would be quite ver=
bose, the `sve<N>` CPU
 properties have special semantics (see "SVE CPU Property Parsing
 Semantics").
=20
+KVM VCPU Features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+KVM VCPU features are CPU features that are specific to KVM, such as
+paravirt features or features that enable CPU virtualization extensions.
+The features' CPU properties are only available when KVM is enabled and =
are
+named with the prefix "kvm-".  KVM VCPU features may be probed, enabled,=
 and
+disabled in the same way as other CPU features.  Below is the list of KV=
M
+VCPU features and their descriptions.
+
+  kvm-adjvtime             When enabled, each time the VM transitions ba=
ck
+                           to running state the VCPU's vitual counter is
+                           updated to ensure stopped time is not counted=
.
+                           This avoids time jumps surprising guest OSes =
and
+                           applications, as long as they use the virtual
+                           counter for timekeeping, but has the side eff=
ect
+                           of the virtual and physical counters divergin=
g.
+                           All timekeeping based on the virtual counter =
will
+                           appear to lag behind any timekeeping that doe=
s
+                           not subtract VM stopped time.  The guest may
+                           resynchronize its virtual counter with other =
time
+                           sources as needed.
+
 SVE CPU Properties
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0c4465880ddd..151771e12bc5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2481,6 +2481,7 @@ static void arm_max_initfn(Object *obj)
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
+        kvm_arm_add_vcpu_properties(obj);
     } else {
         cortex_a15_initfn(obj);
=20
@@ -2672,6 +2673,7 @@ static void arm_host_initfn(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
     }
+    kvm_arm_add_vcpu_properties(obj);
     arm_cpu_post_init(obj);
 }
=20
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 68baf0482ffa..c9a657a178ce 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -620,6 +620,7 @@ static void aarch64_max_initfn(Object *obj)
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
+        kvm_arm_add_vcpu_properties(obj);
     } else {
         uint64_t t;
         uint32_t u;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 373b868dc248..35160e8d0525 100644
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
@@ -179,6 +181,31 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features =3D arm_host_cpu_features.features;
 }
=20
+static bool kvm_adjvtime_get(Object *obj, Error **errp)
+{
+    return ARM_CPU(obj)->kvm_adjvtime;
+}
+
+static void kvm_adjvtime_set(Object *obj, bool value, Error **errp)
+{
+    ARM_CPU(obj)->kvm_adjvtime =3D value;
+}
+
+/* KVM VCPU properties should be prefixed with "kvm-". */
+void kvm_arm_add_vcpu_properties(Object *obj)
+{
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    object_property_add_bool(obj, "kvm-adjvtime", kvm_adjvtime_get,
+                             kvm_adjvtime_set, &error_abort);
+    object_property_set_description(obj, "kvm-adjvtime",
+                                    "Set on to enable the adjustment of =
"
+                                    "the virtual counter. VM stopped tim=
e "
+                                    "will not be counted.", &error_abort=
);
+}
+
 bool kvm_arm_pmu_supported(CPUState *cpu)
 {
     KVMState *s =3D KVM_STATE(current_machine->accelerator);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 3bb7e331aa06..a5429bfc0dbf 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -232,6 +232,15 @@ void kvm_arm_sve_get_vls(CPUState *cs, unsigned long=
 *map);
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
  * void kvm_arm_set_virtual_time:
  * @cs: CPUState
@@ -311,6 +320,8 @@ static inline void kvm_arm_set_cpu_features_from_host=
(ARMCPU *cpu)
     cpu->host_cpu_probe_failed =3D true;
 }
=20
+static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
+
 static inline bool kvm_arm_aarch32_supported(CPUState *cs)
 {
     return false;
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index fa054f8a369c..d9b2d94ac3fa 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -103,6 +103,7 @@ static const char *cpu_model_advertised_features[] =3D=
 {
     "sve128", "sve256", "sve384", "sve512",
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
+    "kvm-adjvtime",
     NULL
 };
=20
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index ee444b04010f..c207a2bec9e9 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -417,6 +417,8 @@ static void test_query_cpu_model_expansion(const void=
 *data)
     assert_has_feature_enabled(qts, "cortex-a15", "pmu");
     assert_has_not_feature(qts, "cortex-a15", "aarch64");
=20
+    assert_has_not_feature(qts, "max", "kvm-adjvtime");
+
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature_enabled(qts, "max", "aarch64");
         assert_has_feature_enabled(qts, "max", "sve");
@@ -445,6 +447,8 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
=20
     assert_has_feature_enabled(qts, "host", "pmu");
=20
+    assert_has_feature_disabled(qts, "host", "kvm-adjvtime");
+
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
         char max_name[8], name[8];
--=20
2.21.0


