Received: from eggs.gnu.org ([2001:4830:134:3::10]:45046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cedvd-0004Cz-Ly
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cedvY-0001Dz-N8
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:30:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cedvY-0001Dd-Cy
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:30:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1H8TH5W139512
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:30:03 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28nrgkj5r0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:30:03 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 17 Feb 2017 01:30:02 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 09:29:30 +0100
In-Reply-To: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170217082939.33208-7-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v3 06/15] vfio: ccw: register vfio_ccw to
 the mediated device framework
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

To make vfio support subchannel devices, we need to leverage the
mediated device framework to create a mediated device for the
subchannel device.

This registers the subchannel device to the mediated device
framework during probe to enable mediated device creation.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 arch/s390/Kconfig                   |   2 +-
 drivers/s390/cio/Makefile           |   2 +-
 drivers/s390/cio/vfio_ccw_drv.c     |  12 ++-
 drivers/s390/cio/vfio_ccw_ops.c     | 147 ++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  11 +++
 5 files changed, 171 insertions(+), 3 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_ops.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b920df8..32008b8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -673,7 +673,7 @@ config EADM_SCH
 config VFIO_CCW
 	def_tristate n
 	prompt "Support for VFIO-CCW subchannels"
-	depends on S390_CCW_IOMMU && VFIO
+	depends on S390_CCW_IOMMU && VFIO_MDEV
 	help
 	  This driver allows usage of VFIO-CCW subchannels.
 
diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index 1bec279..b0586b2 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -18,5 +18,5 @@ obj-$(CONFIG_CCWGROUP) += ccwgroup.o
 qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
 
-vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o
+vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o
 obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index b068207..80d20e3 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -19,7 +19,7 @@
 /*
  * Helpers
  */
-static int vfio_ccw_sch_quiesce(struct subchannel *sch)
+int vfio_ccw_sch_quiesce(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	DECLARE_COMPLETION_ONSTACK(completion);
@@ -152,8 +152,16 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_disable;
 
+	ret = vfio_ccw_mdev_reg(sch);
+	if (ret)
+		goto out_rm_group;
+
+	atomic_set(&private->avail, 1);
+
 	return 0;
 
+out_rm_group:
+	sysfs_remove_group(&sch->dev.kobj, &vfio_subchannel_attr_group);
 out_disable:
 	cio_disable_subchannel(sch);
 out_free:
@@ -168,6 +176,8 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	vfio_ccw_sch_quiesce(sch);
 
+	vfio_ccw_mdev_unreg(sch);
+
 	sysfs_remove_group(&sch->dev.kobj, &vfio_subchannel_attr_group);
 
 	dev_set_drvdata(&sch->dev, NULL);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
new file mode 100644
index 0000000..b8a2fed
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -0,0 +1,147 @@
+/*
+ * Physical device callbacks for vfio_ccw
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#include <linux/vfio.h>
+#include <linux/mdev.h>
+
+#include "vfio_ccw_private.h"
+
+static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
+				  unsigned long action,
+				  void *data)
+{
+	struct vfio_ccw_private *private =
+		container_of(nb, struct vfio_ccw_private, nb);
+
+	if (!private)
+		return NOTIFY_STOP;
+
+	/*
+	 * TODO:
+	 * Vendor drivers MUST unpin pages in response to an
+	 * invalidation.
+	 */
+	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP)
+		return NOTIFY_BAD;
+
+	return NOTIFY_DONE;
+}
+
+static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	return sprintf(buf, "I/O subchannel (Non-QDIO)\n");
+}
+MDEV_TYPE_ATTR_RO(name);
+
+static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
+			       char *buf)
+{
+	return sprintf(buf, "%s\n", VFIO_DEVICE_API_CCW_STRING);
+}
+MDEV_TYPE_ATTR_RO(device_api);
+
+static ssize_t available_instances_show(struct kobject *kobj,
+					struct device *dev, char *buf)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", atomic_read(&private->avail));
+}
+MDEV_TYPE_ATTR_RO(available_instances);
+
+static struct attribute *mdev_types_attrs[] = {
+	&mdev_type_attr_name.attr,
+	&mdev_type_attr_device_api.attr,
+	&mdev_type_attr_available_instances.attr,
+	NULL,
+};
+
+static struct attribute_group mdev_type_group = {
+	.name  = "io",
+	.attrs = mdev_types_attrs,
+};
+
+struct attribute_group *mdev_type_groups[] = {
+	&mdev_type_group,
+	NULL,
+};
+
+static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
+{
+	struct vfio_ccw_private *private =
+		dev_get_drvdata(mdev_parent_dev(mdev));
+
+	if (atomic_dec_if_positive(&private->avail) < 0)
+		return -EPERM;
+
+	private->mdev = mdev;
+
+	return 0;
+}
+
+static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
+{
+	struct vfio_ccw_private *private;
+	struct subchannel *sch;
+	int ret;
+
+	private = dev_get_drvdata(mdev_parent_dev(mdev));
+	sch = private->sch;
+	ret = vfio_ccw_sch_quiesce(sch);
+	if (ret)
+		return ret;
+	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+	if (ret)
+		return ret;
+
+	private->mdev = NULL;
+	atomic_inc(&private->avail);
+
+	return 0;
+}
+
+static int vfio_ccw_mdev_open(struct mdev_device *mdev)
+{
+	struct vfio_ccw_private *private =
+		dev_get_drvdata(mdev_parent_dev(mdev));
+	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+
+	private->nb.notifier_call = vfio_ccw_mdev_notifier;
+
+	return vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				      &events, &private->nb);
+}
+
+void vfio_ccw_mdev_release(struct mdev_device *mdev)
+{
+	struct vfio_ccw_private *private =
+		dev_get_drvdata(mdev_parent_dev(mdev));
+
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &private->nb);
+}
+
+static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
+	.owner			= THIS_MODULE,
+	.supported_type_groups  = mdev_type_groups,
+	.create			= vfio_ccw_mdev_create,
+	.remove			= vfio_ccw_mdev_remove,
+	.open			= vfio_ccw_mdev_open,
+	.release		= vfio_ccw_mdev_release,
+};
+
+int vfio_ccw_mdev_reg(struct subchannel *sch)
+{
+	return mdev_register_device(&sch->dev, &vfio_ccw_mdev_ops);
+}
+
+void vfio_ccw_mdev_unreg(struct subchannel *sch)
+{
+	mdev_unregister_device(&sch->dev);
+}
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 38d69a5..5afb3ba 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -16,10 +16,21 @@
  * struct vfio_ccw_private
  * @sch: pointer to the subchannel
  * @completion: synchronization helper of the I/O completion
+ * @avail: available for creating a mediated device
+ * @mdev: pointer to the mediated device
+ * @nb: notifier for vfio events
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
 	struct completion	*completion;
+	atomic_t		avail;
+	struct mdev_device	*mdev;
+	struct notifier_block	nb;
 } __aligned(8);
 
+extern int vfio_ccw_mdev_reg(struct subchannel *sch);
+extern void vfio_ccw_mdev_unreg(struct subchannel *sch);
+
+extern int vfio_ccw_sch_quiesce(struct subchannel *sch);
+
 #endif
-- 
2.8.4
