Received: from eggs.gnu.org ([209.51.188.92]:58111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlH-0005PC-IG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlF-0002ty-IW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:35 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:44 +1100
Message-Id: <20190226045304.25618-31-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/50] spapr: Generate FDT fragment for LMBs at
 configure connector time
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

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059666331.1466090.6766540766297333313.stgit@bahia.lab.tou=
louse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 33 ++++++++++++++++++---------------
 hw/ppc/spapr_drc.c     |  1 +
 include/hw/ppc/spapr.h |  4 +++-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 00eb3b643c..b92deee771 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3333,14 +3333,26 @@ static void spapr_nmi(NMIState *n, int cpu_index,=
 Error **errp)
     }
 }
=20
+int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+                          void *fdt, int *fdt_start_offset, Error **errp=
)
+{
+    uint64_t addr;
+    uint32_t node;
+
+    addr =3D spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE;
+    node =3D object_property_get_uint(OBJECT(drc->dev), PC_DIMM_NODE_PRO=
P,
+                                    &error_abort);
+    *fdt_start_offset =3D spapr_populate_memory_node(fdt, node, addr,
+                                                   SPAPR_MEMORY_BLOCK_SI=
ZE);
+    return 0;
+}
+
 static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64=
_t size,
-                           uint32_t node, bool dedicated_hp_event_source=
,
-                           Error **errp)
+                           bool dedicated_hp_event_source, Error **errp)
 {
     sPAPRDRConnector *drc;
     uint32_t nr_lmbs =3D size/SPAPR_MEMORY_BLOCK_SIZE;
-    int i, fdt_offset, fdt_size;
-    void *fdt;
+    int i;
     uint64_t addr =3D addr_start;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
     Error *local_err =3D NULL;
@@ -3350,11 +3362,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint6=
4_t addr_start, uint64_t size,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
=20
-        fdt =3D create_device_tree(&fdt_size);
-        fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
-                                                SPAPR_MEMORY_BLOCK_SIZE)=
;
-
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
+        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
         if (local_err) {
             while (addr > addr_start) {
                 addr -=3D SPAPR_MEMORY_BLOCK_SIZE;
@@ -3362,7 +3370,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
                 spapr_drc_detach(drc);
             }
-            g_free(fdt);
             error_propagate(errp, local_err);
             return;
         }
@@ -3395,7 +3402,6 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
     sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     uint64_t size, addr;
-    uint32_t node;
=20
     size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_ab=
ort);
=20
@@ -3410,10 +3416,7 @@ static void spapr_memory_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
         goto out_unplug;
     }
=20
-    node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
-                                    &error_abort);
-    spapr_add_lmbs(dev, addr, size, node,
-                   spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
+    spapr_add_lmbs(dev, addr, size, spapr_ovec_test(ms->ov5_cas, OV5_HP_=
EVT),
                    &local_err);
     if (local_err) {
         goto out_unplug;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 66b965a0a7..634c28695a 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -700,6 +700,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, =
void *data)
     drck->typename =3D "MEM";
     drck->drc_name_prefix =3D "LMB ";
     drck->release =3D spapr_lmb_release;
+    drck->dt_populate =3D spapr_lmb_dt_populate;
 }
=20
 static const TypeInfo spapr_dr_connector_info =3D {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 659204ea93..0ec309da49 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -764,9 +764,11 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, =
int shift,
 void spapr_clear_pending_events(sPAPRMachineState *spapr);
 int spapr_max_server_number(sPAPRMachineState *spapr);
=20
-/* CPU and LMB DRC release callbacks. */
+/* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
 void spapr_lmb_release(DeviceState *dev);
+int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+                          void *fdt, int *fdt_start_offset, Error **errp=
);
=20
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
--=20
2.20.1
