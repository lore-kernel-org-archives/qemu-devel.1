Received: from eggs.gnu.org ([2001:4830:134:3::10]:33966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k9F-00055t-W1
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k9C-0006Zd-QQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39748
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d6k9C-0006Yz-KI
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45KhifN073049
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 16:48:18 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a8y2uuvqq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 16:48:17 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 5 May 2017 17:48:15 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 17:47:46 -0300
In-Reply-To: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170505204746.14116-7-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v9 6/6] migration: spapr: migrate
 pending_events of spapr state
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

From: Jianjun Duan <duanj@linux.vnet.ibm.com>

In racing situations between hotplug events and migration operation,
a rtas hotplug event could have not yet be delivered to the source
guest when migration is started. In this case the pending_events of
spapr state need be transmitted to the target so that the hotplug
event can be finished on the target.

All the different fields of the events are encoded as defined by
PAPR. We can migrate them as uint8_t binary stream without any
concerns about data padding or endianess.

pending_events is put in a subsection in the spapr state VMSD to make
sure migration across different versions is not broken.

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
 include/hw/ppc/spapr.h |  3 ++-
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bc56249..e924fd4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1498,6 +1498,38 @@ static const VMStateDescription vmstate_spapr_ccs_list = {
     },
 };
 
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
+        VMSTATE_INT32(log_type, sPAPREventLogEntry),
+        VMSTATE_BOOL(exception, sPAPREventLogEntry),
+        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
+        VMSTATE_VARRAY_UINT32_ALLOC(data, sPAPREventLogEntry, data_size,
+                                    0, vmstate_info_uint8, uint8_t),
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
@@ -1598,6 +1630,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_patb_entry,
         &vmstate_spapr_pending_dimm_unplugs,
         &vmstate_spapr_ccs_list,
+        &vmstate_spapr_pending_events,
         NULL
     }
 };
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index f0b28d8..70c7cfc 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -342,7 +342,8 @@ static int rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
     return source->irq;
 }
 
-static void rtas_event_log_queue(int log_type, void *data, bool exception)
+static void rtas_event_log_queue(int log_type, void *data, bool exception,
+                                 int data_size)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPREventLogEntry *entry = g_new(sPAPREventLogEntry, 1);
@@ -351,6 +352,7 @@ static void rtas_event_log_queue(int log_type, void *data, bool exception)
     entry->log_type = log_type;
     entry->exception = exception;
     entry->data = data;
+    entry->data_size = data_size;
     QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
 }
 
@@ -445,6 +447,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
     struct rtas_event_log_v6_mainb *mainb;
     struct rtas_event_log_v6_epow *epow;
     struct epow_log_full *new_epow;
+    uint32_t data_size;
 
     new_epow = g_malloc0(sizeof(*new_epow));
     hdr = &new_epow->hdr;
@@ -453,14 +456,13 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
     mainb = &new_epow->mainb;
     epow = &new_epow->epow;
 
+    data_size = sizeof(*new_epow);
     hdr->summary = cpu_to_be32(RTAS_LOG_VERSION_6
                                | RTAS_LOG_SEVERITY_EVENT
                                | RTAS_LOG_DISPOSITION_NOT_RECOVERED
                                | RTAS_LOG_OPTIONAL_PART_PRESENT
                                | RTAS_LOG_TYPE_EPOW);
-    hdr->extended_length = cpu_to_be32(sizeof(*new_epow)
-                                       - sizeof(new_epow->hdr));
-
+    hdr->extended_length = cpu_to_be32(data_size - sizeof(new_epow->hdr));
     spapr_init_v6hdr(v6hdr);
     spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
 
@@ -479,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
     epow->event_modifier = RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
     epow->extended_modifier = RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPECIFIC;
 
-    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
+    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true, data_size);
 
     qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
                                  rtas_event_log_to_irq(spapr,
@@ -504,6 +506,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     struct rtas_event_log_v6_maina *maina;
     struct rtas_event_log_v6_mainb *mainb;
     struct rtas_event_log_v6_hp *hp;
+    uint32_t data_size;
 
     new_hp = g_malloc0(sizeof(struct hp_log_full));
     hdr = &new_hp->hdr;
@@ -512,14 +515,14 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     mainb = &new_hp->mainb;
     hp = &new_hp->hp;
 
+    data_size = sizeof(*new_hp);
     hdr->summary = cpu_to_be32(RTAS_LOG_VERSION_6
                                | RTAS_LOG_SEVERITY_EVENT
                                | RTAS_LOG_DISPOSITION_NOT_RECOVERED
                                | RTAS_LOG_OPTIONAL_PART_PRESENT
                                | RTAS_LOG_INITIATOR_HOTPLUG
                                | RTAS_LOG_TYPE_HOTPLUG);
-    hdr->extended_length = cpu_to_be32(sizeof(*new_hp)
-                                       - sizeof(new_hp->hdr));
+    hdr->extended_length = cpu_to_be32(data_size - sizeof(new_hp->hdr));
 
     spapr_init_v6hdr(v6hdr);
     spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
@@ -572,7 +575,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
             cpu_to_be32(drc_id->count_indexed.index);
     }
 
-    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
+    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true, data_size);
 
     qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
                                  rtas_event_log_to_irq(spapr,
@@ -671,8 +674,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     if (!event) {
         goto out_no_events;
     }
-
-    hdr = event->data;
+    hdr = (struct rtas_error_log *)event->data;
     event_len = be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
 
     if (event_len < len) {
@@ -728,7 +730,7 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         goto out_no_events;
     }
 
-    hdr = event->data;
+    hdr = (struct rtas_error_log *)event->data;
     event_len = be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
 
     if (event_len < len) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index adc9fdb..ddac014 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -603,7 +603,8 @@ sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
 struct sPAPREventLogEntry {
     int log_type;
     bool exception;
-    void *data;
+    uint8_t *data;
+    uint32_t data_size;
     QTAILQ_ENTRY(sPAPREventLogEntry) next;
 };
 
-- 
2.9.3
