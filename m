Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70545C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CA320717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CA320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8iLW-0001CK-52
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i8iK1-0008Is-Ei
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i8iK0-0007Nr-FN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i8iJy-0007Mv-Bp; Fri, 13 Sep 2019 05:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FA72300C72B;
 Fri, 13 Sep 2019 09:56:53 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB97960C44;
 Fri, 13 Sep 2019 09:56:51 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 11:56:39 +0200
Message-Id: <20190913095639.25447-4-eric.auger@redhat.com>
In-Reply-To: <20190913095639.25447-1-eric.auger@redhat.com>
References: <20190913095639.25447-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 13 Sep 2019 09:56:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 3/3] ARM: KVM: Check
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256
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
Cc: yuzenghui@huawei.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Host kernel within [4.18, 5.3] report an erroneous KVM_MAX_VCPUS=3D512
for ARM. The actual capability to instantiate more than 256 vcpus
was fixed in 5.4 with the upgrade of the KVM_IRQ_LINE ABI to support
vcpu id encoded on 12 bits instead of 8 and a redistributor consuming
a single KVM IO device instead of 2.

So let's check this capability when attempting to use more than 256
vcpus within any ARM kvm accelerated machine.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- Implement the check in kvm_arch_init as suggested by Peter
---
 target/arm/kvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b10581fa06..b473c63edb 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -182,6 +182,7 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
=20
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    int ret =3D 0;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -195,7 +196,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
=20
     cap_has_mp_state =3D kvm_check_extension(s, KVM_CAP_MP_STATE);
=20
-    return 0;
+    if (ms->smp.cpus > 256 &&
+        !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
+        error_report("Using more than 256 vcpus requires a host kernel "
+                     "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
+        ret =3D -EINVAL;
+    }
+
+    return ret;
 }
=20
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
--=20
2.20.1


