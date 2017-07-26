Received: from eggs.gnu.org ([2001:4830:134:3::10]:49545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daHrg-0001eU-0C
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daHrc-0003CX-TZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:40:20 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:51202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daHrc-0003C5-Ix
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:40:16 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id DCE90116ADD
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 10:40:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 26 Jul 2017 10:40:04 +0200
Message-ID: <150105840463.12000.9666180368681199673.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 26/26] spapr: add hotplug hooks for
 PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Hotplugging PHBs is a machine-level operation, but PHBs reside on the
main system bus, so we register spapr machine as the handler for the
main system bus.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
- rebased against ppc-for-2.10
- converted to unplug_request
- handle drc_id at pre-plug
- reset hotplugged PHB at plug
- compatibility with older machine types
---
 hw/ppc/spapr.c              |  114 +++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_drc.c          |    1 
 hw/ppc/spapr_pci.c          |    2 -
 include/hw/pci-host/spapr.h |    2 +
 include/hw/ppc/spapr.h      |    1 
 5 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 90485054c2e7..589f76ef9fb8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2540,6 +2540,10 @@ static void ppc_spapr_init(MachineState *machine)
     register_savevm_live(NULL, "spapr/htab", -1, 1,
                          &savevm_htab_handlers, spapr);
 
+    if (spapr->dr_phb_enabled) {
+        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine), NULL);
+    }
+
     qemu_register_boot_set(spapr_boot_set, spapr);
 
     if (kvm_enabled()) {
@@ -3238,6 +3242,103 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
+
+    if (sphb->drc_id == (uint32_t)-1) {
+        sphb->drc_id = sphb->index;
+    }
+
+    if (sphb->drc_id >= SPAPR_DRC_MAX_PHB) {
+        error_setg(errp, "PHB id %d out of range", sphb->drc_id);
+    }
+}
+
+static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                           Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
+    void *fdt = NULL;
+    int fdt_start_offset;
+    int fdt_size;
+    Error *local_err = NULL;
+    sPAPRDRConnector *drc;
+    uint32_t phandle;
+    int ret;
+    bool hotplugged = spapr_drc_hotplugged(dev);
+
+    if (!spapr->dr_phb_enabled) {
+        return;
+    }
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->drc_id);
+    /* hotplug hooks should check it's enabled before getting this far */
+    g_assert(drc);
+
+    if (hotplugged) {
+        if (spapr->xics_phandle == UINT32_MAX) {
+            error_setg(&local_err,
+                       "SLOF didn't update the XICS phandle. PHB hotplug cancelled");
+            goto out;
+        }
+        phandle = spapr->xics_phandle;
+
+        spapr_phb_reset(dev);
+    } else {
+        phandle = PHANDLE_XICP;
+    }
+
+    fdt = create_device_tree(&fdt_size);
+    ret = spapr_populate_pci_dt(sphb, phandle, fdt, &fdt_start_offset);
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
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->drc_id);
+    g_assert(drc);
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
@@ -3284,6 +3385,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
         spapr_memory_plug(hotplug_dev, dev, node, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3311,6 +3414,12 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
             return;
         }
         spapr_core_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        if (sms->dr_phb_enabled) {
+            spapr_phb_unplug_request(hotplug_dev, dev, errp);
+        } else {
+            error_setg(errp, "PHB hot unplug not supported on this machine");
+        }
     }
 }
 
@@ -3321,6 +3430,8 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
         spapr_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        spapr_phb_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -3328,7 +3439,8 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
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
index 2e1049ce61c7..845fcf70b932 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -704,6 +704,7 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
     drck->typename = "PHB";
     drck->drc_name_prefix = "PHB ";
+    drck->release = spapr_phb_release;
 }
 
 static const TypeInfo spapr_dr_connector_info = {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 157867af8178..c12f71ae3e2d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1833,7 +1833,7 @@ void spapr_phb_dma_reset(sPAPRPHBState *sphb)
                            sphb->dma_win_size >> SPAPR_TCE_PAGE_SHIFT);
 }
 
-static void spapr_phb_reset(DeviceState *qdev)
+void spapr_phb_reset(DeviceState *qdev)
 {
     sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(qdev);
 
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 7837fb0b1110..15799cee4280 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -120,6 +120,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
 
 void spapr_pci_rtas_init(void);
 
+void spapr_phb_reset(DeviceState *qdev);
+
 sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t buid);
 PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t buid,
                               uint32_t config_addr);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f09c54d5bb94..a2f6782bdbbf 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -673,6 +673,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
 void spapr_lmb_release(DeviceState *dev);
+void spapr_phb_release(DeviceState *dev);
 
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
