Received: from eggs.gnu.org ([2001:4830:134:3::10]:57343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoR-0006Wm-5E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoP-0007Uh-9Z
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:22 +1000
Message-Id: <20170525035132.24268-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/18] hw/ppc/spapr_events.c: removing
 'exception' from sPAPREventLogEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Currenty we do not have any RTAS event that is reported by the
event-scan interface. The existing events, RTAS_LOG_TYPE_EPOW and
RTAS_LOG_TYPE_HOTPLUG, are being reported by the check-exception
interface and, as such, marked as 'exception=true'.

Commit 79853e18d9, 'spapr_events: event-scan RTAS interface', added
the event_scan interface because the guest kernel requires it to
initialize other required interfaces. It is acting since then as
a stub because no events that would be reported by it were added
since then. However, the existence of the 'exception' boolean adds
an unnecessary load in the future migration of the pending_events,
sPAPREventLogEntry QTAILQ that hosts the pending RTAS events.

To make the code cleaner and ease the future migration changes, this
patch makes the following changes:

- remove the 'exception' boolean that filter these events. There is
nothing to filter since all events are reported by check-exception;

- functions rtas_event_log_queue, rtas_event_log_dequeue and
rtas_event_log_contains don't receive the 'exception' boolean
as parameter;

- event_scan function was simplified. It was calling
'rtas_event_log_dequeue(mask, false)' that was always returning
'NULL' because we have no events that are created with
exception=false, thus in the end it would execute a jump to
'out_no_events' all the time. The function now assumes that
this will always be the case and all the remaining logic were
deleted.

In the future, when or if we add new RTAS events that should
be reported with the event_scan interface, we can refer to
the changes made in this patch to add the event_scan logic
back.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c  | 52 +++++++-------------------------------------------
 include/hw/ppc/spapr.h |  1 -
 2 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index f0b28d8..73e2a18 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -342,20 +342,18 @@ static int rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
     return source->irq;
 }
 
-static void rtas_event_log_queue(int log_type, void *data, bool exception)
+static void rtas_event_log_queue(int log_type, void *data)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPREventLogEntry *entry = g_new(sPAPREventLogEntry, 1);
 
     g_assert(data);
     entry->log_type = log_type;
-    entry->exception = exception;
     entry->data = data;
     QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
 }
 
-static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask,
-                                                  bool exception)
+static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPREventLogEntry *entry = NULL;
@@ -364,10 +362,6 @@ static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask,
         const sPAPREventSource *source =
             rtas_event_log_to_source(spapr, entry->log_type);
 
-        if (entry->exception != exception) {
-            continue;
-        }
-
         if (source->mask & event_mask) {
             break;
         }
@@ -380,7 +374,7 @@ static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask,
     return entry;
 }
 
-static bool rtas_event_log_contains(uint32_t event_mask, bool exception)
+static bool rtas_event_log_contains(uint32_t event_mask)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPREventLogEntry *entry = NULL;
@@ -389,10 +383,6 @@ static bool rtas_event_log_contains(uint32_t event_mask, bool exception)
         const sPAPREventSource *source =
             rtas_event_log_to_source(spapr, entry->log_type);
 
-        if (entry->exception != exception) {
-            continue;
-        }
-
         if (source->mask & event_mask) {
             return true;
         }
@@ -479,7 +469,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
     epow->event_modifier = RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
     epow->extended_modifier = RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPECIFIC;
 
-    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
+    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow);
 
     qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
                                  rtas_event_log_to_irq(spapr,
@@ -572,7 +562,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
             cpu_to_be32(drc_id->count_indexed.index);
     }
 
-    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
+    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp);
 
     qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
                                  rtas_event_log_to_irq(spapr,
@@ -667,7 +657,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         xinfo |= (uint64_t)rtas_ld(args, 6) << 32;
     }
 
-    event = rtas_event_log_dequeue(mask, true);
+    event = rtas_event_log_dequeue(mask);
     if (!event) {
         goto out_no_events;
     }
@@ -690,7 +680,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
      * interrupts.
      */
     for (i = 0; i < EVENT_CLASS_MAX; i++) {
-        if (rtas_event_log_contains(EVENT_CLASS_MASK(i), true)) {
+        if (rtas_event_log_contains(EVENT_CLASS_MASK(i))) {
             const sPAPREventSource *source =
                 spapr_event_sources_get_source(spapr->event_sources, i);
 
@@ -710,38 +700,10 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                        target_ulong args,
                        uint32_t nret, target_ulong rets)
 {
-    uint32_t mask, buf, len, event_len;
-    sPAPREventLogEntry *event;
-    struct rtas_error_log *hdr;
-
     if (nargs != 4 || nret != 1) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
     }
-
-    mask = rtas_ld(args, 0);
-    buf = rtas_ld(args, 2);
-    len = rtas_ld(args, 3);
-
-    event = rtas_event_log_dequeue(mask, false);
-    if (!event) {
-        goto out_no_events;
-    }
-
-    hdr = event->data;
-    event_len = be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
-
-    if (event_len < len) {
-        len = event_len;
-    }
-
-    cpu_physical_memory_write(buf, event->data, len);
-    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-    g_free(event->data);
-    g_free(event);
-    return;
-
-out_no_events:
     rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 93c4cfc..8f424ca 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -598,7 +598,6 @@ sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
 
 struct sPAPREventLogEntry {
     int log_type;
-    bool exception;
     void *data;
     QTAILQ_ENTRY(sPAPREventLogEntry) next;
 };
-- 
2.9.4
