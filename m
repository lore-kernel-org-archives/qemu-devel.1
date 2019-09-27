Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC12C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882BE20863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o/myXAOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882BE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjRO-0000r9-5c
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9S-0006lc-69
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9Q-00050I-2O
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:46 -0400
Received: from ozlabs.org ([203.11.71.1]:41869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9P-0004xb-H0; Fri, 27 Sep 2019 01:50:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrD4qGKz9sQy; Fri, 27 Sep 2019 15:50:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563436;
 bh=qhYcJkkudgnsn44UBh0ssvogcxBdApRBNIouidlOZRM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o/myXAOmKxVC9L4wcG3rgDfAvbQBIHN4shX7k/hpO6dXjvYN5FwNduLaJjirMtYb1
 0FZdzq5OFPJ1fTIFbz3IaBFRpW1Z2y7gsDXz08gLKvTjDKNy7Kg2r8V0pYSa6anHmy
 ar3IhaABPnfc+ryOBFxC0REWWo5eTXMZ++OEAasI=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 10/33] spapr: Eliminate nr_irqs parameter to SpaprIrq::init
Date: Fri, 27 Sep 2019 15:50:05 +1000
Message-Id: <20190927055028.11493-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only reason this parameter was needed was to work around the
inconsistent meaning of nr_irqs between xics and xive.  Now that we've
fixed that, we can consistently use the number directly in the SpaprIrq
configuration.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_irq.c         | 21 ++++++++++-----------
 include/hw/ppc/spapr_irq.h |  2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 3207b6bd01..cded3a0154 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -92,8 +92,7 @@ static void spapr_irq_init_kvm(SpaprMachineState *spapr=
,
  * XICS IRQ backend.
  */
=20
-static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs,
-                                Error **errp)
+static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp)
 {
     Object *obj;
     Error *local_err =3D NULL;
@@ -102,7 +101,8 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_xirqs,
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
     object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                    &error_fatal);
-    object_property_set_int(obj, nr_xirqs, "nr-irqs",  &error_fatal);
+    object_property_set_int(obj, spapr->irq->nr_xirqs,
+                            "nr-irqs",  &error_fatal);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -256,15 +256,15 @@ SpaprIrq spapr_irq_xics =3D {
 /*
  * XIVE IRQ backend.
  */
-static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_xirqs,
-                                Error **errp)
+static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp)
 {
     uint32_t nr_servers =3D spapr_max_server_number(spapr);
     DeviceState *dev;
     int i;
=20
     dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
-    qdev_prop_set_uint32(dev, "nr-irqs", nr_xirqs + SPAPR_XIRQ_BASE);
+    qdev_prop_set_uint32(dev, "nr-irqs",
+                         spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
     /*
      * 8 XIVE END structures per CPU. One for each available priority
      */
@@ -438,18 +438,17 @@ static SpaprIrq *spapr_irq_current(SpaprMachineStat=
e *spapr)
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_xirqs,
-                                Error **errp)
+static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp)
 {
     Error *local_err =3D NULL;
=20
-    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_xirqs, &local_err);
+    spapr_irq_xics.init(spapr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
=20
-    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_xirqs, &local_err);
+    spapr_irq_xive.init(spapr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -678,7 +677,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
         spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
     }
=20
-    spapr->irq->init(spapr, spapr->irq->nr_xirqs, errp);
+    spapr->irq->init(spapr, errp);
=20
     spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
                                       spapr->irq->nr_xirqs + SPAPR_XIRQ_=
BASE);
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index a8f9a2ab11..7e26288fcd 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -41,7 +41,7 @@ typedef struct SpaprIrq {
     uint32_t    nr_msis;
     uint8_t     ov5;
=20
-    void (*init)(SpaprMachineState *spapr, int nr_irqs, Error **errp);
+    void (*init)(SpaprMachineState *spapr, Error **errp);
     int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
     void (*free)(SpaprMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(SpaprMachineState *spapr, int irq);
--=20
2.21.0


