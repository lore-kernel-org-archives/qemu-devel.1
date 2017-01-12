Received: from eggs.gnu.org ([2001:4830:134:3::10]:35527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgV-00038J-MM
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZgQ-0003FT-QQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38621
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZgQ-0003FM-KA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:20:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7J6cW120284
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:26 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27x3at3kw3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:20:25 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:20:24 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:19:39 +0100
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112071947.98071-8-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 07/15] vfio: ccw: introduce ccw_io_region
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

To provide user-space a set of interfaces to:
1. pass in a ccw program to perform an I/O operation.
2. read back I/O results of the completed I/O operations.
We introduce an MMIO region for the vfio-ccw device here.

This region is defined to content:
1. areas to store arguments that an ssch required.
2. areas to store the I/O results.

Using pwrite/pread to the device on this region, a user-space program
could write/read data to/from the vfio-ccw device.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 arch/s390/include/uapi/asm/Kbuild     |  1 +
 arch/s390/include/uapi/asm/vfio_ccw.h | 28 +++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c       | 47 +++++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h   |  4 +++
 4 files changed, 80 insertions(+)
 create mode 100644 arch/s390/include/uapi/asm/vfio_ccw.h

diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index bf736e7..fdb9529 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -52,3 +52,4 @@ header-y += unistd.h
 header-y += virtio-ccw.h
 header-y += vtoc.h
 header-y += zcrypt.h
+header-y += vfio_ccw.h
diff --git a/arch/s390/include/uapi/asm/vfio_ccw.h b/arch/s390/include/uapi/asm/vfio_ccw.h
new file mode 100644
index 0000000..4ee74ae
--- /dev/null
+++ b/arch/s390/include/uapi/asm/vfio_ccw.h
@@ -0,0 +1,28 @@
+/*
+ * Interfaces for vfio-ccw
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ */
+
+#ifndef _VFIO_CCW_H_
+#define _VFIO_CCW_H_
+
+#include <linux/types.h>
+
+struct ccw_io_region {
+#define ORB_AREA_SIZE 12
+	__u8	orb_area[ORB_AREA_SIZE];
+#define SCSW_AREA_SIZE 12
+	__u8	scsw_area[SCSW_AREA_SIZE];
+#define IRB_AREA_SIZE 96
+	__u8	irb_area[IRB_AREA_SIZE];
+	__u32	ret_code;
+} __packed;
+
+#endif
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 6031a10..d68a296 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -129,6 +129,51 @@ void vfio_ccw_mdev_release(struct mdev_device *mdev)
 	vfio_unregister_notifier(&mdev->dev, VFIO_IOMMU_NOTIFY, &private->nb);
 }
 
+static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
+				  char __user *buf,
+				  size_t count,
+				  loff_t *ppos)
+{
+	struct vfio_ccw_private *private;
+	struct ccw_io_region *region;
+
+	if (*ppos + count > sizeof(*region))
+		return -EINVAL;
+
+	private = dev_get_drvdata(mdev->dev.parent);
+	if (!private)
+		return -ENODEV;
+
+	region = &private->io_region;
+	if (copy_to_user(buf, (void *)region + *ppos, count))
+		return -EFAULT;
+
+	return count;
+}
+
+static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
+				   const char __user *buf,
+				   size_t count,
+				   loff_t *ppos)
+{
+	struct vfio_ccw_private *private;
+	struct ccw_io_region *region;
+
+	if (*ppos + count > sizeof(*region))
+		return -EINVAL;
+
+	private = dev_get_drvdata(mdev->dev.parent);
+	if (!private)
+		return -ENODEV;
+
+	region = &private->io_region;
+	if (copy_from_user((void *)region + *ppos, buf, count))
+		return -EFAULT;
+	region->ret_code = 0;
+
+	return count;
+}
+
 static const struct parent_ops vfio_ccw_mdev_ops = {
 	.owner			= THIS_MODULE,
 	.supported_type_groups  = mdev_type_groups,
@@ -136,6 +181,8 @@ static const struct parent_ops vfio_ccw_mdev_ops = {
 	.remove			= vfio_ccw_mdev_remove,
 	.open			= vfio_ccw_mdev_open,
 	.release		= vfio_ccw_mdev_release,
+	.read			= vfio_ccw_mdev_read,
+	.write			= vfio_ccw_mdev_write,
 };
 
 int vfio_ccw_mdev_reg(struct subchannel *sch)
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 4cd6657..99265a9 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -14,6 +14,8 @@
 #ifndef _VFIO_CCW_PRIVATE_H_
 #define _VFIO_CCW_PRIVATE_H_
 
+#include <asm/vfio_ccw.h>
+
 #include "css.h"
 
 /**
@@ -22,12 +24,14 @@
  * @completion: synchronization helper of the I/O completion
  * @mdev: pointor to the mediated device
  * @nb: notifier for vfio events
+ * @io_region: MMIO region to input/output I/O arguments/results
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
 	struct completion	*completion;
 	struct mdev_device	*mdev;
 	struct notifier_block	nb;
+	struct ccw_io_region	io_region;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
-- 
2.8.4
