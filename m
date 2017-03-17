Received: from eggs.gnu.org ([2001:4830:134:3::10]:56792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiPB-0006Py-8L
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiP3-0000K0-86
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1coiP3-0000Jm-18
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H3DvTl059171
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 297w4aa1fv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:08 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 16 Mar 2017 21:18:07 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 04:17:31 +0100
In-Reply-To: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170317031743.40128-5-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 04/16] vfio: ccw: basic implementation for
 vfio_ccw driver
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

To make vfio support subchannel devices, we need a css driver for
the vfio subchannels. This patch adds a basic vfio-ccw subchannel
driver for this purpose.

To enable VFIO for vfio-ccw, enable S390_CCW_IOMMU config option
and configure VFIO as required.

Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 arch/s390/Kconfig                   |  10 ++
 arch/s390/include/asm/isc.h         |   1 +
 drivers/iommu/Kconfig               |   8 ++
 drivers/s390/cio/Makefile           |   3 +
 drivers/s390/cio/vfio_ccw_drv.c     | 262 ++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  25 ++++
 6 files changed, 309 insertions(+)
 create mode 100644 drivers/s390/cio/vfio_ccw_drv.c
 create mode 100644 drivers/s390/cio/vfio_ccw_private.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a2dcef0..b53f0359 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -672,6 +672,16 @@ config EADM_SCH
 	  To compile this driver as a module, choose M here: the
 	  module will be called eadm_sch.
 
+config VFIO_CCW
+	def_tristate n
+	prompt "Support for VFIO-CCW subchannels"
+	depends on S390_CCW_IOMMU && VFIO
+	help
+	  This driver allows usage of I/O subchannels via VFIO-CCW.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vfio_ccw.
+
 endmenu
 
 menu "Dump support"
diff --git a/arch/s390/include/asm/isc.h b/arch/s390/include/asm/isc.h
index 68d7d68..8a0b721 100644
--- a/arch/s390/include/asm/isc.h
+++ b/arch/s390/include/asm/isc.h
@@ -16,6 +16,7 @@
 #define CONSOLE_ISC 1			/* console I/O subchannel */
 #define EADM_SCH_ISC 4			/* EADM subchannels */
 #define CHSC_SCH_ISC 7			/* CHSC subchannels */
+#define VFIO_CCW_ISC IO_SCH_ISC		/* VFIO-CCW I/O subchannels */
 /* Adapter interrupts. */
 #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
 #define PCI_ISC 2			/* PCI I/O subchannels */
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 37e204f..6ee3a25 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -327,6 +327,14 @@ config S390_IOMMU
 	help
 	  Support for the IOMMU API for s390 PCI devices.
 
+config S390_CCW_IOMMU
+	bool "S390 CCW IOMMU Support"
+	depends on S390 && CCW
+	select IOMMU_API
+	help
+	  Enables bits of IOMMU API required by VFIO. The iommu_ops
+	  is not implemented as it is not necessary for VFIO.
+
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
 	depends on ARM || ARM64
diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index 3ab9aed..3d7390e 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -17,3 +17,6 @@ obj-$(CONFIG_CCWGROUP) += ccwgroup.o
 
 qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
+
+vfio_ccw-objs += vfio_ccw_drv.o
+obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
new file mode 100644
index 0000000..de4f4f1
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -0,0 +1,262 @@
+/*
+ * VFIO based Physical Subchannel device driver
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#include <asm/isc.h>
+
+#include "vfio_ccw_private.h"
+
+/*
+ * Helpers
+ */
+static int vfio_ccw_sch_quiesce(struct subchannel *sch)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	DECLARE_COMPLETION_ONSTACK(completion);
+	int iretry, ret = 0;
+
+	spin_lock_irq(sch->lock);
+	if (!sch->schib.pmcw.ena)
+		goto out_unlock;
+	ret = cio_disable_subchannel(sch);
+	if (ret != -EBUSY)
+		goto out_unlock;
+
+	do {
+		iretry = 255;
+
+		ret = cio_cancel_halt_clear(sch, &iretry);
+		while (ret == -EBUSY) {
+			/*
+			 * Flush all I/O and wait for
+			 * cancel/halt/clear completion.
+			 */
+			private->completion = &completion;
+			spin_unlock_irq(sch->lock);
+
+			wait_for_completion_timeout(&completion, 3*HZ);
+
+			spin_lock_irq(sch->lock);
+			private->completion = NULL;
+			ret = cio_cancel_halt_clear(sch, &iretry);
+		};
+
+		ret = cio_disable_subchannel(sch);
+	} while (ret == -EBUSY);
+
+out_unlock:
+	spin_unlock_irq(sch->lock);
+	return ret;
+}
+
+/*
+ * Sysfs interfaces
+ */
+static ssize_t chpids_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct chsc_ssd_info *ssd = &sch->ssd_info;
+	ssize_t ret = 0;
+	int chp;
+	int mask;
+
+	for (chp = 0; chp < 8; chp++) {
+		mask = 0x80 >> chp;
+		if (ssd->path_mask & mask)
+			ret += sprintf(buf + ret, "%02x ", ssd->chpid[chp].id);
+		else
+			ret += sprintf(buf + ret, "00 ");
+	}
+	ret += sprintf(buf+ret, "\n");
+	return ret;
+}
+
+static ssize_t pimpampom_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct pmcw *pmcw = &sch->schib.pmcw;
+
+	return sprintf(buf, "%02x %02x %02x\n",
+		       pmcw->pim, pmcw->pam, pmcw->pom);
+}
+
+static DEVICE_ATTR(chpids, 0444, chpids_show, NULL);
+static DEVICE_ATTR(pimpampom, 0444, pimpampom_show, NULL);
+
+static struct attribute *vfio_subchannel_attrs[] = {
+	&dev_attr_chpids.attr,
+	&dev_attr_pimpampom.attr,
+	NULL,
+};
+
+static struct attribute_group vfio_subchannel_attr_group = {
+	.attrs = vfio_subchannel_attrs,
+};
+
+/*
+ * Css driver callbacks
+ */
+static void vfio_ccw_sch_irq(struct subchannel *sch)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+
+	inc_irq_stat(IRQIO_CIO);
+
+	if (!private)
+		return;
+
+	if (private->completion)
+		complete(private->completion);
+}
+
+static int vfio_ccw_sch_probe(struct subchannel *sch)
+{
+	struct pmcw *pmcw = &sch->schib.pmcw;
+	struct vfio_ccw_private *private;
+	int ret;
+
+	if (pmcw->qf) {
+		dev_warn(&sch->dev, "vfio: ccw: does not support QDIO: %s\n",
+			 dev_name(&sch->dev));
+		return -ENODEV;
+	}
+
+	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
+	if (!private)
+		return -ENOMEM;
+	private->sch = sch;
+	dev_set_drvdata(&sch->dev, private);
+
+	spin_lock_irq(sch->lock);
+	sch->isc = VFIO_CCW_ISC;
+	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+	spin_unlock_irq(sch->lock);
+	if (ret)
+		goto out_free;
+
+	ret = sysfs_create_group(&sch->dev.kobj, &vfio_subchannel_attr_group);
+	if (ret)
+		goto out_disable;
+
+	return 0;
+
+out_disable:
+	cio_disable_subchannel(sch);
+out_free:
+	dev_set_drvdata(&sch->dev, NULL);
+	kfree(private);
+	return ret;
+}
+
+static int vfio_ccw_sch_remove(struct subchannel *sch)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+
+	vfio_ccw_sch_quiesce(sch);
+
+	sysfs_remove_group(&sch->dev.kobj, &vfio_subchannel_attr_group);
+
+	dev_set_drvdata(&sch->dev, NULL);
+
+	kfree(private);
+
+	return 0;
+}
+
+static void vfio_ccw_sch_shutdown(struct subchannel *sch)
+{
+	vfio_ccw_sch_quiesce(sch);
+}
+
+/**
+ * vfio_ccw_sch_event - process subchannel event
+ * @sch: subchannel
+ * @process: non-zero if function is called in process context
+ *
+ * An unspecified event occurred for this subchannel. Adjust data according
+ * to the current operational state of the subchannel. Return zero when the
+ * event has been handled sufficiently or -EAGAIN when this function should
+ * be called again in process context.
+ */
+static int vfio_ccw_sch_event(struct subchannel *sch, int process)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(sch->lock, flags);
+	if (!device_is_registered(&sch->dev))
+		goto out_unlock;
+
+	if (work_pending(&sch->todo_work))
+		goto out_unlock;
+
+	if (cio_update_schib(sch)) {
+		/* Not operational. */
+		css_sched_sch_todo(sch, SCH_TODO_UNREG);
+
+		/*
+		 * TODO:
+		 * Probably we should send the machine check to the guest.
+		 */
+		goto out_unlock;
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(sch->lock, flags);
+
+	return 0;
+}
+
+static struct css_device_id vfio_ccw_sch_ids[] = {
+	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(css, vfio_ccw_sch_ids);
+
+static struct css_driver vfio_ccw_sch_driver = {
+	.drv = {
+		.name = "vfio_ccw",
+		.owner = THIS_MODULE,
+	},
+	.subchannel_type = vfio_ccw_sch_ids,
+	.irq = vfio_ccw_sch_irq,
+	.probe = vfio_ccw_sch_probe,
+	.remove = vfio_ccw_sch_remove,
+	.shutdown = vfio_ccw_sch_shutdown,
+	.sch_event = vfio_ccw_sch_event,
+};
+
+static int __init vfio_ccw_sch_init(void)
+{
+	int ret;
+
+	isc_register(VFIO_CCW_ISC);
+	ret = css_driver_register(&vfio_ccw_sch_driver);
+	if (ret)
+		isc_unregister(VFIO_CCW_ISC);
+
+	return ret;
+}
+
+static void __exit vfio_ccw_sch_exit(void)
+{
+	css_driver_unregister(&vfio_ccw_sch_driver);
+	isc_unregister(VFIO_CCW_ISC);
+}
+module_init(vfio_ccw_sch_init);
+module_exit(vfio_ccw_sch_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
new file mode 100644
index 0000000..38d69a5
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -0,0 +1,25 @@
+/*
+ * Private stuff for vfio_ccw driver
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#ifndef _VFIO_CCW_PRIVATE_H_
+#define _VFIO_CCW_PRIVATE_H_
+
+#include "css.h"
+
+/**
+ * struct vfio_ccw_private
+ * @sch: pointer to the subchannel
+ * @completion: synchronization helper of the I/O completion
+ */
+struct vfio_ccw_private {
+	struct subchannel	*sch;
+	struct completion	*completion;
+} __aligned(8);
+
+#endif
-- 
2.8.4
