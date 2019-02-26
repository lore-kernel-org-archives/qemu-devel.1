Received: from eggs.gnu.org ([209.51.188.92]:58301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlP-0005Zt-7O
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlN-0002zY-Aw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:47 +1100
Message-Id: <20190226045304.25618-34-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/50] spapr/drc: Drop spapr_drc_attach() fdt
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

All DRC subtypes have been converted to generate the FDT fragment at
configure connector time instead of attach time. The fdt and fdt_offset
arguments of spapr_drc_attach() aren't needed anymore. Drop them and
make the implementation of the dt_populate() method mandatory.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059667853.1466090.16527852453054217565.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             |  4 ++--
 hw/ppc/spapr_drc.c         | 13 +------------
 hw/ppc/spapr_pci.c         |  2 +-
 include/hw/ppc/spapr_drc.h |  3 +--
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6cf7a9f5c1..9364d07364 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3362,7 +3362,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
=20
-        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
+        spapr_drc_attach(drc, dev, &local_err);
         if (local_err) {
             while (addr > addr_start) {
                 addr -=3D SPAPR_MEMORY_BLOCK_SIZE;
@@ -3744,7 +3744,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
     g_assert(drc || !mc->has_hotpluggable_cpus);
=20
     if (drc) {
-        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
+        spapr_drc_attach(drc, dev, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 248eb8a93d..87ca7d9735 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -374,11 +374,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, co=
nst char *name,
     } while (fdt_depth !=3D 0);
 }
=20
-void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                      int fdt_start_offset, Error **errp)
+void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-
     trace_spapr_drc_attach(spapr_drc_index(drc));
=20
     if (drc->dev) {
@@ -387,15 +384,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceS=
tate *d, void *fdt,
     }
     g_assert((drc->state =3D=3D SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
              || (drc->state =3D=3D SPAPR_DRC_STATE_PHYSICAL_POWERON));
-    g_assert(fdt || drck->dt_populate);
=20
     drc->dev =3D d;
=20
-    if (fdt) {
-        drc->fdt =3D fdt;
-        drc->fdt_start_offset =3D fdt_start_offset;
-    }
-
     object_property_add_link(OBJECT(drc), "device",
                              object_get_typename(OBJECT(drc->dev)),
                              (Object **)(&drc->dev),
@@ -1113,8 +1104,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
=20
     drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
-    g_assert(drc->fdt || drck->dt_populate);
-
     if (!drc->fdt) {
         Error *local_err =3D NULL;
         void *fdt;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b22c9f57b2..e2bc9fec82 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1457,7 +1457,7 @@ static void spapr_pci_plug(HotplugHandler *plug_han=
dler,
         goto out;
     }
=20
-    spapr_drc_attach(drc, DEVICE(pdev), NULL, 0, &local_err);
+    spapr_drc_attach(drc, DEVICE(pdev), &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 2aa919f0cf..f32758ec84 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -261,8 +261,7 @@ sPAPRDRConnector *spapr_drc_by_id(const char *type, u=
int32_t id);
 int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
                           uint32_t drc_type_mask);
=20
-void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                      int fdt_start_offset, Error **errp);
+void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p);
 void spapr_drc_detach(sPAPRDRConnector *drc);
 bool spapr_drc_needed(void *opaque);
=20
--=20
2.20.1
