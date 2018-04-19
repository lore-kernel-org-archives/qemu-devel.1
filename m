Received: from eggs.gnu.org ([2001:4830:134:3::10]:57775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wQ-0000fQ-Sy
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wM-0000RE-Sn
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:34 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:32845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wM-0000QN-M3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:30 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.13])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C3048198890
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:28 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:14 +0200
Message-Id: <20180419124331.3915-19-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 18/35] spapr: introduce a spapr_icp_create()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On sPAPR, the creation of the interrupt presenter depends on some of
the machine attributes. When the XIVE exploitation interrupt mode is
available, this will get more complex. So provide a machine-level
helper to isolate the process and hide the details to the sPAPR core
realize function.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c          | 14 ++++++++++++++
 hw/ppc/spapr_cpu_core.c |  3 +--
 include/hw/ppc/spapr.h  |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4fcc942ccfa3..32c7801b249e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3952,6 +3952,20 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int =
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
index 94afeb399e99..76bff4cc372d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -129,8 +129,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
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
index 6b6496d9c343..d5e168f5ad4e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -819,4 +819,6 @@ void spapr_caps_reset(sPAPRMachineState *spapr);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
=20
+Object *spapr_icp_create(sPAPRMachineState *spapr, Object *cpu, Error **=
errp);
+
 #endif /* HW_SPAPR_H */
--=20
2.13.6
