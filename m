Received: from eggs.gnu.org ([2001:4830:134:3::10]:35566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgd-0003D3-8q
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZga-0003Gh-32
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52210
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZgZ-0003GZ-OL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7IuEg067033
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:35 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27x1rcpeyp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:35 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:20:34 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:19:42 +0100
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112071947.98071-11-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 10/15] vfio: ccw: realize
 VFIO_DEVICE_RESET ioctl
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

Introduce VFIO_DEVICE_RESET ioctl for vfio-ccw to make it possible
to hot-reset the device.

We try to achieve a reset by first disabling the subchannel and
then enabling it again: this should clear all state at the subchannel.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 42 +++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5c60cda..b702735 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -19,6 +19,31 @@
 #define MAX_INSTANCES	1
 static int available_instances = MAX_INSTANCES;
 
+static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(mdev->dev.parent);
+	struct subchannel *sch;
+	int ret;
+
+	if (!private)
+		return -ENODEV;
+
+	sch = private->sch;
+	/*
+	 * TODO:
+	 * In the cureent stage, some things like "no I/O running" and "no
+	 * interrupt pending" are clear, but we are not sure what other state
+	 * we need to care about.
+	 * There are still a lot more instructions need to be handled. We
+	 * should come back here later.
+	 */
+	ret = vfio_ccw_sch_quiesce(sch);
+	if (ret)
+		return ret;
+
+	return cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+}
+
 static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
 				  unsigned long action,
 				  void *data)
@@ -35,15 +60,11 @@ static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
 	 */
 	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
 		struct vfio_iommu_type1_dma_unmap *unmap = data;
-		struct subchannel *sch = private->sch;
 
 		if (!cp_iova_pinned(&private->cp, unmap->iova))
 			return NOTIFY_OK;
 
-		if (vfio_ccw_sch_quiesce(sch))
-			return NOTIFY_BAD;
-
-		if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
+		if (vfio_ccw_mdev_reset(private->mdev))
 			return NOTIFY_BAD;
 
 		cp_free(&private->cp);
@@ -107,14 +128,9 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(mdev->parent->dev);
-	struct subchannel *sch;
 	int ret;
 
-	sch = private->sch;
-	ret = vfio_ccw_sch_quiesce(sch);
-	if (ret)
-		return ret;
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+	ret = vfio_ccw_mdev_reset(mdev);
 	if (ret)
 		return ret;
 
@@ -193,7 +209,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 static int vfio_ccw_mdev_get_device_info(struct mdev_device *mdev,
 					 struct vfio_device_info *info)
 {
-	info->flags = VFIO_DEVICE_FLAGS_CCW;
+	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
 	info->num_regions = VFIO_CCW_NUM_REGIONS;
 	info->num_irqs = 0;
 
@@ -265,6 +281,8 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 	}
+	case VFIO_DEVICE_RESET:
+		return vfio_ccw_mdev_reset(mdev);
 	default:
 		return -ENOTTY;
 	}
-- 
2.8.4
