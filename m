Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD869C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FE1206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FE1206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2e2s-0007TO-PD
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i2dz6-0003IR-Gn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i2dz5-0002FA-5u
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i2dz1-0002Du-Gs; Tue, 27 Aug 2019 12:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8AA67FDFB;
 Tue, 27 Aug 2019 16:06:10 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DCBD1001B13;
 Tue, 27 Aug 2019 16:06:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Tue, 27 Aug 2019 18:05:54 +0200
Message-Id: <20190827160554.30995-4-eric.auger@redhat.com>
In-Reply-To: <20190827160554.30995-1-eric.auger@redhat.com>
References: <20190827160554.30995-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 27 Aug 2019 16:06:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 3/3] virt: Check KVM_CAP_ARM_IRQ_LINE_LAYOUT_2
 for smp_cpus > 256
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
vcpus.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c        |  7 +++++++
 target/arm/kvm.c     |  7 +++++++
 target/arm/kvm_arm.h | 13 +++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d1629ccb3..bcc8d64384 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1575,6 +1575,13 @@ static void machvirt_init(MachineState *machine)
         virt_max_cpus =3D GIC_NCPU;
     }
=20
+    if (kvm_enabled() && max_cpus > 256 &&
+        !kvm_arm_irq_line_layout_2(MACHINE(vms))) {
+        error_report("Using more than 256 vcpus require a host kernel "
+                     "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
+        exit(1);
+    }
+
     if (max_cpus > virt_max_cpus) {
         error_report("Number of SMP CPUs requested (%d) exceeds max CPUs=
 "
                      "supported by machine 'mach-virt' (%d)",
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b2eaa50b8d..db88fcc5bf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -171,6 +171,13 @@ bool kvm_arm_pmu_supported(CPUState *cpu)
     return kvm_check_extension(s, KVM_CAP_ARM_PMU_V3);
 }
=20
+bool kvm_arm_irq_line_layout_2(MachineState *ms)
+{
+    KVMState *s =3D KVM_STATE(ms->accelerator);
+
+    return kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2);
+}
+
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     KVMState *s =3D KVM_STATE(ms->accelerator);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b3106c8600..06b4db4513 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -233,6 +233,14 @@ bool kvm_arm_pmu_supported(CPUState *cs);
  */
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms);
=20
+/**
+ * kvm_arm_irq_line_layout_2 - Returns whether more than 256
+ * vcpus are supported by KVM_IRQ_LINE
+ *
+ * @ms: Machine state handle
+ */
+bool kvm_arm_irq_line_layout_2(MachineState *ms);
+
 /**
  * kvm_arm_sync_mpstate_to_kvm
  * @cpu: ARMCPU
@@ -280,6 +288,11 @@ static inline int kvm_arm_get_max_vm_ipa_size(Machin=
eState *ms)
     return -ENOENT;
 }
=20
+static inline int kvm_arm_irq_line_layout_2(MachineState *ms)
+{
+    return -ENOENT;
+}
+
 static inline int kvm_arm_vgic_probe(void)
 {
     return 0;
--=20
2.20.1


