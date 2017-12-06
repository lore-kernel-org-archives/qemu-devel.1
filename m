Received: from eggs.gnu.org ([2001:4830:134:3::10]:49827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCf-0000ug-A5
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCc-0000x3-1n
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40672
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCb-0000wW-SZ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:53 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE8EN050719
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:53 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epk5h2m7v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:51 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:50 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:36 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-44-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 43/55] hw/ppc: clear pending_events on machine
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

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
(cherry picked from commit 56258174238eb25df629a53a96e1ac16a32dc7d4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |  1 +
 hw/ppc/spapr_events.c  | 11 +++++++++++
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cc3901a790..954fd1a747 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1416,6 +1416,7 @@ static void ppc_spapr_reset(void)
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
2.11.0
