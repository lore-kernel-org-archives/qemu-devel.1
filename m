Received: from eggs.gnu.org ([2001:4830:134:3::10]:37836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrb3-0000ly-Vr
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrb0-0000PD-QO
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:18 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrb0-0000NH-KM
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:14 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6B74B175AA8
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:31:13 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:33 +0100
Message-Id: <20171123132955.1261-4-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/25] spapr: introduce a spapr_icp_create()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On sPAPR, the creation of the interrupt presenter depends on some of
the machine attributes. When the XIVE interrupt mode is available,
this will get more complex. So provide a machine-level helper to
isolate the process and hide the details to the sPAPR core realize
function.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c          | 14 ++++++++++++++
 hw/ppc/spapr_cpu_core.c |  2 +-
 include/hw/ppc/spapr.h  |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 174e7ff0678d..925cbd3c1bf4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3556,6 +3556,20 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
 vcpu_id)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
+Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Error *=
*errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_e=
rr);
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
index f7cc74512481..61a9850e688b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -122,7 +122,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
         goto error;
     }
=20
-    cpu->intc =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &l=
ocal_err);
+    cpu->intc =3D spapr_icp_create(spapr, cs, &local_err);
     if (local_err) {
         goto error;
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9d21ca9bde3a..9da38de34277 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -707,4 +707,6 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
 int spapr_vcpu_id(PowerPCCPU *cpu);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
=20
+Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Error *=
*errp);
+
 #endif /* HW_SPAPR_H */
--=20
2.13.6
