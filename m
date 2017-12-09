Received: from eggs.gnu.org ([2001:4830:134:3::10]:45981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalQ-0001zE-CZ
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNalM-00081q-FM
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:40 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:33071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNalM-00081e-7e
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:45:36 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1B6121277DB
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:45:35 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:35 +0100
Message-Id: <20171209084338.29395-17-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/19] spapr: introduce a spapr_icp_create()
 helper
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

On sPAPR, the creation of the interrupt presenter depends on some of
the machine attributes. When the XIVE exploitation interrupt mode is
available, this will get more complex. So provide a machine-level
helper to isolate the process and hide the details to the sPAPR core
realize function.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c          | 14 ++++++++++++++
 hw/ppc/spapr_cpu_core.c |  3 +--
 include/hw/ppc/spapr.h  |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d117fbd5ce9d..65fca10e5b30 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3821,6 +3821,20 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int =
irq)
     return NULL;
 }
=20
+Object *spapr_icp_create(sPAPRMachineState *spapr, Object *cpu, Error **=
errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), &local_=
err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return obj;
+}
+
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
                                  Monitor *mon)
 {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 032438b9ce70..1bfe3ff55058 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -121,8 +121,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
         goto error;
     }
=20
-    cpu->intc =3D icp_create(child, spapr->icp_type, XICS_FABRIC(spapr),
-                           &local_err);
+    cpu->intc =3D spapr_icp_create(spapr, child, &local_err);
     if (local_err) {
         goto error;
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ad923e668946..40bda1a34607 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -740,4 +740,6 @@ int spapr_irq_alloc_block(sPAPRMachineState *spapr, i=
nt num, bool lsi,
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
=20
+Object *spapr_icp_create(sPAPRMachineState *spapr, Object *cpu, Error **=
errp);
+
 #endif /* HW_SPAPR_H */
--=20
2.13.6
