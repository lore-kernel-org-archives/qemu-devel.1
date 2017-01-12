Received: from eggs.gnu.org ([2001:4830:134:3::10]:35537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgX-00039c-6V
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgT-0003Fu-Nl
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38692
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZgT-0003Fn-HF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:29 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7J7SN120381
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:29 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27x3at3ky7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:28 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:20:28 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:19:40 +0100
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112071947.98071-9-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 08/15] vfio: ccw: handle ccw command
 request
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

We implement the basic ccw command handling infrastructure
here:
1. Translate the ccw commands.
2. Issue the translated ccw commands to the device.
3. Once we get the execution result, update the guest SCSW
   with it.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 115 ++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c     |  24 ++++++--
 drivers/s390/cio/vfio_ccw_private.h |  14 +++++
 3 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ef34b15..595dcb4 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -15,9 +15,13 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
+#include <linux/mdev.h>
 
 #include <asm/isc.h>
 
+#include "ioasm.h"
+#include "css.h"
 #include "vfio_ccw_private.h"
 
 /*
@@ -63,6 +67,109 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 	return ret;
 }
 
+static int doing_io(struct vfio_ccw_private *private, u32 intparm)
+{
+	return (private->intparm == intparm);
+}
+
+static int vfio_ccw_sch_io_helper(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch;
+	union orb *orb;
+	int ccode;
+	__u8 lpm;
+	u32 intparm;
+
+	sch = private->sch;
+
+	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
+
+	/* Issue "Start Subchannel" */
+	ccode = ssch(sch->schid, orb);
+
+	switch (ccode) {
+	case 0:
+		/*
+		 * Initialize device status information
+		 */
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
+		break;
+	case 1:		/* Status pending */
+	case 2:		/* Busy */
+		return -EBUSY;
+	case 3:		/* Device/path not operational */
+	{
+		lpm = orb->cmd.lpm;
+		if (lpm != 0)
+			sch->lpm &= ~lpm;
+		else
+			sch->lpm = 0;
+
+		if (cio_update_schib(sch))
+			return -ENODEV;
+
+		return sch->lpm ? -EACCES : -ENODEV;
+	}
+	default:
+		return ccode;
+	}
+
+	intparm = (u32)(addr_t)sch;
+	private->intparm = 0;
+	wait_event(private->wait_q, doing_io(private, intparm));
+
+	if (scsw_is_solicited(&private->irb.scsw))
+		cp_update_scsw(&private->cp, &private->irb.scsw);
+
+	return 0;
+}
+
+/* Deal with the ccw command request from the userspace. */
+int vfio_ccw_sch_cmd_request(struct vfio_ccw_private *private)
+{
+	struct mdev_device *mdev = private->mdev;
+	union orb *orb;
+	union scsw *scsw = &private->scsw;
+	struct irb *irb = &private->irb;
+	struct ccw_io_region *io_region = &private->io_region;
+	int ret;
+
+	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
+
+	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
+		orb = (union orb *)io_region->orb_area;
+
+		ret = cp_init(&private->cp, &mdev->dev, orb);
+		if (ret)
+			return ret;
+
+		ret = cp_prefetch(&private->cp);
+		if (ret) {
+			cp_free(&private->cp);
+			return ret;
+		}
+
+		/* Start channel program and wait for I/O interrupt. */
+		ret = vfio_ccw_sch_io_helper(private);
+		if (!ret) {
+			/* Get irb info and copy it to irb_area. */
+			memcpy(io_region->irb_area, irb, sizeof(*irb));
+		}
+
+		cp_free(&private->cp);
+	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
+		/* XXX: Handle halt. */
+		ret = -EOPNOTSUPP;
+	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
+		/* XXX: Handle clear. */
+		ret = -EOPNOTSUPP;
+	} else {
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
 /*
  * Sysfs interfaces
  */
@@ -117,12 +224,18 @@ static struct attribute_group vfio_subchannel_attr_group = {
 static void vfio_ccw_sch_irq(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	struct irb *irb;
 
 	inc_irq_stat(IRQIO_CIO);
 
 	if (!private)
 		return;
 
+	irb = this_cpu_ptr(&cio_irb);
+	memcpy(&private->irb, irb, sizeof(*irb));
+	private->intparm = (u32)(addr_t)sch;
+	wake_up(&private->wait_q);
+
 	if (private->completion)
 		complete(private->completion);
 }
@@ -160,6 +273,8 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_rm_group;
 
+	init_waitqueue_head(&private->wait_q);
+
 	return 0;
 
 out_rm_group:
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index d68a296..360ba47 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -30,12 +30,25 @@ static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
 		return NOTIFY_STOP;
 
 	/*
-	 * TODO:
 	 * Vendor drivers MUST unpin pages in response to an
 	 * invalidation.
 	 */
-	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP)
-		return NOTIFY_BAD;
+	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
+		struct vfio_iommu_type1_dma_unmap *unmap = data;
+		struct subchannel *sch = private->sch;
+
+		if (!cp_iova_pinned(&private->cp, unmap->iova))
+			return NOTIFY_OK;
+
+		if (vfio_ccw_sch_quiesce(sch))
+			return NOTIFY_BAD;
+
+		if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
+			return NOTIFY_BAD;
+
+		cp_free(&private->cp);
+		return NOTIFY_OK;
+	}
 
 	return NOTIFY_DONE;
 }
@@ -169,7 +182,10 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	region = &private->io_region;
 	if (copy_from_user((void *)region + *ppos, buf, count))
 		return -EFAULT;
-	region->ret_code = 0;
+
+	region->ret_code = vfio_ccw_sch_cmd_request(private);
+	if (region->ret_code != 0)
+		return region->ret_code;
 
 	return count;
 }
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 99265a9..4621934 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -14,9 +14,11 @@
 #ifndef _VFIO_CCW_PRIVATE_H_
 #define _VFIO_CCW_PRIVATE_H_
 
+#include <linux/completion.h>
 #include <asm/vfio_ccw.h>
 
 #include "css.h"
+#include "vfio_ccw_cp.h"
 
 /**
  * struct vfio_ccw_private
@@ -25,6 +27,11 @@
  * @mdev: pointor to the mediated device
  * @nb: notifier for vfio events
  * @io_region: MMIO region to input/output I/O arguments/results
+ * @wait_q: wait for interrupt
+ * @intparm: record current interrupt parameter, used for wait interrupt
+ * @cp: ccw program for the current I/O operation
+ * @irb: irb info received from interrupt
+ * @scsw: scsw info
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -32,11 +39,18 @@ struct vfio_ccw_private {
 	struct mdev_device	*mdev;
 	struct notifier_block	nb;
 	struct ccw_io_region	io_region;
+
+	wait_queue_head_t	wait_q;
+	u32			intparm;
+	struct ccwprogram	cp;
+	struct irb		irb;
+	union scsw		scsw;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
 extern void vfio_ccw_mdev_unreg(struct subchannel *sch);
 
 extern int vfio_ccw_sch_quiesce(struct subchannel *sch);
+extern int vfio_ccw_sch_cmd_request(struct vfio_ccw_private *private);
 
 #endif
-- 
2.8.4
