Received: from eggs.gnu.org ([2001:4830:134:3::10]:57234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7cs-00054g-PA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7cn-0006Qe-Oj
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dn7cn-0006QH-HW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UIJhoR133660
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:22:01 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cnxtfev8a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:22:00 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 14:22:00 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 15:21:40 -0300
In-Reply-To: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
References: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170830182141.19996-3-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 2/3] hw/ppc: clear pending_events
 on machine reset
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

The sPAPR machine isn't clearing up the pending events QTAILQ on
machine reboot. This allows for unprocessed hotplug/epow events
to persist in the queue after reset and, when reasserting the IRQs in
check_exception later on, these will be being processed by the OS.

This patch implements a new function called 'spapr_clear_pending_events'
that clears up the pending_events QTAILQ. This helper is then called
inside ppc_spapr_reset to clear up the events queue, preventing
old/deprecated events from persisting after a reset.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |  1 +
 hw/ppc/spapr_events.c  | 11 +++++++++++
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fb1e5e0..085415c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1392,6 +1392,7 @@ static void ppc_spapr_reset(void)
     }
 
     qemu_devices_reset();
+    spapr_clear_pending_events(spapr);
 
     /*
      * We place the device tree and RTAS just below either the top of the RMA,
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index f952b78..66b8164 100644
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
index 86c982c..91617e3 100644
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
2.9.4
