Received: from eggs.gnu.org ([2001:4830:134:3::10]:47732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dkcij-0000UN-Nh
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dkcig-0004NO-I8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:57:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dkcig-0004MY-8T
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:57:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7NKsOhH086077
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 16:57:44 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chgynrrub-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 16:57:43 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 23 Aug 2017 16:57:42 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 17:57:31 -0300
Message-Id: <20170823205731.3325-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] hw/ppc: CAS reset on early device hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

This patch is a follow up on the discussions made in patch
"hw/ppc: disable hotplug before CAS is completed" that can be
found at [1].

At this moment, we do not support CPU/memory hotplug in early
boot stages, before CAS. When a hotplug occurs, the event is logged
in an internal rtas event log queue and an IRQ pulse is fired. In
regular conditions, the guest handles the interrupt by executing
check_exception, fetching the generated hotplug event and enabling
the device for use.

In early boot, this IRQ isn't caught (SLOF does not handle hotplug
events), leaving the event in the rtas event log queue. If the guest
executes check_exception due to another hotplug event, the re-assertion
of the IRQ ends up de-queuing the first hotplug event as well. In short,
a device hotplugged before CAS is considered coldplugged by SLOF.
This leads to device misbehavior and, in some cases, guest kernel
Ooops when trying to unplug the device.

A proper fix would be to turn every device hotplugged before CAS
as a colplugged device. This is not trivial to do with the current
code base though - the FDT is written in the guest memory at
ppc_spapr_reset and can't be retrieved without adding extra state
(fdt_size for example) that will need to managed and migrated. Adding
the hotplugged DT in the middle of CAS negotiation via the updated DT
tree works with CPU devs, but panics the guest kernel at boot. Additional
analysis would be necessary for LMBs and PCI devices. There are]
questions to be made in QEMU/SLOF/kernel level about how we can make
this change in a sustainable way.

Until we go all the way with the proper fix, this patch works around
the situation by issuing a CAS reset if a hotplugged device is detected
during CAS negotiations:

- 'spapr_cas_completed' is a helper function that is used in the 'plug'
functions of CPU, LMB and PCI devices to inform if we are past CAS. If a
device is hotplugged after CAS, no changes are made. Otherwise, we
do not fire any hotplug event (it will be lost anyway) and no DRC changes
are made, leaving the DRC in empty state.

- In the middle of CAS negotiations, the function
'spapr_hotplugged_dev_before_cas' goes through all the DRCs to see
if there are any DRC that belongs to a hotplugged dev and it has
empty state. This matches the condition of a hotplugged device before
CAS, returning '1' in 'spapr_h_cas_compose_response' which will set
spapr->cas_reboot to true in 'h_client_architecture_support', causing
the machine to reboot.

- after reboot, the hotplugged devs DTs will be added in the base FDT
tree by ppc_spapr_reset and will behave as expected.

- no changes are made for coldplug devices. A colplug device is either
a device that has dev->hotplugged = false or any device that was added
in the INMIGRATE runstate.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02855.html

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c              | 72 +++++++++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_ovec.c         |  7 +++++
 hw/ppc/spapr_pci.c          | 10 ++++++-
 include/hw/ppc/spapr.h      |  2 ++
 include/hw/ppc/spapr_ovec.h |  1 +
 5 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cec441c..10faae3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -790,6 +790,31 @@ out:
     return ret;
 }
 
+static bool spapr_hotplugged_dev_before_cas(void)
+{
+    Object *drc_container, *obj;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+    sPAPRDRConnector *drc;
+    sPAPRDRConnectorClass *drck;
+
+    drc_container = container_get(object_get_root(), "/dr-connector");
+    object_property_iter_init(&iter, drc_container);
+    while ((prop = object_property_iter_next(&iter))) {
+        if (!strstart(prop->type, "link<", NULL)) {
+            continue;
+        }
+        obj = object_property_get_link(drc_container, prop->name, NULL);
+        drc = SPAPR_DR_CONNECTOR(obj);
+        drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+        if (drc->dev && drc->dev->hotplugged &&
+                (drc->state == drck->empty_state)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
                                  target_ulong addr, target_ulong size,
                                  sPAPROptionVector *ov5_updates)
@@ -797,6 +822,10 @@ int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
     void *fdt, *fdt_skel;
     sPAPRDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
+    if (spapr_hotplugged_dev_before_cas()) {
+        return 1;
+    }
+
     size -= sizeof(hdr);
 
     /* Create sceleton */
@@ -2710,9 +2739,22 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+/*
+ * 'h_client_architecture_support' will set at least OV5_FORM1_AFFINITY
+ * in ov5_cas when intersecting it with spapr->ov5 and ov5_guest. It's safe
+ * then to assume that CAS ov5_cas will have something set after CAS.
+ */
+bool spapr_cas_completed(sPAPRMachineState *spapr)
+{
+    if (spapr->ov5_cas == NULL) {
+        return false;
+    }
+    return !spapr_ovec_is_unset(spapr->ov5_cas);
+}
+
 static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                            uint32_t node, bool dedicated_hp_event_source,
-                           Error **errp)
+                           sPAPRMachineState *spapr, Error **errp)
 {
     sPAPRDRConnector *drc;
     uint32_t nr_lmbs = size/SPAPR_MEMORY_BLOCK_SIZE;
@@ -2748,10 +2790,18 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         }
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
-    /* send hotplug notification to the
-     * guest only in case of hotplugged memory
+
+    /*
+     * Send hotplug notification interrupt to the guest only
+     * in case of hotplugged memory.
+     *
+     * Before CAS, we don't know how to queue up events yet because
+     * we don't know if the guest is able to handle HOTPLUG or
+     * EPOW (see rtas_event_log_to_source). In this case, do
+     * not queue up the event. The memory will be left in
+     * the 'empty_state' and will trigger a CAS reboot later.
      */
-    if (hotplugged) {
+    if (hotplugged && spapr_cas_completed(spapr)) {
         if (dedicated_hp_event_source) {
             drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                                   addr_start / SPAPR_MEMORY_BLOCK_SIZE);
@@ -2795,7 +2845,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     spapr_add_lmbs(dev, addr, size, node,
                    spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                   &local_err);
+                   ms, &local_err);
     if (local_err) {
         goto out_unplug;
     }
@@ -3113,8 +3163,18 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             /*
              * Send hotplug notification interrupt to the guest only
              * in case of hotplugged CPUs.
+             *
+             * Before CAS, we don't know how to queue up events yet because
+             * we don't know if the guest is able to handle HOTPLUG or
+             * EPOW (see rtas_event_log_to_source). In this case, do
+             * not queue up the event.
+             *
+             * A hotplugged CPU before CAS will trigger a CAS reboot
+             * later on.
              */
-            spapr_hotplug_req_add_by_index(drc);
+            if (spapr_cas_completed(spapr)) {
+                spapr_hotplug_req_add_by_index(drc);
+            }
         } else {
             spapr_drc_reset(drc);
         }
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 41df4c3..fe7bc85 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -134,6 +134,13 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }
 
+bool spapr_ovec_is_unset(sPAPROptionVector *ov)
+{
+    unsigned long lastbit;
+    lastbit = find_last_bit(ov->bitmap, OV_MAXBITS);
+    return (lastbit == OV_MAXBITS);
+}
+
 static void guest_byte_to_bitmap(uint8_t entry, unsigned long *bitmap,
                                  long bitmap_offset)
 {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d84abf1..4dffa2f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1440,10 +1440,18 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
 
     /* If this is function 0, signal hotplug for all the device functions.
      * Otherwise defer sending the hotplug event.
+     *
+     * Before CAS, we don't know how to queue up events yet because
+     * we don't know if the guest is able to handle HOTPLUG or
+     * EPOW (see rtas_event_log_to_source). In this case, do
+     * not queue up the event. The device will be left in
+     * the 'empty_state' and will trigger a CAS reboot later.
+     *
      */
     if (!spapr_drc_hotplugged(plugged_dev)) {
         spapr_drc_reset(drc);
-    } else if (PCI_FUNC(pdev->devfn) == 0) {
+    } else if (PCI_FUNC(pdev->devfn) == 0 &&
+            spapr_cas_completed(SPAPR_MACHINE(qdev_get_machine()))) {
         int i;
 
         for (i = 0; i < 8; i++) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2a303a7..a2999d1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -662,6 +662,8 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
 void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
                           Error **errp);
+bool spapr_cas_completed(sPAPRMachineState *spapr);
+
 
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 9edfa5f..8126374 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -71,6 +71,7 @@ void spapr_ovec_cleanup(sPAPROptionVector *ov);
 void spapr_ovec_set(sPAPROptionVector *ov, long bitnr);
 void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr);
 bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr);
+bool spapr_ovec_is_unset(sPAPROptionVector *ov);
 sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector);
 int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
                            sPAPROptionVector *ov, const char *name);
-- 
2.9.4
