Received: from eggs.gnu.org ([2001:4830:134:3::10]:45102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cedvo-0004QE-Fz
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cedvj-0001Ll-HE
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:30:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39273
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cedvj-0001LL-A3
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:30:15 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1H8TEMc032419
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:30:14 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28ns6j0tbv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:30:14 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 17 Feb 2017 01:30:13 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 09:29:35 +0100
In-Reply-To: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170217082939.33208-12-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v3 11/15] vfio: ccw: realize
 VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
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

Realize VFIO_DEVICE_GET_IRQ_INFO ioctl to retrieve
VFIO_CCW_IO_IRQ information.

Realize VFIO_DEVICE_SET_IRQS ioctl to set an eventfd fd for
VFIO_CCW_IO_IRQ. Once a write operation to the ccw_io_region
was performed, trigger a signal on this fd.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c     | 123 +++++++++++++++++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_private.h |   4 ++
 include/uapi/linux/vfio.h           |  10 ++-
 3 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 125818c..ebc38fb 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -202,6 +202,9 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	if (region->ret_code != 0)
 		return region->ret_code;
 
+	if (private->io_trigger)
+		eventfd_signal(private->io_trigger, 1);
+
 	return count;
 }
 
@@ -209,7 +212,7 @@ static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
 {
 	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
 	info->num_regions = VFIO_CCW_NUM_REGIONS;
-	info->num_irqs = 0;
+	info->num_irqs = VFIO_CCW_NUM_IRQS;
 
 	return 0;
 }
@@ -230,6 +233,83 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 	}
 }
 
+int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
+{
+	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
+		return -EINVAL;
+
+	info->count = 1;
+	info->flags = VFIO_IRQ_INFO_EVENTFD | VFIO_IRQ_INFO_NORESIZE;
+
+	return 0;
+}
+
+static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
+				  uint32_t flags,
+				  void __user *data)
+{
+	struct vfio_ccw_private *private;
+	struct eventfd_ctx **ctx;
+
+	if (!(flags & VFIO_IRQ_SET_ACTION_TRIGGER))
+		return -EINVAL;
+
+	private = dev_get_drvdata(mdev_parent_dev(mdev));
+	if (!private)
+		return -ENODEV;
+
+	ctx = &private->io_trigger;
+
+	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
+	case VFIO_IRQ_SET_DATA_NONE:
+	{
+		if (*ctx)
+			eventfd_signal(*ctx, 1);
+		return 0;
+	}
+	case VFIO_IRQ_SET_DATA_BOOL:
+	{
+		uint8_t trigger;
+
+		if (get_user(trigger, (uint8_t __user *)data))
+			return -EFAULT;
+
+		if (trigger && *ctx)
+			eventfd_signal(*ctx, 1);
+		return 0;
+	}
+	case VFIO_IRQ_SET_DATA_EVENTFD:
+	{
+		int32_t fd;
+
+		if (get_user(fd, (int32_t __user *)data))
+			return -EFAULT;
+
+		if (fd == -1) {
+			if (*ctx)
+				eventfd_ctx_put(*ctx);
+			*ctx = NULL;
+		} else if (fd >= 0) {
+			struct eventfd_ctx *efdctx;
+
+			efdctx = eventfd_ctx_fdget(fd);
+			if (IS_ERR(efdctx))
+				return PTR_ERR(efdctx);
+
+			if (*ctx)
+				eventfd_ctx_put(*ctx);
+
+			*ctx = efdctx;
+		} else
+			return -EINVAL;
+
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
 static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 				   unsigned int cmd,
 				   unsigned long arg)
@@ -277,6 +357,47 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 	}
+	case VFIO_DEVICE_GET_IRQ_INFO:
+	{
+		struct vfio_irq_info info;
+
+		minsz = offsetofend(struct vfio_irq_info, count);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz || info.index >= VFIO_CCW_NUM_IRQS)
+			return -EINVAL;
+
+		ret = vfio_ccw_mdev_get_irq_info(&info);
+		if (ret)
+			return ret;
+
+		if (info.count == -1)
+			return -EINVAL;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+	}
+	case VFIO_DEVICE_SET_IRQS:
+	{
+		struct vfio_irq_set hdr;
+		size_t data_size;
+		void __user *data;
+
+		minsz = offsetofend(struct vfio_irq_set, count);
+
+		if (copy_from_user(&hdr, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		ret = vfio_set_irqs_validate_and_prepare(&hdr, 1,
+							 VFIO_CCW_NUM_IRQS,
+							 &data_size);
+		if (ret)
+			return ret;
+
+		data = (void __user *)(arg + minsz);
+		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, data);
+	}
 	case VFIO_DEVICE_RESET:
 		return vfio_ccw_mdev_reset(mdev);
 	default:
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 79e5337..dddab52 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -11,6 +11,7 @@
 #define _VFIO_CCW_PRIVATE_H_
 
 #include <linux/completion.h>
+#include <linux/eventfd.h>
 #include <linux/vfio_ccw.h>
 
 #include "css.h"
@@ -29,6 +30,7 @@
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @io_trigger: eventfd ctx for signaling userspace I/O results
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -43,6 +45,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	struct eventfd_ctx	*io_trigger;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 3fd70ff..ae46105 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -449,8 +449,9 @@ enum {
 };
 
 /*
- * The vfio-ccw bus driver makes use of the following fixed region.
- * Unimplemented regions return a size of zero.
+ * The vfio-ccw bus driver makes use of the following fixed region and
+ * IRQ index mapping. Unimplemented regions return a size of zero.
+ * Unimplemented IRQ types return a count of zero.
  */
 
 enum {
@@ -458,6 +459,11 @@ enum {
 	VFIO_CCW_NUM_REGIONS
 };
 
+enum {
+	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_NUM_IRQS
+};
+
 /**
  * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
  *					      struct vfio_pci_hot_reset_info)
-- 
2.8.4
