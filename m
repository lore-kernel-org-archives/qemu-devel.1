Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0292EC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDB7216C8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDB7216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htWgP-0003vu-4M
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 08:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37800)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1htWdm-0005On-No
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1htWdl-0001xr-EN
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1htWda-0001s2-0A; Fri, 02 Aug 2019 08:26:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A56F882F2;
 Fri,  2 Aug 2019 12:26:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 453BC5C205;
 Fri,  2 Aug 2019 12:26:17 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri,  2 Aug 2019 14:25:32 +0200
Message-Id: <20190802122540.26385-8-drjones@redhat.com>
In-Reply-To: <20190802122540.26385-1-drjones@redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 02 Aug 2019 12:26:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 07/15] target/arm: Allow SVE to be disabled
 via a CPU property
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

Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
a CPU property") we can disable the 'max' cpu model's VFP and neon
features, but there's no way to disable SVE. Add the 'sve=3Don|off'
property to give it that flexibility. We also rename
cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
to follow the typical *_get/set_<property-name> pattern.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.c         |  3 ++-
 target/arm/cpu64.c       | 42 ++++++++++++++++++++++++++++++++++------
 target/arm/monitor.c     |  2 +-
 tests/arm-cpu-features.c |  1 +
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8b86ce478fc0..930f4579ccae 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -200,7 +200,8 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.cpacr_el1 =3D deposit64(env->cp15.cpacr_el1, 16, 2, 3)=
;
         env->cp15.cptr_el[3] |=3D CPTR_EZ;
         /* with maximum vector length */
-        env->vfp.zcr_el[1] =3D cpu->sve_max_vq - 1;
+        env->vfp.zcr_el[1] =3D cpu_isar_feature(aa64_sve, cpu) ?
+                             cpu->sve_max_vq - 1 : 0;
         env->vfp.zcr_el[2] =3D env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] =3D env->vfp.zcr_el[1];
         /*
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 946994838d8a..e470c34f89ac 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -257,15 +257,15 @@ static void aarch64_a72_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
 }
=20
-static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name=
,
-                               void *opaque, Error **errp)
+static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *=
name,
+                                   void *opaque, Error **errp)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
     visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
 }
=20
-static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name=
,
-                               void *opaque, Error **errp)
+static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *=
name,
+                                   void *opaque, Error **errp)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
     Error *err =3D NULL;
@@ -280,6 +280,34 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor =
*v, const char *name,
     error_propagate(errp, err);
 }
=20
+static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    bool value =3D cpu_isar_feature(aa64_sve, cpu);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    Error *err =3D NULL;
+    bool value;
+    uint64_t t;
+
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    t =3D cpu->isar.id_aa64pfr0;
+    t =3D FIELD_DP64(t, ID_AA64PFR0, SVE, value);
+    cpu->isar.id_aa64pfr0 =3D t;
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
  * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -373,8 +401,10 @@ static void aarch64_max_initfn(Object *obj)
 #endif
=20
         cpu->sve_max_vq =3D ARM_MAX_VQ;
-        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve=
_vq,
-                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal=
);
+        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve=
_max_vq,
+                            cpu_max_set_sve_max_vq, NULL, NULL, &error_f=
atal);
+        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
+                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
     }
 }
=20
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 96ada22d9cc7..36a86cb83ce5 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -91,7 +91,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **e=
rrp)
 }
=20
 static const char *cpu_model_advertised_features[] =3D {
-    "aarch64", "pmu",
+    "aarch64", "pmu", "sve",
     NULL
 };
=20
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 198ff6d6b495..202bc0e3e823 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -179,6 +179,7 @@ static void test_query_cpu_model_expansion(const void=
 *data)
=20
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature(qts, "max", "aarch64");
+        assert_has_feature(qts, "max", "sve");
         assert_has_feature(qts, "cortex-a57", "pmu");
         assert_has_feature(qts, "cortex-a57", "aarch64");
=20
--=20
2.20.1


