Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D819CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA25C2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HL+6TnT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA25C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQBuz-0007RQ-Ss
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iQBgg-0005FQ-Mm
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iQBgd-0007pk-1n
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:44:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iQBgA-0007PY-S9
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572533041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aRicQGQeeR0NRsMiufZBZ+3m5FnR4gDww1lsLI4DgM=;
 b=HL+6TnT1oCm5A+/67AzWq0KehKRjsK7K91p5Ple+wAiPIYQfQOlgQALx0nDXeU3teI2ujl
 QUNZSAoQk7b2TqoIUuX7mFtA1DbIdJsqPy/Bj5hqbPVL1ySihGY7Npbnj5H2mZhh5Gqi6W
 wcgDHs7I8PAQyKYiHjQMu5UYhieHsLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-P7rZWGESPG-exBBU2NWLlw-1; Thu, 31 Oct 2019 10:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6671800D49;
 Thu, 31 Oct 2019 14:37:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-117-53.ams2.redhat.com
 [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 679D260870;
 Thu, 31 Oct 2019 14:36:55 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v8 9/9] target/arm/kvm: host cpu: Add support for sve<N>
 properties
Date: Thu, 31 Oct 2019 15:27:34 +0100
Message-Id: <20191031142734.8590-10-drjones@redhat.com>
In-Reply-To: <20191031142734.8590-1-drjones@redhat.com>
References: <20191031142734.8590-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: P7rZWGESPG-exBBU2NWLlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: m.mizuma@jp.fujitsu.com, beata.michalska@linaro.org,
 richard.henderson@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
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
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 docs/arm-cpu-features.rst | 19 ++++++++++++-------
 target/arm/cpu.c          |  3 +++
 target/arm/cpu.h          |  2 ++
 target/arm/cpu64.c        | 33 +++++++++++++++++----------------
 target/arm/kvm64.c        | 14 +++++++++++++-
 tests/arm-cpu-features.c  | 17 ++++++++---------
 6 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index bed218d44619..1b367e22e16e 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -272,31 +272,36 @@ SVE CPU Property Examples
=20
      $ qemu-system-aarch64 -M virt -cpu max
=20
-  3) Only enable the 128-bit vector length::
+  3) When KVM is enabled, implicitly enable all host CPU supported vector
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
      $ qemu-system-aarch64 -M virt -cpu max,sve128=3Don,sve256=3Don,sve512=
=3Don
=20
-  6) The same as (5), but since the 128-bit and 256-bit vector
+  7) The same as (6), but since the 128-bit and 256-bit vector
      lengths are required for the 512-bit vector length to be enabled,
      then allow them to be auto-enabled::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve512=3Don
=20
-  7) Do the same as (6), but by first disabling SVE and then re-enabling i=
t::
+  8) Do the same as (7), but by first disabling SVE and then re-enabling i=
t::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve=3Doff,sve512=3Don,sve=3Don
=20
-  8) Force errors regarding the last vector length::
+  9) Force errors regarding the last vector length::
=20
      $ qemu-system-aarch64 -M virt -cpu max,sve128=3Doff
      $ qemu-system-aarch64 -M virt -cpu max,sve=3Doff,sve128=3Doff,sve=3Do=
n
@@ -308,5 +313,5 @@ The examples in "SVE CPU Property Examples" exhibit man=
y ways to select
 vector lengths which developers may find useful in order to avoid overly
 verbose command lines.  However, the recommended way to select vector
 lengths is to explicitly enable each desired length.  Therefore only
-example's (1), (3), and (5) exhibit recommended uses of the properties.
+example's (1), (4), and (6) exhibit recommended uses of the properties.
=20
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 17d1f2b2894d..7a4ac9339bf9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2670,6 +2670,9 @@ static void arm_host_initfn(Object *obj)
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
index a044d6028b6a..e1a66a2d1cc0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -977,11 +977,13 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, uin=
t8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
+void aarch64_add_sve_properties(Object *obj);
 #else
 static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { =
}
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
@@ -594,6 +594,21 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, c=
onst char *name,
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
+                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
+    }
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this ho=
st);
  * otherwise, a CPU with as many features enabled as our emulation support=
s.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -602,17 +617,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, =
const char *name,
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
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_v=
q,
                         cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
-
-    for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
-        char name[8];
-        sprintf(name, "sve%d", vq * 128);
-        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
-                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
-    }
 }
=20
 struct ARMCPUInfo {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c93bbee425ae..876184b8fe4d 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -488,7 +488,9 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *=
ahcf)
      * and then query that CPU for the relevant ID registers.
      */
     int fdarray[3];
+    bool sve_supported;
     uint64_t features =3D 0;
+    uint64_t t;
     int err;
=20
     /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
@@ -578,13 +580,23 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures=
 *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
     }
=20
+    sve_supported =3D ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_S=
VE) > 0;
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
index 40d8395b7f75..b132ed09806d 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -458,8 +458,8 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
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
@@ -470,7 +470,7 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
             sprintf(max_name, "sve%d", max_vq * 128);
=20
             /* Enabling a supported length is of course fine. */
-            assert_sve_vls(qts, "max", vls, "{ %s: true }", max_name);
+            assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
=20
             /* Get the next supported length smaller than max-vq. */
             vq =3D 64 - __builtin_clzll(vls & ~BIT_ULL(max_vq - 1));
@@ -479,7 +479,7 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
                  * We have at least one length smaller than max-vq,
                  * so we can disable max-vq.
                  */
-                assert_sve_vls(qts, "max", (vls & ~BIT_ULL(max_vq - 1)),
+                assert_sve_vls(qts, "host", (vls & ~BIT_ULL(max_vq - 1)),
                                "{ %s: false }", max_name);
=20
                 /*
@@ -489,7 +489,7 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
                  */
                 sprintf(name, "sve%d", vq * 128);
                 error =3D g_strdup_printf("cannot disable %s", name);
-                assert_error(qts, "max", error,
+                assert_error(qts, "host", error,
                              "{ %s: true, %s: false }",
                              max_name, name);
                 g_free(error);
@@ -502,7 +502,7 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
             vq =3D __builtin_ffsll(vls);
             sprintf(name, "sve%d", vq * 128);
             error =3D g_strdup_printf("cannot disable %s", name);
-            assert_error(qts, "max", error, "{ %s: false }", name);
+            assert_error(qts, "host", error, "{ %s: false }", name);
             g_free(error);
=20
             /* Get an unsupported length. */
@@ -514,7 +514,7 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
             if (vq <=3D SVE_MAX_VQ) {
                 sprintf(name, "sve%d", vq * 128);
                 error =3D g_strdup_printf("cannot enable %s", name);
-                assert_error(qts, "max", error, "{ %s: true }", name);
+                assert_error(qts, "host", error, "{ %s: true }", name);
                 g_free(error);
             }
         } else {
@@ -523,8 +523,7 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
     } else {
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
-
-        assert_has_not_feature(qts, "max", "sve");
+        assert_has_not_feature(qts, "host", "sve");
     }
=20
     qtest_quit(qts);
--=20
2.21.0


