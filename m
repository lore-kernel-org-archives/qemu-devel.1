Received: from eggs.gnu.org ([2001:4830:134:3::10]:51328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dNO4t-0005Fa-Nc
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dNO4q-0000pQ-IH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:40:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dNO4q-0000oa-8E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:40:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5KId4K5007964
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:40:33 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b72sq40xd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:40:32 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 20 Jun 2017 15:40:29 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 15:40:17 -0300
In-Reply-To: <20170620184017.17919-1-danielhb@linux.vnet.ibm.com>
References: <20170620184017.17919-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170620184017.17919-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v14] migration: spapr: migrate pending_events
 of spapr state
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

In racing situations between hotplug events and migration operation,
a rtas hotplug event could have not yet be delivered to the source
guest when migration is started. In this case the pending_events of
spapr state need be transmitted to the target so that the hotplug
event can be finished on the target.

To achieve the minimal VMSD possible to migrate the pending_events list,
this patch makes the changes in spapr_events.c:

- 'log_type' of sPAPREventLogEntry struct deleted. This information can be
derived by inspecting the rtas_error_log summary field. A new function
called 'spapr_event_log_entry_type' was added to retrieve the type of
a given sPAPREventLogEntry.

- sPAPREventLogEntry, epow_log_full and hp_log_full were redesigned. The
only data we're going to migrate in the VMSD is the event log data itself,
which can be divided in two parts: a rtas_error_log header and an extended
event log field. The rtas_error_log header contains information about the
size of the extended log field, which can be used inside VMSD as the size
parameter of the VBUFFER_ALOC field that will store it. To allow this use,
the header.extended_length field must be exposed inline to the VMSD instead
of embedded into a 'data' field that holds everything. With this in mind,
the following changes were done:

    * a new 'header' field was added to sPAPREventLogEntry. This field holds a
a struct rtas_error_log inline.
    * the declaration of the 'rtas_error_log' struct was moved to spapr.h
to be visible to the VMSD macros.
    * 'data' field of sPAPREventLogEntry was renamed to 'extended_log' and
now holds only the contents of the extended event log.
   *  'struct rtas_error_log hdr' were taken away from both epow_log_full
and hp_log_full. This information is now available at the header field of
sPAPREventLogEntry.
   * epow_log_full and hp_log_full were renamed to epow_extended_log and
hp_extended_log respectively. This rename makes it clearer to understand
the new purpose of both structures: hold the information of an extended
event log field.
    * spapr_powerdown_req and spapr_hotplug_req_event now creates a
sPAPREventLogEntry structure that contains the full rtas log entry.
    * rtas_event_log_queue and rtas_event_log_dequeue now receives a
sPAPREventLogEntry pointer as a parameter instead of a void pointer.

- rtas_event_log_queue changes the endianess of the header.extended_length
from be32 to native. This change is need to allow the VMSD inside spapr.c
to read the correct size of the entended_log field. As a follow up,
rtas_event_log_dequeue revert this change before returning the
sPAPREventLogEntry to the caller.

- 'check_exception' now uses a buffer called 'full_log' to store the contents
of rtas_error_log and the extended_log. This is need to allow the call to
cpu_physical_memory_write() to work the same way as it did before - one
write with a buffer with the whole rtas event log information.

- inside spapr.c, pending_events is put in a subsection in the spapr state
VMSD to make sure migration across different versions is not broken.

A small change in rtas_event_log_queue and rtas_event_log_dequeue were also
made: instead of calling qdev_get_machine(), both functions now receive
a pointer to the sPAPRMachineState. This pointer is already available in
the callers of these functions and we don't need to waste resources
calling qdev() again.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 32 +++++++++++++++++
 hw/ppc/spapr_events.c  | 98 +++++++++++++++++++++++++++++++-------------------
 include/hw/ppc/spapr.h |  9 +++--
 3 files changed, 101 insertions(+), 38 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e877d45..28f5c82 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1451,6 +1451,37 @@ static bool version_before_3(void *opaque, int version_id)
     return version_id < 3;
 }
 
+static bool spapr_pending_events_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
+    return !QTAILQ_EMPTY(&spapr->pending_events);
+}
+
+static const VMStateDescription vmstate_spapr_event_entry = {
+    .name = "spapr_event_log_entry",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(header.summary, sPAPREventLogEntry),
+        VMSTATE_UINT32(header.extended_length, sPAPREventLogEntry),
+        VMSTATE_VBUFFER_ALLOC_UINT32(extended_log, sPAPREventLogEntry, 0,
+                                     NULL, header.extended_length),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_spapr_pending_events = {
+    .name = "spapr_pending_events",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_pending_events_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_QTAILQ_V(pending_events, sPAPRMachineState, 1,
+                         vmstate_spapr_event_entry, sPAPREventLogEntry, next),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool spapr_ov5_cas_needed(void *opaque)
 {
     sPAPRMachineState *spapr = opaque;
@@ -1549,6 +1580,7 @@ static const VMStateDescription vmstate_spapr = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
+        &vmstate_spapr_pending_events,
         NULL
     }
 };
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 171aedc..82b1e66 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -42,8 +42,7 @@
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
 
-struct rtas_error_log {
-    uint32_t summary;
+/* Macros related to rtas_error_log struct defined in spapr.h */
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
 #define RTAS_LOG_SEVERITY_MASK                  0x00e00000
@@ -85,8 +84,6 @@ struct rtas_error_log {
 #define   RTAS_LOG_TYPE_ECC_CORR                0x0000000a
 #define   RTAS_LOG_TYPE_EPOW                    0x00000040
 #define   RTAS_LOG_TYPE_HOTPLUG                 0x000000e5
-    uint32_t extended_length;
-} QEMU_PACKED;
 
 struct rtas_event_log_v6 {
     uint8_t b0;
@@ -166,8 +163,7 @@ struct rtas_event_log_v6_epow {
     uint64_t reason_code;
 } QEMU_PACKED;
 
-struct epow_log_full {
-    struct rtas_error_log hdr;
+struct epow_extended_log {
     struct rtas_event_log_v6 v6hdr;
     struct rtas_event_log_v6_maina maina;
     struct rtas_event_log_v6_mainb mainb;
@@ -205,8 +201,7 @@ struct rtas_event_log_v6_hp {
     union drc_identifier drc_id;
 } QEMU_PACKED;
 
-struct hp_log_full {
-    struct rtas_error_log hdr;
+struct hp_extended_log {
     struct rtas_event_log_v6 v6hdr;
     struct rtas_event_log_v6_maina maina;
     struct rtas_event_log_v6_mainb mainb;
@@ -341,25 +336,32 @@ static int rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
     return source->irq;
 }
 
-static void rtas_event_log_queue(int log_type, void *data)
+static uint32_t spapr_event_log_entry_type(sPAPREventLogEntry *entry)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    sPAPREventLogEntry *entry = g_new(sPAPREventLogEntry, 1);
+    return be32_to_cpu(entry->header.summary) & RTAS_LOG_TYPE_MASK;
+}
+
+static void rtas_event_log_queue(sPAPRMachineState *spapr,
+                                 sPAPREventLogEntry *entry)
+{
+    /* Changing header.extended_length to native endianess in
+     * case a migration occurs and the VMSD needs to read the size
+     * of the entry->extended_log field.
+     */
+    entry->header.extended_length = be32_to_cpu(entry->header.extended_length);
 
-    g_assert(data);
-    entry->log_type = log_type;
-    entry->data = data;
     QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
 }
 
-static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask)
+static sPAPREventLogEntry *rtas_event_log_dequeue(sPAPRMachineState *spapr,
+                                                  uint32_t event_mask)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPREventLogEntry *entry = NULL;
 
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
         const sPAPREventSource *source =
-            rtas_event_log_to_source(spapr, entry->log_type);
+            rtas_event_log_to_source(spapr,
+                                     spapr_event_log_entry_type(entry));
 
         if (source->mask & event_mask) {
             break;
@@ -368,6 +370,11 @@ static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask)
 
     if (entry) {
         QTAILQ_REMOVE(&spapr->pending_events, entry, next);
+
+        /* Reverting the endianess change made in rtas_event_log_queue.
+         */
+        entry->header.extended_length = cpu_to_be32(
+            entry->header.extended_length);
     }
 
     return entry;
@@ -380,7 +387,8 @@ static bool rtas_event_log_contains(uint32_t event_mask)
 
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
         const sPAPREventSource *source =
-            rtas_event_log_to_source(spapr, entry->log_type);
+            rtas_event_log_to_source(spapr,
+                                     spapr_event_log_entry_type(entry));
 
         if (source->mask & event_mask) {
             return true;
@@ -428,15 +436,21 @@ static void spapr_init_maina(struct rtas_event_log_v6_maina *maina,
 static void spapr_powerdown_req(Notifier *n, void *opaque)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    sPAPREventLogEntry *entry;
     struct rtas_error_log *hdr;
     struct rtas_event_log_v6 *v6hdr;
     struct rtas_event_log_v6_maina *maina;
     struct rtas_event_log_v6_mainb *mainb;
     struct rtas_event_log_v6_epow *epow;
-    struct epow_log_full *new_epow;
+    struct epow_extended_log *new_epow;
 
+    entry = g_new(sPAPREventLogEntry, 1);
     new_epow = g_malloc0(sizeof(*new_epow));
-    hdr = &new_epow->hdr;
+    g_assert(entry);
+    g_assert(new_epow);
+    entry->extended_log = new_epow;
+
+    hdr = &entry->header;
     v6hdr = &new_epow->v6hdr;
     maina = &new_epow->maina;
     mainb = &new_epow->mainb;
@@ -447,8 +461,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
                                | RTAS_LOG_DISPOSITION_NOT_RECOVERED
                                | RTAS_LOG_OPTIONAL_PART_PRESENT
                                | RTAS_LOG_TYPE_EPOW);
-    hdr->extended_length = cpu_to_be32(sizeof(*new_epow)
-                                       - sizeof(new_epow->hdr));
+    hdr->extended_length = cpu_to_be32(sizeof(*new_epow));
 
     spapr_init_v6hdr(v6hdr);
     spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
@@ -468,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
     epow->event_modifier = RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
     epow->extended_modifier = RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPECIFIC;
 
-    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow);
+    rtas_event_log_queue(spapr, entry);
 
     qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
                                  rtas_event_log_to_irq(spapr,
@@ -487,15 +500,21 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
                                     union drc_identifier *drc_id)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    struct hp_log_full *new_hp;
+    sPAPREventLogEntry *entry;
+    struct hp_extended_log *new_hp;
     struct rtas_error_log *hdr;
     struct rtas_event_log_v6 *v6hdr;
     struct rtas_event_log_v6_maina *maina;
     struct rtas_event_log_v6_mainb *mainb;
     struct rtas_event_log_v6_hp *hp;
 
-    new_hp = g_malloc0(sizeof(struct hp_log_full));
-    hdr = &new_hp->hdr;
+    entry = g_new(sPAPREventLogEntry, 1);
+    new_hp = g_malloc0(sizeof(struct hp_extended_log));
+    g_assert(entry);
+    g_assert(new_hp);
+    entry->extended_log = new_hp;
+
+    hdr = &entry->header;
     v6hdr = &new_hp->v6hdr;
     maina = &new_hp->maina;
     mainb = &new_hp->mainb;
@@ -507,8 +526,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
                                | RTAS_LOG_OPTIONAL_PART_PRESENT
                                | RTAS_LOG_INITIATOR_HOTPLUG
                                | RTAS_LOG_TYPE_HOTPLUG);
-    hdr->extended_length = cpu_to_be32(sizeof(*new_hp)
-                                       - sizeof(new_hp->hdr));
+    hdr->extended_length = cpu_to_be32(sizeof(*new_hp));
 
     spapr_init_v6hdr(v6hdr);
     spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
@@ -561,7 +579,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
             cpu_to_be32(drc_id->count_indexed.index);
     }
 
-    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp);
+    rtas_event_log_queue(spapr, entry);
 
     qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
                                  rtas_event_log_to_irq(spapr,
@@ -635,10 +653,10 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                             target_ulong args,
                             uint32_t nret, target_ulong rets)
 {
-    uint32_t mask, buf, len, event_len;
+    uint32_t mask, buf, len, event_len, extended_len;
     uint64_t xinfo;
+    uint8_t *full_log;
     sPAPREventLogEntry *event;
-    struct rtas_error_log *hdr;
     int i;
 
     if ((nargs < 6) || (nargs > 7) || nret != 1) {
@@ -654,21 +672,29 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         xinfo |= (uint64_t)rtas_ld(args, 6) << 32;
     }
 
-    event = rtas_event_log_dequeue(mask);
+    event = rtas_event_log_dequeue(spapr, mask);
     if (!event) {
         goto out_no_events;
     }
 
-    hdr = event->data;
-    event_len = be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
+    extended_len = be32_to_cpu(event->header.extended_length);
+    event_len = extended_len + sizeof(event->header);
 
     if (event_len < len) {
         len = event_len;
     }
 
-    cpu_physical_memory_write(buf, event->data, len);
+    full_log = g_malloc0(event_len);
+    g_assert(full_log);
+
+    memcpy(full_log, &event->header, sizeof(event->header));
+    memcpy(full_log + sizeof(event->header), event->extended_log,
+           extended_len);
+
+    cpu_physical_memory_write(buf, full_log, len);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
-    g_free(event->data);
+    g_free(full_log);
+    g_free(event->extended_log);
     g_free(event);
 
     /* according to PAPR+, the IRQ must be left asserted, or re-asserted, if
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f973b02..9432b64 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -598,9 +598,14 @@ struct sPAPRTCETable {
 
 sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
 
+struct rtas_error_log {
+    uint32_t summary;
+    uint32_t extended_length;
+} QEMU_PACKED;
+
 struct sPAPREventLogEntry {
-    int log_type;
-    void *data;
+    struct rtas_error_log header;
+    void *extended_log;
     QTAILQ_ENTRY(sPAPREventLogEntry) next;
 };
 
-- 
2.9.4
