Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F8BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9592120717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9592120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8iMf-0002U7-QF
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i8iK0-0008Gl-0T
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i8iJy-0007NC-Ou
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i8iJw-0007M7-7M; Fri, 13 Sep 2019 05:56:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 855C68AB25B;
 Fri, 13 Sep 2019 09:56:51 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFF9E60C44;
 Fri, 13 Sep 2019 09:56:49 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 11:56:38 +0200
Message-Id: <20190913095639.25447-3-eric.auger@redhat.com>
In-Reply-To: <20190913095639.25447-1-eric.auger@redhat.com>
References: <20190913095639.25447-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 13 Sep 2019 09:56:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 2/3] intc/arm_gic: Support IRQ injection for
 more than 256 vpus
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

Host kernels that expose the KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 capability
allow injection of interrupts along with vcpu ids larger than 255.
Let's encode the vpcu id on 12 bits according to the upgraded KVM_IRQ_LIN=
E
ABI when needed.

Given that we have two callsites that need to assemble
the value for kvm_set_irq(), a new helper routine, kvm_arm_set_irq
is introduced.

Without that patch qemu exits with "kvm_set_irq: Invalid argument"
message.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Zenghui Yu <yuzenghui@huawei.com>

---

v2 -> v3:
- remove if (cpu !=3D0), drop mask, as per Drew's suggestions
---
 hw/intc/arm_gic_kvm.c |  7 ++-----
 target/arm/cpu.c      | 10 ++++------
 target/arm/kvm.c      | 12 ++++++++++++
 target/arm/kvm_arm.h  |  1 +
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index b56fda144f..9deb15e7e6 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -55,7 +55,7 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, int=
 level)
      * has separate fields in the irq number for type,
      * CPU number and interrupt number.
      */
-    int kvm_irq, irqtype, cpu;
+    int irqtype, cpu;
=20
     if (irq < (num_irq - GIC_INTERNAL)) {
         /* External interrupt. The kernel numbers these like the GIC
@@ -72,10 +72,7 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, in=
t level)
         cpu =3D irq / GIC_INTERNAL;
         irq %=3D GIC_INTERNAL;
     }
-    kvm_irq =3D (irqtype << KVM_ARM_IRQ_TYPE_SHIFT)
-        | (cpu << KVM_ARM_IRQ_VCPU_SHIFT) | irq;
-
-    kvm_set_irq(kvm_state, kvm_irq, !!level);
+    kvm_arm_set_irq(cpu, irqtype, irq, !!level);
 }
=20
 static void kvm_arm_gicv2_set_irq(void *opaque, int irq, int level)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c14471..13813fb213 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -576,16 +576,16 @@ static void arm_cpu_kvm_set_irq(void *opaque, int i=
rq, int level)
     ARMCPU *cpu =3D opaque;
     CPUARMState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
-    int kvm_irq =3D KVM_ARM_IRQ_TYPE_CPU << KVM_ARM_IRQ_TYPE_SHIFT;
     uint32_t linestate_bit;
+    int irq_id;
=20
     switch (irq) {
     case ARM_CPU_IRQ:
-        kvm_irq |=3D KVM_ARM_IRQ_CPU_IRQ;
+        irq_id =3D KVM_ARM_IRQ_CPU_IRQ;
         linestate_bit =3D CPU_INTERRUPT_HARD;
         break;
     case ARM_CPU_FIQ:
-        kvm_irq |=3D KVM_ARM_IRQ_CPU_FIQ;
+        irq_id =3D KVM_ARM_IRQ_CPU_FIQ;
         linestate_bit =3D CPU_INTERRUPT_FIQ;
         break;
     default:
@@ -597,9 +597,7 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq=
, int level)
     } else {
         env->irq_line_state &=3D ~linestate_bit;
     }
-
-    kvm_irq |=3D cs->cpu_index << KVM_ARM_IRQ_VCPU_SHIFT;
-    kvm_set_irq(kvm_state, kvm_irq, level ? 1 : 0);
+    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level=
);
 #endif
 }
=20
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b2eaa50b8d..b10581fa06 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -744,6 +744,18 @@ int kvm_arm_vgic_probe(void)
     }
 }
=20
+int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
+{
+    int kvm_irq =3D (irqtype << KVM_ARM_IRQ_TYPE_SHIFT) | irq;
+    int cpu_idx1 =3D cpu % 256;
+    int cpu_idx2 =3D cpu / 256;
+
+    kvm_irq |=3D (cpu_idx1 << KVM_ARM_IRQ_VCPU_SHIFT) |
+               (cpu_idx2 << KVM_ARM_IRQ_VCPU2_SHIFT);
+
+    return kvm_set_irq(kvm_state, kvm_irq, !!level);
+}
+
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice =
*dev)
 {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b3106c8600..b4e19457a0 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -253,6 +253,7 @@ int kvm_arm_vgic_probe(void);
=20
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
+int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
=20
 #else
=20
--=20
2.20.1


