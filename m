Received: from eggs.gnu.org ([209.51.188.92]:36300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goppH-00014D-IV
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goppF-0005y5-7m
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:47 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Jan 2019 14:22:10 +0100
Message-Id: <20190130132212.7376-5-cohuck@redhat.com>
In-Reply-To: <20190130132212.7376-1-cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/6] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Allow to extend the regions used by vfio-ccw. The first user will be
handling of halt and clear subchannel.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_ops.c     | 181 ++++++++++++++++++++++++----
 drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
 include/uapi/linux/vfio.h           |   2 +
 3 files changed, 195 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 025c8a832bc8..48b2d7930ea8 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -3,9 +3,11 @@
  * Physical device callbacks for vfio_ccw
  *
  * Copyright IBM Corp. 2017
+ * Copyright Red Hat, Inc. 2019
  *
  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Cornelia Huck <cohuck@redhat.com>
  */
 
 #include <linux/vfio.h>
@@ -157,27 +159,33 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 {
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
+	int i;
 
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
+
+	for (i = 0; i < private->num_regions; i++)
+		private->region[i].ops->release(private, &private->region[i]);
+
+	private->num_regions = 0;
+	kfree(private->region);
+	private->region = NULL;
 }
 
-static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
-				  char __user *buf,
-				  size_t count,
-				  loff_t *ppos)
+static ssize_t vfio_ccw_mdev_read_io_region(struct vfio_ccw_private *private,
+					    char __user *buf, size_t count,
+					    loff_t *ppos)
 {
-	struct vfio_ccw_private *private;
+	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_io_region *region;
 	int ret;
 
-	if (*ppos + count > sizeof(*region))
+	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
-	private = dev_get_drvdata(mdev_parent_dev(mdev));
 	mutex_lock(&private->io_mutex);
 	region = private->io_region;
-	if (copy_to_user(buf, (void *)region + *ppos, count))
+	if (copy_to_user(buf, (void *)region + pos, count))
 		ret = -EFAULT;
 	else
 		ret = count;
@@ -185,24 +193,47 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
 	return ret;
 }
 
-static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
-				   const char __user *buf,
-				   size_t count,
-				   loff_t *ppos)
+static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
+				  char __user *buf,
+				  size_t count,
+				  loff_t *ppos)
 {
+	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
 	struct vfio_ccw_private *private;
+
+	private = dev_get_drvdata(mdev_parent_dev(mdev));
+
+	if (index >= VFIO_CCW_NUM_REGIONS + private->num_regions)
+		return -EINVAL;
+
+	switch (index) {
+	case VFIO_CCW_CONFIG_REGION_INDEX:
+		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
+	default:
+		index -= VFIO_CCW_NUM_REGIONS;
+		return private->region[index].ops->read(private, buf, count,
+							ppos);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_io_region *region;
 	int ret;
 
-	if (*ppos + count > sizeof(*region))
+	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
-	private = dev_get_drvdata(mdev_parent_dev(mdev));
 	if (!mutex_trylock(&private->io_mutex))
 		return -EAGAIN;
 
 	region = private->io_region;
-	if (copy_from_user((void *)region + *ppos, buf, count)) {
+	if (copy_from_user((void *)region + pos, buf, count)) {
 		ret = -EFAULT;
 		goto out_unlock;
 	}
@@ -217,19 +248,52 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	return ret;
 }
 
-static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
+static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
+				   const char __user *buf,
+				   size_t count,
+				   loff_t *ppos)
+{
+	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
+	struct vfio_ccw_private *private;
+
+	private = dev_get_drvdata(mdev_parent_dev(mdev));
+
+	if (index >= VFIO_CCW_NUM_REGIONS + private->num_regions)
+		return -EINVAL;
+
+	switch (index) {
+	case VFIO_CCW_CONFIG_REGION_INDEX:
+		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
+	default:
+		index -= VFIO_CCW_NUM_REGIONS;
+		return private->region[index].ops->write(private, buf, count,
+							 ppos);
+	}
+
+	return -EINVAL;
+}
+
+static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info,
+					 struct mdev_device *mdev)
 {
+	struct vfio_ccw_private *private;
+
+	private = dev_get_drvdata(mdev_parent_dev(mdev));
 	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
-	info->num_regions = VFIO_CCW_NUM_REGIONS;
+	info->num_regions = VFIO_CCW_NUM_REGIONS + private->num_regions;
 	info->num_irqs = VFIO_CCW_NUM_IRQS;
 
 	return 0;
 }
 
 static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
-					 u16 *cap_type_id,
-					 void **cap_type)
+					 struct mdev_device *mdev,
+					 unsigned long arg)
 {
+	struct vfio_ccw_private *private;
+	int i;
+
+	private = dev_get_drvdata(mdev_parent_dev(mdev));
 	switch (info->index) {
 	case VFIO_CCW_CONFIG_REGION_INDEX:
 		info->offset = 0;
@@ -237,9 +301,51 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 		info->flags = VFIO_REGION_INFO_FLAG_READ
 			      | VFIO_REGION_INFO_FLAG_WRITE;
 		return 0;
-	default:
-		return -EINVAL;
+	default: /* all other regions are handled via capability chain */
+	{
+		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+		struct vfio_region_info_cap_type cap_type = {
+			.header.id = VFIO_REGION_INFO_CAP_TYPE,
+			.header.version = 1 };
+		int ret;
+
+		if (info->index >=
+		    VFIO_CCW_NUM_REGIONS + private->num_regions)
+			return -EINVAL;
+
+		i = info->index - VFIO_CCW_NUM_REGIONS;
+
+		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
+		info->size = private->region[i].size;
+		info->flags = private->region[i].flags;
+
+		cap_type.type = private->region[i].type;
+		cap_type.subtype = private->region[i].subtype;
+
+		ret = vfio_info_add_capability(&caps, &cap_type.header,
+					       sizeof(cap_type));
+		if (ret)
+			return ret;
+
+		info->flags |= VFIO_REGION_INFO_FLAG_CAPS;
+		if (info->argsz < sizeof(*info) + caps.size) {
+			info->argsz = sizeof(*info) + caps.size;
+			info->cap_offset = 0;
+		} else {
+			vfio_info_cap_shift(&caps, sizeof(*info));
+			if (copy_to_user((void __user *)arg + sizeof(*info),
+					 caps.buf, caps.size)) {
+				kfree(caps.buf);
+				return -EFAULT;
+			}
+			info->cap_offset = sizeof(*info);
+		}
+
+		kfree(caps.buf);
+
+	}
 	}
+	return 0;
 }
 
 static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
@@ -316,6 +422,32 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 	}
 }
 
+int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
+				 unsigned int subtype,
+				 const struct vfio_ccw_regops *ops,
+				 size_t size, u32 flags, void *data)
+{
+	struct vfio_ccw_region *region;
+
+	region = krealloc(private->region,
+			  (private->num_regions + 1) * sizeof(*region),
+			  GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	private->region = region;
+	private->region[private->num_regions].type = VFIO_REGION_TYPE_CCW;
+	private->region[private->num_regions].subtype = subtype;
+	private->region[private->num_regions].ops = ops;
+	private->region[private->num_regions].size = size;
+	private->region[private->num_regions].flags = flags;
+	private->region[private->num_regions].data = data;
+
+	private->num_regions++;
+
+	return 0;
+}
+
 static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 				   unsigned int cmd,
 				   unsigned long arg)
@@ -336,7 +468,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		ret = vfio_ccw_mdev_get_device_info(&info);
+		ret = vfio_ccw_mdev_get_device_info(&info, mdev);
 		if (ret)
 			return ret;
 
@@ -345,8 +477,6 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 	case VFIO_DEVICE_GET_REGION_INFO:
 	{
 		struct vfio_region_info info;
-		u16 cap_type_id = 0;
-		void *cap_type = NULL;
 
 		minsz = offsetofend(struct vfio_region_info, offset);
 
@@ -356,8 +486,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		ret = vfio_ccw_mdev_get_region_info(&info, &cap_type_id,
-						    &cap_type);
+		ret = vfio_ccw_mdev_get_region_info(&info, mdev, arg);
 		if (ret)
 			return ret;
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 32173cbd838d..c979eb32fb1c 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -3,9 +3,11 @@
  * Private stuff for vfio_ccw driver
  *
  * Copyright IBM Corp. 2017
+ * Copyright Red Hat, Inc. 2019
  *
  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Cornelia Huck <cohuck@redhat.com>
  */
 
 #ifndef _VFIO_CCW_PRIVATE_H_
@@ -19,6 +21,38 @@
 #include "css.h"
 #include "vfio_ccw_cp.h"
 
+#define VFIO_CCW_OFFSET_SHIFT   40
+#define VFIO_CCW_OFFSET_TO_INDEX(off)	(off >> VFIO_CCW_OFFSET_SHIFT)
+#define VFIO_CCW_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_CCW_OFFSET_SHIFT)
+#define VFIO_CCW_OFFSET_MASK	(((u64)(1) << VFIO_CCW_OFFSET_SHIFT) - 1)
+
+/* capability chain handling similar to vfio-pci */
+struct vfio_ccw_private;
+struct vfio_ccw_region;
+
+struct vfio_ccw_regops {
+	ssize_t	(*read)(struct vfio_ccw_private *private, char __user *buf,
+			size_t count, loff_t *ppos);
+	ssize_t	(*write)(struct vfio_ccw_private *private,
+			 const char __user *buf, size_t count, loff_t *ppos);
+	void	(*release)(struct vfio_ccw_private *private,
+			   struct vfio_ccw_region *region);
+};
+
+struct vfio_ccw_region {
+	u32				type;
+	u32				subtype;
+	const struct vfio_ccw_regops	*ops;
+	void				*data;
+	size_t				size;
+	u32				flags;
+};
+
+int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
+				 unsigned int subtype,
+				 const struct vfio_ccw_regops *ops,
+				 size_t size, u32 flags, void *data);
+
 /**
  * struct vfio_ccw_private
  * @sch: pointer to the subchannel
@@ -29,6 +63,8 @@
  * @nb: notifier for vfio events
  * @io_region: MMIO region to input/output I/O arguments/results
  * @io_mutex: protect against concurrent update of I/O regions
+ * @region: additional regions for other subchannel operations
+ * @num_regions: number of additional regions
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
@@ -44,6 +80,8 @@ struct vfio_ccw_private {
 	struct notifier_block	nb;
 	struct ccw_io_region	*io_region;
 	struct mutex		io_mutex;
+	struct vfio_ccw_region *region;
+	int num_regions;
 
 	struct channel_program	cp;
 	struct irb		irb;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 02bb7ad6e986..56e2413d3e00 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -353,6 +353,8 @@ struct vfio_region_gfx_edid {
 #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
 };
 
+#define VFIO_REGION_TYPE_CCW			(2)
+
 /*
  * 10de vendor sub-type
  *
-- 
2.17.2
