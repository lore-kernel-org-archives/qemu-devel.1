Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D4CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F7024679
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3UfLBzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F7024679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIWs-0006yu-7r
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOr-0002Cr-0g
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOp-0004Ms-LU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54529
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHOp-0004KP-E0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19yQ4vp56OlBsL/0IrWKby5/zs2yahEC4NVwVl09/bk=;
 b=G3UfLBzYqlCXsU0y1w7G3tsyPap1TergDLakD7weNcp8zgYg1Do9nWfUNWWeOQtugi1xD1
 w4/Os6hTZ4+WF/9uLYo0DlTrQSeZ4AT43qyS86KAOTua0CTpetsFGOECA9RzSejZW488nn
 kgLdSQugQ6zs28CdteQv+C/zn85jjI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-K79uiRAXONuXvi2zOw0w7Q-1; Fri, 06 Dec 2019 12:28:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B301B1005502;
 Fri,  6 Dec 2019 17:28:11 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0C1E60BF4;
 Fri,  6 Dec 2019 17:28:06 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 09/10] arm/arm64: gic: Introduce setup_irq()
 helper
Date: Fri,  6 Dec 2019 18:27:23 +0100
Message-Id: <20191206172724.947-10-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: K79uiRAXONuXvi2zOw0w7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

ipi_enable() code would be reusable for other interrupts
than IPI. Let's rename it setup_irq() and pass an interrupt
handler pointer. We also export it to use it in other tests
such as the PMU's one.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/gic.c         | 24 +++---------------------
 lib/arm/asm/gic.h |  3 +++
 lib/arm/gic.c     | 11 +++++++++++
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index adb6aa4..04919ae 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -215,20 +215,9 @@ static void ipi_test_smp(void)
 =09report_prefix_pop();
 }
=20
-static void ipi_enable(void)
-{
-=09gic_enable_defaults();
-#ifdef __arm__
-=09install_exception_handler(EXCPTN_IRQ, ipi_handler);
-#else
-=09install_irq_handler(EL1H_IRQ, ipi_handler);
-#endif
-=09local_irq_enable();
-}
-
 static void ipi_send(void)
 {
-=09ipi_enable();
+=09setup_irq(ipi_handler);
 =09wait_on_ready();
 =09ipi_test_self();
 =09ipi_test_smp();
@@ -238,7 +227,7 @@ static void ipi_send(void)
=20
 static void ipi_recv(void)
 {
-=09ipi_enable();
+=09setup_irq(ipi_handler);
 =09cpumask_set_cpu(smp_processor_id(), &ready);
 =09while (1)
 =09=09wfi();
@@ -295,14 +284,7 @@ static void ipi_clear_active_handler(struct pt_regs *r=
egs __unused)
 static void run_active_clear_test(void)
 {
 =09report_prefix_push("active");
-=09gic_enable_defaults();
-#ifdef __arm__
-=09install_exception_handler(EXCPTN_IRQ, ipi_clear_active_handler);
-#else
-=09install_irq_handler(EL1H_IRQ, ipi_clear_active_handler);
-#endif
-=09local_irq_enable();
-
+=09setup_irq(ipi_clear_active_handler);
 =09ipi_test_self();
 =09report_prefix_pop();
 }
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index 21cdb58..55dd84b 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -82,5 +82,8 @@ void gic_set_irq_target(int irq, int cpu);
 void gic_set_irq_group(int irq, int group);
 int gic_get_irq_group(int irq);
=20
+typedef void (*handler_t)(struct pt_regs *regs __unused);
+extern void setup_irq(handler_t handler);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_H_ */
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index aa9cb86..0c5511f 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -236,3 +236,14 @@ int gic_get_irq_group(int irq)
 {
 =09return gic_masked_irq_bits(irq, GICD_IGROUPR, 1, 0, ACCESS_READ);
 }
+
+void setup_irq(handler_t handler)
+{
+        gic_enable_defaults();
+#ifdef __arm__
+        install_exception_handler(EXCPTN_IRQ, handler);
+#else
+        install_irq_handler(EL1H_IRQ, handler);
+#endif
+        local_irq_enable();
+}
--=20
2.20.1


