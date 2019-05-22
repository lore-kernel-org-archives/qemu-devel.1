Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287BBC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96BB2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KwvLJO3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96BB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTJek-0006pe-4p
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 01:19:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJAU-0004l5-1B
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJAS-0007aV-SN
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:47:57 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49737 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTJAS-0007Jn-G3; Wed, 22 May 2019 00:47:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4580T41Gz7z9sRG; Wed, 22 May 2019 14:46:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558500376;
	bh=N4Msu5vC5ToRCfQzQVywNNY77GKEdiRxWk6vPULpnQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwvLJO3X7MndBDT0Sdq7ysQEtWylMk4dTCiBwIxviPMlY0UWg7d/q9UvtdavWbH0F
	nExqzSYKdrPDRAVNDkKdRhhzTMPPspIwSaHssd6sDg84F9AexhQgh8Ol0rzceca7qn
	JJUuk107msTKFfEpSDmblhjOplVWG5k1H/7/KCWs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 22 May 2019 14:45:58 +1000
Message-Id: <20190522044600.16534-37-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522044600.16534-1-david@gibson.dropbear.id.au>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 36/38] ppc/xics: fix irq priority in
 ics_set_irq_type()
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Recent commits changed the behavior of ics_set_irq_type() to
initialize correctly LSIs at the KVM level. ics_set_irq_type() is also
called by the realize routine of the different devices of the machine
when initial interrupts are claimed, before the ICSState device is
reseted.

In the case, the ICSIRQState priority is 0x0 and the call to
ics_set_irq_type() results in configuring the target of the
interrupt. On P9, when using the KVM XICS-on-XIVE device, the target
is configured to be server 0, priority 0 and the event queue 0 is
created automatically by KVM.

With the dual interrupt mode creating the KVM device at reset, it
leads to unexpected effects on the guest, mostly blocking IPIs. This
is wrong, fix it by reseting the ICSIRQState structure when
ics_set_irq_type() is called.

Fixes: commit 6cead90c5c9c ("xics: Write source state to KVM at claim tim=
e")
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190513084245.25755-14-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index af7dc709ab..79f5a8a916 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -610,6 +610,12 @@ static const TypeInfo ics_simple_info =3D {
     .class_size =3D sizeof(ICSStateClass),
 };
=20
+static void ics_reset_irq(ICSIRQState *irq)
+{
+    irq->priority =3D 0xff;
+    irq->saved_priority =3D 0xff;
+}
+
 static void ics_base_reset(DeviceState *dev)
 {
     ICSState *ics =3D ICS_BASE(dev);
@@ -623,8 +629,7 @@ static void ics_base_reset(DeviceState *dev)
     memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
=20
     for (i =3D 0; i < ics->nr_irqs; i++) {
-        ics->irqs[i].priority =3D 0xff;
-        ics->irqs[i].saved_priority =3D 0xff;
+        ics_reset_irq(ics->irqs + i);
         ics->irqs[i].flags =3D flags[i];
     }
 }
@@ -760,6 +765,7 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool =
lsi)
         lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
=20
     if (kvm_irqchip_in_kernel()) {
+        ics_reset_irq(ics->irqs + srcno);
         ics_set_kvm_state_one(ics, srcno);
     }
 }
--=20
2.21.0


