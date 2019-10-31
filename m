Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71BCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B042086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arvxgqDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B042086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQBs8-0003hG-Fn
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iQBYh-0003ed-6n
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iQBYf-0000Fi-Lq
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:36:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iQBYR-0007ra-4c
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572532562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKBy1Y1Kkn9dGmibAmsiz6a0MAdBDihiPMDDXFne0IQ=;
 b=arvxgqDxEXg0DXiBAoIFBHugpAlLizbqMhuVBvg4SG+/XzreZH2mKVO8gG4fBBLR9APk2f
 4gdM3nOjX5A0xnxzmwmfghJS5xRqSK6JSpmgkEAEriQgyEvW7kNGQm80wOUekTUqQpsx6r
 HxRmXd3o1Yt8PO59548op/AaTjwHAsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368--GBC6y7tPmezM__IsCJtsg-1; Thu, 31 Oct 2019 10:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D98801800D6B;
 Thu, 31 Oct 2019 14:35:57 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-117-53.ams2.redhat.com
 [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAEDB60870;
 Thu, 31 Oct 2019 14:35:26 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v8 7/9] target/arm/kvm: scratch vcpu: Preserve input
 kvm_vcpu_init features
Date: Thu, 31 Oct 2019 15:27:32 +0100
Message-Id: <20191031142734.8590-8-drjones@redhat.com>
In-Reply-To: <20191031142734.8590-1-drjones@redhat.com>
References: <20191031142734.8590-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: -GBC6y7tPmezM__IsCJtsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

kvm_arm_create_scratch_host_vcpu() takes a struct kvm_vcpu_init
parameter. Rather than just using it as an output parameter to
pass back the preferred target, use it also as an input parameter,
allowing a caller to pass a selected target if they wish and to
also pass cpu features. If the caller doesn't want to select a
target they can pass -1 for the target which indicates they want
to use the preferred target and have it passed back like before.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/kvm.c   | 20 +++++++++++++++-----
 target/arm/kvm32.c |  6 +++++-
 target/arm/kvm64.c |  6 +++++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f07332bbda30..5b82cefef608 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -66,7 +66,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpu=
s_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
-    int ret, kvmfd =3D -1, vmfd =3D -1, cpufd =3D -1;
+    int ret =3D 0, kvmfd =3D -1, vmfd =3D -1, cpufd =3D -1;
=20
     kvmfd =3D qemu_open("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -86,7 +86,14 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cp=
us_to_try,
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
@@ -98,10 +105,12 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *=
cpus_to_try,
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
+            memcpy(try.features, init->features, sizeof(init->features));
+            ret =3D ioctl(cpufd, KVM_ARM_VCPU_INIT, &try);
             if (ret >=3D 0) {
                 break;
             }
@@ -109,6 +118,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *c=
pus_to_try,
         if (ret < 0) {
             goto err;
         }
+        init->target =3D try.target;
     } else {
         /* Treat a NULL cpus_to_try argument the same as an empty
          * list, which means we will fail the call since this must
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 2451a2d4bbef..32bf8d6757c4 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -53,7 +53,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *a=
hcf)
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
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
         return false;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 850da1b5e6aa..c7ecefbed720 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -502,7 +502,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures =
*ahcf)
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
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
         return false;
--=20
2.21.0


