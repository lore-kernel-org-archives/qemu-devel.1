Received: from eggs.gnu.org ([209.51.188.92]:48013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzntx-0007w2-Eq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gznts-0002R6-L3
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzntm-0002GI-Lq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21JOFqM037344
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 14:32:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qy8arykq9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 14:32:44 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 1 Mar 2019 19:32:42 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 01 Mar 2019 20:32:37 +0100
In-Reply-To: <155146874478.147873.5019623412212796259.stgit@bahia.lan>
References: <155146874478.147873.5019623412212796259.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155146875704.147873.10563808578795890265.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 2/2] spapr: Simulate CAS for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The RTAS event hotplug code for machine types 2.8 and newer depends on
the CAS negotiated ov5 in order to work properly. However, there's no
CAS when running under qtest. There has been a tentative to trick the
code by faking the OV5_HP_EVT bit, but it turned out to break other
assumptions in the code and the change got reverted.

Go for a more general approach and simulate a CAS when running under
qtest. For simplicity, this pseudo CAS simple simulates the case where
the guest supports the same features as the machine. It is done at
reset time, just before we reset the DRCs, which could potentially
exercise the unplug code.

This allows to test unplug on spapr with both older and newer machine
types.

Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b6a571b6f184..6da64ef7ee2b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -29,6 +29,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/qtest.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
@@ -1711,6 +1712,16 @@ static void spapr_machine_reset(void)
      */
     spapr_irq_reset(spapr, &error_fatal);
 
+    /*
+     * There is no CAS under qtest. Simulate one to please the code that
+     * depends on spapr->ov5_cas. This is especially needed to test device
+     * unplug, so we do that before resetting the DRCs.
+     */
+    if (qtest_enabled()) {
+        spapr_ovec_cleanup(spapr->ov5_cas);
+        spapr->ov5_cas = spapr_ovec_clone(spapr->ov5);
+    }
+
     /* DRC reset may cause a device to be unplugged. This will cause troubles
      * if this device is used by another device (eg, a running vhost backend
      * will crash QEMU if the DIMM holding the vring goes away). To avoid such
