Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD7FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A64206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DRyXfdG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A64206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjho-0000zX-JI
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9v-0007Y4-AZ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9s-0005hg-QA
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:15 -0400
Received: from ozlabs.org ([203.11.71.1]:34251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9s-0005eA-E9; Fri, 27 Sep 2019 01:51:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrJ09xGz9sRh; Fri, 27 Sep 2019 15:50:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563440;
 bh=ftc+9reTs94x7+CEbKyUaxxznkMvEhB+bz3tkbgBK1I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DRyXfdG6TBy8RxoBpg2OweaJeoCG9HLxe9DmD0fju4BoLl9b+7rUjXKTkj8omltOG
 tZfqk4EyslXvRNaum/j/ZFudpHLIkCP4Nj8YAWQjTWCActgOTxtODgArhE+3qbhleT
 pTTCtANNtzoCSJKx/4aRNZtReM4tLWO4o+v8J0Bk=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 32/33] spapr: Move SpaprIrq::nr_xirqs to SpaprMachineClass
Date: Fri, 27 Sep 2019 15:50:27 +1000
Message-Id: <20190927055028.11493-33-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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

For the benefit of peripheral device allocation, the number of available
irqs really wants to be the same on a given machine type version,
regardless of what irq backends we are using.  That's the case now, but
only because we make sure the different SpaprIrq instances have the same
value except for the special legacy one.

Since this really only depends on machine type version, move the value to
SpaprMachineClass instead of SpaprIrq.  This also puts the code to set it
to the lower value on old machine types right next to setting
legacy_irq_allocation, which needs to go hand in hand.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             |  2 ++
 hw/ppc/spapr_irq.c         | 33 ++++++++++++++++-----------------
 include/hw/ppc/spapr.h     |  1 +
 include/hw/ppc/spapr_irq.h |  1 -
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 34b693beba..7113249c89 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4513,6 +4513,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->irq =3D &spapr_irq_dual;
     smc->dr_phb_enabled =3D true;
     smc->linux_pci_probe =3D true;
+    smc->nr_xirqs =3D SPAPR_NR_XIRQS;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -4648,6 +4649,7 @@ static void spapr_machine_3_0_class_options(Machine=
Class *mc)
     compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len)=
;
=20
     smc->legacy_irq_allocation =3D true;
+    smc->nr_xirqs =3D 0x400;
     smc->irq =3D &spapr_irq_xics_legacy;
 }
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 799755c811..f76f30f54b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -106,7 +106,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptContro=
ller *, Error **),
  */
=20
 SpaprIrq spapr_irq_xics =3D {
-    .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .xics        =3D true,
     .xive        =3D false,
 };
@@ -116,7 +115,6 @@ SpaprIrq spapr_irq_xics =3D {
  */
=20
 SpaprIrq spapr_irq_xive =3D {
-    .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .xics        =3D false,
     .xive        =3D true,
 };
@@ -134,7 +132,6 @@ SpaprIrq spapr_irq_xive =3D {
  * Define values in sync with the XIVE and XICS backend
  */
 SpaprIrq spapr_irq_dual =3D {
-    .nr_xirqs    =3D SPAPR_NR_XIRQS,
     .xics        =3D true,
     .xive        =3D true,
 };
@@ -249,16 +246,19 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_=
t nr_servers,
=20
 uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 {
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        return spapr->irq->nr_xirqs;
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    if (smc->legacy_irq_allocation) {
+        return smc->nr_xirqs;
     } else {
-        return SPAPR_XIRQ_BASE + spapr->irq->nr_xirqs - SPAPR_IRQ_MSI;
+        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
     }
 }
=20
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     Error *local_err =3D NULL;
=20
     if (machine_kernel_irqchip_split(machine)) {
@@ -295,8 +295,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
             goto out;
         }
=20
-        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
-                                &local_err);
+        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_er=
r);
         if (local_err) {
             goto out;
         }
@@ -315,8 +314,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
         int i;
=20
         dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs",
-                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
+        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_=
BASE);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -343,7 +341,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
     }
=20
     spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      spapr->irq->nr_xirqs + SPAPR_XIRQ_=
BASE);
+                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
=20
 out:
     error_propagate(errp, local_err);
@@ -351,10 +349,11 @@ out:
=20
 int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
 {
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int rc;
=20
     assert(irq >=3D SPAPR_XIRQ_BASE);
-    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
=20
     if (spapr->xive) {
         SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(spa=
pr->xive);
@@ -379,10 +378,11 @@ int spapr_irq_claim(SpaprMachineState *spapr, int i=
rq, bool lsi, Error **errp)
=20
 void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
 {
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int i;
=20
     assert(irq >=3D SPAPR_XIRQ_BASE);
-    assert((irq + num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert((irq + num) <=3D (smc->nr_xirqs + SPAPR_XIRQ_BASE));
=20
     for (i =3D irq; i < (irq + num); i++) {
         if (spapr->xive) {
@@ -402,6 +402,8 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq=
, int num)
=20
 qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
 {
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
     /*
      * This interface is basically for VIO and PHB devices to find the
      * right qemu_irq to manipulate, so we only allow access to the
@@ -410,7 +412,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq=
)
      * interfaces, we can change this if we need to in future.
      */
     assert(irq >=3D SPAPR_XIRQ_BASE);
-    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
=20
     if (spapr->ics) {
         assert(ics_valid_irq(spapr->ics, irq));
@@ -563,10 +565,7 @@ int spapr_irq_find(SpaprMachineState *spapr, int num=
, bool align, Error **errp)
     return first + ics->offset;
 }
=20
-#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
-
 SpaprIrq spapr_irq_xics_legacy =3D {
-    .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
     .xics        =3D true,
     .xive        =3D false,
 };
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 763da757f0..623e8e3f93 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -119,6 +119,7 @@ struct SpaprMachineClass {
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
+    uint32_t nr_xirqs;
     bool broken_host_serial_model; /* present real host info to the gues=
t */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 308bfcefd1..73d8beda39 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -77,7 +77,6 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint3=
2_t num, bool align,
 void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)=
;
=20
 typedef struct SpaprIrq {
-    uint32_t    nr_xirqs;
     bool        xics;
     bool        xive;
 } SpaprIrq;
--=20
2.21.0


