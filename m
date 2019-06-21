Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91325C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B79620665
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B79620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMiT-0004kf-Eq
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1heMVv-0002Fb-Ax
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1heMVr-0002mL-FV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1heMVf-0002DR-43; Fri, 21 Jun 2019 12:35:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 54205301EA82;
 Fri, 21 Jun 2019 16:35:28 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7BA1001DDE;
 Fri, 21 Jun 2019 16:35:26 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri, 21 Jun 2019 18:34:21 +0200
Message-Id: <20190621163422.6127-14-drjones@redhat.com>
In-Reply-To: <20190621163422.6127-1-drjones@redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 21 Jun 2019 16:35:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 13/14] target/arm/cpu64: max cpu: Support
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
 target/arm/cpu.h         |   3 +-
 target/arm/cpu64.c       | 171 +++++++++++++++++++++++++++------------
 target/arm/kvm64.c       | 117 +++++++++++++++++++++++++--
 target/arm/kvm_arm.h     |  19 +++++
 target/arm/monitor.c     |   2 +-
 tests/arm-cpu-features.c |  86 +++++++++++++++++---
 6 files changed, 331 insertions(+), 67 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cbb155cf72a5..8a1c6c66a462 100644
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
index 2e595ad53137..6e92aa54b9c8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -261,10 +261,11 @@ static void aarch64_a72_initfn(Object *obj)
  * While we eventually use cpu->sve_vq_map as a typical bitmap, where ea=
ch vq
  * has only two states (off/on), until we've finalized the map at realiz=
e time
  * we use an extra bit, at the vq - 1 + ARM_MAX_VQ bit number, to also a=
llow
- * tracking of the uninitialized state. The arm_vq_state typedef and fol=
lowing
- * functions allow us to more easily work with the bitmap. Also, while t=
he map
- * is still initializing, sve-max-vq has an additional three states, bri=
nging
- * the number of its states to five, which are the following:
+ * tracking of the uninitialized state and the uninitialized but support=
ed by
+ * KVM state. The arm_vq_state typedef and following functions allow us =
to more
+ * easily work with the bitmap. Also, while the map is still initializin=
g,
+ * sve-max-vq has an additional three states, bringing the number of its=
 states
+ * to five, which are the following:
  *
  * sve-max-vq:
  *   0:    SVE is disabled. The default value for a vq in the map is 'OF=
F'.
@@ -296,6 +297,11 @@ typedef enum arm_vq_state {
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
 static arm_vq_state arm_cpu_vq_map_get(ARMCPU *cpu, int vq)
@@ -324,6 +330,23 @@ static void arm_cpu_vq_map_init(ARMCPU *cpu)
 {
     bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ * 2);
     bitmap_set(cpu->sve_vq_map, ARM_MAX_VQ, ARM_MAX_VQ);
+
+    if (kvm_enabled()) {
+        DECLARE_BITMAP(kvm_supported, ARM_MAX_VQ);
+        uint32_t kvm_max_vq;
+
+        bitmap_zero(kvm_supported, ARM_MAX_VQ);
+
+        kvm_arm_sve_get_vls(CPU(cpu), kvm_supported, ARM_MAX_VQ, &kvm_ma=
x_vq);
+
+        if (kvm_max_vq > ARM_MAX_VQ) {
+            warn_report("KVM supports vector lengths larger than "
+                        "QEMU can enable");
+        }
+
+        bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map,
+                  kvm_supported, ARM_MAX_VQ);
+    }
 }
=20
 static bool arm_cpu_vq_map_is_finalized(ARMCPU *cpu)
@@ -371,12 +394,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
         return;
     }
=20
-    /* sve-max-vq and sve<vl-bits> properties not yet implemented for KV=
M */
-    if (kvm_enabled()) {
-        return;
-    }
-
-    if (cpu->sve_max_vq =3D=3D ARM_SVE_INIT) {
+    if (!kvm_enabled() && cpu->sve_max_vq =3D=3D ARM_SVE_INIT) {
         object_property_set_uint(OBJECT(cpu), ARM_MAX_VQ, "sve-max-vq", =
&err);
         if (err) {
             error_propagate(errp, err);
@@ -431,6 +449,11 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visi=
tor *v, const char *name,
         return;
     }
=20
+    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+        error_setg(errp, "'sve' feature not supported by KVM on this hos=
t");
+        return;
+    }
+
     /*
      * It gets complicated trying to support both sve-max-vq and
      * sve<vl-bits> properties together, so we mostly don't. We
@@ -460,6 +483,12 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visi=
tor *v, const char *name,
             sprintf(name, "sve%d", vq * 128);
             object_property_set_bool(obj, true, name, &err);
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
@@ -484,6 +513,12 @@ static void cpu_arm_get_sve_vq(Object *obj, Visitor =
*v, const char *name,
         value =3D true;
     } else if (vq_state =3D=3D ARM_VQ_OFF) {
         value =3D false;
+    } else if (kvm_enabled() && vq_state =3D=3D ARM_VQ_UNINITIALIZED) {
+        /*
+         * When KVM is enabled, anything not supported by the host must =
have
+         * 'OFF' for the default.
+         */
+        value =3D false;
     } else {
         /*
          * vq is uninitialized. We pick a default here based on the
@@ -539,6 +574,11 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor =
*v, const char *name,
         return;
     }
=20
+    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+        error_setg(errp, "'sve' feature not supported by KVM on this hos=
t");
+        return;
+    }
+
     if (arm_sve_have_max_vq(cpu)) {
         max_vq =3D cpu->sve_max_vq;
     } else {
@@ -569,6 +609,8 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *=
v, const char *name,
         }
     }
=20
+    vq_state =3D arm_cpu_vq_map_get(cpu, vq);
+
     if (arm_sve_have_max_vq(cpu) && value && vq > cpu->sve_max_vq) {
         error_setg(errp, "cannot enable %s", name);
         error_append_hint(errp, "vq=3D%d (%d bits) is larger than the "
@@ -580,19 +622,31 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor=
 *v, const char *name,
         error_append_hint(errp, "The maximum vector length must be "
                           "enabled, sve-max-vq=3D%d (%d bits)\n",
                           cpu->sve_max_vq, cpu->sve_max_vq * 128);
-    } else if (arm_sve_have_max_vq(cpu) && !value && vq < cpu->sve_max_v=
q &&
-               is_power_of_2(vq)) {
+    } else if (!kvm_enabled() && arm_sve_have_max_vq(cpu) && !value &&
+               vq < cpu->sve_max_vq && is_power_of_2(vq)) {
         error_setg(errp, "cannot disable %s", name);
         error_append_hint(errp, "vq=3D%d (%d bits) is required as it is =
a "
                           "power-of-2 length smaller than the maximum, "
                           "sve-max-vq=3D%d (%d bits)\n", vq, vq * 128,
                           cpu->sve_max_vq, cpu->sve_max_vq * 128);
-    } else if (!value && vq < max_vq && is_power_of_2(vq)) {
+    } else if (!kvm_enabled() && !value && vq < max_vq && is_power_of_2(=
vq)) {
         error_setg(errp, "cannot disable %s", name);
         error_append_hint(errp, "Vector length %d-bits is required as it=
 "
                           "is a power-of-2 length smaller than another "
                           "enabled vector length. Disable all larger vec=
tor "
                           "lengths first.\n", vq * 128);
+    } else if (kvm_enabled() && value && vq_state =3D=3D ARM_VQ_UNINITIA=
LIZED) {
+        error_setg(errp, "cannot enable %s", name);
+        error_append_hint(errp, "This KVM host does not support "
+                          "the vector length %d-bits.\n", vq * 128);
+    } else if (kvm_enabled() && !value && vq < max_vq &&
+               (vq_state =3D=3D ARM_VQ_ON ||
+                vq_state =3D=3D ARM_VQ_UNINITIALIZED_KVM_SUPPORTED)) {
+        error_setg(errp, "cannot disable %s", name);
+        error_append_hint(errp, "Vector length %d-bits is a KVM supporte=
d "
+                          "length smaller than another enabled vector "
+                          "length. Disable all larger vector lengths "
+                          "first.\n", vq * 128);
     } else {
         if (value) {
             bool fail =3D false;
@@ -602,31 +656,53 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor=
 *v, const char *name,
              * Enabling a vector length automatically enables all
              * uninitialized power-of-2 lengths smaller than it, as
              * per the architecture.
+             *
+             * For KVM we have to automatically enable all supported,
+             * uninitialized lengths smaller than this length, even
+             * when it's not a power-of-2.
              */
             for (s =3D 1; s < vq; ++s) {
-                if (is_power_of_2(s)) {
-                    vq_state =3D arm_cpu_vq_map_get(cpu, s);
-                    if (vq_state =3D=3D ARM_VQ_UNINITIALIZED) {
-                        arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
-                    } else if (vq_state =3D=3D ARM_VQ_OFF) {
-                        fail =3D true;
-                        break;
-                    }
+                vq_state =3D arm_cpu_vq_map_get(cpu, s);
+                if (!kvm_enabled() && is_power_of_2(s) &&
+                    vq_state =3D=3D ARM_VQ_UNINITIALIZED) {
+                    arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
+                } else if (vq_state =3D=3D ARM_VQ_UNINITIALIZED_KVM_SUPP=
ORTED) {
+                    assert(kvm_enabled());
+                    arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
+                } else if ((kvm_enabled() || is_power_of_2(s)) &&
+                           vq_state =3D=3D ARM_VQ_OFF) {
+                    fail =3D true;
+                    break;
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
-            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
+            /*
+             * For KVM if the vq wasn't supported then we leave it in
+             * the ARM_VQ_UNINITIALIZED state in order to keep that
+             * unsupported information. It'll be set to OFF later when
+             * we finalize the map.
+             */
+            if (!kvm_enabled() || vq_state !=3D ARM_VQ_UNINITIALIZED) {
+                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
+            }
         }
     }
 }
@@ -689,11 +765,6 @@ static void aarch64_max_initfn(Object *obj)
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        /*
-         * KVM doesn't yet support the sve-max-vq property, but
-         * setting cpu->sve_max_vq is also used to turn SVE on.
-         */
-        cpu->sve_max_vq =3D ARM_SVE_INIT;
     } else {
         uint64_t t;
         uint32_t u;
@@ -774,32 +845,32 @@ static void aarch64_max_initfn(Object *obj)
         cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT=
 icache */
         cpu->dcz_blocksize =3D 7; /*  512 bytes */
 #endif
-
-        /*
-         * sve_max_vq is initially unspecified, but must be initialized =
to a
-         * non-zero value (ARM_SVE_INIT) to indicate that this cpu type =
has
-         * SVE. It will be finalized in arm_cpu_realizefn().
-         */
-        cpu->sve_max_vq =3D ARM_SVE_INIT;
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
+
+    /*
+     * sve_max_vq is initially unspecified, but must be initialized to a
+     * non-zero value (ARM_SVE_INIT) to indicate that this cpu type has
+     * SVE. It will be finalized in arm_cpu_realizefn().
+     */
+    cpu->sve_max_vq =3D ARM_SVE_INIT;
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
index 2821135a4d0e..5b0707e1192b 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -617,6 +617,110 @@ bool kvm_arm_sve_supported(CPUState *cpu)
     return ret > 0;
 }
=20
+QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN !=3D 1);
+
+void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map,
+                         uint32_t qemu_max_vq, uint32_t *kvm_max_vq)
+{
+    static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
+    static uint32_t host_max_vq =3D -1;
+    uint32_t vq;
+    int i, j;
+
+    bitmap_clear(map, 0, qemu_max_vq);
+    *kvm_max_vq =3D 0;
+
+    /*
+     * KVM ensures all host CPUs support the same set of vector lengths.
+     * So we only need to create a scratch VCPU once and then cache the
+     * results.
+     */
+    if (host_max_vq =3D=3D -1) {
+        int fdarray[3], ret =3D -1;
+
+        if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
+            error_report("failed to create scratch vcpu");
+            abort();
+        }
+
+        if (ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0)=
 {
+            struct kvm_vcpu_init init =3D {
+                .target =3D -1,
+                .features[0] =3D (1 << KVM_ARM_VCPU_SVE),
+            };
+            struct kvm_one_reg reg =3D {
+                .id =3D KVM_REG_ARM64_SVE_VLS,
+                .addr =3D (uint64_t)&vls[0],
+            };
+
+            kvm_arm_destroy_scratch_host_vcpu(fdarray);
+
+            if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, &init))=
 {
+                error_report("failed to create scratch vcpu");
+                abort();
+            }
+
+            ret =3D ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
+            if (ret) {
+                error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
+                             strerror(errno));
+                abort();
+            }
+        }
+
+        kvm_arm_destroy_scratch_host_vcpu(fdarray);
+
+        if (ret) {
+            /* The host doesn't support SVE. */
+            return;
+        }
+    }
+
+    for (i =3D KVM_ARM64_SVE_VLS_WORDS - 1; i >=3D 0; --i) {
+        if (!vls[i]) {
+            continue;
+        }
+        if (host_max_vq =3D=3D -1) {
+            host_max_vq =3D 64 - clz64(vls[i]) + i * 64;
+        }
+        for (j =3D 1; j <=3D 64; ++j) {
+            vq =3D j + i * 64;
+            if (vq > qemu_max_vq) {
+                break;
+            }
+            if (vls[i] & (1UL << (j - 1))) {
+                set_bit(vq - 1, map);
+            }
+        }
+    }
+
+    *kvm_max_vq =3D host_max_vq;
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
@@ -628,7 +732,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
=20
     if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_NONE ||
         !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
-        fprintf(stderr, "KVM is not supported for this guest CPU type\n"=
);
+        error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
=20
@@ -653,11 +757,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         unset_feature(&env->features, ARM_FEATURE_PMU);
     }
     if (cpu->sve_max_vq) {
-        if (!kvm_arm_sve_supported(cs)) {
-            cpu->sve_max_vq =3D 0;
-        } else {
-            cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_SVE;
-        }
+        assert(kvm_arm_sve_supported(cs));
+        cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_SVE;
     }
=20
     /* Do KVM_ARM_VCPU_INIT ioctl */
@@ -667,6 +768,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
=20
     if (cpu->sve_max_vq) {
+        ret =3D kvm_arm_sve_set_vls(cs);
+        if (ret) {
+            return ret;
+        }
         ret =3D kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
         if (ret) {
             return ret;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2367f8ab78ed..d5eb341e906d 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -212,6 +212,22 @@ typedef struct ARMHostCPUFeatures {
  */
 bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
=20
+/**
+ * kvm_arm_sve_get_vls:
+ * @cs: CPUState
+ * @map: bitmap to fill in
+ * @qemu_max_vq: the maximum vector length QEMU supports in quadwords
+ *               (size of the bitmap to fill in)
+ * @kvm_max_vq: the maximum vector length KVM supports in quadwords
+ *
+ * Get all the SVE vector lengths supported by the KVM host, setting
+ * the bits corresponding to their length in quadwords minus one
+ * (vq - 1) in @map up to @qemu_max_vq. Also assign @kvm_max_vq to the
+ * maximum vector length the KVM host supports.
+ */
+void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map,
+                         uint32_t qemu_max_vq, uint32_t *kvm_max_vq);
+
 /**
  * kvm_arm_set_cpu_features_from_host:
  * @cpu: ARMCPU to set the features for
@@ -314,6 +330,9 @@ static inline int kvm_arm_vgic_probe(void)
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
=20
+static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map,
+                                       uint32_t qemu_max_vq,
+                                       uint32_t *kvm_max_vq) {}
 #endif
=20
 static inline const char *gic_class_name(void)
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 1e213906fd8f..284818fb4a51 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -100,7 +100,7 @@ QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
  *
  * The sve<vl-bits> features need to be in reverse order in order to
  * enable/disable the largest vector lengths first, ensuring all
- * power-of-2 vector lengths smaller can also be enabled/disabled.
+ * smaller required vector lengths can also be enabled/disabled.
  */
 static const char *cpu_model_advertised_features[] =3D {
     "aarch64", "pmu", "sve",
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 67ad5f2b78d5..349bd0dca6d1 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -324,23 +324,35 @@ static void sve_tests_sve_max_vq_8(const void *data=
)
     qtest_quit(qts);
 }
=20
-static void sve_tests_sve_off(const void *data)
+static void sve_tests_off(QTestState *qts, const char *cpu_type)
 {
-    QTestState *qts;
-
-    qts =3D qtest_init(MACHINE "-cpu max,sve=3Doff");
-
     /*
      * SVE is off, so the map should be empty.
      */
-    assert_sve_vls(qts, "max", 0, NULL);
+    assert_sve_vls(qts, cpu_type, 0, NULL);
=20
     /*
      * We can't turn anything on, but off is OK.
      */
-    assert_error(qts, "max", "cannot enable sve128", "{ 'sve128': true }=
");
-    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
+    assert_error(qts, cpu_type, "cannot enable sve128", "{ 'sve128': tru=
e }");
+    assert_sve_vls(qts, cpu_type, 0, "{ 'sve128': false }");
+}
=20
+static void sve_tests_sve_off(const void *data)
+{
+    QTestState *qts;
+
+    qts =3D qtest_init(MACHINE "-cpu max,sve=3Doff");
+    sve_tests_off(qts, "max");
+    qtest_quit(qts);
+}
+
+static void sve_tests_sve_off_kvm(const void *data)
+{
+    QTestState *qts;
+
+    qts =3D qtest_init(MACHINE "-accel kvm -cpu max,sve=3Doff");
+    sve_tests_off(qts, "max");
     qtest_quit(qts);
 }
=20
@@ -392,12 +404,66 @@ static void test_query_cpu_model_expansion_kvm(cons=
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
             "The CPU definition 'cortex-a15' cannot "
             "be used with KVM on this host", NULL);
+
+        assert_has_feature(qts, "max", "sve");
+        resp =3D do_query_no_props(qts, "max");
+        g_assert(resp);
+        kvm_supports_sve =3D qdict_get_bool(resp_get_props(resp), "sve")=
;
+        qobject_unref(resp);
+
+        if (kvm_supports_sve) {
+            resp =3D do_query_no_props(qts, "max");
+            resp_get_sve_vls(resp, &vls, &max_vq);
+            g_assert(max_vq !=3D 0);
+            qobject_unref(resp);
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
+                /* The next smaller, supported vq is required */
+                vq =3D 64 - __builtin_clzll(vls & ~BIT(max_vq - 1));
+                sprintf(name, "sve%d", vq * 128);
+                error =3D g_strdup_printf("cannot disable %s", name);
+                assert_error(qts, "max", error, "{ %s: false }", name);
+                g_free(error);
+            }
+        } else {
+            resp =3D do_query_no_props(qts, "max");
+            resp_get_sve_vls(resp, &vls, &max_vq);
+            g_assert(max_vq =3D=3D 0);
+            qobject_unref(resp);
+        }
     } else {
         assert_error(qts, "host",
                      "'pmu' feature not supported by KVM on this host",
@@ -434,6 +500,8 @@ int main(int argc, char **argv)
     if (kvm_available) {
         qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
                             NULL, test_query_cpu_model_expansion_kvm);
+        qtest_add_data_func("/arm/kvm/query-cpu-model-expansion/sve-off"=
,
+                            NULL, sve_tests_sve_off_kvm);
     }
=20
     return g_test_run();
--=20
2.20.1


