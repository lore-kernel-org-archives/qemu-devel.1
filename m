Received: from eggs.gnu.org ([2001:4830:134:3::10]:35414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgA-0002f8-Oq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZg5-000385-LL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZg5-00037j-CJ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7Isf7101507
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:03 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27x2m3csgb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:03 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:20:02 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:19:33 +0100
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112071947.98071-2-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 01/15] s390: cio: introduce
 cio_cancel_halt_clear
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

For future code reuse purpose, this decouples the cio code with
the ccw device specific parts from ccw_device_cancel_halt_clear,
and makes a new common I/O interface named cio_cancel_halt_clear.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/cio.c        | 59 +++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/cio.h        |  1 +
 drivers/s390/cio/device_fsm.c | 54 ++++++---------------------------------
 3 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index de6fccc..8f86072 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -309,6 +309,65 @@ cio_cancel (struct subchannel *sch)
 	}
 }
 
+/**
+ * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt
+ * and clear ordinally if subchannel is valid.
+ * @sch: subchannel on which to perform the cancel_halt_clear operation
+ * @iretry: the number of the times remained to retry the next operation
+ *
+ * This should be called repeatedly since halt/clear are asynchronous
+ * operations. We do one try with cio_cancel, two tries with cio_halt,
+ * 255 tries with cio_clear. The caller should initialize @iretry with
+ * the value 255 for its first call to this, and keep using the same
+ * @iretry in the subsequent calls until it gets a non -EBUSY return.
+ *
+ * Returns 0 if device now idle, -ENODEV for device not operational,
+ * -EBUSY if an interrupt is expected (either from halt/clear or from a
+ * status pending), and -EIO if out of retries.
+ */
+int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)
+{
+	int ret;
+
+	if (cio_update_schib(sch))
+		return -ENODEV;
+	if (!sch->schib.pmcw.ena)
+		/* Not operational -> done. */
+		return 0;
+	/* Stage 1: cancel io. */
+	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_HALT_PEND) &&
+	    !(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
+		if (!scsw_is_tm(&sch->schib.scsw)) {
+			ret = cio_cancel(sch);
+			if (ret != -EINVAL)
+				return ret;
+		}
+		/*
+		 * Cancel io unsuccessful or not applicable (transport mode).
+		 * Continue with asynchronous instructions.
+		 */
+		*iretry = 3;	/* 3 halt retries. */
+	}
+	/* Stage 2: halt io. */
+	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
+		if (*iretry) {
+			*iretry -= 1;
+			ret = cio_halt(sch);
+			if (ret != -EBUSY)
+				return (ret == 0) ? -EBUSY : ret;
+		}
+		/* Halt io unsuccessful. */
+		*iretry = 255;	/* 255 clear retries. */
+	}
+	/* Stage 3: clear io. */
+	if (*iretry) {
+		*iretry -= 1;
+		ret = cio_clear(sch);
+		return (ret == 0) ? -EBUSY : ret;
+	}
+	/* Function was unsuccessful */
+	return -EIO;
+}
 
 static void cio_apply_config(struct subchannel *sch, struct schib *schib)
 {
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index f0e57ae..939596d 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -123,6 +123,7 @@ extern int cio_enable_subchannel(struct subchannel *, u32);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
 extern int cio_clear (struct subchannel *);
+extern int cio_cancel_halt_clear(struct subchannel *, int *);
 extern int cio_resume (struct subchannel *);
 extern int cio_halt (struct subchannel *);
 extern int cio_start (struct subchannel *, struct ccw1 *, __u8);
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 9afb5ce..12016e3 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -124,14 +124,6 @@ ccw_device_set_timeout(struct ccw_device *cdev, int expires)
 	add_timer(&cdev->private->timer);
 }
 
-/*
- * Cancel running i/o. This is called repeatedly since halt/clear are
- * asynchronous operations. We do one try with cio_cancel, two tries
- * with cio_halt, 255 tries with cio_clear. If everythings fails panic.
- * Returns 0 if device now idle, -ENODEV for device not operational and
- * -EBUSY if an interrupt is expected (either from halt/clear or from a
- * status pending).
- */
 int
 ccw_device_cancel_halt_clear(struct ccw_device *cdev)
 {
@@ -139,44 +131,14 @@ ccw_device_cancel_halt_clear(struct ccw_device *cdev)
 	int ret;
 
 	sch = to_subchannel(cdev->dev.parent);
-	if (cio_update_schib(sch))
-		return -ENODEV; 
-	if (!sch->schib.pmcw.ena)
-		/* Not operational -> done. */
-		return 0;
-	/* Stage 1: cancel io. */
-	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_HALT_PEND) &&
-	    !(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
-		if (!scsw_is_tm(&sch->schib.scsw)) {
-			ret = cio_cancel(sch);
-			if (ret != -EINVAL)
-				return ret;
-		}
-		/* cancel io unsuccessful or not applicable (transport mode).
-		 * Continue with asynchronous instructions. */
-		cdev->private->iretry = 3;	/* 3 halt retries. */
-	}
-	if (!(scsw_actl(&sch->schib.scsw) & SCSW_ACTL_CLEAR_PEND)) {
-		/* Stage 2: halt io. */
-		if (cdev->private->iretry) {
-			cdev->private->iretry--;
-			ret = cio_halt(sch);
-			if (ret != -EBUSY)
-				return (ret == 0) ? -EBUSY : ret;
-		}
-		/* halt io unsuccessful. */
-		cdev->private->iretry = 255;	/* 255 clear retries. */
-	}
-	/* Stage 3: clear io. */
-	if (cdev->private->iretry) {
-		cdev->private->iretry--;
-		ret = cio_clear (sch);
-		return (ret == 0) ? -EBUSY : ret;
-	}
-	/* Function was unsuccessful */
-	CIO_MSG_EVENT(0, "0.%x.%04x: could not stop I/O\n",
-		      cdev->private->dev_id.ssid, cdev->private->dev_id.devno);
-	return -EIO;
+	ret = cio_cancel_halt_clear(sch, &cdev->private->iretry);
+
+	if (ret == -EIO)
+		CIO_MSG_EVENT(0, "0.%x.%04x: could not stop I/O\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
+
+	return ret;
 }
 
 void ccw_device_update_sense_data(struct ccw_device *cdev)
-- 
2.8.4
