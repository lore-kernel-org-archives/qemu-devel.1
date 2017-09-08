Received: from eggs.gnu.org ([2001:4830:134:3::10]:58538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdz-00023n-DV
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdu-00037r-PS
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:20 +1000
Message-Id: <20170908103558.31632-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/40] hw/ppc: clear pending_events on machine
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

The sPAPR machine isn't clearing up the pending events QTAILQ on
machine reboot. This allows for unprocessed hotplug/epow events
to persist in the queue after reset and, when reasserting the IRQs in
check_exception later on, these will be being processed by the OS.

This patch implements a new function called 'spapr_clear_pending_events'
that clears up the pending_events QTAILQ. This helper is then called
inside ppc_spapr_reset to clear up the events queue, preventing
old/deprecated events from persisting after a reset.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  1 +
 hw/ppc/spapr_events.c  | 11 +++++++++++
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cec441cbf4..0e5f29d348 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1392,6 +1392,7 @@ static void ppc_spapr_reset(void)
     }
 
     qemu_devices_reset();
+    spapr_clear_pending_events(spapr);
 
     /*
      * We place the device tree and RTAS just below either the top of the RMA,
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index f952b78237..66b8164f30 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -700,6 +700,17 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
 }
 
+void spapr_clear_pending_events(sPAPRMachineState *spapr)
+{
+    sPAPREventLogEntry *entry = NULL;
+
+    QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
+        QTAILQ_REMOVE(&spapr->pending_events, entry, next);
+        g_free(entry->extended_log);
+        g_free(entry);
+    }
+}
+
 void spapr_events_init(sPAPRMachineState *spapr)
 {
     QTAILQ_INIT(&spapr->pending_events);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2a303a705c..5d161ec580 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -662,6 +662,7 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
 void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
                           Error **errp);
+void spapr_clear_pending_events(sPAPRMachineState *spapr);
 
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
-- 
2.13.5
