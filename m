Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A9C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A6921479
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A6921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6tm-0002b5-23
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:05:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6o4-0006Yd-RI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6ZM-0004LV-BT
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:25 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:36645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6ZM-0004L6-5E
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:24 -0400
Received: from player778.ha.ovh.net (unknown [10.109.146.20])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6F9C26010C
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:44:22 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id AFE1B59C41EB;
	Mon, 13 May 2019 08:44:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:44 +0200
Message-Id: <20190513084245.25755-14-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3343359773746695142
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.197
Subject: [Qemu-devel] [PATCH v4 13/14] ppc/xics: fix irq priority in
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/intc/xics.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index af7dc709abab..79f5a8a91665 100644
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
2.20.1


