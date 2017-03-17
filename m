Received: from eggs.gnu.org ([2001:4830:134:3::10]:56979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiPY-0006mB-AH
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiPT-0000Ru-9I
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52560
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1coiPT-0000Rn-2a
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H3DtDH005158
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 297nkp1x6u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:34 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 16 Mar 2017 21:18:33 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 04:17:39 +0100
In-Reply-To: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170317031743.40128-13-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 12/16] vfio: ccw: return I/O results
 asynchronously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

Introduce a singlethreaded workqueue to handle the I/O interrupts.
With the work added to this queue, we store the I/O results to the
io_region of the subchannel, then signal the userspace program to
handle the results.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 58 ++++++++++++++++++++++---------------
 drivers/s390/cio/vfio_ccw_ops.c     |  3 --
 drivers/s390/cio/vfio_ccw_private.h |  7 ++---
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index b5971d3..3e0a40e 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -20,6 +20,8 @@
 #include "css.h"
 #include "vfio_ccw_private.h"
 
+struct workqueue_struct *vfio_ccw_work_q;
+
 /*
  * Helpers
  */
@@ -52,6 +54,7 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 
 			spin_lock_irq(sch->lock);
 			private->completion = NULL;
+			flush_workqueue(vfio_ccw_work_q);
 			ret = cio_cancel_halt_clear(sch, &iretry);
 		};
 
@@ -63,18 +66,12 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 	return ret;
 }
 
-static int doing_io(struct vfio_ccw_private *private, u32 intparm)
-{
-	return (private->intparm == intparm);
-}
-
 static int vfio_ccw_sch_io_helper(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch;
 	union orb *orb;
 	int ccode;
 	__u8 lpm;
-	u32 intparm;
 
 	sch = private->sch;
 
@@ -89,7 +86,7 @@ static int vfio_ccw_sch_io_helper(struct vfio_ccw_private *private)
 		 * Initialize device status information
 		 */
 		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
-		break;
+		return 0;
 	case 1:		/* Status pending */
 	case 2:		/* Busy */
 		return -EBUSY;
@@ -109,15 +106,26 @@ static int vfio_ccw_sch_io_helper(struct vfio_ccw_private *private)
 	default:
 		return ccode;
 	}
+}
 
-	intparm = (u32)(addr_t)sch;
-	private->intparm = 0;
-	wait_event(private->wait_q, doing_io(private, intparm));
+static void vfio_ccw_sch_io_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+	struct subchannel *sch;
+	struct irb *irb;
 
-	if (scsw_is_solicited(&private->irb.scsw))
-		cp_update_scsw(&private->cp, &private->irb.scsw);
+	private = container_of(work, struct vfio_ccw_private, io_work);
+	irb = &private->irb;
+	sch = private->sch;
 
-	return 0;
+	if (scsw_is_solicited(&irb->scsw)) {
+		cp_update_scsw(&private->cp, &irb->scsw);
+		cp_free(&private->cp);
+	}
+	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
+
+	if (private->io_trigger)
+		eventfd_signal(private->io_trigger, 1);
 }
 
 /* Deal with the ccw command request from the userspace. */
@@ -126,7 +134,6 @@ int vfio_ccw_sch_cmd_request(struct vfio_ccw_private *private)
 	struct mdev_device *mdev = private->mdev;
 	union orb *orb;
 	union scsw *scsw = &private->scsw;
-	struct irb *irb = &private->irb;
 	struct ccw_io_region *io_region = &private->io_region;
 	int ret;
 
@@ -147,12 +154,8 @@ int vfio_ccw_sch_cmd_request(struct vfio_ccw_private *private)
 
 		/* Start channel program and wait for I/O interrupt. */
 		ret = vfio_ccw_sch_io_helper(private);
-		if (!ret) {
-			/* Get irb info and copy it to irb_area. */
-			memcpy(io_region->irb_area, irb, sizeof(*irb));
-		}
-
-		cp_free(&private->cp);
+		if (!ret)
+			cp_free(&private->cp);
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		/* XXX: Handle halt. */
 		ret = -EOPNOTSUPP;
@@ -229,8 +232,8 @@ static void vfio_ccw_sch_irq(struct subchannel *sch)
 
 	irb = this_cpu_ptr(&cio_irb);
 	memcpy(&private->irb, irb, sizeof(*irb));
-	private->intparm = (u32)(addr_t)sch;
-	wake_up(&private->wait_q);
+
+	queue_work(vfio_ccw_work_q, &private->io_work);
 
 	if (private->completion)
 		complete(private->completion);
@@ -269,7 +272,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_rm_group;
 
-	init_waitqueue_head(&private->wait_q);
+	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	atomic_set(&private->avail, 1);
 
 	return 0;
@@ -367,10 +370,16 @@ static int __init vfio_ccw_sch_init(void)
 {
 	int ret;
 
+	vfio_ccw_work_q = create_singlethread_workqueue("vfio-ccw");
+	if (!vfio_ccw_work_q)
+		return -ENOMEM;
+
 	isc_register(VFIO_CCW_ISC);
 	ret = css_driver_register(&vfio_ccw_sch_driver);
-	if (ret)
+	if (ret) {
 		isc_unregister(VFIO_CCW_ISC);
+		destroy_workqueue(vfio_ccw_work_q);
+	}
 
 	return ret;
 }
@@ -379,6 +388,7 @@ static void __exit vfio_ccw_sch_exit(void)
 {
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
+	destroy_workqueue(vfio_ccw_work_q);
 }
 module_init(vfio_ccw_sch_init);
 module_exit(vfio_ccw_sch_exit);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 1294c53..d754d3d 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -202,9 +202,6 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	if (region->ret_code != 0)
 		return region->ret_code;
 
-	if (private->io_trigger)
-		eventfd_signal(private->io_trigger, 1);
-
 	return count;
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index dddab52..2503797 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -12,6 +12,7 @@
 
 #include <linux/completion.h>
 #include <linux/eventfd.h>
+#include <linux/workqueue.h>
 #include <linux/vfio_ccw.h>
 
 #include "css.h"
@@ -25,12 +26,11 @@
  * @mdev: pointer to the mediated device
  * @nb: notifier for vfio events
  * @io_region: MMIO region to input/output I/O arguments/results
- * @wait_q: wait for interrupt
- * @intparm: record current interrupt parameter, used for wait interrupt
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
  * @io_trigger: eventfd ctx for signaling userspace I/O results
+ * @io_work: work for deferral process of I/O handling
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -40,13 +40,12 @@ struct vfio_ccw_private {
 	struct notifier_block	nb;
 	struct ccw_io_region	io_region;
 
-	wait_queue_head_t	wait_q;
-	u32			intparm;
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
 
 	struct eventfd_ctx	*io_trigger;
+	struct work_struct	io_work;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
-- 
2.8.4
