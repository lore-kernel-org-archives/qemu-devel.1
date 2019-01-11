Received: from eggs.gnu.org ([209.51.188.92]:56026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi4Pu-0008C3-CG
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi4BD-00080j-PB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:17:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50630
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi4BC-0007zU-6E
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:17:27 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BLDg11132927
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 16:17:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pxxsme4tn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 16:17:23 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 11 Jan 2019 21:17:21 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 11 Jan 2019 22:17:13 +0100
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154724143303.527341.6106211869690782552.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v2 12/13] spapr: add hotplug hooks for PHB
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

We re-get the phandle of the interrupt controller systematically for
simplicity.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - reworked phandle handling
    - sync LSIs to KVM
---
 hw/ppc/spapr.c         |  125 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_drc.c     |    1 
 hw/ppc/spapr_pci.c     |   27 +++++-----
 include/hw/ppc/spapr.h |    1 
 4 files changed, 138 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ebb6fbbb2b69..96979caa5b11 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2930,6 +2930,11 @@ static void spapr_machine_init(MachineState *machine)
     register_savevm_live(NULL, "spapr/htab", -1, 1,
                          &savevm_htab_handlers, spapr);
 
+    if (smc->dr_phb_enabled) {
+        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
+                                 &error_fatal);
+    }
+
     qemu_register_boot_set(spapr_boot_set, spapr);
 
     if (kvm_enabled()) {
@@ -3727,6 +3732,112 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
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
+    void *fdt = NULL;
+    int fdt_start_offset;
+    int fdt_size;
+    Error *local_err = NULL;
+    sPAPRDRConnector *drc;
+    int ret;
+    bool hotplugged = spapr_drc_hotplugged(dev);
+    int phandle;
+
+    if (!smc->dr_phb_enabled) {
+        return;
+    }
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
+    /* hotplug hooks should check it's enabled before getting this far */
+    assert(drc);
+
+    if (hotplugged) {
+        phandle = spapr->irq->get_phandle(spapr, spapr->fdt_blob,
+                                          &local_err);
+        if (local_err) {
+            goto out;
+        }
+    } else {
+        phandle = PHANDLE_INTC;
+    }
+
+    fdt = create_device_tree(&fdt_size);
+    ret = spapr_populate_pci_dt(sphb, phandle, fdt, spapr->irq->nr_msis,
+                                &fdt_start_offset);
+    if (ret < 0) {
+        error_setg(&local_err, "unable to create FDT for %sPHB",
+                   dev->hotplugged ? "hotplugged " : "");
+        goto out;
+    }
+
+    if (hotplugged) {
+        /* generally SLOF creates these, for hotplug it's up to QEMU */
+        _FDT(fdt_setprop_string(fdt, fdt_start_offset, "name", "pci"));
+    }
+
+    spapr_drc_attach(drc, DEVICE(dev), fdt, fdt_start_offset, &local_err);
+
+out:
+    if (local_err) {
+        error_propagate(errp, local_err);
+        g_free(fdt);
+        return;
+    }
+
+    if (hotplugged) {
+        spapr_hotplug_req_add_by_index(drc);
+    } else if (drc) {
+        spapr_drc_reset(drc);
+    }
+}
+
+void spapr_phb_release(DeviceState *dev)
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
@@ -3734,6 +3845,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
         spapr_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3752,6 +3865,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
@@ -3771,6 +3885,12 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
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
 
@@ -3781,6 +3901,8 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
         spapr_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3788,7 +3910,8 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
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
index 189ee681062a..7a2676716364 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -703,6 +703,7 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
     drck->typename = "PHB";
     drck->drc_name_prefix = "PHB ";
+    drck->release = spapr_phb_release;
 }
 
 static const TypeInfo spapr_dr_connector_info = {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f2b9066ecabe..6ee285e84efb 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1641,21 +1641,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
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
@@ -1873,6 +1859,17 @@ static void spapr_phb_reset(DeviceState *qdev)
     if (spapr_phb_eeh_available(SPAPR_PCI_HOST_BRIDGE(qdev))) {
         spapr_phb_vfio_reset(qdev);
     }
+
+    if (spapr_drc_hotplugged(qdev)) {
+        sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+        int i;
+
+        for (i = 0; i < PCI_NUM_PINS; i++) {
+            uint32_t irq = sphb->lsi_table[i].irq;
+
+            spapr_irq_sync_to_kvm(spapr, irq, &error_abort);
+        }
+    }
 }
 
 static Property spapr_phb_properties[] = {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4eb80c3d888c..92aae58916ff 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -766,6 +766,7 @@ int spapr_max_server_number(sPAPRMachineState *spapr);
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
 void spapr_lmb_release(DeviceState *dev);
+void spapr_phb_release(DeviceState *dev);
 
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
