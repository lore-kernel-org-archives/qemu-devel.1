Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxL-0002ap-Bv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxJ-0001ZR-BR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jul 2017 16:56:03 +1000
Message-Id: <20170717065621.4688-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170717065621.4688-1-david@gibson.dropbear.id.au>
References: <20170717065621.4688-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/21] spapr: Minor cleanups to events handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sjitindarsingh@gmail.com, David Gibson <david@gibson.dropbear.id.au>

The rtas_error_log structure is marked packed, which strongly suggests its
precise layout is important to match an external interface.  Along with
that one could expect it to have a fixed endianness to match the same
interface.  That used to be the case - matching the layout of PAPR RTAS
event format and requiring BE fields.

Now, however, it's only used embedded within sPAPREventLogEntry with the
fields in native order, since they're processed internally.

Clear that up by removing the nested structure in sPAPREventLogEntry.
struct rtas_error_log is moved back to spapr_events.c where it is used as
a temporary to help convert the fields in sPAPREventLogEntry to the correct
in memory format when delivering an event to the guest.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  6 +++---
 hw/ppc/spapr_events.c  | 45 ++++++++++++++++++++++-----------------------
 include/hw/ppc/spapr.h |  6 +-----
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b451d856b8..8528c30ad7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1528,10 +1528,10 @@ static const VMStateDescription vmstate_spapr_event_entry = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(header.summary, sPAPREventLogEntry),
-        VMSTATE_UINT32(header.extended_length, sPAPREventLogEntry),
+        VMSTATE_UINT32(summary, sPAPREventLogEntry),
+        VMSTATE_UINT32(extended_length, sPAPREventLogEntry),
         VMSTATE_VBUFFER_ALLOC_UINT32(extended_log, sPAPREventLogEntry, 0,
-                                     NULL, header.extended_length),
+                                     NULL, extended_length),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ce41e74665..f952b78237 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -42,7 +42,6 @@
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
 
-/* Macros related to rtas_error_log struct defined in spapr.h */
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
 #define RTAS_LOG_SEVERITY_MASK                  0x00e00000
@@ -85,6 +84,11 @@
 #define   RTAS_LOG_TYPE_EPOW                    0x00000040
 #define   RTAS_LOG_TYPE_HOTPLUG                 0x000000e5
 
+struct rtas_error_log {
+    uint32_t summary;
+    uint32_t extended_length;
+} QEMU_PACKED;
+
 struct rtas_event_log_v6 {
     uint8_t b0;
 #define RTAS_LOG_V6_B0_VALID                          0x80
@@ -338,7 +342,7 @@ static int rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
 
 static uint32_t spapr_event_log_entry_type(sPAPREventLogEntry *entry)
 {
-    return entry->header.summary & RTAS_LOG_TYPE_MASK;
+    return entry->summary & RTAS_LOG_TYPE_MASK;
 }
 
 static void rtas_event_log_queue(sPAPRMachineState *spapr,
@@ -426,7 +430,6 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPREventLogEntry *entry;
-    struct rtas_error_log *hdr;
     struct rtas_event_log_v6 *v6hdr;
     struct rtas_event_log_v6_maina *maina;
     struct rtas_event_log_v6_mainb *mainb;
@@ -437,18 +440,17 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
     new_epow = g_malloc0(sizeof(*new_epow));
     entry->extended_log = new_epow;
 
-    hdr = &entry->header;
     v6hdr = &new_epow->v6hdr;
     maina = &new_epow->maina;
     mainb = &new_epow->mainb;
     epow = &new_epow->epow;
 
-    hdr->summary = RTAS_LOG_VERSION_6
+    entry->summary = RTAS_LOG_VERSION_6
                        | RTAS_LOG_SEVERITY_EVENT
                        | RTAS_LOG_DISPOSITION_NOT_RECOVERED
                        | RTAS_LOG_OPTIONAL_PART_PRESENT
                        | RTAS_LOG_TYPE_EPOW;
-    hdr->extended_length = sizeof(*new_epow);
+    entry->extended_length = sizeof(*new_epow);
 
     spapr_init_v6hdr(v6hdr);
     spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
@@ -482,7 +484,6 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPREventLogEntry *entry;
     struct hp_extended_log *new_hp;
-    struct rtas_error_log *hdr;
     struct rtas_event_log_v6 *v6hdr;
     struct rtas_event_log_v6_maina *maina;
     struct rtas_event_log_v6_mainb *mainb;
@@ -492,19 +493,18 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     new_hp = g_malloc0(sizeof(struct hp_extended_log));
     entry->extended_log = new_hp;
 
-    hdr = &entry->header;
     v6hdr = &new_hp->v6hdr;
     maina = &new_hp->maina;
     mainb = &new_hp->mainb;
     hp = &new_hp->hp;
 
-    hdr->summary = RTAS_LOG_VERSION_6
-                       | RTAS_LOG_SEVERITY_EVENT
-                       | RTAS_LOG_DISPOSITION_NOT_RECOVERED
-                       | RTAS_LOG_OPTIONAL_PART_PRESENT
-                       | RTAS_LOG_INITIATOR_HOTPLUG
-                       | RTAS_LOG_TYPE_HOTPLUG;
-    hdr->extended_length = sizeof(*new_hp);
+    entry->summary = RTAS_LOG_VERSION_6
+        | RTAS_LOG_SEVERITY_EVENT
+        | RTAS_LOG_DISPOSITION_NOT_RECOVERED
+        | RTAS_LOG_OPTIONAL_PART_PRESENT
+        | RTAS_LOG_INITIATOR_HOTPLUG
+        | RTAS_LOG_TYPE_HOTPLUG;
+    entry->extended_length = sizeof(*new_hp);
 
     spapr_init_v6hdr(v6hdr);
     spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
@@ -628,10 +628,10 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                             target_ulong args,
                             uint32_t nret, target_ulong rets)
 {
-    CPUState *cs = CPU(cpu);
     uint32_t mask, buf, len, event_len;
     uint64_t xinfo;
     sPAPREventLogEntry *event;
+    struct rtas_error_log header;
     int i;
 
     if ((nargs < 6) || (nargs > 7) || nret != 1) {
@@ -652,18 +652,17 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         goto out_no_events;
     }
 
-    event_len = event->header.extended_length + sizeof(event->header);
+    event_len = event->extended_length + sizeof(header);
 
     if (event_len < len) {
         len = event_len;
     }
 
-    stl_be_phys(cs->as, buf, event->header.summary);
-    stl_be_phys(cs->as, buf + sizeof(event->header.summary),
-                event->header.extended_length);
-    cpu_physical_memory_write(buf + sizeof(event->header),
-                              event->extended_log,
-                              event->header.extended_length);
+    header.summary = cpu_to_be32(event->summary);
+    header.extended_length = cpu_to_be32(event->extended_length);
+    cpu_physical_memory_write(buf, &header, sizeof(header));
+    cpu_physical_memory_write(buf + sizeof(header), event->extended_log,
+                              event->extended_length);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     g_free(event->extended_log);
     g_free(event);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2718b90db7..2ddec025d2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -606,13 +606,9 @@ struct sPAPRTCETable {
 
 sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
 
-struct rtas_error_log {
+struct sPAPREventLogEntry {
     uint32_t summary;
     uint32_t extended_length;
-} QEMU_PACKED;
-
-struct sPAPREventLogEntry {
-    struct rtas_error_log header;
     void *extended_log;
     QTAILQ_ENTRY(sPAPREventLogEntry) next;
 };
-- 
2.13.3
