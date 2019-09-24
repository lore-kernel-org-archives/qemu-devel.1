Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E722FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9718214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9718214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCjRb-0007Zx-Uv
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iCj2c-0002fe-IF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iCj2b-0005Pa-2V
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iCj2V-0005N3-88; Tue, 24 Sep 2019 07:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76D7B5859E;
 Tue, 24 Sep 2019 11:31:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AD7A61559;
 Tue, 24 Sep 2019 11:31:24 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 5/9] target/arm/kvm64: Add kvm_arch_get/put_sve
Date: Tue, 24 Sep 2019 13:31:01 +0200
Message-Id: <20190924113105.19076-6-drjones@redhat.com>
In-Reply-To: <20190924113105.19076-1-drjones@redhat.com>
References: <20190924113105.19076-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 24 Sep 2019 11:31:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

These are the SVE equivalents to kvm_arch_get/put_fpsimd. Note, the
swabbing is different than it is for fpsmid because the vector format
is a little-endian stream of words.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm64.c | 137 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 28f6db57d5ee..ea454c613919 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -671,11 +671,12 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
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
@@ -761,6 +762,78 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
     return 0;
 }
=20
+/*
+ * SVE registers are encoded in KVM's memory in an endianness-invariant =
format.
+ * The byte at offset i from the start of the in-memory representation c=
ontains
+ * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means=
 the
+ * lowest offsets are stored in the lowest memory addresses, then that n=
early
+ * matches QEMU's representation, which is to use an array of host-endia=
n
+ * uint64_t's, where the lower offsets are at the lower indices. To comp=
lete
+ * the translation we just need to byte swap the uint64_t's on big-endia=
n hosts.
+ */
+static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    int i;
+
+    for (i =3D 0; i < nr; ++i) {
+        dst[i] =3D bswap64(src[i]);
+    }
+
+    return dst;
+#else
+    return src;
+#endif
+}
+
+/*
+ * KVM SVE registers come in slices where ZREGs have a slice size of 204=
8 bits
+ * and PREGS and the FFR have a slice size of 256 bits. However we simpl=
y hard
+ * code the slice index to zero for now as it's unlikely we'll need more=
 than
+ * one slice for quite some time.
+ */
+static int kvm_arch_put_sve(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    uint64_t tmp[ARM_MAX_VQ * 2];
+    uint64_t *r;
+    struct kvm_one_reg reg;
+    int n, ret;
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
+        r =3D sve_bswap64(tmp, &env->vfp.zregs[n].d[0], cpu->sve_max_vq =
* 2);
+        reg.addr =3D (uintptr_t)r;
+        reg.id =3D KVM_REG_ARM64_SVE_ZREG(n, 0);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
+        r =3D sve_bswap64(tmp, r =3D &env->vfp.pregs[n].p[0],
+                        DIV_ROUND_UP(cpu->sve_max_vq, 8));
+        reg.addr =3D (uintptr_t)r;
+        reg.id =3D KVM_REG_ARM64_SVE_PREG(n, 0);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    r =3D sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
+                    DIV_ROUND_UP(cpu->sve_max_vq, 8));
+    reg.addr =3D (uintptr_t)r;
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
@@ -855,7 +928,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
=20
-    ret =3D kvm_arch_put_fpsimd(cs);
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret =3D kvm_arch_put_sve(cs);
+    } else {
+        ret =3D kvm_arch_put_fpsimd(cs);
+    }
     if (ret) {
         return ret;
     }
@@ -918,6 +995,54 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
     return 0;
 }
=20
+/*
+ * KVM SVE registers come in slices where ZREGs have a slice size of 204=
8 bits
+ * and PREGS and the FFR have a slice size of 256 bits. However we simpl=
y hard
+ * code the slice index to zero for now as it's unlikely we'll need more=
 than
+ * one slice for quite some time.
+ */
+static int kvm_arch_get_sve(CPUState *cs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    struct kvm_one_reg reg;
+    uint64_t *r;
+    int n, ret;
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
+        r =3D &env->vfp.zregs[n].d[0];
+        reg.addr =3D (uintptr_t)r;
+        reg.id =3D KVM_REG_ARM64_SVE_ZREG(n, 0);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+        sve_bswap64(r, r, cpu->sve_max_vq * 2);
+    }
+
+    for (n =3D 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
+        r =3D &env->vfp.pregs[n].p[0];
+        reg.addr =3D (uintptr_t)r;
+        reg.id =3D KVM_REG_ARM64_SVE_PREG(n, 0);
+        ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+        sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq, 8));
+    }
+
+    r =3D &env->vfp.pregs[FFR_PRED_NUM].p[0];
+    reg.addr =3D (uintptr_t)r;
+    reg.id =3D KVM_REG_ARM64_SVE_FFR(0);
+    ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+    sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq, 8));
+
+    return 0;
+}
+
 int kvm_arch_get_registers(CPUState *cs)
 {
     struct kvm_one_reg reg;
@@ -1012,7 +1137,11 @@ int kvm_arch_get_registers(CPUState *cs)
         env->spsr =3D env->banked_spsr[i];
     }
=20
-    ret =3D kvm_arch_get_fpsimd(cs);
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret =3D kvm_arch_get_sve(cs);
+    } else {
+        ret =3D kvm_arch_get_fpsimd(cs);
+    }
     if (ret) {
         return ret;
     }
--=20
2.20.1


