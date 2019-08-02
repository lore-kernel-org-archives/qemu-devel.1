Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C282FC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C02216C8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C02216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htWhu-0006KC-Sq
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 08:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1htWdr-0005fO-Er
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1htWdq-00021W-4J
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:26:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1htWdl-0001vu-Dk; Fri, 02 Aug 2019 08:26:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10F6620260;
 Fri,  2 Aug 2019 12:26:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F29F85C205;
 Fri,  2 Aug 2019 12:26:26 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri,  2 Aug 2019 14:25:35 +0200
Message-Id: <20190802122540.26385-11-drjones@redhat.com>
In-Reply-To: <20190802122540.26385-1-drjones@redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 02 Aug 2019 12:26:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 10/15] target/arm/kvm64: Move the get/put of
 fpsimd registers out
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

Move the getting/putting of the fpsimd registers out of
kvm_arch_get/put_registers() into their own helper functions
to prepare for alternatively getting/putting SVE registers.

No functional change.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm64.c | 148 +++++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 60 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ddde6268b9d0..0b004d5d3050 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -719,13 +719,53 @@ int kvm_arm_cpreg_level(uint64_t regidx)
 #define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
=20
+static int kvm_arch_put_fpsimd(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    struct kvm_one_reg reg;
+    uint32_t fpr;
+    int i, ret;
+
+    for (i =3D 0; i < 32; i++) {
+        uint64_t *q =3D aa64_vfp_qreg(env, i);
+#ifdef HOST_WORDS_BIGENDIAN
+        uint64_t fp_val[2] =3D { q[1], q[0] };
+        reg.addr =3D (uintptr_t)fp_val;
+#else
+        reg.addr =3D (uintptr_t)q;
+#endif
+        reg.id =3D AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    reg.addr =3D (uintptr_t)(&fpr);
+    fpr =3D vfp_get_fpsr(env);
+    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
+    ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg.addr =3D (uintptr_t)(&fpr);
+    fpr =3D vfp_get_fpcr(env);
+    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
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
-    uint32_t fpr;
     uint64_t val;
-    int i;
-    int ret;
+    int i, ret;
     unsigned int el;
=20
     ARMCPU *cpu =3D ARM_CPU(cs);
@@ -815,33 +855,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
=20
-    /* Advanced SIMD and FP registers. */
-    for (i =3D 0; i < 32; i++) {
-        uint64_t *q =3D aa64_vfp_qreg(env, i);
-#ifdef HOST_WORDS_BIGENDIAN
-        uint64_t fp_val[2] =3D { q[1], q[0] };
-        reg.addr =3D (uintptr_t)fp_val;
-#else
-        reg.addr =3D (uintptr_t)q;
-#endif
-        reg.id =3D AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
-        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
-        if (ret) {
-            return ret;
-        }
-    }
-
-    reg.addr =3D (uintptr_t)(&fpr);
-    fpr =3D vfp_get_fpsr(env);
-    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
-    if (ret) {
-        return ret;
-    }
-
-    fpr =3D vfp_get_fpcr(env);
-    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
-    ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret =3D kvm_arch_put_fpsimd(cs);
     if (ret) {
         return ret;
     }
@@ -862,14 +876,54 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     return ret;
 }
=20
+static int kvm_arch_get_fpsimd(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    struct kvm_one_reg reg;
+    uint32_t fpr;
+    int i, ret;
+
+    for (i =3D 0; i < 32; i++) {
+        uint64_t *q =3D aa64_vfp_qreg(env, i);
+        reg.id =3D AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
+        reg.addr =3D (uintptr_t)q;
+        ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        } else {
+#ifdef HOST_WORDS_BIGENDIAN
+            uint64_t t;
+            t =3D q[0], q[0] =3D q[1], q[1] =3D t;
+#endif
+        }
+    }
+
+    reg.addr =3D (uintptr_t)(&fpr);
+    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
+    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+    vfp_set_fpsr(env, fpr);
+
+    reg.addr =3D (uintptr_t)(&fpr);
+    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
+    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+    vfp_set_fpcr(env, fpr);
+
+    return 0;
+}
+
 int kvm_arch_get_registers(CPUState *cs)
 {
     struct kvm_one_reg reg;
     uint64_t val;
-    uint32_t fpr;
     unsigned int el;
-    int i;
-    int ret;
+    int i, ret;
=20
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
@@ -958,36 +1012,10 @@ int kvm_arch_get_registers(CPUState *cs)
         env->spsr =3D env->banked_spsr[i];
     }
=20
-    /* Advanced SIMD and FP registers */
-    for (i =3D 0; i < 32; i++) {
-        uint64_t *q =3D aa64_vfp_qreg(env, i);
-        reg.id =3D AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
-        reg.addr =3D (uintptr_t)q;
-        ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
-        if (ret) {
-            return ret;
-        } else {
-#ifdef HOST_WORDS_BIGENDIAN
-            uint64_t t;
-            t =3D q[0], q[0] =3D q[1], q[1] =3D t;
-#endif
-        }
-    }
-
-    reg.addr =3D (uintptr_t)(&fpr);
-    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
-    if (ret) {
-        return ret;
-    }
-    vfp_set_fpsr(env, fpr);
-
-    reg.id =3D AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
-    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret =3D kvm_arch_get_fpsimd(cs);
     if (ret) {
         return ret;
     }
-    vfp_set_fpcr(env, fpr);
=20
     ret =3D kvm_get_vcpu_events(cpu);
     if (ret) {
--=20
2.20.1


