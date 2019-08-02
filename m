Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F76C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D0021841
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D0021841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htWk4-0000yU-E5
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 08:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1htWe7-0006Uw-AV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1htWe4-00029Z-BS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:26:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1htWdy-00026N-DT; Fri, 02 Aug 2019 08:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB93181F07;
 Fri,  2 Aug 2019 12:26:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4451F5C205;
 Fri,  2 Aug 2019 12:26:41 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri,  2 Aug 2019 14:25:39 +0200
Message-Id: <20190802122540.26385-15-drjones@redhat.com>
In-Reply-To: <20190802122540.26385-1-drjones@redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 02 Aug 2019 12:26:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 14/15] target/arm/cpu64: max cpu: Support
 sve properties with KVM
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

Extend the SVE vq map initialization and validation with KVM's
supported vector lengths when KVM is enabled. In order to determine
and select supported lengths we add two new KVM functions for getting
and setting the KVM_REG_ARM64_SVE_VLS pseudo-register.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 docs/arm-cpu-features.rst |  36 ++++++---
 target/arm/cpu.h          |   3 +-
 target/arm/cpu64.c        | 159 +++++++++++++++++++++++++++++---------
 target/arm/kvm64.c        | 110 +++++++++++++++++++++++++-
 target/arm/kvm_arm.h      |  12 +++
 target/arm/monitor.c      |   2 +-
 tests/arm-cpu-features.c  |  89 ++++++++++++++++++++-
 7 files changed, 359 insertions(+), 52 deletions(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index aaaed861cda2..4181539e06a5 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -188,10 +188,17 @@ SVE CPU Property Dependencies and Constraints
=20
   1) At least one vector length must be enabled when `sve` is enabled.
=20
-  2) If a vector length `N` is enabled, then all power-of-2 vector
-     lengths smaller than `N` must also be enabled.  E.g. if `sve512`
-     is enabled, then `sve128` and `sve256` must also be enabled,
-     but `sve384` is not required.
+  2) If a vector length `N` is enabled, then, when KVM is enabled, all
+     smaller, host supported vector lengths must also be enabled.  If
+     KVM is not enabled, then only all the smaller, power-of-2 vector
+     lengths must be enabled.  E.g. with KVM if the host supports all
+     vector lengths up to 512-bits (128, 256, 384, 512), then if
+     `sve512` is enabled, `sve128`, `sve256`, and `sve384` must also
+     be enabled. Without KVM `sve384` would not be required.
+
+  3) If KVM is enabled then only vector lengths that the host CPU type
+     support may be enabled.  If SVE is not supported by the host, then
+     no `sve*` properties may be enabled.
=20
 SVE CPU Property Parsing Semantics
 ----------------------------------
@@ -210,20 +217,29 @@ SVE CPU Property Parsing Semantics
      disable the last enabled vector length (see constraint (1) of "SVE
      CPU Property Dependencies and Constraints").
=20
-  4) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N=
>`,
+  4) When KVM is enabled, if the host does not support SVE, then an erro=
r
+     is generated when attempting to enable any `sve*` properties.
+
+  5) When KVM is enabled, if the host does support SVE, then an error is
+     generated when attempting to enable any vector lengths not supporte=
d
+     by the host.
+
+  6) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N=
>`,
      CPU properties are set `on`, then the specified vector lengths are
      disabled but the default for any unspecified lengths remains enable=
d.
-     Disabling a power-of-2 vector length also disables all vector lengt=
hs
-     larger than the power-of-2 length (see constraint (2) of "SVE CPU
-     Property Dependencies and Constraints").
+     When KVM is not enabled, disabling a power-of-2 vector length also
+     disables all vector lengths larger than the power-of-2 length.  Whe=
n
+     KVM is enabled, then disabling any length also disables all larger
+     vector lengths (see constraint (2) of "SVE CPU Property Dependencie=
s
+     and Constraints").
=20
-  5) If one or more `sve<N>` CPU properties are set to `on`, then they
+  7) If one or more `sve<N>` CPU properties are set to `on`, then they
      are enabled and all unspecified lengths default to disabled, except
      for the required lengths per constraint (2) of "SVE CPU Property
      Dependencies and Constraints", which will even be auto-enabled if
      they were not explicitly enabled.
=20
-  6) If SVE was disabled (`sve=3Doff`), allowing all vector lengths to b=
e
+  8) If SVE was disabled (`sve=3Doff`), allowing all vector lengths to b=
e
      explicitly disabled (i.e. avoiding the error specified in (3) of
      "SVE CPU Property Parsing Semantics"), then if later an `sve=3Don` =
is
      provided an error will be generated.  To avoid this error, one must
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c8b96293c5e2..b6cd721c91f5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -926,7 +926,8 @@ struct ARMCPU {
      * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vect=
or
      * length in quadwords. We need a map size twice the maximum
      * quadword length though because we use two bits for each vector
-     * length in order to track three states: uninitialized, off, and on=
.
+     * length in order to track four states: uninitialized, uninitialize=
d
+     * but supported by KVM, off, and on.
      */
     DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ * 2);
 };
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f8ed393ed16c..0d0664b24865 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -261,13 +261,19 @@ static void aarch64_a72_initfn(Object *obj)
  * While we eventually use cpu->sve_vq_map as a typical bitmap, where ea=
ch vq
  * has only two states (off/on), until we've finalized the map at realiz=
e time
  * we use an extra bit, at the vq - 1 + ARM_MAX_VQ bit number, to also a=
llow
- * tracking of the uninitialized state. The arm_vq_state typedef and fol=
lowing
- * functions allow us to more easily work with the bitmap.
+ * tracking of the uninitialized state and the uninitialized but support=
ed by
+ * KVM state. The arm_vq_state typedef and following functions allow us =
to more
+ * easily work with the bitmap.
  */
 typedef enum arm_vq_state {
     ARM_VQ_OFF,
     ARM_VQ_ON,
     ARM_VQ_UNINITIALIZED,
+    ARM_VQ_UNINITIALIZED_KVM_SUPPORTED
+    /*
+     * More states cannot be added without adding bits to sve_vq_map
+     * and modifying its supporting functions.
+     */
 } arm_vq_state;
=20
 static arm_vq_state arm_cpu_vq_map_get(ARMCPU *cpu, uint32_t vq)
@@ -292,6 +298,22 @@ static void arm_cpu_vq_map_set(ARMCPU *cpu, uint32_t=
 vq, arm_vq_state state)
     }
 }
=20
+static bool arm_cpu_vq_kvm_supported(ARMCPU *cpu, uint32_t vq)
+{
+    return arm_cpu_vq_map_get(cpu, vq) !=3D ARM_VQ_UNINITIALIZED;
+}
+
+static bool arm_cpu_vq_uninitialized(ARMCPU *cpu, uint32_t vq)
+{
+    arm_vq_state vq_state =3D arm_cpu_vq_map_get(cpu, vq);
+
+    if (kvm_enabled()) {
+        return vq_state =3D=3D ARM_VQ_UNINITIALIZED_KVM_SUPPORTED;
+    }
+
+    return vq_state =3D=3D ARM_VQ_UNINITIALIZED;
+}
+
 /*
  * Uninitialized vector lengths need a default value to use in case we n=
eed
  * to query their value prior to map finalization. Additionally map fina=
lizing
@@ -341,11 +363,9 @@ static int arm_cpu_num_vqs_available(ARMCPU *cpu)
     defval =3D arm_cpu_vq_map_get_default(cpu);
=20
     for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
-        arm_vq_state vq_state =3D arm_cpu_vq_map_get(cpu, vq);
-
-        if (vq_state =3D=3D ARM_VQ_ON) {
+        if (arm_cpu_vq_map_get(cpu, vq) =3D=3D ARM_VQ_ON) {
             ++num;
-        } else if (defval && vq_state =3D=3D ARM_VQ_UNINITIALIZED) {
+        } else if (defval && arm_cpu_vq_uninitialized(cpu, vq)) {
             ++num;
         }
     }
@@ -358,6 +378,18 @@ static void arm_cpu_vq_map_init(ARMCPU *cpu)
     /* Set all vq's to 0b10 (ARM_VQ_UNINITIALIZED) */
     bitmap_clear(cpu->sve_vq_map, 0, ARM_MAX_VQ);
     bitmap_set(cpu->sve_vq_map, ARM_MAX_VQ, ARM_MAX_VQ);
+
+    if (kvm_enabled()) {
+        /*
+         * As the upper bits of the ARM_VQ_UNINITIALIZED_KVM_SUPPORTED (=
0b11)
+         * states have already been set with the bitmap_set() above, we =
only
+         * need to OR in the lower bits.
+         */
+        DECLARE_BITMAP(kvm_supported, ARM_MAX_VQ);
+
+        kvm_arm_sve_get_vls(CPU(cpu), kvm_supported);
+        bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, kvm_supported, ARM_M=
AX_VQ);
+    }
 }
=20
 void arm_cpu_sve_finalize(ARMCPU *cpu)
@@ -366,9 +398,9 @@ void arm_cpu_sve_finalize(ARMCPU *cpu)
     uint32_t vq, max_vq;
=20
     for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
-        arm_vq_state vq_state =3D arm_cpu_vq_map_get(cpu, vq);
-
-        if (vq_state =3D=3D ARM_VQ_UNINITIALIZED) {
+        if (kvm_enabled() && !arm_cpu_vq_kvm_supported(cpu, vq)) {
+            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
+        } else if (arm_cpu_vq_uninitialized(cpu, vq)) {
             if (defval) {
                 arm_cpu_vq_map_set(cpu, vq, ARM_VQ_ON);
             } else {
@@ -421,6 +453,12 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visi=
tor *v, const char *name,
         return;
     }
=20
+    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+        error_setg(errp, "cannot set sve-max-vq");
+        error_append_hint(errp, "SVE not supported by KVM on this host\n=
");
+        return;
+    }
+
     if (cpu->sve_max_vq =3D=3D 0 || cpu->sve_max_vq > ARM_MAX_VQ) {
         error_setg(errp, "unsupported SVE vector length");
         error_append_hint(errp, "Valid sve-max-vq in range [1-%d]\n",
@@ -435,6 +473,12 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visi=
tor *v, const char *name,
             sprintf(tmp, "sve%d", vq * 128);
             object_property_set_bool(obj, true, tmp, &err);
             if (err) {
+                if (kvm_enabled()) {
+                    error_append_hint(&err, "It is not possible to use "
+                                      "sve-max-vq with this KVM host. Tr=
y "
+                                      "using only sve<vl-bits> "
+                                      "properties.\n");
+                }
                 error_propagate(errp, err);
                 return;
             }
@@ -459,6 +503,8 @@ static void cpu_arm_get_sve_vq(Object *obj, Visitor *=
v, const char *name,
         value =3D true;
     } else if (vq_state =3D=3D ARM_VQ_OFF) {
         value =3D false;
+    } else if (kvm_enabled() && !arm_cpu_vq_kvm_supported(cpu, vq)) {
+        value =3D false;
     } else if (arm_cpu_vq_map_get_default(cpu)) {
         value =3D true;
     } else {
@@ -483,6 +529,12 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor =
*v, const char *name,
         return;
     }
=20
+    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+        error_setg(errp, "cannot enable %s", name);
+        error_append_hint(errp, "SVE not supported by KVM on this host\n=
");
+        return;
+    }
+
     /*
      * We need to know the maximum vector length, which may just current=
ly
      * be the maximum length, in order to validate the enabling/disablin=
g
@@ -507,69 +559,101 @@ static void cpu_arm_set_sve_vq(Object *obj, Visito=
r *v, const char *name,
         error_append_hint(errp, "The maximum vector length must be "
                           "enabled, sve-max-vq=3D%d (%d bits)\n",
                           cpu->sve_max_vq, cpu->sve_max_vq * 128);
-    } else if (cpu->sve_max_vq && !value && vq < cpu->sve_max_vq &&
-               is_power_of_2(vq)) {
+    } else if (!kvm_enabled() && cpu->sve_max_vq && !value &&
+               vq < cpu->sve_max_vq && is_power_of_2(vq)) {
         error_setg(errp, "cannot disable %s", name);
         error_append_hint(errp, "vq=3D%d (%d bits) is required as it is =
a "
                           "power-of-2 length smaller than the maximum, "
                           "sve-max-vq=3D%d (%d bits)\n", vq, vq * 128,
                           cpu->sve_max_vq, cpu->sve_max_vq * 128);
-    } else if (max_vq && !value && vq < max_vq && is_power_of_2(vq)) {
+    } else if (!kvm_enabled() && max_vq && !value && vq < max_vq &&
+               is_power_of_2(vq)) {
         error_setg(errp, "cannot disable %s", name);
         error_append_hint(errp, "Vector length %d-bits is required as it=
 "
                           "is a power-of-2 length smaller than another "
                           "enabled vector length. Disable all larger vec=
tor "
                           "lengths first.\n", vq * 128);
+    } else if (kvm_enabled() && !value && vq < max_vq &&
+                arm_cpu_vq_kvm_supported(cpu, vq)) {
+        error_setg(errp, "cannot disable %s", name);
+        error_append_hint(errp, "Vector length %d-bits is a KVM supporte=
d "
+                          "length smaller than another enabled vector "
+                          "length. Disable all larger vector lengths "
+                          "first.\n", vq * 128);
+    } else if (kvm_enabled() && value && !arm_cpu_vq_kvm_supported(cpu, =
vq)) {
+        error_setg(errp, "cannot enable %s", name);
+        error_append_hint(errp, "This KVM host does not support "
+                          "the vector length %d-bits.\n", vq * 128);
     } else {
         uint32_t s;
=20
         if (value) {
-            arm_vq_state vq_state;
             bool fail =3D false;
=20
             /*
              * Enabling a vector length automatically enables all
              * uninitialized power-of-2 lengths smaller than it, as
              * per the architecture.
+             *
+             * For KVM we have to automatically enable all supported,
+             * uninitialized lengths smaller than this length, even
+             * when the smaller lengths are not power-of-2's.
              */
             for (s =3D 1; s < vq; ++s) {
-                if (is_power_of_2(s)) {
-                    vq_state =3D arm_cpu_vq_map_get(cpu, s);
-                    if (vq_state =3D=3D ARM_VQ_UNINITIALIZED) {
+                if (kvm_enabled() || is_power_of_2(s)) {
+                    if (arm_cpu_vq_uninitialized(cpu, s)) {
                         arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
-                    } else if (vq_state =3D=3D ARM_VQ_OFF) {
+                    } else if (arm_cpu_vq_map_get(cpu, s) =3D=3D ARM_VQ_=
OFF) {
                         fail =3D true;
                         break;
                     }
                 }
             }
=20
-            if (fail) {
+            if (!kvm_enabled() && fail) {
                 error_setg(errp, "cannot enable %s", name);
                 error_append_hint(errp, "Vector length %d-bits is disabl=
ed "
                                   "and is a power-of-2 length smaller th=
an "
                                   "%s. All power-of-2 vector lengths sma=
ller "
                                   "than the maximum length are required.=
\n",
                                   s * 128, name);
+
+            } else if (fail) {
+                error_setg(errp, "cannot enable %s", name);
+                error_append_hint(errp, "Vector length %d-bits is disabl=
ed "
+                                  "and the KVM host requires all support=
ed "
+                                  "vector lengths smaller than %s to als=
o be "
+                                  "enabled.\n", s * 128, name);
             } else {
                 arm_cpu_vq_map_set(cpu, vq, ARM_VQ_ON);
             }
         } else {
             /*
+             * When disabling vector lengths with KVM enabled if the vq =
wasn't
+             * supported then we leave it in the ARM_VQ_UNINITIALIZED st=
ate in
+             * order to keep that unsupported information. It'll be set =
to OFF
+             * later when we finalize the map.
+             *
              * We would have errored-out already if we were attempting t=
o
              * disable a power-of-2 vector length less than another enab=
led
              * vector length, but there may be uninitialized vector leng=
ths
              * larger than a power-of-2 vector length that we're disabli=
ng.
              * We disable all of those lengths now too, as they can no l=
onger
-             * be enabled.
+             * be enabled. Additionally, for KVM, we have to automatical=
ly
+             * disable all supported, uninitialized lengths larger than =
this
+             * length, even when this length is not a power-of-2.
              */
-            if (is_power_of_2(vq)) {
+            if (kvm_enabled() || is_power_of_2(vq)) {
                 for (s =3D vq + 1; s <=3D ARM_MAX_VQ; ++s) {
-                    arm_cpu_vq_map_set(cpu, s, ARM_VQ_OFF);
+                    if (!kvm_enabled() || arm_cpu_vq_kvm_supported(cpu, =
vq)) {
+                        arm_cpu_vq_map_set(cpu, s, ARM_VQ_OFF);
+                    }
                 }
             }
=20
-            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
+            if (!kvm_enabled() || arm_cpu_vq_kvm_supported(cpu, vq)) {
+                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
+            }
=20
             /*
              * We just disabled one or more vector lengths. We need to m=
ake
@@ -727,26 +811,25 @@ static void aarch64_max_initfn(Object *obj)
         cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT=
 icache */
         cpu->dcz_blocksize =3D 7; /*  512 bytes */
 #endif
-
-        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve=
_max_vq,
-                            cpu_max_set_sve_max_vq, NULL, NULL, &error_f=
atal);
-
-        /*
-         * sve_vq_map uses a special state while setting properties, so
-         * we initialize it here with its init function and finalize it
-         * in arm_cpu_realizefn().
-         */
-        arm_cpu_vq_map_init(cpu);
-        for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
-            char name[8];
-            sprintf(name, "sve%d", vq * 128);
-            object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
-                                cpu_arm_set_sve_vq, NULL, NULL, &error_f=
atal);
-        }
     }
=20
     object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
                         cpu_arm_set_sve, NULL, NULL, &error_fatal);
+    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max=
_vq,
+                        cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal=
);
+
+    /*
+     * sve_vq_map uses a special state while setting properties, so
+     * we initialize it here with its init function and finalize it
+     * in arm_cpu_realizefn().
+     */
+    arm_cpu_vq_map_init(cpu);
+    for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
+        char name[8];
+        sprintf(name, "sve%d", vq * 128);
+        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
+                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal=
);
+    }
 }
=20
 struct ARMCPUInfo {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 48adfc16b3d7..f6e2389f9f29 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -613,6 +613,110 @@ bool kvm_arm_sve_supported(CPUState *cpu)
     return kvm_check_extension(s, KVM_CAP_ARM_SVE);
 }
=20
+QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN !=3D 1);
+
+void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)
+{
+    static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
+    static bool probed;
+    uint32_t vq =3D 0;
+    int i, j;
+
+    bitmap_clear(map, 0, ARM_MAX_VQ);
+
+    /*
+     * KVM ensures all host CPUs support the same set of vector lengths.
+     * So we only need to create the scratch VCPUs once and then cache
+     * the results.
+     */
+    if (!probed) {
+        struct kvm_vcpu_init init =3D {
+            .target =3D -1,
+            .features[0] =3D (1 << KVM_ARM_VCPU_SVE),
+        };
+        struct kvm_one_reg reg =3D {
+            .id =3D KVM_REG_ARM64_SVE_VLS,
+            .addr =3D (uint64_t)&vls[0],
+        };
+        int fdarray[3], ret;
+
+        probed =3D true;
+
+        if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
+            error_report("failed to create scratch vcpu");
+            abort();
+        }
+        ret =3D ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE);
+        kvm_arm_destroy_scratch_host_vcpu(fdarray);
+        if (ret <=3D 0) {
+            /* The host doesn't support SVE. */
+            return;
+        }
+
+        if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, &init)) {
+            error_report("failed to create scratch vcpu");
+            abort();
+        }
+        ret =3D ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
+        kvm_arm_destroy_scratch_host_vcpu(fdarray);
+        if (ret) {
+            error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
+                         strerror(errno));
+            abort();
+        }
+
+        for (i =3D KVM_ARM64_SVE_VLS_WORDS - 1; i >=3D 0; --i) {
+            if (vls[i]) {
+                vq =3D 64 - clz64(vls[i]) + i * 64;
+                break;
+            }
+        }
+        if (vq > ARM_MAX_VQ) {
+            warn_report("KVM supports vector lengths larger than "
+                        "QEMU can enable");
+        }
+    }
+
+    for (i =3D 0; i < KVM_ARM64_SVE_VLS_WORDS; ++i) {
+        if (!vls[i]) {
+            continue;
+        }
+        for (j =3D 1; j <=3D 64; ++j) {
+            vq =3D j + i * 64;
+            if (vq > ARM_MAX_VQ) {
+                return;
+            }
+            if (vls[i] & (1UL << (j - 1))) {
+                set_bit(vq - 1, map);
+            }
+        }
+    }
+}
+
+static int kvm_arm_sve_set_vls(CPUState *cs)
+{
+    uint64_t vls[KVM_ARM64_SVE_VLS_WORDS] =3D {0};
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM64_SVE_VLS,
+        .addr =3D (uint64_t)&vls[0],
+    };
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    uint32_t vq;
+    int i, j;
+
+    assert(cpu->sve_max_vq <=3D KVM_ARM64_SVE_VQ_MAX);
+
+    for (vq =3D 1; vq <=3D cpu->sve_max_vq; ++vq) {
+        if (test_bit(vq - 1, cpu->sve_vq_map)) {
+            i =3D (vq - 1) / 64;
+            j =3D (vq - 1) % 64;
+            vls[i] |=3D 1UL << j;
+        }
+    }
+
+    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+}
+
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
=20
 int kvm_arch_init_vcpu(CPUState *cs)
@@ -624,7 +728,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
=20
     if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_NONE ||
         !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
-        fprintf(stderr, "KVM is not supported for this guest CPU type\n"=
);
+        error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
=20
@@ -660,6 +764,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
=20
     if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret =3D kvm_arm_sve_set_vls(cs);
+        if (ret) {
+            return ret;
+        }
         ret =3D kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
         if (ret) {
             return ret;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 1151877f97ea..a1cc6513f72b 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -212,6 +212,17 @@ typedef struct ARMHostCPUFeatures {
  */
 bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
=20
+/**
+ * kvm_arm_sve_get_vls:
+ * @cs: CPUState
+ * @map: bitmap to fill in
+ *
+ * Get all the SVE vector lengths supported by the KVM host, setting
+ * the bits corresponding to their length in quadwords minus one
+ * (vq - 1) in @map up to ARM_MAX_VQ.
+ */
+void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map);
+
 /**
  * kvm_arm_set_cpu_features_from_host:
  * @cpu: ARMCPU to set the features for
@@ -315,6 +326,7 @@ static inline int kvm_arm_vgic_probe(void)
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
=20
+static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)=
 {}
 #endif
=20
 static inline const char *gic_class_name(void)
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index f7099917e137..e2d559c2301a 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -101,7 +101,7 @@ QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
  *
  * The sve<vl-bits> features need to be in reverse order in order to
  * enable/disable the largest vector lengths first, ensuring all
- * power-of-2 vector lengths smaller can also be enabled/disabled.
+ * smaller required vector lengths can also be enabled/disabled.
  */
 static const char *cpu_model_advertised_features[] =3D {
     "aarch64", "pmu", "sve",
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 51fbb1739d8e..720741375bc8 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -117,6 +117,17 @@ static QDict *resp_get_props(QDict *resp)
     return qdict;
 }
=20
+static bool resp_get_feature(QDict *resp, const char *feature)
+{
+    QDict *props;
+
+    g_assert(resp);
+    g_assert(resp_has_props(resp));
+    props =3D resp_get_props(resp);
+    g_assert(qdict_get(props, feature));
+    return qdict_get_bool(props, feature);
+}
+
 #define assert_has_feature(qts, cpu_type, feature)                     \
 ({                                                                     \
     QDict *_resp =3D do_query_no_props(qts, cpu_type);                  =
 \
@@ -344,6 +355,25 @@ static void sve_tests_sve_off(const void *data)
     qtest_quit(qts);
 }
=20
+static void sve_tests_sve_off_kvm(const void *data)
+{
+    QTestState *qts;
+
+    qts =3D qtest_init(MACHINE "-accel kvm -cpu max,sve=3Doff");
+
+    /*
+     * We don't know if this host supports SVE so we don't
+     * attempt to test enabling anything. We only test that
+     * everything is disabled (as it should be with sve=3Doff)
+     * and that using sve<vl-bits>=3Doff to explicitly disable
+     * vector lengths is OK too.
+     */
+    assert_sve_vls(qts, "max", 0, NULL);
+    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
+
+    qtest_quit(qts);
+}
+
 static void test_query_cpu_model_expansion(const void *data)
 {
     QTestState *qts;
@@ -393,12 +423,65 @@ static void test_query_cpu_model_expansion_kvm(cons=
t void *data)
     assert_has_feature(qts, "host", "pmu");
=20
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        bool kvm_supports_sve;
+        uint32_t max_vq, vq;
+        uint64_t vls;
+        char name[8];
+        QDict *resp;
+        char *error;
+
         assert_has_feature(qts, "host", "aarch64");
-        assert_has_feature(qts, "max", "sve");
=20
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
             "with KVM on this host", NULL);
+
+        assert_has_feature(qts, "max", "sve");
+        resp =3D do_query_no_props(qts, "max");
+        kvm_supports_sve =3D resp_get_feature(resp, "sve");
+        vls =3D resp_get_sve_vls(resp);
+        qobject_unref(resp);
+
+        if (kvm_supports_sve) {
+            g_assert(vls !=3D 0);
+            max_vq =3D 64 - __builtin_clzll(vls);
+
+            /* Enabling a supported length is of course fine. */
+            sprintf(name, "sve%d", max_vq * 128);
+            assert_sve_vls(qts, "max", vls, "{ %s: true }", name);
+
+            /* Also disabling the largest lengths is fine. */
+            assert_sve_vls(qts, "max", (vls & ~BIT(max_vq - 1)),
+                           "{ %s: false }", name);
+
+            for (vq =3D 1; vq <=3D max_vq; ++vq) {
+                if (!(vls & BIT(vq - 1))) {
+                    /* vq is unsupported */
+                    break;
+                }
+            }
+            if (vq <=3D SVE_MAX_VQ) {
+                sprintf(name, "sve%d", vq * 128);
+                error =3D g_strdup_printf("cannot enable %s", name);
+                assert_error(qts, "max", error, "{ %s: true }", name);
+                g_free(error);
+            }
+
+            if (max_vq > 1) {
+                /*
+                 * Smaller, supported vector lengths cannot be disabled
+                 * unless all larger, supported vector lengths are disab=
led
+                 * first.
+                 */
+                vq =3D 64 - __builtin_clzll(vls & ~BIT(max_vq - 1));
+                sprintf(name, "sve%d", vq * 128);
+                error =3D g_strdup_printf("cannot disable %s", name);
+                assert_error(qts, "max", error, "{ %s: false }", name);
+                g_free(error);
+            }
+        } else {
+            g_assert(vls =3D=3D 0);
+        }
     } else {
         assert_error(qts, "host",
                      "'pmu' feature not supported by KVM on this host",
@@ -435,6 +518,10 @@ int main(int argc, char **argv)
     if (kvm_available) {
         qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
                             NULL, test_query_cpu_model_expansion_kvm);
+        if (g_str_equal(qtest_get_arch(), "aarch64")) {
+            qtest_add_data_func("/arm/kvm/query-cpu-model-expansion/sve-=
off",
+                                NULL, sve_tests_sve_off_kvm);
+        }
     }
=20
     return g_test_run();
--=20
2.20.1


