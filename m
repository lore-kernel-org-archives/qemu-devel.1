Received: from eggs.gnu.org ([2001:4830:134:3::10]:45948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalK-0001w1-DO
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalG-000801-GB
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:34 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:55923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNalG-0007zG-9u
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:30 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id E0D811277CF
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:45:28 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:34 +0100
Message-Id: <20171209084338.29395-16-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/19] spapr: add XIVE support to
 spapr_qirq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE object has its own set of qirqs which is to be used when the
XIVE exploitation interrupt mode is activated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:
=20
 - introduced a spapr_xive_qirq() helper

 hw/intc/spapr_xive.c        | 12 ++++++++++++
 hw/ppc/spapr.c              |  4 ++++
 include/hw/ppc/spapr_xive.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index fcdadf727f9d..e650ed69eb70 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -980,3 +980,15 @@ void spapr_xive_mmio_map(sPAPRXive *xive)
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->tm_base);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base + (1 << TM_SH=
IFT));
 }
+
+qemu_irq spapr_xive_qirq(sPAPRXive *xive, int lisn)
+{
+    XiveIVE *ive =3D spapr_xive_get_ive(xive, lisn);
+
+    if (!ive || !(ive->w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
+        return NULL;
+    }
+
+    return xive->qirqs[lisn];
+}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 73df038a9e8b..d117fbd5ce9d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3810,6 +3810,10 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int =
irq)
 {
     ICSState *ics =3D spapr->ics;
=20
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return spapr_xive_qirq(spapr->xive, irq);
+    }
+
     if (ics_valid_irq(ics, irq)) {
         return ics->qirqs[irq - ics->offset];
     }
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 5d0c178a4984..8eefb09999de 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -60,6 +60,7 @@ bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t l=
isn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 void spapr_xive_nvt_pic_print_info(sPAPRXiveNVT *nvt, Monitor *mon);
 void spapr_xive_mmio_map(sPAPRXive *xive);
+qemu_irq spapr_xive_qirq(sPAPRXive *xive, int lisn);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
--=20
2.13.6
