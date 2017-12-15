Received: from eggs.gnu.org ([2001:4830:134:3::10]:53256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixN-0003fQ-UO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixM-0004iF-Rf
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:50 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:27 +1100
Message-Id: <20171215055435.24204-17-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/24] spapr: introduce a spapr_irq_set_lsi()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

It will make synchronisation easier with the XIVE interrupt mode when
available. The 'irq' parameter refers to the global IRQ number space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 53c2c58a25..02cc7ffd4d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3582,6 +3582,14 @@ static int ics_find_free_block(ICSState *ics, int =
num, int alignnum)
     return -1;
 }
=20
+/*
+ * Allocate the IRQ number and set the IRQ type, LSI or MSI
+ */
+static void spapr_irq_set_lsi(sPAPRMachineState *spapr, int irq, bool ls=
i)
+{
+    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
+}
+
 int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
                     Error **errp)
 {
@@ -3606,7 +3614,7 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int i=
rq_hint, bool lsi,
         irq +=3D ics->offset;
     }
=20
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
+    spapr_irq_set_lsi(spapr, irq, lsi);
     trace_spapr_irq_alloc(irq);
=20
     return irq;
@@ -3645,10 +3653,10 @@ int spapr_irq_alloc_block(sPAPRMachineState *spap=
r, int num, bool lsi,
         return -1;
     }
=20
+    first +=3D ics->offset;
     for (i =3D first; i < first + num; ++i) {
-        ics_set_irq_type(ics, i, lsi);
+        spapr_irq_set_lsi(spapr, i, lsi);
     }
-    first +=3D ics->offset;
=20
     trace_spapr_irq_alloc_block(first, num, lsi, align);
=20
--=20
2.14.3
