Received: from eggs.gnu.org ([2001:4830:134:3::10]:41590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIEB4-0005xi-Vn
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIEB3-0000rz-Fl
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:05:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 23:05:34 +1000
Message-Id: <20170606130534.11019-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170606130534.11019-1-david@gibson.dropbear.id.au>
References: <20170606130534.11019-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 3/3] spapr: Eliminate DRC 'signalled' state
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The 'signalled' field in the DRC appears to be entirely a torturous
workaround for the fact that PCI devices were started in UNISOLATED state
for unclear reasons.

1) 'signalled' is already meaningless for logical (so far, all non PCI)
DRCs.  It's always set to true (at least at any point it might be tested),
and can't be assigned any real meaning due to the way signalling works for
logical DRCs.

2) For PCI DRCs, the only time signalled would be false is when non-zero
functions of a multifunction device are hotplugged, followed by function
zero (the other way around is explicitly not permitted). In that case the
secondary function DRCs are attached, but the notification isn't sent to
the guest until function 0 is plugged.

3) signalled being false is used to allow a DRC detach to switch mode
back to ISOLATED state, which allows a secondary function to be hotplugged
then unplugged with function 0 never inserted.  Without this a secondary
function starting in UNISOLATED state couldn't be detached again without
function 0 being inserted, all the functions configured by the guest, then
sent back to ISOLATED state.

4) But now that PCI DRCs start in ISOLATED state, there's nothing to be
done.  If the guest doesn't get the notification, it won't switch the
device to UNISOLATED state, so nothing prevents it from being unplugged.
If the guest does move it to UNISOLATED state without the signal (due to
a manual drmgr call, for instance) then it really isn't safe to unplug it.


So, this patch removes the signalled variable and all code related to it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 45 +--------------------------------------------
 hw/ppc/spapr_events.c      | 10 ----------
 include/hw/ppc/spapr_drc.h |  2 --
 3 files changed, 1 insertion(+), 56 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 22f9224..7c778cf 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -155,12 +155,6 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
     return RTAS_OUT_SUCCESS;
 }
 
-/* has the guest been notified of device attachment? */
-static void set_signalled(sPAPRDRConnector *drc)
-{
-    drc->signalled = true;
-}
-
 /*
  * dr-entity-sense sensor value
  * returned via get-sensor-state RTAS calls
@@ -297,17 +291,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     drc->fdt = fdt;
     drc->fdt_start_offset = fdt_start_offset;
     drc->configured = coldplug;
-    /* 'logical' DR resources such as memory/cpus are in some cases treated
-     * as a pool of resources from which the guest is free to choose from
-     * based on only a count. for resources that can be assigned in this
-     * fashion, we must assume the resource is signalled immediately
-     * since a single hotplug request might make an arbitrary number of
-     * such attached resources available to the guest, as opposed to
-     * 'physical' DR resources such as PCI where each device/resource is
-     * signalled individually.
-     */
-    drc->signalled = (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI)
-                     ? true : coldplug;
 
     if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->awaiting_allocation = true;
@@ -323,26 +306,6 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
 {
     trace_spapr_drc_detach(spapr_drc_index(drc));
 
-    /* if we've signalled device presence to the guest, or if the guest
-     * has gone ahead and configured the device (via manually-executed
-     * device add via drmgr in guest, namely), we need to wait
-     * for the guest to quiesce the device before completing detach.
-     * Otherwise, we can assume the guest hasn't seen it and complete the
-     * detach immediately. Note that there is a small race window
-     * just before, or during, configuration, which is this context
-     * refers mainly to fetching the device tree via RTAS.
-     * During this window the device access will be arbitrated by
-     * associated DRC, which will simply fail the RTAS calls as invalid.
-     * This is recoverable within guest and current implementations of
-     * drmgr should be able to cope.
-     */
-    if (!drc->signalled && !drc->configured) {
-        /* if the guest hasn't seen the device we can't rely on it to
-         * set it back to an isolated state via RTAS, so do it here manually
-         */
-        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
-    }
-
     if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
         trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
         drc->awaiting_release = true;
@@ -431,10 +394,6 @@ static void reset(DeviceState *d)
             drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_UNUSABLE);
         }
     }
-
-    if (drck->dr_entity_sense(drc) == SPAPR_DR_ENTITY_SENSE_PRESENT) {
-        drck->set_signalled(drc);
-    }
 }
 
 static bool spapr_drc_needed(void *opaque)
@@ -459,7 +418,7 @@ static bool spapr_drc_needed(void *opaque)
     case SPAPR_DR_CONNECTOR_TYPE_LMB:
         rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
                (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
-               drc->configured && drc->signalled && !drc->awaiting_release);
+               drc->configured && !drc->awaiting_release);
         break;
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
     case SPAPR_DR_CONNECTOR_TYPE_VIO:
@@ -481,7 +440,6 @@ static const VMStateDescription vmstate_spapr_drc = {
         VMSTATE_BOOL(configured, sPAPRDRConnector),
         VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
         VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
-        VMSTATE_BOOL(signalled, sPAPRDRConnector),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -594,7 +552,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     drck->set_isolation_state = set_isolation_state;
     drck->set_allocation_state = set_allocation_state;
     drck->release_pending = release_pending;
-    drck->set_signalled = set_signalled;
     /*
      * Reason: it crashes FIXME find and document the real reason
      */
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 171aedc..587a3da 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -475,13 +475,6 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
                                                        RTAS_LOG_TYPE_EPOW)));
 }
 
-static void spapr_hotplug_set_signalled(uint32_t drc_index)
-{
-    sPAPRDRConnector *drc = spapr_drc_by_index(drc_index);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->set_signalled(drc);
-}
-
 static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
                                     sPAPRDRConnectorType drc_type,
                                     union drc_identifier *drc_id)
@@ -528,9 +521,6 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     switch (drc_type) {
     case SPAPR_DR_CONNECTOR_TYPE_PCI:
         hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PCI;
-        if (hp->hotplug_action == RTAS_LOG_V6_HP_ACTION_ADD) {
-            spapr_hotplug_set_signalled(drc_id->index);
-        }
         break;
     case SPAPR_DR_CONNECTOR_TYPE_LMB:
         hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_MEMORY;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index ec0256b..b68e8a6 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -200,7 +200,6 @@ typedef struct sPAPRDRConnector {
     sPAPRConfigureConnectorState *ccs;
 
     bool awaiting_release;
-    bool signalled;
     bool awaiting_allocation;
     bool awaiting_allocation_skippable;
 
@@ -226,7 +225,6 @@ typedef struct sPAPRDRConnectorClass {
 
     /* QEMU interfaces for managing hotplug operations */
     bool (*release_pending)(sPAPRDRConnector *drc);
-    void (*set_signalled)(sPAPRDRConnector *drc);
 } sPAPRDRConnectorClass;
 
 uint32_t spapr_drc_index(sPAPRDRConnector *drc);
-- 
2.9.4
