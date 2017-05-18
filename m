Received: from eggs.gnu.org ([2001:4830:134:3::10]:41352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBRyD-0005k7-Io
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBRyB-0001Yo-2E
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:24:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dBRyA-0001Yb-U1
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:24:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IKIewf128385
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:24:22 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahhndjfn4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:24:21 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 18 May 2017 17:24:19 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 17:24:01 -0300
In-Reply-To: <20170518202402.12571-1-danielhb@linux.vnet.ibm.com>
References: <20170518202402.12571-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170518202402.12571-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v11 1/2] hw/ppc/spapr_events.c: removing
 'exception' from sPAPREventLogEntry
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
index 5802f88..02239a5 100644
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
