Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB79C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CE72146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CE72146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPk4x-0000QR-SN
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:43:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzZ-0004Mj-L3
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzX-0003nr-E2
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjz9-0003X3-9p; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91DED3082E4C;
	Sun, 12 May 2019 08:37:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D26D5D706;
	Sun, 12 May 2019 08:37:25 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:23 +0200
Message-Id: <20190512083624.8916-13-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Sun, 12 May 2019 08:37:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 12/13] target/arm/kvm: max cpu: Add support for
 sve-vls-map
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

The max cpu type can have its SVE vector lengths explicitly set
with the sve-vls-map property. This patch allows that property
to work when KVM is in use. The map must conform to additional
constraints for KVM which are checked at vcpu init.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu64.c |  7 +++---
 target/arm/kvm64.c | 56 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9ac702d54136..94f3dd5b51e5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -310,7 +310,7 @@ static void cpu_set_sve_vls_map(Object *obj, Visitor =
*v, const char *name,
             error_setg(&err, "SVE vector length map has unsupported leng=
ths");
             error_append_hint(&err, "Valid vector lengths in range [1-%d=
]\n",
                               ARM_MAX_VQ);
-        } else if (cpu->sve_max_vq !=3D ARM_MAX_VQ &&
+        } else if (cpu->sve_max_vq !=3D ARM_MAX_VQ && cpu->sve_max_vq !=3D=
 -1 &&
                    cpu->sve_max_vq !=3D arm_cpu_fls64(cpu->sve_vls_map))=
 {
             /*
              * If the user provides both sve-max-vq and sve-vls-map, wit=
h
@@ -433,13 +433,12 @@ static void aarch64_max_initfn(Object *obj)
 #endif
=20
         cpu->sve_max_vq =3D ARM_MAX_VQ;
-
-        object_property_add(obj, "sve-vls-map", "uint64", cpu_get_sve_vl=
s_map,
-                            cpu_set_sve_vls_map, NULL, NULL, &error_fata=
l);
     }
=20
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
                         cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
+    object_property_add(obj, "sve-vls-map", "uint64", cpu_get_sve_vls_ma=
p,
+                        cpu_set_sve_vls_map, NULL, NULL, &error_fatal);
 }
=20
 struct ARMCPUInfo {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 11c6334a7c08..5506f019c190 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -685,9 +685,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     } else {
         unset_feature(&env->features, ARM_FEATURE_PMU);
     }
-    if (cpu->sve_max_vq) {
+    if (cpu->sve_max_vq || cpu->sve_vls_map) {
         if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SVE)) {
-            if (cpu->sve_max_vq =3D=3D -1) {
+            if (cpu->sve_max_vq =3D=3D -1 && !cpu->sve_vls_map) {
                 cpu->sve_max_vq =3D 0;
             } else {
                 error_report("This KVM host does not support SVE");
@@ -704,12 +704,62 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
=20
-    if (cpu->sve_max_vq) {
+    if (cpu->sve_max_vq || cpu->sve_vls_map) {
         uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS];
         ret =3D kvm_arm_get_sve_vls(cs, sve_vls);
         if (ret < 0) {
             return ret;
         }
+        if (cpu->sve_vls_map) {
+            uint64_t ovls;
+            int i;
+
+            /*
+             * We currently only support a single VLS word, as that shou=
ld
+             * be sufficient for some time (vq=3D64 means a 8192-bit vec=
tor
+             * and KVM currently only supports up to 2048-bit vectors).
+             * The choice to only support a single word for now is due t=
o
+             * the need to input it on the command line. It's much simpl=
er
+             * to input a word as a cpu property than an array of words.
+             * So for now just warn if we detect our assumption was wron=
g.
+             */
+            for (i =3D 1; i < KVM_ARM64_SVE_VLS_WORDS; ++i) {
+                if (sve_vls[i]) {
+                    warn_report("KVM supports vector lengths larger than=
 "
+                                "sve-vls-map can select");
+                    sve_vls[i] =3D 0;
+                }
+            }
+
+            ovls =3D sve_vls[0];
+            sve_vls[0] =3D cpu->sve_vls_map;
+
+            if (cpu->sve_vls_map & ~ovls) {
+                error_report("sve-vls-map=3D0x%lx is not valid on this h=
ost "
+                             "which supports 0x%lx", cpu->sve_vls_map, o=
vls);
+                return -EINVAL;
+            }
+
+            i =3D arm_cpu_fls64(cpu->sve_vls_map);
+            if (cpu->sve_max_vq && cpu->sve_max_vq !=3D -1 &&
+                cpu->sve_max_vq !=3D i) {
+                error_report("sve-vls-map and sve-max-vq are inconsisten=
t");
+                return -EINVAL;
+            }
+            cpu->sve_max_vq =3D i;
+
+            /*
+             * sve-vls-map must have all the same vector lengths up to i=
ts
+             * max vq that the host supports.
+             */
+            if (cpu->sve_vls_map !=3D (ovls & (BIT_MASK(cpu->sve_max_vq)=
 - 1))) {
+                error_report("sve-vls-map=3D0x%lx is not valid on this h=
ost "
+                             "which supports 0x%lx", cpu->sve_vls_map, o=
vls);
+                error_printf("All host vector lengths up to %d must also=
 "
+                             "be selected.\n", cpu->sve_max_vq);
+                return -EINVAL;
+            }
+        }
         if (cpu->sve_max_vq =3D=3D -1) {
             cpu->sve_max_vq =3D ret;
         } else if (cpu->sve_max_vq > ret) {
--=20
2.20.1


