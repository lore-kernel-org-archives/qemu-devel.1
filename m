Received: from eggs.gnu.org ([2001:4830:134:3::10]:58666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xj-0001ol-AV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xf-0001T2-EX
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:55 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:33393)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xf-0001SI-9E
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:51 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.117])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3662712E80A
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:50 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:28 +0200
Message-Id: <20180419124331.3915-33-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 32/35] ppc/pnv: introduce a pnv_icp_create()
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

The type of the interrupt presenter depends on the processor family,
POWER8 uses XICS and POWER9 uses XIVE. Provide a machine-level helper
to isolate the process and hide the details to the pnv core realize
function.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c         | 14 ++++++++++++++
 hw/ppc/pnv_core.c    |  2 +-
 include/hw/ppc/pnv.h |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 98ee3c607ae7..91452b7eeb01 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1015,6 +1015,20 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int p=
ir)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
+Object *pnv_icp_create(PnvMachineState *pnv, Object *cpu, Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D icp_create(cpu, TYPE_PNV_ICP, XICS_FABRIC(pnv), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return obj;
+}
+
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
                                Monitor *mon)
 {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index cbb64ad9e7e0..1961dd2a2641 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -133,7 +133,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
         return;
     }
=20
-    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    cpu->intc =3D pnv_icp_create(PNV_MACHINE(xi), child, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 90759240a7b1..877c3b79b239 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -191,4 +191,6 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
     (0x0003ffe000000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * \
      PNV_PSIHB_FSP_SIZE)
=20
+Object *pnv_icp_create(PnvMachineState *spapr, Object *cpu, Error **errp=
);
+
 #endif /* _PPC_PNV_H */
--=20
2.13.6
