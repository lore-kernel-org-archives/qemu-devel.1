Received: from eggs.gnu.org ([2001:4830:134:3::10]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgb-0003Bl-MV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgW-0003GE-PA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZgW-0003G4-7e
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:32 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7Iu9W018153
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:31 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27wyp9tgkt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:31 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:20:30 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:19:41 +0100
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112071947.98071-10-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 09/15] vfio: ccw: realize
 VFIO_DEVICE_GET_REGION_INFO
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

Introduce device information about vfio-ccw: VFIO_DEVICE_FLAGS_CCW.
Realize VFIO_DEVICE_GET_REGION_INFO ioctl for vfio-ccw.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 81 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       | 11 ++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 360ba47..5c60cda 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -190,6 +190,86 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	return count;
 }
 
+static int vfio_ccw_mdev_get_device_info(struct mdev_device *mdev,
+					 struct vfio_device_info *info)
+{
+	info->flags = VFIO_DEVICE_FLAGS_CCW;
+	info->num_regions = VFIO_CCW_NUM_REGIONS;
+	info->num_irqs = 0;
+
+	return 0;
+}
+
+static int vfio_ccw_mdev_get_region_info(struct mdev_device *mdev,
+					 struct vfio_region_info *info,
+					 u16 *cap_type_id,
+					 void **cap_type)
+{
+	switch (info->index) {
+	case VFIO_CCW_CONFIG_REGION_INDEX:
+		info->offset = 0;
+		info->size = sizeof(struct ccw_io_region);
+		info->flags = VFIO_REGION_INFO_FLAG_READ
+			      | VFIO_REGION_INFO_FLAG_WRITE;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
+				   unsigned int cmd,
+				   unsigned long arg)
+{
+	int ret = 0;
+	unsigned long minsz;
+
+	switch (cmd) {
+	case VFIO_DEVICE_GET_INFO:
+	{
+		struct vfio_device_info info;
+
+		minsz = offsetofend(struct vfio_device_info, num_irqs);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		ret = vfio_ccw_mdev_get_device_info(mdev, &info);
+		if (ret)
+			return ret;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+	}
+	case VFIO_DEVICE_GET_REGION_INFO:
+	{
+		struct vfio_region_info info;
+		u16 cap_type_id = 0;
+		void *cap_type = NULL;
+
+		minsz = offsetofend(struct vfio_region_info, offset);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		ret = vfio_ccw_mdev_get_region_info(mdev, &info,
+						    &cap_type_id,
+						    &cap_type);
+		if (ret)
+			return ret;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+	}
+	default:
+		return -ENOTTY;
+	}
+}
+
 static const struct parent_ops vfio_ccw_mdev_ops = {
 	.owner			= THIS_MODULE,
 	.supported_type_groups  = mdev_type_groups,
@@ -199,6 +279,7 @@ static const struct parent_ops vfio_ccw_mdev_ops = {
 	.release		= vfio_ccw_mdev_release,
 	.read			= vfio_ccw_mdev_read,
 	.write			= vfio_ccw_mdev_write,
+	.ioctl			= vfio_ccw_mdev_ioctl,
 };
 
 int vfio_ccw_mdev_reg(struct subchannel *sch)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 6183789..3fd70ff 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -198,6 +198,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
+#define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -447,6 +448,16 @@ enum {
 	VFIO_PCI_NUM_IRQS
 };
 
+/*
+ * The vfio-ccw bus driver makes use of the following fixed region.
+ * Unimplemented regions return a size of zero.
+ */
+
+enum {
+	VFIO_CCW_CONFIG_REGION_INDEX,
+	VFIO_CCW_NUM_REGIONS
+};
+
 /**
  * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
  *					      struct vfio_pci_hot_reset_info)
-- 
2.8.4
