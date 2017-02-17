Received: from eggs.gnu.org ([2001:4830:134:3::10]:44864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ceduv-0003W0-6S
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ceduq-0000uq-LC
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:29:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57479
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1ceduq-0000ue-FD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:29:20 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1H8TAol067147
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:29:19 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28ngt9327m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:29:19 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 17 Feb 2017 03:29:19 -0500
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 09:28:44 +0100
In-Reply-To: <20170217082844.89466-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082844.89466-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170217082844.89466-12-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v3 11/11] vfio/ccw: update sense data if a
 unit check is pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

Concurrent-sense data is currently not delivered. This patch stores
the concurrent-sense data to the subchannel if a unit check is pending
and the concurrent-sense bit is enabled. Then a TSCH can retreive the
right IRB data back to the guest.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 00ab285..b9e365a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -94,6 +94,7 @@ static void vfio_ccw_io_notifier_handler(void *opaque)
     CcwDevice *ccw_dev = CCW_DEVICE(cdev);
     SubchDev *sch = ccw_dev->sch;
     SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
     IRB irb;
 
     if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
@@ -133,6 +134,12 @@ static void vfio_ccw_io_notifier_handler(void *opaque)
     /* Update control block via irb. */
     copy_scsw_to_guest(s, &irb.scsw);
 
+    /* If a uint check is pending, copy sense data. */
+    if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) &&
+        (p->chars & PMCW_CHARS_MASK_CSENSE)) {
+        memcpy(sch->sense_data, irb.ecw, sizeof(irb.ecw));
+    }
+
 read_err:
     css_inject_io_interrupt(sch);
 }
-- 
2.8.4
