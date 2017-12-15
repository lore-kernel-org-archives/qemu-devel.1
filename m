Received: from eggs.gnu.org ([2001:4830:134:3::10]:53306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixP-0003hz-GW
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixN-0004jL-SF
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:25 +1100
Message-Id: <20171215055435.24204-15-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/24] ppc/xics: assign of the CPU 'intc'
 pointer under the core
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

The 'intc' pointer of the CPU references the interrupt presenter in
the XICS interrupt mode. When the XIVE interrupt mode is available and
activated, the machine will need to reassign this pointer to reflect
the change.

Moving this assignment under the realize routine of the CPU will ease
the process when the interrupt mode is toggled.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c          | 1 -
 hw/ppc/pnv_core.c       | 2 +-
 hw/ppc/spapr_cpu_core.c | 3 ++-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index bfc6b5bb23..700f6baa13 100644
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
index 8d966e0802..03317db853 100644
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
index 70e757f808..032438b9ce 100644
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
2.14.3
