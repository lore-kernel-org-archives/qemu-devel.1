Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F07C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ED32168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ED32168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKfIy-0000vI-P1
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iKf5A-0002RL-VK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iKf59-0006Ee-30
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:55:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iKf52-0006D9-Te; Wed, 16 Oct 2019 04:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED0FB189F446;
 Wed, 16 Oct 2019 08:54:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 965755D9CD;
 Wed, 16 Oct 2019 08:54:38 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v6 9/9] target/arm/kvm: host cpu: Add support for sve<N>
 properties
Date: Wed, 16 Oct 2019 10:54:08 +0200
Message-Id: <20191016085408.24360-10-drjones@redhat.com>
In-Reply-To: <20191016085408.24360-1-drjones@redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 16 Oct 2019 08:54:49 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 eric.auger@redhat.com, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow cpu 'host' to enable SVE when it's available, unless the
user chooses to disable it with the added 'sve=3Doff' cpu property.
Also give the user the ability to select vector lengths with the
sve<N> properties. We don't adopt 'max' cpu's other sve property,
sve-max-vq, because that property is difficult to use with KVM.
That property assumes all vector lengths in the range from 1 up
to and including the specified maximum length are supported, but
there may be optional lengths not supported by the host in that
range. With KVM one must be more specific when enabling vector
lengths.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/arm-cpu-features.rst | 19 ++++++++++++-------
 target/arm/cpu.c          |  3 +++
 target/arm/cpu.h          |  2 ++
 target/arm/cpu64.c        | 33 +++++++++++++++++----------------
 target/arm/kvm64.c        | 14 +++++++++++++-
 tests/arm-cpu-features.c  | 21 +++++++++++----------
 6 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index bed218d44619..1b367e22e16e 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -272,31 +272,36 @@ SVE CPU Property Examples
=20
      $ qemu-system-aarch64 -M virt -cpu max
=20
-  3) Only enable the 128-bit vector length::
+  3) When KVM is enabled, implicitly enable all host CPU supported vecto=
r
+     lengths with the `host` CPU type::
+
+     $ qemu-system-aarch64 -M virt,accel=3Dkvm -cpu host
+
+  4) Only enable the 128-bit vector length::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve128=3Don
=20
-  4) Disable the 512-bit vector length and all larger vector lengths,
+  5) Disable the 512-bit vector length and all larger vector lengths,
      since 512 is a power-of-two.  This results in all the smaller,
      uninitialized lengths (128, 256, and 384) defaulting to enabled::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve512=3Doff
=20
-  5) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
+  6) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve128=3Don,sve256=3Don,sve5=
12=3Don
=20
-  6) The same as (5), but since the 128-bit and 256-bit vector
+  7) The same as (6), but since the 128-bit and 256-bit vector
      lengths are required for the 512-bit vector length to be enabled,
      then allow them to be auto-enabled::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve512=3Don
=20
-  7) Do the same as (6), but by first disabling SVE and then re-enabling=
 it::
+  8) Do the same as (7), but by first disabling SVE and then re-enabling=
 it::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve=3Doff,sve512=3Don,sve=3D=
on
=20
-  8) Force errors regarding the last vector length::
+  9) Force errors regarding the last vector length::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve128=3Doff
      $ qemu-system-aarch64 -M virt -cpu max,sve=3Doff,sve128=3Doff,sve=3D=
on
@@ -308,5 +313,5 @@ The examples in "SVE CPU Property Examples" exhibit m=
any ways to select
 vector lengths which developers may find useful in order to avoid overly
 verbose command lines.  However, the recommended way to select vector
 lengths is to explicitly enable each desired length.  Therefore only
-example's (1), (3), and (5) exhibit recommended uses of the properties.
+example's (1), (4), and (6) exhibit recommended uses of the properties.
=20
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 48c18871f6ea..0c4465880ddd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2669,6 +2669,9 @@ static void arm_host_initfn(Object *obj)
     ARMCPU *cpu =3D ARM_CPU(obj);
=20
     kvm_arm_set_cpu_features_from_host(cpu);
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        aarch64_add_sve_properties(obj);
+    }
     arm_cpu_post_init(obj);
 }
=20
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 11162484465a..5b9c3e4cd73d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -974,11 +974,13 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, u=
int8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
+void aarch64_add_sve_properties(Object *obj);
 #else
 static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) =
{ }
 static inline void aarch64_sve_change_el(CPUARMState *env, int o,
                                          int n, bool a)
 { }
+static inline void aarch64_add_sve_properties(Object *obj) { }
 #endif
=20
 #if !defined(CONFIG_TCG)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c161a146ff0d..68baf0482ffa 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -594,6 +594,21 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v,=
 const char *name,
     cpu->isar.id_aa64pfr0 =3D t;
 }
=20
+void aarch64_add_sve_properties(Object *obj)
+{
+    uint32_t vq;
+
+    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
+                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
+
+    for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
+        char name[8];
+        sprintf(name, "sve%d", vq * 128);
+        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
+                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal=
);
+    }
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
  * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -602,17 +617,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v=
, const char *name,
 static void aarch64_max_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
-    uint32_t vq;
-    uint64_t t;
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        if (kvm_arm_sve_supported(CPU(cpu))) {
-            t =3D cpu->isar.id_aa64pfr0;
-            t =3D FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
-            cpu->isar.id_aa64pfr0 =3D t;
-        }
     } else {
+        uint64_t t;
         uint32_t u;
         aarch64_a57_initfn(obj);
=20
@@ -712,17 +721,9 @@ static void aarch64_max_initfn(Object *obj)
 #endif
     }
=20
-    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
-                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
+    aarch64_add_sve_properties(obj);
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max=
_vq,
                         cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal=
);
-
-    for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
-        char name[8];
-        sprintf(name, "sve%d", vq * 128);
-        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
-                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal=
);
-    }
 }
=20
 struct ARMCPUInfo {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c93bbee425ae..876184b8fe4d 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -488,7 +488,9 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures=
 *ahcf)
      * and then query that CPU for the relevant ID registers.
      */
     int fdarray[3];
+    bool sve_supported;
     uint64_t features =3D 0;
+    uint64_t t;
     int err;
=20
     /* Old kernels may not know about the PREFERRED_TARGET ioctl: howeve=
r
@@ -578,13 +580,23 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatur=
es *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
     }
=20
+    sve_supported =3D ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM=
_SVE) > 0;
+
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
=20
     if (err < 0) {
         return false;
     }
=20
-   /* We can assume any KVM supporting CPU is at least a v8
+    /* Add feature bits that can't appear until after VCPU init. */
+    if (sve_supported) {
+        t =3D ahcf->isar.id_aa64pfr0;
+        t =3D FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
+        ahcf->isar.id_aa64pfr0 =3D t;
+    }
+
+    /*
+     * We can assume any KVM supporting CPU is at least a v8
      * with VFPv4+Neon; this in turn implies most of the other
      * feature bits.
      */
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 61694e2f8e0c..92668efb8f56 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -356,7 +356,7 @@ static void sve_tests_sve_off_kvm(const void *data)
 {
     QTestState *qts;
=20
-    qts =3D qtest_init(MACHINE "-accel kvm -cpu max,sve=3Doff");
+    qts =3D qtest_init(MACHINE "-accel kvm -cpu host,sve=3Doff");
=20
     /*
      * We don't know if this host supports SVE so we don't
@@ -365,8 +365,8 @@ static void sve_tests_sve_off_kvm(const void *data)
      * and that using sve<N>=3Doff to explicitly disable vector
      * lengths is OK too.
      */
-    assert_sve_vls(qts, "max", 0, NULL);
-    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
+    assert_sve_vls(qts, "host", 0, NULL);
+    assert_sve_vls(qts, "host", 0, "{ 'sve128': false }");
=20
     qtest_quit(qts);
 }
@@ -433,8 +433,8 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
             "We cannot guarantee the CPU type 'cortex-a15' works "
             "with KVM on this host", NULL);
=20
-        assert_has_feature(qts, "max", "sve");
-        resp =3D do_query_no_props(qts, "max");
+        assert_has_feature(qts, "host", "sve");
+        resp =3D do_query_no_props(qts, "host");
         kvm_supports_sve =3D resp_get_feature(resp, "sve");
         vls =3D resp_get_sve_vls(resp);
         qobject_unref(resp);
@@ -445,7 +445,7 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
             sprintf(max_name, "sve%d", max_vq * 128);
=20
             /* Enabling a supported length is of course fine. */
-            assert_sve_vls(qts, "max", vls, "{ %s: true }", max_name);
+            assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
=20
             /* Get the next supported length smaller than max-vq. */
             vq =3D 64 - __builtin_clzll(vls & ~BIT_ULL(max_vq - 1));
@@ -454,7 +454,7 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
                  * We have at least one length smaller than max-vq,
                  * so we can disable max-vq.
                  */
-                assert_sve_vls(qts, "max", (vls & ~BIT_ULL(max_vq - 1)),
+                assert_sve_vls(qts, "host", (vls & ~BIT_ULL(max_vq - 1))=
,
                                "{ %s: false }", max_name);
=20
                 /*
@@ -464,7 +464,7 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
                  */
                 sprintf(name, "sve%d", vq * 128);
                 error =3D g_strdup_printf("cannot disable %s", name);
-                assert_error(qts, "max", error,
+                assert_error(qts, "host", error,
                              "{ %s: true, %s: false }",
                              max_name, name);
                 g_free(error);
@@ -477,7 +477,7 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
             vq =3D __builtin_ffsll(vls);
             sprintf(name, "sve%d", vq * 128);
             error =3D g_strdup_printf("cannot disable %s", name);
-            assert_error(qts, "max", error, "{ %s: false }", name);
+            assert_error(qts, "host", error, "{ %s: false }", name);
             g_free(error);
=20
             /* Get an unsupported length. */
@@ -489,13 +489,14 @@ static void test_query_cpu_model_expansion_kvm(cons=
t void *data)
             if (vq <=3D SVE_MAX_VQ) {
                 sprintf(name, "sve%d", vq * 128);
                 error =3D g_strdup_printf("cannot enable %s", name);
-                assert_error(qts, "max", error, "{ %s: true }", name);
+                assert_error(qts, "host", error, "{ %s: true }", name);
                 g_free(error);
             }
         } else {
             g_assert(vls =3D=3D 0);
         }
     } else {
+        assert_has_not_feature(qts, "host", "sve");
         assert_error(qts, "host",
                      "'pmu' feature not supported by KVM on this host",
                      "{ 'pmu': true }");
--=20
2.21.0


