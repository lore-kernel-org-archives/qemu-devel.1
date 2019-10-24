Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DFDCA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED9520659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCoVe8sT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED9520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcu5-0007Zu-Dj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iNc5D-0001Kw-GZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iNc5A-0004Gh-K8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48239
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iNc5A-0004GN-FD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571919552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hSmYREoJ+UXm6rJ/wX0fdl2eVAD5IrX1t5KyW4nFkw=;
 b=KCoVe8sTOXLuhTbY33IGCmXWBJRkc1WmO25onIuRih/z8x5Ct1AXfeRdkUOiQvPCCMI/OR
 z8vgeyutg2BjTLQrofZr4iunomCifn8iqgJwOF+eYqXU9ip/g1M6GZsBRRkAT9Ik50CDO2
 sA1m/MvPTNE5BrE89PUapvvfcLIMxEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-q_vgK6whM-OMpwGkWL7wNw-1; Thu, 24 Oct 2019 08:19:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBACE800D49;
 Thu, 24 Oct 2019 12:19:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC1460E1C;
 Thu, 24 Oct 2019 12:18:51 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v7 8/9] target/arm/cpu64: max cpu: Support sve properties with
 KVM
Date: Thu, 24 Oct 2019 14:18:07 +0200
Message-Id: <20191024121808.9612-9-drjones@redhat.com>
In-Reply-To: <20191024121808.9612-1-drjones@redhat.com>
References: <20191024121808.9612-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: q_vgK6whM-OMpwGkWL7wNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Extend the SVE vq map initialization and validation with KVM's
supported vector lengths when KVM is enabled. In order to determine
and select supported lengths we add two new KVM functions for getting
and setting the KVM_REG_ARM64_SVE_VLS pseudo-register.

This patch has been co-authored with Richard Henderson, who reworked
the target/arm/cpu64.c changes in order to push all the validation and
auto-enabling/disabling steps into the finalizer, resulting in a nice
LOC reduction.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 docs/arm-cpu-features.rst |  45 +++++++---
 target/arm/cpu64.c        | 172 +++++++++++++++++++++++++++++---------
 target/arm/kvm64.c        | 100 +++++++++++++++++++++-
 target/arm/kvm_arm.h      |  12 +++
 tests/arm-cpu-features.c  | 106 ++++++++++++++++++++++-
 5 files changed, 379 insertions(+), 56 deletions(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index 2ea4d6e90c02..bed218d44619 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -191,10 +191,18 @@ SVE CPU Property Dependencies and Constraints
=20
   1) At least one vector length must be enabled when `sve` is enabled.
=20
-  2) If a vector length `N` is enabled, then all power-of-two vector
-     lengths smaller than `N` must also be enabled.  E.g. if `sve512`
-     is enabled, then the 128-bit and 256-bit vector lengths must also
-     be enabled.
+  2) If a vector length `N` is enabled, then, when KVM is enabled, all
+     smaller, host supported vector lengths must also be enabled.  If
+     KVM is not enabled, then only all the smaller, power-of-two vector
+     lengths must be enabled.  E.g. with KVM if the host supports all
+     vector lengths up to 512-bits (128, 256, 384, 512), then if `sve512`
+     is enabled, the 128-bit vector length, 256-bit vector length, and
+     384-bit vector length must also be enabled. Without KVM, the 384-bit
+     vector length would not be required.
+
+  3) If KVM is enabled then only vector lengths that the host CPU type
+     support may be enabled.  If SVE is not supported by the host, then
+     no `sve*` properties may be enabled.
=20
 SVE CPU Property Parsing Semantics
 ----------------------------------
@@ -209,8 +217,10 @@ SVE CPU Property Parsing Semantics
      an error is generated.
=20
   2) If SVE is enabled (`sve=3Don`), but no `sve<N>` CPU properties are
-     provided, then all supported vector lengths are enabled, including
-     the non-power-of-two lengths.
+     provided, then all supported vector lengths are enabled, which when
+     KVM is not in use means including the non-power-of-two lengths, and,
+     when KVM is in use, it means all vector lengths supported by the host
+     processor.
=20
   3) If SVE is enabled, then an error is generated when attempting to
      disable the last enabled vector length (see constraint (1) of "SVE
@@ -221,20 +231,31 @@ SVE CPU Property Parsing Semantics
      has been explicitly disabled, then an error is generated (see
      constraint (2) of "SVE CPU Property Dependencies and Constraints").
=20
-  5) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N>`=
,
+  5) When KVM is enabled, if the host does not support SVE, then an error
+     is generated when attempting to enable any `sve*` properties (see
+     constraint (3) of "SVE CPU Property Dependencies and Constraints").
+
+  6) When KVM is enabled, if the host does support SVE, then an error is
+     generated when attempting to enable any vector lengths not supported
+     by the host (see constraint (3) of "SVE CPU Property Dependencies and
+     Constraints").
+
+  7) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N>`=
,
      CPU properties are set `on`, then the specified vector lengths are
      disabled but the default for any unspecified lengths remains enabled.
-     Disabling a power-of-two vector length also disables all vector
-     lengths larger than the power-of-two length (see constraint (2) of
-     "SVE CPU Property Dependencies and Constraints").
+     When KVM is not enabled, disabling a power-of-two vector length also
+     disables all vector lengths larger than the power-of-two length.
+     When KVM is enabled, then disabling any supported vector length also
+     disables all larger vector lengths (see constraint (2) of "SVE CPU
+     Property Dependencies and Constraints").
=20
-  6) If one or more `sve<N>` CPU properties are set to `on`, then they
+  8) If one or more `sve<N>` CPU properties are set to `on`, then they
      are enabled and all unspecified lengths default to disabled, except
      for the required lengths per constraint (2) of "SVE CPU Property
      Dependencies and Constraints", which will even be auto-enabled if
      they were not explicitly enabled.
=20
-  7) If SVE was disabled (`sve=3Doff`), allowing all vector lengths to be
+  9) If SVE was disabled (`sve=3Doff`), allowing all vector lengths to be
      explicitly disabled (i.e. avoiding the error specified in (3) of
      "SVE CPU Property Parsing Semantics"), then if later an `sve=3Don` is
      provided an error will be generated.  To avoid this error, one must
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a771a28daa56..c161a146ff0d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -273,9 +273,18 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
      * any of the above.  Finally, if SVE is not disabled, then at least o=
ne
      * vector length must be enabled.
      */
+    DECLARE_BITMAP(kvm_supported, ARM_MAX_VQ);
     DECLARE_BITMAP(tmp, ARM_MAX_VQ);
     uint32_t vq, max_vq =3D 0;
=20
+    /* Collect the set of vector lengths supported by KVM. */
+    bitmap_zero(kvm_supported, ARM_MAX_VQ);
+    if (kvm_enabled() && kvm_arm_sve_supported(CPU(cpu))) {
+        kvm_arm_sve_get_vls(CPU(cpu), kvm_supported);
+    } else if (kvm_enabled()) {
+        assert(!cpu_isar_feature(aa64_sve, cpu));
+    }
+
     /*
      * Process explicit sve<N> properties.
      * From the properties, sve_vq_map<N> implies sve_vq_init<N>.
@@ -293,10 +302,19 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
             return;
         }
=20
-        /* Propagate enabled bits down through required powers-of-two. */
-        for (vq =3D pow2floor(max_vq); vq >=3D 1; vq >>=3D 1) {
-            if (!test_bit(vq - 1, cpu->sve_vq_init)) {
-                set_bit(vq - 1, cpu->sve_vq_map);
+        if (kvm_enabled()) {
+            /*
+             * For KVM we have to automatically enable all supported uniti=
alized
+             * lengths, even when the smaller lengths are not all powers-o=
f-two.
+             */
+            bitmap_andnot(tmp, kvm_supported, cpu->sve_vq_init, max_vq);
+            bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, tmp, max_vq);
+        } else {
+            /* Propagate enabled bits down through required powers-of-two.=
 */
+            for (vq =3D pow2floor(max_vq); vq >=3D 1; vq >>=3D 1) {
+                if (!test_bit(vq - 1, cpu->sve_vq_init)) {
+                    set_bit(vq - 1, cpu->sve_vq_map);
+                }
             }
         }
     } else if (cpu->sve_max_vq =3D=3D 0) {
@@ -308,23 +326,45 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
             return;
         }
=20
-        /* Disabling a power-of-two disables all larger lengths. */
-        if (test_bit(0, cpu->sve_vq_init)) {
-            error_setg(errp, "cannot disable sve128");
-            error_append_hint(errp, "Disabling sve128 results in all vecto=
r "
-                              "lengths being disabled.\n");
-            error_append_hint(errp, "With SVE enabled, at least one vector=
 "
-                              "length must be enabled.\n");
-            return;
-        }
-        for (vq =3D 2; vq <=3D ARM_MAX_VQ; vq <<=3D 1) {
-            if (test_bit(vq - 1, cpu->sve_vq_init)) {
-                break;
+        if (kvm_enabled()) {
+            /* Disabling a supported length disables all larger lengths. *=
/
+            for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
+                if (test_bit(vq - 1, cpu->sve_vq_init) &&
+                    test_bit(vq - 1, kvm_supported)) {
+                    break;
+                }
+            }
+            max_vq =3D vq <=3D ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
+            bitmap_andnot(cpu->sve_vq_map, kvm_supported,
+                          cpu->sve_vq_init, max_vq);
+            if (max_vq =3D=3D 0 || bitmap_empty(cpu->sve_vq_map, max_vq)) =
{
+                error_setg(errp, "cannot disable sve%d", vq * 128);
+                error_append_hint(errp, "Disabling sve%d results in all "
+                                  "vector lengths being disabled.\n",
+                                  vq * 128);
+                error_append_hint(errp, "With SVE enabled, at least one "
+                                  "vector length must be enabled.\n");
+                return;
+            }
+        } else {
+            /* Disabling a power-of-two disables all larger lengths. */
+            if (test_bit(0, cpu->sve_vq_init)) {
+                error_setg(errp, "cannot disable sve128");
+                error_append_hint(errp, "Disabling sve128 results in all "
+                                  "vector lengths being disabled.\n");
+                error_append_hint(errp, "With SVE enabled, at least one "
+                                  "vector length must be enabled.\n");
+                return;
+            }
+            for (vq =3D 2; vq <=3D ARM_MAX_VQ; vq <<=3D 1) {
+                if (test_bit(vq - 1, cpu->sve_vq_init)) {
+                    break;
+                }
             }
+            max_vq =3D vq <=3D ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
+            bitmap_complement(cpu->sve_vq_map, cpu->sve_vq_init, max_vq);
         }
-        max_vq =3D vq <=3D ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
=20
-        bitmap_complement(cpu->sve_vq_map, cpu->sve_vq_init, max_vq);
         max_vq =3D find_last_bit(cpu->sve_vq_map, max_vq) + 1;
     }
=20
@@ -358,16 +398,48 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
     assert(max_vq !=3D 0);
     bitmap_clear(cpu->sve_vq_map, max_vq, ARM_MAX_VQ - max_vq);
=20
-    /* Ensure all required powers-of-two are enabled. */
-    for (vq =3D pow2floor(max_vq); vq >=3D 1; vq >>=3D 1) {
-        if (!test_bit(vq - 1, cpu->sve_vq_map)) {
-            error_setg(errp, "cannot disable sve%d", vq * 128);
-            error_append_hint(errp, "sve%d is required as it "
-                              "is a power-of-two length smaller than "
-                              "the maximum, sve%d\n",
-                              vq * 128, max_vq * 128);
+    if (kvm_enabled()) {
+        /* Ensure the set of lengths matches what KVM supports. */
+        bitmap_xor(tmp, cpu->sve_vq_map, kvm_supported, max_vq);
+        if (!bitmap_empty(tmp, max_vq)) {
+            vq =3D find_last_bit(tmp, max_vq) + 1;
+            if (test_bit(vq - 1, cpu->sve_vq_map)) {
+                if (cpu->sve_max_vq) {
+                    error_setg(errp, "cannot set sve-max-vq=3D%d",
+                               cpu->sve_max_vq);
+                    error_append_hint(errp, "This KVM host does not suppor=
t "
+                                      "the vector length %d-bits.\n",
+                                      vq * 128);
+                    error_append_hint(errp, "It may not be possible to use=
 "
+                                      "sve-max-vq with this KVM host. Try =
"
+                                      "using only sve<N> properties.\n");
+                } else {
+                    error_setg(errp, "cannot enable sve%d", vq * 128);
+                    error_append_hint(errp, "This KVM host does not suppor=
t "
+                                      "the vector length %d-bits.\n",
+                                      vq * 128);
+                }
+            } else {
+                error_setg(errp, "cannot disable sve%d", vq * 128);
+                error_append_hint(errp, "The KVM host requires all "
+                                  "supported vector lengths smaller "
+                                  "than %d bits to also be enabled.\n",
+                                  max_vq * 128);
+            }
             return;
         }
+    } else {
+        /* Ensure all required powers-of-two are enabled. */
+        for (vq =3D pow2floor(max_vq); vq >=3D 1; vq >>=3D 1) {
+            if (!test_bit(vq - 1, cpu->sve_vq_map)) {
+                error_setg(errp, "cannot disable sve%d", vq * 128);
+                error_append_hint(errp, "sve%d is required as it "
+                                  "is a power-of-two length smaller than "
+                                  "the maximum, sve%d\n",
+                                  vq * 128, max_vq * 128);
+                return;
+            }
+        }
     }
=20
     /*
@@ -421,15 +493,28 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visit=
or *v, const char *name,
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
     Error *err =3D NULL;
+    uint32_t max_vq;
+
+    visit_type_uint32(v, name, &max_vq, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
=20
-    visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
+    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+        error_setg(errp, "cannot set sve-max-vq");
+        error_append_hint(errp, "SVE not supported by KVM on this host\n")=
;
+        return;
+    }
=20
-    if (!err && (cpu->sve_max_vq =3D=3D 0 || cpu->sve_max_vq > ARM_MAX_VQ)=
) {
-        error_setg(&err, "unsupported SVE vector length");
-        error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n",
+    if (max_vq =3D=3D 0 || max_vq > ARM_MAX_VQ) {
+        error_setg(errp, "unsupported SVE vector length");
+        error_append_hint(errp, "Valid sve-max-vq in range [1-%d]\n",
                           ARM_MAX_VQ);
+        return;
     }
-    error_propagate(errp, err);
+
+    cpu->sve_max_vq =3D max_vq;
 }
=20
 static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
@@ -462,6 +547,12 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v=
, const char *name,
         return;
     }
=20
+    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+        error_setg(errp, "cannot enable %s", name);
+        error_append_hint(errp, "SVE not supported by KVM on this host\n")=
;
+        return;
+    }
+
     if (value) {
         set_bit(vq - 1, cpu->sve_vq_map);
     } else {
@@ -619,20 +710,19 @@ static void aarch64_max_initfn(Object *obj)
         cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT i=
cache */
         cpu->dcz_blocksize =3D 7; /*  512 bytes */
 #endif
-
-        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_m=
ax_vq,
-                            cpu_max_set_sve_max_vq, NULL, NULL, &error_fat=
al);
-
-        for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
-            char name[8];
-            sprintf(name, "sve%d", vq * 128);
-            object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
-                                cpu_arm_set_sve_vq, NULL, NULL, &error_fat=
al);
-        }
     }
=20
     object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
                         cpu_arm_set_sve, NULL, NULL, &error_fatal);
+    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_v=
q,
+                        cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
+
+    for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
+        char name[8];
+        sprintf(name, "sve%d", vq * 128);
+        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
+                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
+    }
 }
=20
 struct ARMCPUInfo {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c7ecefbed720..c93bbee425ae 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -613,6 +613,100 @@ bool kvm_arm_sve_supported(CPUState *cpu)
     return kvm_check_extension(s, KVM_CAP_ARM_SVE);
 }
=20
+QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN !=3D 1);
+
+void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)
+{
+    /* Only call this function if kvm_arm_sve_supported() returns true. */
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
+        if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, &init)) {
+            error_report("failed to create scratch VCPU with SVE enabled")=
;
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
@@ -624,7 +718,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
=20
     if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_NONE ||
         !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
-        fprintf(stderr, "KVM is not supported for this guest CPU type\n");
+        error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
=20
@@ -660,6 +754,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
index 7c12f1501a8b..8e14d400e8ab 100644
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
@@ -316,6 +327,7 @@ static inline int kvm_arm_vgic_probe(void)
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
=20
+static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {=
}
 #endif
=20
 static inline const char *gic_class_name(void)
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 3efc168d62a4..597c1cd78db2 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -112,6 +112,17 @@ static QDict *resp_get_props(QDict *resp)
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
     QDict *_resp =3D do_query_no_props(qts, cpu_type);                   \
@@ -341,6 +352,25 @@ static void sve_tests_sve_off(const void *data)
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
+     * and that using sve<N>=3Doff to explicitly disable vector
+     * lengths is OK too.
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
@@ -388,14 +418,82 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
     qts =3D qtest_init(MACHINE "-accel kvm -cpu host");
=20
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        bool kvm_supports_sve;
+        char max_name[8], name[8];
+        uint32_t max_vq, vq;
+        uint64_t vls;
+        QDict *resp;
+        char *error;
+
         assert_has_feature(qts, "host", "aarch64");
         assert_has_feature(qts, "host", "pmu");
=20
-        assert_has_feature(qts, "max", "sve");
-
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
+            sprintf(max_name, "sve%d", max_vq * 128);
+
+            /* Enabling a supported length is of course fine. */
+            assert_sve_vls(qts, "max", vls, "{ %s: true }", max_name);
+
+            /* Get the next supported length smaller than max-vq. */
+            vq =3D 64 - __builtin_clzll(vls & ~BIT_ULL(max_vq - 1));
+            if (vq) {
+                /*
+                 * We have at least one length smaller than max-vq,
+                 * so we can disable max-vq.
+                 */
+                assert_sve_vls(qts, "max", (vls & ~BIT_ULL(max_vq - 1)),
+                               "{ %s: false }", max_name);
+
+                /*
+                 * Smaller, supported vector lengths cannot be disabled
+                 * unless all larger, supported vector lengths are also
+                 * disabled.
+                 */
+                sprintf(name, "sve%d", vq * 128);
+                error =3D g_strdup_printf("cannot disable %s", name);
+                assert_error(qts, "max", error,
+                             "{ %s: true, %s: false }",
+                             max_name, name);
+                g_free(error);
+            }
+
+            /*
+             * The smallest, supported vector length is required, because
+             * we need at least one vector length enabled.
+             */
+            vq =3D __builtin_ffsll(vls);
+            sprintf(name, "sve%d", vq * 128);
+            error =3D g_strdup_printf("cannot disable %s", name);
+            assert_error(qts, "max", error, "{ %s: false }", name);
+            g_free(error);
+
+            /* Get an unsupported length. */
+            for (vq =3D 1; vq <=3D max_vq; ++vq) {
+                if (!(vls & BIT_ULL(vq - 1))) {
+                    break;
+                }
+            }
+            if (vq <=3D SVE_MAX_VQ) {
+                sprintf(name, "sve%d", vq * 128);
+                error =3D g_strdup_printf("cannot enable %s", name);
+                assert_error(qts, "max", error, "{ %s: true }", name);
+                g_free(error);
+            }
+        } else {
+            g_assert(vls =3D=3D 0);
+        }
     } else {
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
@@ -433,6 +531,10 @@ int main(int argc, char **argv)
     if (kvm_available) {
         qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
                             NULL, test_query_cpu_model_expansion_kvm);
+        if (g_str_equal(qtest_get_arch(), "aarch64")) {
+            qtest_add_data_func("/arm/kvm/query-cpu-model-expansion/sve-of=
f",
+                                NULL, sve_tests_sve_off_kvm);
+        }
     }
=20
     return g_test_run();
--=20
2.21.0


