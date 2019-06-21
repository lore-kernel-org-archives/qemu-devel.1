Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A780C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EB92089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EB92089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMtk-0005qr-3U
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 13:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1heMVr-00029s-EX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1heMVp-0002k0-SW
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1heMVk-000285-Td; Fri, 21 Jun 2019 12:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBCEB30C62A8;
 Fri, 21 Jun 2019 16:35:25 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE0A21001B3F;
 Fri, 21 Jun 2019 16:35:22 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri, 21 Jun 2019 18:34:20 +0200
Message-Id: <20190621163422.6127-13-drjones@redhat.com>
In-Reply-To: <20190621163422.6127-1-drjones@redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 21 Jun 2019 16:35:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 12/14] target/arm/kvm: scratch vcpu:
 Preserve input kvm_vcpu_init features
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

kvm_arm_create_scratch_host_vcpu() takes a struct kvm_vcpu_init
parameter. Rather than just using it as an output parameter to
pass back the preferred target, use it also as an input parameter,
allowing a caller to pass a selected target if they wish and to
also pass cpu features. If the caller doesn't want to select a
target they can pass -1 for the target which indicates they want
to use the preferred target and have it passed back like before.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/kvm.c   | 20 +++++++++++++++-----
 target/arm/kvm32.c |  6 +++++-
 target/arm/kvm64.c |  6 +++++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 60645a196d3d..66c0c198604a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -64,7 +64,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *c=
pus_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
-    int ret, kvmfd =3D -1, vmfd =3D -1, cpufd =3D -1;
+    int ret =3D 0, kvmfd =3D -1, vmfd =3D -1, cpufd =3D -1;
=20
     kvmfd =3D qemu_open("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -84,7 +84,14 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *=
cpus_to_try,
         goto finish;
     }
=20
-    ret =3D ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, init);
+    if (init->target =3D=3D -1) {
+        struct kvm_vcpu_init preferred;
+
+        ret =3D ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
+        if (!ret) {
+            init->target =3D preferred.target;
+        }
+    }
     if (ret >=3D 0) {
         ret =3D ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
         if (ret < 0) {
@@ -96,10 +103,12 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t=
 *cpus_to_try,
          * creating one kind of guest CPU which is its preferred
          * CPU type.
          */
+        struct kvm_vcpu_init try;
+
         while (*cpus_to_try !=3D QEMU_KVM_ARM_TARGET_NONE) {
-            init->target =3D *cpus_to_try++;
-            memset(init->features, 0, sizeof(init->features));
-            ret =3D ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
+            try.target =3D *cpus_to_try++;
+            memcpy(try.features, init->features, sizeof(init->features))=
;
+            ret =3D ioctl(cpufd, KVM_ARM_VCPU_INIT, &try);
             if (ret >=3D 0) {
                 break;
             }
@@ -107,6 +116,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t =
*cpus_to_try,
         if (ret < 0) {
             goto err;
         }
+        init->target =3D try.target;
     } else {
         /* Treat a NULL cpus_to_try argument the same as an empty
          * list, which means we will fail the call since this must
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 51f78f722b18..d007f6bd34d7 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -54,7 +54,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures =
*ahcf)
         QEMU_KVM_ARM_TARGET_CORTEX_A15,
         QEMU_KVM_ARM_TARGET_NONE
     };
-    struct kvm_vcpu_init init;
+    /*
+     * target =3D -1 informs kvm_arm_create_scratch_host_vcpu()
+     * to use the preferred target
+     */
+    struct kvm_vcpu_init init =3D { .target =3D -1, };
=20
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) =
{
         return false;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 9fc7f078cf68..2821135a4d0e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -502,7 +502,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeature=
s *ahcf)
         KVM_ARM_TARGET_CORTEX_A57,
         QEMU_KVM_ARM_TARGET_NONE
     };
-    struct kvm_vcpu_init init;
+    /*
+     * target =3D -1 informs kvm_arm_create_scratch_host_vcpu()
+     * to use the preferred target
+     */
+    struct kvm_vcpu_init init =3D { .target =3D -1, };
=20
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) =
{
         return false;
--=20
2.20.1


