Received: from eggs.gnu.org ([2001:4830:134:3::10]:56339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIB-0001WE-Au
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIA-0003QP-7h
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:55 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:04 +1000
Message-Id: <20170424015927.8933-25-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/47] ppc/pnv: create the ICP object under
 PnvCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Each thread of a core is linked to an ICP. This allocates a PnvICPState
object before the PowerPCCPU object is realized and lets the XICSFabric
do the store under the 'intc' backlink when xics_cpu_setup() is
called.

This modeling removes the need of maintaining an array of ICP objects
under the PowerNV machine and also simplifies the XICSFabric icp_get()
handler.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c      |  2 ++
 hw/ppc/pnv_core.c | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f3623ee..2add2ad 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -694,6 +694,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
         object_property_set_int(OBJECT(pnv_core),
                                 pcc->core_pir(chip, core_hwid),
                                 "pir", &error_fatal);
+        object_property_add_const_link(OBJECT(pnv_core), "xics",
+                                       qdev_get_machine(), &error_fatal)=
;
         object_property_set_bool(OBJECT(pnv_core), true, "realized",
                                  &error_fatal);
         object_unref(OBJECT(pnv_core));
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index d79d530..1b7ec70 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -25,6 +25,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/xics.h"
=20
 static void powernv_cpu_reset(void *opaque)
 {
@@ -110,23 +111,37 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-static void pnv_core_realize_child(Object *child, Error **errp)
+static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
 {
     Error *local_err =3D NULL;
     CPUState *cs =3D CPU(child);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    Object *obj;
+
+    obj =3D object_new(TYPE_PNV_ICP);
+    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
+    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort=
);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
+        object_unparent(obj);
         error_propagate(errp, local_err);
         return;
     }
=20
     powernv_cpu_init(cpu, &local_err);
     if (local_err) {
+        object_unparent(obj);
         error_propagate(errp, local_err);
         return;
     }
+
+    xics_cpu_setup(xi, cpu, ICP(obj));
 }
=20
 static void pnv_core_realize(DeviceState *dev, Error **errp)
@@ -140,6 +155,14 @@ static void pnv_core_realize(DeviceState *dev, Error=
 **errp)
     void *obj;
     int i, j;
     char name[32];
+    Object *xi;
+
+    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
+    if (!xi) {
+        error_setg(errp, "%s: required link 'xics' not found: %s",
+                   __func__, error_get_pretty(local_err));
+        return;
+    }
=20
     pc->threads =3D g_malloc0(size * cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
@@ -160,7 +183,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     for (j =3D 0; j < cc->nr_threads; j++) {
         obj =3D pc->threads + j * size;
=20
-        pnv_core_realize_child(obj, &local_err);
+        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
         if (local_err) {
             goto err;
         }
--=20
2.9.3
