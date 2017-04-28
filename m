Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45fY-0002ys-QV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45fT-0005vs-OL
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d45fT-0005vg-Fx
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3SDA4ux025000
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:38 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3hf68gyu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:38 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Apr 2017 07:10:37 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 28 Apr 2017 15:09:50 +0200
In-Reply-To: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170428130951.44771-13-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 12/13] vfio/ccw: update sense data if a unit
 check is pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com

Concurrent-sense data is currently not delivered. This patch stores
the concurrent-sense data to the subchannel if a unit check is pending
and the concurrent-sense bit is enabled. Then a TSCH can retreive the
right IRB data back to the guest.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 3ff78c5..03687a8 100644
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
2.10.2
