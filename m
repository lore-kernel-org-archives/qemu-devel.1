Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0529C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7606D2146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7606D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPk24-00064m-L3
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:40:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzY-0004L8-FF
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzW-0003mG-4g
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjyj-0003O5-IP; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7F50DC8EF;
	Sun, 12 May 2019 08:37:04 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 237625D706;
	Sun, 12 May 2019 08:37:00 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:18 +0200
Message-Id: <20190512083624.8916-8-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Sun, 12 May 2019 08:37:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/13] target/arm/kvm: max cpu: Allow sve max
 vector length setting
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the cpu type 'max' sve-max-vq property to work with kvm
too. If the property is not specified then the maximum kvm
supports is used. If it is specified we check that kvm supports
that exact length or error out if it doesn't.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.h   |  4 +++
 target/arm/cpu64.c |  7 ++--
 target/arm/kvm64.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 733b840a7127..8292d547e8f9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3122,6 +3122,10 @@ static inline uint64_t arm_sctlr(CPUARMState *env,=
 int el)
     }
 }
=20
+static inline int arm_cpu_fls64(uint64_t v)
+{
+    return !v ? 0 : 64 - clz64(v);
+}
=20
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6c19ef6837d5..3756e7e2a3e5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -292,7 +292,7 @@ static void aarch64_max_initfn(Object *obj)
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        cpu->sve_max_vq =3D ARM_MAX_VQ;
+        cpu->sve_max_vq =3D -1; /* set in kvm_arch_init_vcpu() */
     } else {
         uint64_t t;
         uint32_t u;
@@ -374,9 +374,10 @@ static void aarch64_max_initfn(Object *obj)
 #endif
=20
         cpu->sve_max_vq =3D ARM_MAX_VQ;
-        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve=
_vq,
-                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal=
);
     }
+
+    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
+                        cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
 }
=20
 struct ARMCPUInfo {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c2d92df75353..0c666e405357 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -446,6 +446,59 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
=20
+static int kvm_arm_get_sve_vls(CPUState *cs, uint64_t sve_vls[])
+{
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM64_SVE_VLS,
+        .addr =3D (uint64_t)&sve_vls[0],
+    };
+    int i, ret;
+
+    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    ret =3D 0;
+    for (i =3D KVM_ARM64_SVE_VLS_WORDS - 1; i >=3D 0; --i) {
+        if (sve_vls[i]) {
+            ret =3D arm_cpu_fls64(sve_vls[i]) + i * 64;
+            break;
+        }
+    }
+
+    return ret;
+}
+
+static int kvm_arm_set_sve_vls(CPUState *cs, uint64_t sve_vls[], int max=
_vq)
+{
+    struct kvm_one_reg reg =3D {
+        .id =3D KVM_REG_ARM64_SVE_VLS,
+        .addr =3D (uint64_t)&sve_vls[0],
+    };
+    int i;
+
+    for (i =3D KVM_ARM64_SVE_VLS_WORDS - 1; i >=3D 0; --i) {
+        if (sve_vls[i]) {
+            int vq =3D arm_cpu_fls64(sve_vls[i]) + i * 64;
+            while (vq > max_vq) {
+                sve_vls[i] &=3D ~BIT_MASK(vq - 1);
+                vq =3D arm_cpu_fls64(sve_vls[i]) + i * 64;
+            }
+            if (vq < max_vq) {
+                error_report("sve-max-vq=3D%d is not a valid length", ma=
x_vq);
+                error_printf("next lowest is %d\n", vq);
+                return -EINVAL;
+            }
+            if (vq =3D=3D max_vq) {
+                break;
+            }
+        }
+    }
+
+    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+}
+
 static inline void set_feature(uint64_t *features, int feature)
 {
     *features |=3D 1ULL << feature;
@@ -605,7 +658,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
=20
     if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_NONE ||
         !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
-        fprintf(stderr, "KVM is not supported for this guest CPU type\n"=
);
+        error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
=20
@@ -631,7 +684,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     if (cpu->sve_max_vq) {
         if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SVE)) {
-            cpu->sve_max_vq =3D 0;
+            if (cpu->sve_max_vq =3D=3D -1) {
+                cpu->sve_max_vq =3D 0;
+            } else {
+                error_report("This KVM host does not support SVE");
+                return -EINVAL;
+            }
         } else {
             cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_SVE;
         }
@@ -644,6 +702,24 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
=20
     if (cpu->sve_max_vq) {
+        uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS];
+        ret =3D kvm_arm_get_sve_vls(cs, sve_vls);
+        if (ret < 0) {
+            return ret;
+        }
+        if (cpu->sve_max_vq =3D=3D -1) {
+            cpu->sve_max_vq =3D ret;
+        } else if (cpu->sve_max_vq > ret) {
+            error_report("This KVM host does not support SVE vectors "
+                         "of length %d quadwords (%d bytes)",
+                         cpu->sve_max_vq, cpu->sve_max_vq * 16);
+            return -EINVAL;
+        } else {
+            ret =3D kvm_arm_set_sve_vls(cs, sve_vls, cpu->sve_max_vq);
+            if (ret < 0) {
+                return ret;
+            }
+        }
         ret =3D kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
         if (ret) {
             return ret;
--=20
2.20.1


