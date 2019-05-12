Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CEC04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14212146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14212146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40622 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPk9G-0003xy-3I
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:47:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzZ-0004Mr-NM
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzX-0003op-W1
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjyZ-0003LM-EK; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B98283086212;
	Sun, 12 May 2019 08:36:54 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3376E5D706;
	Sun, 12 May 2019 08:36:50 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:16 +0200
Message-Id: <20190512083624.8916-6-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Sun, 12 May 2019 08:36:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 05/13] target/arm/kvm: Add kvm_arch_get/put_sve
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

These are the SVE equivalents to kvm_arch_get/put_fpsimd.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/kvm64.c | 127 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 61947f3716e1..86362f4cd7d0 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -658,11 +658,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
@@ -748,6 +749,61 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
     return 0;
 }
=20
+static int kvm_arch_put_sve(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    struct kvm_one_reg reg;
+    int n, ret;
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
+        uint64_t *q =3D aa64_vfp_qreg(env, n);
+#ifdef HOST_WORDS_BIGENDIAN
+        uint64_t d[ARM_MAX_VQ * 2];
+        int i;
+        for (i =3D 0; i < cpu->sve_max_vq * 2; i++) {
+            d[i] =3D q[cpu->sve_max_vq * 2 - 1 - i];
+        }
+        reg.addr =3D (uintptr_t)d;
+#else
+        reg.addr =3D (uintptr_t)q;
+#endif
+        reg.id =3D KVM_REG_ARM64_SVE_ZREG(n, 0);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_PREGS; n++) {
+        uint64_t *p =3D &env->vfp.pregs[n].p[0];
+#ifdef HOST_WORDS_BIGENDIAN
+        uint64_t d[ARM_MAX_VQ * 2];
+        int i;
+        for (i =3D 0; i < cpu->sve_max_vq * 2 / 8; i++) {
+            d[i] =3D p[cpu->sve_max_vq * 2 / 8 - 1 - i];
+        }
+        reg.addr =3D (uintptr_t)d;
+#else
+        reg.addr =3D (uintptr_t)p;
+#endif
+        reg.id =3D KVM_REG_ARM64_SVE_PREG(n, 0);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    reg.addr =3D (uintptr_t)&env->vfp.pregs[FFR_PRED_NUM].p[0];
+    reg.id =3D KVM_REG_ARM64_SVE_FFR(0);
+    ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     struct kvm_one_reg reg;
@@ -842,7 +898,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
=20
-    ret =3D kvm_arch_put_fpsimd(cs);
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        ret =3D kvm_arch_put_fpsimd(cs);
+    } else {
+        ret =3D kvm_arch_put_sve(cs);
+    }
     if (ret) {
         return ret;
     }
@@ -905,6 +965,61 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
     return 0;
 }
=20
+static int kvm_arch_get_sve(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    struct kvm_one_reg reg;
+    int n, ret;
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
+        uint64_t *q =3D aa64_vfp_qreg(env, n);
+        reg.id =3D KVM_REG_ARM64_SVE_ZREG(n, 0);
+        reg.addr =3D (uintptr_t)q;
+        ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        } else {
+#ifdef HOST_WORDS_BIGENDIAN
+            int i =3D 0, j =3D cpu->sve_max_vq * 2 - 1;
+            while (i < j) {
+                uint64_t t;
+                t =3D q[i], q[i] =3D q[j], q[j] =3D t;
+                ++i, --j;
+            }
+#endif
+        }
+    }
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_PREGS; n++) {
+        uint64_t *p =3D &env->vfp.pregs[n].p[0];
+        reg.id =3D KVM_REG_ARM64_SVE_PREG(n, 0);
+        reg.addr =3D (uintptr_t)p;
+        ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        } else {
+#ifdef HOST_WORDS_BIGENDIAN
+            int i =3D 0, j =3D cpu->sve_max_vq * 2 / 8 - 1;
+            while (i < j) {
+                uint64_t t;
+                t =3D q[i], q[i] =3D q[j], q[j] =3D t;
+                ++i, --j;
+            }
+#endif
+        }
+    }
+
+    reg.addr =3D (uintptr_t)&env->vfp.pregs[FFR_PRED_NUM].p[0];
+    reg.id =3D KVM_REG_ARM64_SVE_FFR(0);
+    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 int kvm_arch_get_registers(CPUState *cs)
 {
     struct kvm_one_reg reg;
@@ -999,7 +1114,11 @@ int kvm_arch_get_registers(CPUState *cs)
         env->spsr =3D env->banked_spsr[i];
     }
=20
-    ret =3D kvm_arch_get_fpsimd(cs);
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        ret =3D kvm_arch_get_fpsimd(cs);
+    } else {
+        ret =3D kvm_arch_get_sve(cs);
+    }
     if (ret) {
         return ret;
     }
--=20
2.20.1


