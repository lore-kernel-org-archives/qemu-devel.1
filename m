Received: from eggs.gnu.org ([2001:4830:134:3::10]:47755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpf-0001An-LP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpa-000287-Ta
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:30 -0500
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:37015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKnpa-00026P-Lb
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:26 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 44EC1177DB2
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 17:06:25 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  1 Dec 2017 17:06:01 +0100
Message-Id: <20171201160604.15265-3-clg@kaod.org>
In-Reply-To: <20171201160604.15265-1-clg@kaod.org>
References: <20171201160604.15265-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] ppc/xics: assign of the CPU 'intc' pointer
 under the core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The 'intc' pointer of the CPU references the interrupt presenter in
the XICS interrupt mode. When the XIVE interrupt mode is available and
activated, the machine will need to reassign this pointer to reflect
the change.

Moving this assignment under the realize routine of the CPU will ease
the process when the interrupt mode is toggled.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c          | 1 -
 hw/ppc/pnv_core.c       | 2 +-
 hw/ppc/spapr_cpu_core.c | 3 ++-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index bfc6b5bb2367..700f6baa1395 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -334,7 +334,6 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
     }
=20
     cpu =3D POWERPC_CPU(obj);
-    cpu->intc =3D OBJECT(icp);
     icp->cs =3D CPU(obj);
=20
     env =3D &cpu->env;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8d966e080288..03317db853d5 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -133,7 +133,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
         return;
     }
=20
-    icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 70e757f808c7..032438b9ce70 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -121,7 +121,8 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
         goto error;
     }
=20
-    icp_create(child, spapr->icp_type, XICS_FABRIC(spapr), &local_err);
+    cpu->intc =3D icp_create(child, spapr->icp_type, XICS_FABRIC(spapr),
+                           &local_err);
     if (local_err) {
         goto error;
     }
--=20
2.13.6
