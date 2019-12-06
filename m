Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F40C2BBE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29899206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCuLAlb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29899206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idI7A-000473-Co
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOm-00028P-Kh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOk-0004D2-Ew
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49336
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHOk-0004B0-3t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lX67DIL+lZaCTnHkDq82inRHfTC6JJtSh3OkkISzfmY=;
 b=TCuLAlb3qiZZwH0YHSf/UdIwo2UnTKom8PX3jNxaCPdKhwz5QTndRSJF1ewCf/LJI8j18J
 ZdJI6vXY3kFvTwt5wA77Ttwqvmm+Vh10pXvT4RP51M/uDkrE1DieX5DqwRsLkVpK/SiPmX
 YUuaDG5CT+68qD3Q0YKhJ0ddA7Zn6FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-ZjMCxGmWPFqGGTt0nhH_nA-1; Fri, 06 Dec 2019 12:28:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A79D107ACC4;
 Fri,  6 Dec 2019 17:28:06 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C04AC60BF4;
 Fri,  6 Dec 2019 17:28:03 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 08/10] arm: gic: Provide per-IRQ helper functions
Date: Fri,  6 Dec 2019 18:27:22 +0100
Message-Id: <20191206172724.947-9-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ZjMCxGmWPFqGGTt0nhH_nA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, andrew.murray@arm.com, drjones@redhat.com,
 andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andre Przywara <andre.przywara@arm.com>

A common theme when accessing per-IRQ parameters in the GIC distributor
is to set fields of a certain bit width in a range of MMIO registers.
Examples are the enabled status (one bit per IRQ), the level/edge
configuration (2 bits per IRQ) or the priority (8 bits per IRQ).

Add a generic helper function which is able to mask and set the
respective number of bits, given the IRQ number and the MMIO offset.
Provide wrappers using this function to easily allow configuring an IRQ.

For now assume that private IRQ numbers always refer to the current CPU.
In a GICv2 accessing the "other" private IRQs is not easily doable (the
registers are banked per CPU on the same MMIO address), so we impose the
same limitation on GICv3, even though those registers are not banked
there anymore.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

---

initialize reg
---
 lib/arm/asm/gic-v3.h |  2 +
 lib/arm/asm/gic.h    |  9 +++++
 lib/arm/gic.c        | 90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
index 347be2f..4a445a5 100644
--- a/lib/arm/asm/gic-v3.h
+++ b/lib/arm/asm/gic-v3.h
@@ -23,6 +23,8 @@
 #define GICD_CTLR_ENABLE_G1A=09=09(1U << 1)
 #define GICD_CTLR_ENABLE_G1=09=09(1U << 0)
=20
+#define GICD_IROUTER=09=09=090x6000
+
 /* Re-Distributor registers, offsets from RD_base */
 #define GICR_TYPER=09=09=090x0008
=20
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index 1fc10a0..21cdb58 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -15,6 +15,7 @@
 #define GICD_IIDR=09=09=090x0008
 #define GICD_IGROUPR=09=09=090x0080
 #define GICD_ISENABLER=09=09=090x0100
+#define GICD_ICENABLER=09=09=090x0180
 #define GICD_ISPENDR=09=09=090x0200
 #define GICD_ICPENDR=09=09=090x0280
 #define GICD_ISACTIVER=09=09=090x0300
@@ -73,5 +74,13 @@ extern void gic_write_eoir(u32 irqstat);
 extern void gic_ipi_send_single(int irq, int cpu);
 extern void gic_ipi_send_mask(int irq, const cpumask_t *dest);
=20
+void gic_set_irq_bit(int irq, int offset);
+void gic_enable_irq(int irq);
+void gic_disable_irq(int irq);
+void gic_set_irq_priority(int irq, u8 prio);
+void gic_set_irq_target(int irq, int cpu);
+void gic_set_irq_group(int irq, int group);
+int gic_get_irq_group(int irq);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_H_ */
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index 9430116..aa9cb86 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -146,3 +146,93 @@ void gic_ipi_send_mask(int irq, const cpumask_t *dest)
 =09assert(gic_common_ops && gic_common_ops->ipi_send_mask);
 =09gic_common_ops->ipi_send_mask(irq, dest);
 }
+
+enum gic_bit_access {
+=09ACCESS_READ,
+=09ACCESS_SET,
+=09ACCESS_RMW
+};
+
+static u8 gic_masked_irq_bits(int irq, int offset, int bits, u8 value,
+=09=09=09      enum gic_bit_access access)
+{
+=09void *base;
+=09int split =3D 32 / bits;
+=09int shift =3D (irq % split) * bits;
+=09u32 reg =3D 0, mask =3D ((1U << bits) - 1) << shift;
+
+=09switch (gic_version()) {
+=09case 2:
+=09=09base =3D gicv2_dist_base();
+=09=09break;
+=09case 3:
+=09=09if (irq < 32)
+=09=09=09base =3D gicv3_sgi_base();
+=09=09else
+=09=09=09base =3D gicv3_dist_base();
+=09=09break;
+=09default:
+=09=09return 0;
+=09}
+=09base +=3D offset + (irq / split) * 4;
+
+=09switch (access) {
+=09case ACCESS_READ:
+=09=09return (readl(base) & mask) >> shift;
+=09case ACCESS_SET:
+=09=09reg =3D 0;
+=09=09break;
+=09case ACCESS_RMW:
+=09=09reg =3D readl(base) & ~mask;
+=09=09break;
+=09}
+
+=09writel(reg | ((u32)value << shift), base);
+
+=09return 0;
+}
+
+void gic_set_irq_bit(int irq, int offset)
+{
+=09gic_masked_irq_bits(irq, offset, 1, 1, ACCESS_SET);
+}
+
+void gic_enable_irq(int irq)
+{
+=09gic_set_irq_bit(irq, GICD_ISENABLER);
+}
+
+void gic_disable_irq(int irq)
+{
+=09gic_set_irq_bit(irq, GICD_ICENABLER);
+}
+
+void gic_set_irq_priority(int irq, u8 prio)
+{
+=09gic_masked_irq_bits(irq, GICD_IPRIORITYR, 8, prio, ACCESS_RMW);
+}
+
+void gic_set_irq_target(int irq, int cpu)
+{
+=09if (irq < 32)
+=09=09return;
+
+=09if (gic_version() =3D=3D 2) {
+=09=09gic_masked_irq_bits(irq, GICD_ITARGETSR, 8, 1U << cpu,
+=09=09=09=09    ACCESS_RMW);
+
+=09=09return;
+=09}
+
+=09writeq(cpus[cpu], gicv3_dist_base() + GICD_IROUTER + irq * 8);
+}
+
+void gic_set_irq_group(int irq, int group)
+{
+=09gic_masked_irq_bits(irq, GICD_IGROUPR, 1, group, ACCESS_RMW);
+}
+
+int gic_get_irq_group(int irq)
+{
+=09return gic_masked_irq_bits(irq, GICD_IGROUPR, 1, 0, ACCESS_READ);
+}
--=20
2.20.1


