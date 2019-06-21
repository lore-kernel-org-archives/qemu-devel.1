Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37556C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFFC2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFFC2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMoX-0001ck-7T
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1heMVm-000214-Og
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1heMVl-0002Yu-18
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1heMVW-0001sK-CY; Fri, 21 Jun 2019 12:35:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31B0D301D680;
 Fri, 21 Jun 2019 16:35:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 207CE1001DC7;
 Fri, 21 Jun 2019 16:35:15 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri, 21 Jun 2019 18:34:18 +0200
Message-Id: <20190621163422.6127-11-drjones@redhat.com>
In-Reply-To: <20190621163422.6127-1-drjones@redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 21 Jun 2019 16:35:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/14] target/arm/kvm64: Add
 kvm_arch_get/put_sve
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

These are the SVE equivalents to kvm_arch_get/put_fpsimd. Note, the
swabbing is different than it is for fpsmid because the vector format
is a little-endian stream of words.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/kvm64.c | 135 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index a2485d447e6a..706541327491 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -673,11 +673,12 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
 bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 {
     /* Return true if the regidx is a register we should synchronize
-     * via the cpreg_tuples array (ie is not a core reg we sync by
-     * hand in kvm_arch_get/put_registers())
+     * via the cpreg_tuples array (ie is not a core or sve reg that
+     * we sync by hand in kvm_arch_get/put_registers())
      */
     switch (regidx & KVM_REG_ARM_COPROC_MASK) {
     case KVM_REG_ARM_CORE:
+    case KVM_REG_ARM64_SVE:
         return false;
     default:
         return true;
@@ -763,6 +764,70 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
     return 0;
 }
=20
+/*
+ * If ARM_MAX_VQ is increased to be greater than 16, then we can no
+ * longer hard code slices to 1 in kvm_arch_put/get_sve().
+ */
+QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
+
+static int kvm_arch_put_sve(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    struct kvm_one_reg reg;
+    int slices =3D 1;
+    int i, n, ret;
+
+    for (i =3D 0; i < slices; i++) {
+        for (n =3D 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
+            uint64_t *q =3D aa64_vfp_qreg(env, n);
+#ifdef HOST_WORDS_BIGENDIAN
+            uint64_t d[ARM_MAX_VQ * 2];
+            int j;
+            for (j =3D 0; j < cpu->sve_max_vq * 2; j++) {
+                d[j] =3D bswap64(q[j]);
+            }
+            reg.addr =3D (uintptr_t)d;
+#else
+            reg.addr =3D (uintptr_t)q;
+#endif
+            reg.id =3D KVM_REG_ARM64_SVE_ZREG(n, i);
+            ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+            if (ret) {
+                return ret;
+            }
+        }
+
+        for (n =3D 0; n < KVM_ARM64_SVE_NUM_PREGS; n++) {
+            uint64_t *q =3D &env->vfp.pregs[n].p[0];
+#ifdef HOST_WORDS_BIGENDIAN
+            uint64_t d[ARM_MAX_VQ * 2 / 8];
+            int j;
+            for (j =3D 0; j < cpu->sve_max_vq * 2 / 8; j++) {
+                d[j] =3D bswap64(q[j]);
+            }
+            reg.addr =3D (uintptr_t)d;
+#else
+            reg.addr =3D (uintptr_t)q;
+#endif
+            reg.id =3D KVM_REG_ARM64_SVE_PREG(n, i);
+            ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+            if (ret) {
+                return ret;
+            }
+        }
+
+        reg.addr =3D (uintptr_t)&env->vfp.pregs[FFR_PRED_NUM].p[0];
+        reg.id =3D KVM_REG_ARM64_SVE_FFR(i);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     struct kvm_one_reg reg;
@@ -857,7 +922,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
=20
-    ret =3D kvm_arch_put_fpsimd(cs);
+    if (!cpu->sve_max_vq) {
+        ret =3D kvm_arch_put_fpsimd(cs);
+    } else {
+        ret =3D kvm_arch_put_sve(cs);
+    }
     if (ret) {
         return ret;
     }
@@ -920,6 +989,60 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
     return 0;
 }
=20
+static int kvm_arch_get_sve(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    struct kvm_one_reg reg;
+    int slices =3D 1;
+    int i, n, ret;
+
+    for (i =3D 0; i < slices; i++) {
+        for (n =3D 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
+            uint64_t *q =3D aa64_vfp_qreg(env, n);
+            reg.id =3D KVM_REG_ARM64_SVE_ZREG(n, i);
+            reg.addr =3D (uintptr_t)q;
+            ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+            if (ret) {
+                return ret;
+            } else {
+#ifdef HOST_WORDS_BIGENDIAN
+                int j;
+                for (j =3D 0; j < cpu->sve_max_vq * 2; j++) {
+                    q[j] =3D bswap64(q[j]);
+                }
+#endif
+            }
+        }
+
+        for (n =3D 0; n < KVM_ARM64_SVE_NUM_PREGS; n++) {
+            uint64_t *q =3D &env->vfp.pregs[n].p[0];
+            reg.id =3D KVM_REG_ARM64_SVE_PREG(n, i);
+            reg.addr =3D (uintptr_t)q;
+            ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+            if (ret) {
+                return ret;
+            } else {
+#ifdef HOST_WORDS_BIGENDIAN
+                int j;
+                for (j =3D 0; j < cpu->sve_max_vq * 2 / 8; j++) {
+                    q[j] =3D bswap64(q[j]);
+                }
+#endif
+            }
+        }
+
+        reg.addr =3D (uintptr_t)&env->vfp.pregs[FFR_PRED_NUM].p[0];
+        reg.id =3D KVM_REG_ARM64_SVE_FFR(i);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 int kvm_arch_get_registers(CPUState *cs)
 {
     struct kvm_one_reg reg;
@@ -1014,7 +1137,11 @@ int kvm_arch_get_registers(CPUState *cs)
         env->spsr =3D env->banked_spsr[i];
     }
=20
-    ret =3D kvm_arch_get_fpsimd(cs);
+    if (!cpu->sve_max_vq) {
+        ret =3D kvm_arch_get_fpsimd(cs);
+    } else {
+        ret =3D kvm_arch_get_sve(cs);
+    }
     if (ret) {
         return ret;
     }
--=20
2.20.1


