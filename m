Received: from eggs.gnu.org ([2001:4830:134:3::10]:47030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaEQF-000843-5P
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaEQB-0004qK-Rt
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:36:35 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:60304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gaEQB-0004of-HG
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:36:31 -0500
Received: from player730.ha.ovh.net (unknown [10.109.146.19])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 242B71A0226
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 07:36:30 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 07:36:12 +0100
Message-ID: <154537417263.891798.7533381599337392867.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 15/15] spapr: add hotplug hooks for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Hotplugging PHBs is a machine-level operation, but PHBs reside on the
main system bus, so we register spapr machine as the handler for the
main system bus.

We re-get the phandle of the interrupt controller systematically for
simplicity.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |  147 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_drc.c     |    1 
 hw/ppc/spapr_pci.c     |   16 -----
 include/hw/ppc/spapr.h |    1 
 4 files changed, 149 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c405a5fafca..065c9f19700e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2923,6 +2923,10 @@ static void spapr_machine_init(MachineState *machine)
     register_savevm_live(NULL, "spapr/htab", -1, 1,
                          &savevm_htab_handlers, spapr);
 
+    if (smc->dr_phb_enabled) {
+        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine), NULL);
+    }
+
     qemu_register_boot_set(spapr_boot_set, spapr);
 
     if (kvm_enabled()) {
@@ -3716,6 +3720,135 @@ out:
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
+    int offset, phandle = 0;
+    gchar *nodename = NULL;
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
+        if (spapr->fdt_blob) {
+            /*
+             * SLOF might have pushed an updated FDT with new phandle values.
+             * Re-get the one of our interrupt controller.
+             */
+            nodename = spapr->irq->get_nodename(spapr);
+
+            offset = fdt_subnode_offset(spapr->fdt_blob, 0, nodename);
+            if (offset < 0) {
+                error_setg(errp, "Can't find node \"%s\": %s",
+                           nodename, fdt_strerror(offset));
+                goto out;
+            }
+
+            phandle = fdt_get_phandle(spapr->fdt_blob, offset);
+            if (phandle < 0) {
+                error_setg(errp, "Can't get phandle of node \"%s\": %s",
+                           nodename, fdt_strerror(offset));
+                goto out;
+            }
+        }
+        DEVICE_GET_CLASS(dev)->reset(dev);
+    }
+
+    /* For cold-plugged at initial boot and fallback for hotplug */
+    if (!phandle) {
+        phandle = PHANDLE_XICP;
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
+    g_free(nodename);
+
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
@@ -3723,6 +3856,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
         spapr_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3741,6 +3876,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
@@ -3760,6 +3896,12 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
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
 
@@ -3770,6 +3912,8 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
         spapr_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3777,7 +3921,8 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
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
index 688cca83ef2f..5bc912aa0028 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1627,21 +1627,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
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
index e96deefa30de..eff479b0a019 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -764,6 +764,7 @@ int spapr_max_server_number(sPAPRMachineState *spapr);
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
 void spapr_lmb_release(DeviceState *dev);
+void spapr_phb_release(DeviceState *dev);
 
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
