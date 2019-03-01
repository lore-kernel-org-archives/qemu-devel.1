Received: from eggs.gnu.org ([209.51.188.92]:47761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzntk-0007hA-F6
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzntj-0002CF-Ff
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzntg-00022q-7r
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:42 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21JOFM7037393
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 14:32:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qy8arykm8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 14:32:38 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 1 Mar 2019 19:32:35 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 01 Mar 2019 20:32:31 +0100
In-Reply-To: <155146874478.147873.5019623412212796259.stgit@bahia.lan>
References: <155146874478.147873.5019623412212796259.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155146875097.147873.1732264036668112686.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 1/2] Revert "spapr: support memory unplug for
 qtest"
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

Commit b8165118f52c broke CPU hotplug tests for old machine types:

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

The approach of faking the availability of OV5_HP_EVT causes the
code to assume the hotplug event source is enabled, which is wrong
for older machines.

This reverts commit b8165118f52ce5ee88565d3cec83d30374efdc96.

A subsequent patch will address the problem of CAS under qtest from
a different angle.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_ovec.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 12510b236a95..318bf33de4b1 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -16,7 +16,6 @@
 #include "qemu/bitmap.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
 #include "trace.h"
 #include <libfdt.h>
 
@@ -132,11 +131,6 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
     g_assert(ov);
     g_assert(bitnr < OV_MAXBITS);
 
-    /* support memory unplug for qtest */
-    if (qtest_enabled() && bitnr == OV5_HP_EVT) {
-        return true;
-    }
-
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }
 
