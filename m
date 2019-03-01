Received: from eggs.gnu.org ([209.51.188.92]:39055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzjDv-0007Qx-No
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzizY-0005zt-Q8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:18:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38836
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzizY-0005zZ-Ky
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:18:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21EFax1129250
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 09:18:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qy3yxptvt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:18:22 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 1 Mar 2019 14:17:57 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 01 Mar 2019 15:17:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155144987334.126105.2493613675615671242.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] spapr: Explicitly check machine support before
 using EVENT_CLASS_HOT_PLUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>

Recent commit b8165118f52c "spapr: support memory unplug for qtest" broke
CPU hotplug tests for old machine types:

$ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-test -m=slow
/ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=6: OK
/ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=6: **
ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_source: assertion failed: (source->enabled)
Broken pipe
/home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
Aborted (core dumped)

The rtas_event_log_to_source() function is supposed to return the event
source to be used for a given event type. In the case of hotplug, it first
tries EVENT_CLASS_HOT_PLUG and, if the guest doesn't support it, it falls
back to EVENT_CLASS_EPOW.

This works well for machine types that enable EVENT_CLASS_HOT_PLUG. For
older machine types, this happened to work because they don't set the
OV5_HP_EVT bit in spapr->ov5. CAS hence logically keeps the bit cleared
in spapr->ov5_cas and we avoid the assert.

As shown by commit b8165118f52c, the logic is fragile and we need a
bigger hammer to ensure that rtas_event_log_to_source() doesn't go
down the EVENT_CLASS_HOT_PLUG path with older machine types.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_events.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ab9a1f0063d5..1a09dab6857d 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -307,11 +307,13 @@ rtas_event_log_to_source(sPAPRMachineState *spapr, int log_type)
 
     switch (log_type) {
     case RTAS_LOG_TYPE_HOTPLUG:
-        source = spapr_event_sources_get_source(spapr->event_sources,
-                                                EVENT_CLASS_HOT_PLUG);
-        if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
-            g_assert(source->enabled);
-            break;
+        if (spapr->use_hotplug_event_source) {
+            source = spapr_event_sources_get_source(spapr->event_sources,
+                                                    EVENT_CLASS_HOT_PLUG);
+            if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
+                g_assert(source->enabled);
+                break;
+            }
         }
         /* fall back to epow for legacy hotplug interrupt source */
     case RTAS_LOG_TYPE_EPOW:
