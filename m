Received: from eggs.gnu.org ([2001:4830:134:3::10]:57358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzJy2-0001k2-9c
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzJxw-0001A0-VH
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:02:54 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:33026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzJxw-00014y-Fh
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:02:48 -0400
Received: from player691.ha.ovh.net (unknown [10.109.143.146])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 05550D1605
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 13:02:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 10 Sep 2018 13:02:20 +0200
Message-Id: <20180910110222.8162-2-clg@kaod.org>
In-Reply-To: <20180910110222.8162-1-clg@kaod.org>
References: <20180910110222.8162-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] spapr: introduce a spapr_irq class
 'nr_msis' attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The number of MSI interrupts a sPAPR machine can allocate is in direct
relation with the number of interrupts of the sPAPRIrq backend. Define
statically this value at the sPAPRIrq class level.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h | 1 +
 hw/ppc/spapr_irq.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 0e98c4474bb2..650f810ad2aa 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -31,6 +31,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
=20
 typedef struct sPAPRIrq {
     uint32_t    nr_irqs;
+    uint32_t    nr_msis;
=20
     void (*init)(sPAPRMachineState *spapr, Error **errp);
     int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **er=
rp);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0cbb5dd39368..d369ac96f5cd 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -99,7 +99,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *spap=
r, Error **errp)
=20
     /* Initialize the MSI IRQ allocator. */
     if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ_MS=
I);
+        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
     }
=20
     if (kvm_enabled()) {
@@ -195,8 +195,13 @@ static void spapr_irq_print_info_xics(sPAPRMachineSt=
ate *spapr, Monitor *mon)
     ics_pic_print_info(spapr->ics, mon);
 }
=20
+#define SPAPR_IRQ_XICS_NR_IRQS     XICS_IRQS_SPAPR
+#define SPAPR_IRQ_XICS_NR_MSIS     \
+    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
+
 sPAPRIrq spapr_irq_xics =3D {
-    .nr_irqs     =3D XICS_IRQS_SPAPR,
+    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
+    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
--=20
2.17.1
