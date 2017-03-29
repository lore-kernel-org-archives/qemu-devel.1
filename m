Received: from eggs.gnu.org ([2001:4830:134:3::10]:53398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE3E-0006bq-K3
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE3B-0001DS-DA
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:16 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:50909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ctE3B-0001DJ-6O
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:13 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D462E6BB83
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 15:54:11 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 29 Mar 2017 15:53:27 +0200
Message-Id: <1490795611-4762-6-git-send-email-clg@kaod.org>
In-Reply-To: <1490795611-4762-1-git-send-email-clg@kaod.org>
References: <1490795611-4762-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 5/9] ppc/pnv: create the ICP object under
 PnvCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Each thread of a core is linked to an ICP. This allocates a PnvICPState
object when the PowerPCCPU object is realized and lets the XICSFabric
do the store under the 'intc' backlink when xics_cpu_setup() is
called.

This modeling removes the need of maintaining an array of ICP objects
under the PowerNV machine and also simplifies the XICSFabric icp_get()
handler.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v3:

 - removed the array of ICP objects from under the PowerNV machine and
   handled the allocation of the PnvICPState object for each thread
   when the PowerPCCPU object is realized.

 hw/ppc/pnv.c      |  2 ++
 hw/ppc/pnv_core.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3fa722af82e6..9505ca7dc09a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -691,6 +691,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
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
index d79d530b4881..87686a1b9e3b 100644
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
@@ -43,12 +44,14 @@ static void powernv_cpu_reset(void *opaque)
     env->msr |=3D MSR_HVB; /* Hypervisor mode */
 }
=20
-static void powernv_cpu_init(PowerPCCPU *cpu, Error **errp)
+static void powernv_cpu_init(PowerPCCPU *cpu, XICSFabric *xi, Error **er=
rp)
 {
     CPUPPCState *env =3D &cpu->env;
     int core_pir;
     int thread_index =3D 0; /* TODO: TCG supports only one thread */
     ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
+    Object *obj;
+    Error *local_err =3D NULL;
=20
     core_pir =3D object_property_get_int(OBJECT(cpu), "core-pir", &error=
_abort);
=20
@@ -63,6 +66,17 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error **=
errp)
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
=20
     qemu_register_reset(powernv_cpu_reset, cpu);
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
+
+    xics_cpu_setup(xi, cpu, ICP(obj));
 }
=20
 /*
@@ -110,7 +124,7 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-static void pnv_core_realize_child(Object *child, Error **errp)
+static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
 {
     Error *local_err =3D NULL;
     CPUState *cs =3D CPU(child);
@@ -122,7 +136,7 @@ static void pnv_core_realize_child(Object *child, Err=
or **errp)
         return;
     }
=20
-    powernv_cpu_init(cpu, &local_err);
+    powernv_cpu_init(cpu, xi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -140,6 +154,14 @@ static void pnv_core_realize(DeviceState *dev, Error=
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
@@ -160,7 +182,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
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
2.7.4
