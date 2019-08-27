Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95D7C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818DD206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818DD206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2e0X-0004Ri-D5
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i2dz1-0003Bf-SW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i2dz0-0002Dn-NK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i2dyx-0002Cj-WE; Tue, 27 Aug 2019 12:06:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 425D57BDB0;
 Tue, 27 Aug 2019 16:06:07 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4541001B17;
 Tue, 27 Aug 2019 16:06:03 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Tue, 27 Aug 2019 18:05:53 +0200
Message-Id: <20190827160554.30995-3-eric.auger@redhat.com>
In-Reply-To: <20190827160554.30995-1-eric.auger@redhat.com>
References: <20190827160554.30995-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 27 Aug 2019 16:06:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 2/3] intc/arm_gic: Support PPI injection for more
 than 256 vpus
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
allow injection of PPIs along with vcpu ids larger than 255. Let's
encode the vpcu id on 12 bits according to the upgraded KVM_IRQ_LINE
ABI when needed.

Without that patch qemu exits with "kvm_set_irq: Invalid argument"
message.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
---
 hw/intc/arm_gic_kvm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index b56fda144f..889293e97f 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -56,6 +56,7 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, int=
 level)
      * CPU number and interrupt number.
      */
     int kvm_irq, irqtype, cpu;
+    int cpu_idx1 =3D 0, cpu_idx2 =3D 0;
=20
     if (irq < (num_irq - GIC_INTERNAL)) {
         /* External interrupt. The kernel numbers these like the GIC
@@ -63,17 +64,20 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, i=
nt level)
          * internal ones.
          */
         irqtype =3D KVM_ARM_IRQ_TYPE_SPI;
-        cpu =3D 0;
         irq +=3D GIC_INTERNAL;
     } else {
         /* Internal interrupt: decode into (cpu, interrupt id) */
         irqtype =3D KVM_ARM_IRQ_TYPE_PPI;
         irq -=3D (num_irq - GIC_INTERNAL);
         cpu =3D irq / GIC_INTERNAL;
+        cpu_idx2 =3D cpu / 256;
+        cpu_idx1 =3D cpu % 256;
         irq %=3D GIC_INTERNAL;
     }
-    kvm_irq =3D (irqtype << KVM_ARM_IRQ_TYPE_SHIFT)
-        | (cpu << KVM_ARM_IRQ_VCPU_SHIFT) | irq;
+    kvm_irq =3D (irqtype << KVM_ARM_IRQ_TYPE_SHIFT) |
+              (cpu_idx1 << KVM_ARM_IRQ_VCPU_SHIFT) |
+              ((cpu_idx2 & KVM_ARM_IRQ_VCPU2_MASK) << KVM_ARM_IRQ_VCPU2_=
SHIFT) |
+              irq;
=20
     kvm_set_irq(kvm_state, kvm_irq, !!level);
 }
--=20
2.20.1


