Received: from eggs.gnu.org ([209.51.188.92]:34300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw933-00036e-9j
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw931-0008W6-MZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59578
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw931-0008Lp-DW
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:11 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEW5v088309
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qrkdr1fg6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:57 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:18:55 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:18:49 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059672926.1466090.13612804072190051439.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 15/17] spapr: add hotplug hooks for PHB
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

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
---
v5: - call qbus_set_hotplug_handler() unconditionally
    - fix unplug call chain
v4: - populate FDT fragment in a DRC callback
v3: - reworked phandle handling some more
v2: - reworked phandle handling
    - sync LSIs to KVM
---
---
 hw/ppc/spapr.c         |  128 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_drc.c     |    2 +
 hw/ppc/spapr_pci.c     |   16 ------
 include/hw/ppc/spapr.h |    3 +
 4 files changed, 133 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 76b3c15d5952..7422c0525494 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3009,6 +3009,9 @@ static void spapr_machine_init(MachineState *machine)
     register_savevm_live(NULL, "spapr/htab", -1, 1,
                          &savevm_htab_handlers, spapr);
 
+    qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
+                             &error_fatal);
+
     qemu_register_boot_set(spapr_boot_set, spapr);
 
     if (kvm_enabled()) {
@@ -3850,6 +3853,115 @@ out:
     error_propagate(errp, local_err);
 }
 
+int spapr_phb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                          void *fdt, int *fdt_start_offset, Error **errp)
+{
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(drc->dev);
+    int intc_phandle;
+
+    intc_phandle = spapr_irq_get_phandle(spapr, spapr->fdt_blob, errp);
+    if (intc_phandle <= 0) {
+        return -1;
+    }
+
+    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
+                              fdt_start_offset)) {
+        error_setg(errp, "unable to create FDT node for PHB %d", sphb->index);
+        return -1;
+    }
+
+    /* generally SLOF creates these, for hotplug it's up to QEMU */
+    _FDT(fdt_setprop_string(fdt, *fdt_start_offset, "name", "pci"));
+
+    return 0;
+}
+
+static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
+
+    if (dev->hotplugged && !smc->dr_phb_enabled) {
+        error_setg(errp, "PHB hotplug not supported for this machine");
+        return;
+    }
+
+    if (sphb->index == (uint32_t)-1) {
+        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
+        return;
+    }
+
+    /*
+     * This will check that sphb->index doesn't exceed the maximum number of
+     * PHBs for the current machine type.
+     */
+    smc->phb_placement(spapr, sphb->index,
+                       &sphb->buid, &sphb->io_win_addr,
+                       &sphb->mem_win_addr, &sphb->mem64_win_addr,
+                       windows_supported, sphb->dma_liobn, errp);
+}
+
+static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                           Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
+    sPAPRDRConnector *drc;
+    bool hotplugged = spapr_drc_hotplugged(dev);
+    Error *local_err = NULL;
+
+    if (!smc->dr_phb_enabled) {
+        return;
+    }
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
+    /* hotplug hooks should check it's enabled before getting this far */
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
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+}
+
+static void spapr_phb_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+{
+    object_unparent(OBJECT(dev));
+}
+
+static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
+    sPAPRDRConnector *drc;
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
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
@@ -3857,6 +3969,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
         spapr_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3867,6 +3981,8 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
         spapr_memory_unplug(hotplug_dev, dev);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_unplug(hotplug_dev, dev);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_unplug(hotplug_dev, dev);
     }
 }
 
@@ -3875,6 +3991,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
@@ -3894,6 +4011,12 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
             return;
         }
         spapr_core_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        if (!smc->dr_phb_enabled) {
+            error_setg(errp, "PHB hot unplug not supported on this machine");
+            return;
+        }
+        spapr_phb_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
@@ -3904,6 +4027,8 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
         spapr_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3911,7 +4036,8 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
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
index fd6380adb367..2943cf47d46c 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -703,6 +703,8 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
     drck->typename = "PHB";
     drck->drc_name_prefix = "PHB ";
+    drck->release = spapr_phb_release;
+    drck->dt_populate = spapr_phb_dt_populate;
 }
 
 static const TypeInfo spapr_dr_connector_info = {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 03fc26985ab1..06a5ffd28184 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1663,21 +1663,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (sphb->index != (uint32_t)-1) {
-        Error *local_err = NULL;
-
-        smc->phb_placement(spapr, sphb->index,
-                           &sphb->buid, &sphb->io_win_addr,
-                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
-                           windows_supported, sphb->dma_liobn, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    } else {
-        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
-        return;
-    }
+    assert(sphb->index != (uint32_t)-1); /* checked in spapr_phb_pre_plug() */
 
     if (sphb->mem64_win_size != 0) {
         if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b173fd714904..59073a757900 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -772,6 +772,9 @@ int spapr_core_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
 void spapr_lmb_release(DeviceState *dev);
 int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
+void spapr_phb_release(DeviceState *dev);
+int spapr_phb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                          void *fdt, int *fdt_start_offset, Error **errp);
 
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
