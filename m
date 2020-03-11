Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D00C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D5A21D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMubJKur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D5A21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1qp-0003hs-0m
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jC1ly-0002LA-Tx
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jC1lx-0001JF-RK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:51:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jC1lx-0001J3-NW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1He/Rpf4JLCiKi93YfAGw3px9JkkCyAWLJbg5rNbYc=;
 b=VMubJKurYFAQ9di2nCg5uxKUnmvO0v3P1fk5CbKdhuH1eQg24C0heqLW3bVckHBJECwjPl
 /elMgFmRun9c4dRn3fNGed/SeJXQcuc2NR7lv25tzzRODjkKnzyFHqvXEXQI1H9GqxnSA8
 aYkauyn6o7rhR9IUJo/EPqUzq1Ypw0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-Y8tlArngP2eITKWtybUnnQ-1; Wed, 11 Mar 2020 09:51:43 -0400
X-MC-Unique: Y8tlArngP2eITKWtybUnnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B410E6A6;
 Wed, 11 Mar 2020 13:51:41 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 265CE5C13D;
 Wed, 11 Mar 2020 13:51:36 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v6 03/13] arm/arm64: gic: Introduce setup_irq()
 helper
Date: Wed, 11 Mar 2020 14:51:07 +0100
Message-Id: <20200311135117.9366-4-eric.auger@redhat.com>
In-Reply-To: <20200311135117.9366-1-eric.auger@redhat.com>
References: <20200311135117.9366-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, andre.przywara@arm.com,
 thuth@redhat.com, yuzenghui@huawei.com, alexandru.elisei@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ipi_enable() code would be reusable for other interrupts
than IPI. Let's rename it setup_irq() and pass an interrupt
handler pointer.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- s/handler_t/irq_handler_t
- also add irq_handler_fn in lib/arm/asm/processor.h

v2 -> v3:
- do not export setup_irq anymore
---
 arm/gic.c               | 19 ++++++-------------
 lib/arm/asm/processor.h |  2 ++
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index fcf4c1f..2f904b0 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -215,20 +215,20 @@ static void ipi_test_smp(void)
 	report_prefix_pop();
 }
=20
-static void ipi_enable(void)
+static void setup_irq(irq_handler_fn handler)
 {
 	gic_enable_defaults();
 #ifdef __arm__
-	install_exception_handler(EXCPTN_IRQ, ipi_handler);
+	install_exception_handler(EXCPTN_IRQ, handler);
 #else
-	install_irq_handler(EL1H_IRQ, ipi_handler);
+	install_irq_handler(EL1H_IRQ, handler);
 #endif
 	local_irq_enable();
 }
=20
 static void ipi_send(void)
 {
-	ipi_enable();
+	setup_irq(ipi_handler);
 	wait_on_ready();
 	ipi_test_self();
 	ipi_test_smp();
@@ -238,7 +238,7 @@ static void ipi_send(void)
=20
 static void ipi_recv(void)
 {
-	ipi_enable();
+	setup_irq(ipi_handler);
 	cpumask_set_cpu(smp_processor_id(), &ready);
 	while (1)
 		wfi();
@@ -295,14 +295,7 @@ static void ipi_clear_active_handler(struct pt_regs =
*regs __unused)
 static void run_active_clear_test(void)
 {
 	report_prefix_push("active");
-	gic_enable_defaults();
-#ifdef __arm__
-	install_exception_handler(EXCPTN_IRQ, ipi_clear_active_handler);
-#else
-	install_irq_handler(EL1H_IRQ, ipi_clear_active_handler);
-#endif
-	local_irq_enable();
-
+	setup_irq(ipi_clear_active_handler);
 	ipi_test_self();
 	report_prefix_pop();
 }
diff --git a/lib/arm/asm/processor.h b/lib/arm/asm/processor.h
index 1e1132d..e26ef89 100644
--- a/lib/arm/asm/processor.h
+++ b/lib/arm/asm/processor.h
@@ -26,7 +26,9 @@ enum vector {
 	EXCPTN_MAX,
 };
=20
+typedef void (*irq_handler_fn)(struct pt_regs *regs);
 typedef void (*exception_fn)(struct pt_regs *);
+
 extern void install_exception_handler(enum vector v, exception_fn fn);
=20
 extern void show_regs(struct pt_regs *regs);
--=20
2.20.1


