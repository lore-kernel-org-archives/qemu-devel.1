Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523AAC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A2120836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A2120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6JLS-0000du-A0
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 14:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6JKc-0008BY-1s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6JKa-0000LG-JY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:23:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6JKa-0000KG-Bc
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:23:52 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01OJL1mD124494
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:23:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yax381x7h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:23:50 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 24 Feb 2020 19:23:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 24 Feb 2020 19:23:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01OJNi4v59179040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 19:23:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73F404C04A;
 Mon, 24 Feb 2020 19:23:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C9464C044;
 Mon, 24 Feb 2020 19:23:44 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.1.90])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2020 19:23:44 +0000 (GMT)
Subject: [PATCH] spapr: Handle pending hot plug/unplug requests at CAS
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Feb 2020 20:23:43 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022419-0016-0000-0000-000002E9E1A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022419-0017-0000-0000-0000334D0A74
Message-Id: <158257222352.4102917.8984214333937947307.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-24_10:2020-02-21,
 2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=2 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 clxscore=1034 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a hot plug or unplug request is pending at CAS, we currently trigger
a CAS reboot, which severely increases the guest boot time. This is
because SLOF doesn't handle hot plug events and we had no way to fix
the FDT that gets presented to the guest.

We can do better thanks to recent changes in QEMU and SLOF:

- we now return a full FDT to SLOF during CAS

- SLOF was fixed to correctly detect any device that was either added or
  removed since boot time and to update its internal DT accordingly.

The right solution is to process all pending hot plug/unplug requests
during CAS: convert hot plugged devices to cold plugged devices and
remove the hot unplugged ones, which is exactly what spapr_drc_reset()
does. Also clear all hot plug events that are currently queued since
they're no longer relevant.

Note that SLOF cannot currently populate hot plugged PCI bridges or PHBs
at CAS. Until this limitation is lifted, SLOF will reset the machine when
this scenario occurs : this will allow the FDT to be fully processed when
SLOF is started again (ie. the same effect as the CAS reboot that would
occur anyway without this patch).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_events.c  |   13 +++++++++++++
 hw/ppc/spapr_hcall.c   |   11 +++++------
 include/hw/ppc/spapr.h |    1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 8b32b7eea526..2afd1844e4d4 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -983,6 +983,19 @@ void spapr_clear_pending_events(SpaprMachineState *spapr)
     }
 }
 
+void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr)
+{
+    SpaprEventLogEntry *entry = NULL, *next_entry;
+
+    QTAILQ_FOREACH_SAFE(entry, &spapr->pending_events, next, next_entry) {
+        if (spapr_event_log_entry_type(entry) == RTAS_LOG_TYPE_HOTPLUG) {
+            QTAILQ_REMOVE(&spapr->pending_events, entry, next);
+            g_free(entry->extended_log);
+            g_free(entry);
+        }
+    }
+}
+
 void spapr_events_init(SpaprMachineState *spapr)
 {
     int epow_irq = SPAPR_IRQ_EPOW;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6db3dbde9c92..5992849c1664 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1640,7 +1640,7 @@ static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return best_compat;
 }
 
-static bool spapr_transient_dev_before_cas(void)
+static void spapr_handle_transient_dev_before_cas(SpaprMachineState *spapr)
 {
     Object *drc_container;
     ObjectProperty *prop;
@@ -1658,10 +1658,11 @@ static bool spapr_transient_dev_before_cas(void)
                                                           prop->name, NULL));
 
         if (spapr_drc_transient(drc)) {
-            return true;
+            spapr_drc_reset(drc);
         }
     }
-    return false;
+
+    spapr_clear_pending_hotplug_events(spapr);
 }
 
 static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
@@ -1834,9 +1835,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     spapr_irq_update_active_intc(spapr);
 
-    if (spapr_transient_dev_before_cas()) {
-        spapr->cas_reboot = true;
-    }
+    spapr_handle_transient_dev_before_cas(spapr);
 
     if (!spapr->cas_reboot) {
         void *fdt;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 09110961a589..a4216935a148 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -824,6 +824,7 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
 void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
                           Error **errp);
 void spapr_clear_pending_events(SpaprMachineState *spapr);
+void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr);
 int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);


