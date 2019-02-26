Received: from eggs.gnu.org ([209.51.188.92]:58643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmI-0006PG-UO
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmD-0003ko-7f
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:57 +1100
Message-Id: <20190226045304.25618-44-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 43/50] spapr: add hotplug hooks for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Hotplugging PHBs is a machine-level operation, but PHBs reside on the
main system bus, so we register spapr machine as the handler for the
main system bus.

Provide the usual pre-plug, plug and unplug-request handlers.

Move the checking of the PHB index to the pre-plug handler. It is okay
to do that and assert in the realize function because the pre-plug
handler is always called, even for the oldest machine types we support.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(Fixed interrupt controller phandle in "interrupt-map" and
 TCE table size in "ibm,dma-window" FDT fragment, Greg Kurz)
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059672926.1466090.13612804072190051439.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 128 ++++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_drc.c     |   2 +
 hw/ppc/spapr_pci.c     |  16 +-----
 include/hw/ppc/spapr.h |   3 +
 4 files changed, 133 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 76b3c15d59..7422c05254 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3009,6 +3009,9 @@ static void spapr_machine_init(MachineState *machin=
e)
     register_savevm_live(NULL, "spapr/htab", -1, 1,
                          &savevm_htab_handlers, spapr);
=20
+    qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
+                             &error_fatal);
+
     qemu_register_boot_set(spapr_boot_set, spapr);
=20
     if (kvm_enabled()) {
@@ -3850,6 +3853,115 @@ out:
     error_propagate(errp, local_err);
 }
=20
+int spapr_phb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+                          void *fdt, int *fdt_start_offset, Error **errp=
)
+{
+    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(drc->dev);
+    int intc_phandle;
+
+    intc_phandle =3D spapr_irq_get_phandle(spapr, spapr->fdt_blob, errp)=
;
+    if (intc_phandle <=3D 0) {
+        return -1;
+    }
+
+    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->nr_ms=
is,
+                              fdt_start_offset)) {
+        error_setg(errp, "unable to create FDT node for PHB %d", sphb->i=
ndex);
+        return -1;
+    }
+
+    /* generally SLOF creates these, for hotplug it's up to QEMU */
+    _FDT(fdt_setprop_string(fdt, *fdt_start_offset, "name", "pci"));
+
+    return 0;
+}
+
+static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
+                               Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
+
+    if (dev->hotplugged && !smc->dr_phb_enabled) {
+        error_setg(errp, "PHB hotplug not supported for this machine");
+        return;
+    }
+
+    if (sphb->index =3D=3D (uint32_t)-1) {
+        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
+        return;
+    }
+
+    /*
+     * This will check that sphb->index doesn't exceed the maximum numbe=
r of
+     * PHBs for the current machine type.
+     */
+    smc->phb_placement(spapr, sphb->index,
+                       &sphb->buid, &sphb->io_win_addr,
+                       &sphb->mem_win_addr, &sphb->mem64_win_addr,
+                       windows_supported, sphb->dma_liobn, errp);
+}
+
+static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev=
,
+                           Error **errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
+    sPAPRDRConnector *drc;
+    bool hotplugged =3D spapr_drc_hotplugged(dev);
+    Error *local_err =3D NULL;
+
+    if (!smc->dr_phb_enabled) {
+        return;
+    }
+
+    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
+    /* hotplug hooks should check it's enabled before getting this far *=
/
+    assert(drc);
+
+    spapr_drc_attach(drc, DEVICE(dev), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (hotplugged) {
+        spapr_hotplug_req_add_by_index(drc);
+    } else {
+        spapr_drc_reset(drc);
+    }
+}
+
+void spapr_phb_release(DeviceState *dev)
+{
+    HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
+
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+}
+
+static void spapr_phb_unplug(HotplugHandler *hotplug_dev, DeviceState *d=
ev)
+{
+    object_unparent(OBJECT(dev));
+}
+
+static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
+    sPAPRDRConnector *drc;
+
+    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
+    assert(drc);
+
+    if (!spapr_drc_unplug_requested(drc)) {
+        spapr_drc_detach(drc);
+        spapr_hotplug_req_remove_by_index(drc);
+    }
+}
+
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
@@ -3857,6 +3969,8 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
         spapr_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
+        spapr_phb_plug(hotplug_dev, dev, errp);
     }
 }
=20
@@ -3867,6 +3981,8 @@ static void spapr_machine_device_unplug(HotplugHand=
ler *hotplug_dev,
         spapr_memory_unplug(hotplug_dev, dev);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_unplug(hotplug_dev, dev);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
+        spapr_phb_unplug(hotplug_dev, dev);
     }
 }
=20
@@ -3875,6 +3991,7 @@ static void spapr_machine_device_unplug_request(Hot=
plugHandler *hotplug_dev,
 {
     sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc =3D MACHINE_GET_CLASS(sms);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
@@ -3894,6 +4011,12 @@ static void spapr_machine_device_unplug_request(Ho=
tplugHandler *hotplug_dev,
             return;
         }
         spapr_core_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
+        if (!smc->dr_phb_enabled) {
+            error_setg(errp, "PHB hot unplug not supported on this machi=
ne");
+            return;
+        }
+        spapr_phb_unplug_request(hotplug_dev, dev, errp);
     }
 }
=20
@@ -3904,6 +4027,8 @@ static void spapr_machine_device_pre_plug(HotplugHa=
ndler *hotplug_dev,
         spapr_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
+        spapr_phb_pre_plug(hotplug_dev, dev, errp);
     }
 }
=20
@@ -3911,7 +4036,8 @@ static HotplugHandler *spapr_get_hotplug_handler(Ma=
chineState *machine,
                                                  DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index fd6380adb3..2943cf47d4 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -703,6 +703,8 @@ static void spapr_drc_phb_class_init(ObjectClass *k, =
void *data)
     drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
     drck->typename =3D "PHB";
     drck->drc_name_prefix =3D "PHB ";
+    drck->release =3D spapr_phb_release;
+    drck->dt_populate =3D spapr_phb_dt_populate;
 }
=20
 static const TypeInfo spapr_dr_connector_info =3D {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 03fc26985a..06a5ffd281 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1663,21 +1663,7 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
         return;
     }
=20
-    if (sphb->index !=3D (uint32_t)-1) {
-        Error *local_err =3D NULL;
-
-        smc->phb_placement(spapr, sphb->index,
-                           &sphb->buid, &sphb->io_win_addr,
-                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
-                           windows_supported, sphb->dma_liobn, &local_er=
r);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    } else {
-        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
-        return;
-    }
+    assert(sphb->index !=3D (uint32_t)-1); /* checked in spapr_phb_pre_p=
lug() */
=20
     if (sphb->mem64_win_size !=3D 0) {
         if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b173fd7149..59073a7579 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -772,6 +772,9 @@ int spapr_core_dt_populate(sPAPRDRConnector *drc, sPA=
PRMachineState *spapr,
 void spapr_lmb_release(DeviceState *dev);
 int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
                           void *fdt, int *fdt_start_offset, Error **errp=
);
+void spapr_phb_release(DeviceState *dev);
+int spapr_phb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+                          void *fdt, int *fdt_start_offset, Error **errp=
);
=20
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
--=20
2.20.1
