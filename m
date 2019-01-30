Received: from eggs.gnu.org ([209.51.188.92]:36489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goppN-00018L-7b
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goppJ-00062P-Iz
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:53 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Jan 2019 14:22:12 +0100
Message-Id: <20190130132212.7376-7-cohuck@redhat.com>
In-Reply-To: <20190130132212.7376-1-cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/6] vfio-ccw: add handling for async
 channel instructions
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

Add a region to the vfio-ccw device that can be used to submit
asynchronous I/O instructions. ssch continues to be handled by the
existing I/O region; the new region handles hsch and csch.

Interrupt status continues to be reported through the same channels
as for ssch.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/Makefile           |   3 +-
 drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_drv.c     |  46 ++++++++---
 drivers/s390/cio/vfio_ccw_fsm.c     | 119 +++++++++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
 drivers/s390/cio/vfio_ccw_private.h |   5 ++
 include/uapi/linux/vfio.h           |   2 +
 include/uapi/linux/vfio_ccw.h       |  12 +++
 8 files changed, 270 insertions(+), 18 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_async.c

diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index f230516abb96..f6a8db04177c 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -20,5 +20,6 @@ obj-$(CONFIG_CCWGROUP) += ccwgroup.o
 qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
 
-vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o
+vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o \
+	vfio_ccw_async.o
 obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
new file mode 100644
index 000000000000..8c1d2357ef5b
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Async I/O region for vfio_ccw
+ *
+ * Copyright Red Hat, Inc. 2019
+ *
+ * Author(s): Cornelia Huck <cohuck@redhat.com>
+ */
+
+#include <linux/vfio.h>
+#include <linux/mdev.h>
+
+#include "vfio_ccw_private.h"
+
+static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
+					  char __user *buf, size_t count,
+					  loff_t *ppos)
+{
+	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
+	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
+	struct ccw_cmd_region *region;
+	int ret;
+
+	if (pos + count > sizeof(*region))
+		return -EINVAL;
+
+	mutex_lock(&private->io_mutex);
+	region = private->region[i].data;
+	if (copy_to_user(buf, (void *)region + pos, count))
+		ret = -EFAULT;
+	else
+		ret = count;
+	mutex_unlock(&private->io_mutex);
+	return ret;
+}
+
+static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
+					   const char __user *buf, size_t count,
+					   loff_t *ppos)
+{
+	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
+	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
+	struct ccw_cmd_region *region;
+	int ret;
+
+	if (pos + count > sizeof(*region))
+		return -EINVAL;
+
+	if (!mutex_trylock(&private->io_mutex))
+		return -EAGAIN;
+
+	region = private->region[i].data;
+	if (copy_from_user((void *)region + pos, buf, count)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_ASYNC_REQ);
+
+	ret = region->ret_code ? region->ret_code : count;
+
+out_unlock:
+	mutex_unlock(&private->io_mutex);
+	return ret;
+}
+
+static void vfio_ccw_async_region_release(struct vfio_ccw_private *private,
+					  struct vfio_ccw_region *region)
+{
+
+}
+
+const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
+	.read = vfio_ccw_async_region_read,
+	.write = vfio_ccw_async_region_write,
+	.release = vfio_ccw_async_region_release,
+};
+
+int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private)
+{
+	return vfio_ccw_register_dev_region(private,
+					    VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD,
+					    &vfio_ccw_async_region_ops,
+					    sizeof(struct ccw_cmd_region),
+					    VFIO_REGION_INFO_FLAG_READ |
+					    VFIO_REGION_INFO_FLAG_WRITE,
+					    private->cmd_region);
+}
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 5ea0da1dd954..c39d01943a6a 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -3,9 +3,11 @@
  * VFIO based Physical Subchannel device driver
  *
  * Copyright IBM Corp. 2017
+ * Copyright Red Hat, Inc. 2019
  *
  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Cornelia Huck <cohuck@redhat.com>
  */
 
 #include <linux/module.h>
@@ -23,6 +25,7 @@
 
 struct workqueue_struct *vfio_ccw_work_q;
 static struct kmem_cache *vfio_ccw_io_region;
+static struct kmem_cache *vfio_ccw_cmd_region;
 
 /*
  * Helpers
@@ -110,7 +113,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 {
 	struct pmcw *pmcw = &sch->schib.pmcw;
 	struct vfio_ccw_private *private;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (pmcw->qf) {
 		dev_warn(&sch->dev, "vfio: ccw: does not support QDIO: %s\n",
@@ -124,10 +127,13 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 
 	private->io_region = kmem_cache_zalloc(vfio_ccw_io_region,
 					       GFP_KERNEL | GFP_DMA);
-	if (!private->io_region) {
-		kfree(private);
-		return -ENOMEM;
-	}
+	if (!private->io_region)
+		goto out_free;
+
+	private->cmd_region = kmem_cache_zalloc(vfio_ccw_cmd_region,
+						GFP_KERNEL | GFP_DMA);
+	if (!private->cmd_region)
+		goto out_free;
 
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
@@ -155,7 +161,10 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
-	kmem_cache_free(vfio_ccw_io_region, private->io_region);
+	if (private->cmd_region)
+		kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
+	if (private->io_region)
+		kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private);
 	return ret;
 }
@@ -170,6 +179,7 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	dev_set_drvdata(&sch->dev, NULL);
 
+	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
 	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private);
 
@@ -244,7 +254,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 
 static int __init vfio_ccw_sch_init(void)
 {
-	int ret;
+	int ret = -ENOMEM;
 
 	vfio_ccw_work_q = create_singlethread_workqueue("vfio-ccw");
 	if (!vfio_ccw_work_q)
@@ -254,20 +264,30 @@ static int __init vfio_ccw_sch_init(void)
 					sizeof(struct ccw_io_region), 0,
 					SLAB_ACCOUNT, 0,
 					sizeof(struct ccw_io_region), NULL);
-	if (!vfio_ccw_io_region) {
-		destroy_workqueue(vfio_ccw_work_q);
-		return -ENOMEM;
-	}
+	if (!vfio_ccw_io_region)
+		goto out_err;
+
+	vfio_ccw_cmd_region = kmem_cache_create_usercopy("vfio_ccw_cmd_region",
+					sizeof(struct ccw_cmd_region), 0,
+					SLAB_ACCOUNT, 0,
+					sizeof(struct ccw_cmd_region), NULL);
+	if (!vfio_ccw_cmd_region)
+		goto out_err;
 
 	isc_register(VFIO_CCW_ISC);
 	ret = css_driver_register(&vfio_ccw_sch_driver);
 	if (ret) {
 		isc_unregister(VFIO_CCW_ISC);
-		kmem_cache_destroy(vfio_ccw_io_region);
-		destroy_workqueue(vfio_ccw_work_q);
+		goto out_err;
 	}
 
 	return ret;
+
+out_err:
+	kmem_cache_destroy(vfio_ccw_cmd_region);
+	kmem_cache_destroy(vfio_ccw_io_region);
+	destroy_workqueue(vfio_ccw_work_q);
+	return ret;
 }
 
 static void __exit vfio_ccw_sch_exit(void)
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index b4a141fbd1a8..49d9d3da0282 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -3,8 +3,10 @@
  * Finite state machine for vfio-ccw device handling
  *
  * Copyright IBM Corp. 2017
+ * Copyright Red Hat, Inc. 2019
  *
  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Cornelia Huck <cohuck@redhat.com>
  */
 
 #include <linux/vfio.h>
@@ -73,6 +75,75 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	return ret;
 }
 
+static int fsm_do_halt(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch;
+	unsigned long flags;
+	int ccode;
+	int ret;
+
+	sch = private->sch;
+
+	spin_lock_irqsave(sch->lock, flags);
+
+	/* Issue "Halt Subchannel" */
+	ccode = hsch(sch->schid);
+
+	switch (ccode) {
+	case 0:
+		/*
+		 * Initialize device status information
+		 */
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
+		ret = 0;
+		break;
+	case 1:		/* Status pending */
+	case 2:		/* Busy */
+		ret = -EBUSY;
+		break;
+	case 3:		/* Device not operational */
+		ret = -ENODEV;
+		break;
+	default:
+		ret = ccode;
+	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	return ret;
+}
+
+static int fsm_do_clear(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch;
+	unsigned long flags;
+	int ccode;
+	int ret;
+
+	sch = private->sch;
+
+	spin_lock_irqsave(sch->lock, flags);
+
+	/* Issue "Clear Subchannel" */
+	ccode = csch(sch->schid);
+
+	switch (ccode) {
+	case 0:
+		/*
+		 * Initialize device status information
+		 */
+		sch->schib.scsw.cmd.actl = SCSW_ACTL_CLEAR_PEND;
+		/* TODO: check what else we might need to clear */
+		ret = 0;
+		break;
+	case 3:		/* Device not operational */
+		ret = -ENODEV;
+		break;
+	default:
+		ret = ccode;
+	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	return ret;
+}
+
 static void fsm_notoper(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
@@ -113,6 +184,24 @@ static void fsm_io_retry(struct vfio_ccw_private *private,
 	private->io_region->ret_code = -EAGAIN;
 }
 
+static void fsm_async_error(struct vfio_ccw_private *private,
+			    enum vfio_ccw_event event)
+{
+	struct ccw_cmd_region *cmd_region = private->cmd_region;
+
+	pr_err("vfio-ccw: FSM: %s request from state:%d\n",
+	       cmd_region->command == VFIO_CCW_ASYNC_CMD_HSCH ? "halt" :
+	       cmd_region->command == VFIO_CCW_ASYNC_CMD_CSCH ? "clear" :
+	       "<unknown>", private->state);
+	cmd_region->ret_code = -EIO;
+}
+
+static void fsm_async_retry(struct vfio_ccw_private *private,
+			    enum vfio_ccw_event event)
+{
+	private->cmd_region->ret_code = -EAGAIN;
+}
+
 static void fsm_disabled_irq(struct vfio_ccw_private *private,
 			     enum vfio_ccw_event event)
 {
@@ -176,11 +265,11 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 		}
 		return;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
-		/* XXX: Handle halt. */
+		/* halt is handled via the async cmd region */
 		io_region->ret_code = -EOPNOTSUPP;
 		goto err_out;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
-		/* XXX: Handle clear. */
+		/* clear is handled via the async cmd region */
 		io_region->ret_code = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -190,6 +279,27 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 			       io_region->ret_code, errstr);
 }
 
+/*
+ * Deal with an async request from userspace.
+ */
+static void fsm_async_request(struct vfio_ccw_private *private,
+			      enum vfio_ccw_event event)
+{
+	struct ccw_cmd_region *cmd_region = private->cmd_region;
+
+	switch (cmd_region->command) {
+	case VFIO_CCW_ASYNC_CMD_HSCH:
+		cmd_region->ret_code = fsm_do_halt(private);
+		break;
+	case VFIO_CCW_ASYNC_CMD_CSCH:
+		cmd_region->ret_code = fsm_do_clear(private);
+		break;
+	default:
+		/* should not happen? */
+		cmd_region->ret_code = -EINVAL;
+	}
+}
+
 /*
  * Got an interrupt for a normal io (state busy).
  */
@@ -213,26 +323,31 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	[VFIO_CCW_STATE_NOT_OPER] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
+		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
+		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
+		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 	},
 	[VFIO_CCW_STATE_CP_PROCESSING] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_retry,
+		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_retry,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 	},
 	[VFIO_CCW_STATE_CP_PENDING] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
+		[VFIO_CCW_EVENT_ASYNC_REQ]	= fsm_async_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 	},
 };
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 48b2d7930ea8..2c7bdbd9e402 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -148,11 +148,20 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	int ret;
 
 	private->nb.notifier_call = vfio_ccw_mdev_notifier;
 
-	return vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
-				      &events, &private->nb);
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &private->nb);
+	if (ret)
+		return ret;
+
+	ret = vfio_ccw_register_async_dev_regions(private);
+	if (ret)
+		vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+					 &private->nb);
+	return ret;
 }
 
 static void vfio_ccw_mdev_release(struct mdev_device *mdev)
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index c979eb32fb1c..bdcb05dcaf29 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -53,6 +53,8 @@ int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
 				 const struct vfio_ccw_regops *ops,
 				 size_t size, u32 flags, void *data);
 
+int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private);
+
 /**
  * struct vfio_ccw_private
  * @sch: pointer to the subchannel
@@ -64,6 +66,7 @@ int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
  * @io_region: MMIO region to input/output I/O arguments/results
  * @io_mutex: protect against concurrent update of I/O regions
  * @region: additional regions for other subchannel operations
+ * @cmd_region: MMIO region for asynchronous I/O commands other than START
  * @num_regions: number of additional regions
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
@@ -81,6 +84,7 @@ struct vfio_ccw_private {
 	struct ccw_io_region	*io_region;
 	struct mutex		io_mutex;
 	struct vfio_ccw_region *region;
+	struct ccw_cmd_region	*cmd_region;
 	int num_regions;
 
 	struct channel_program	cp;
@@ -116,6 +120,7 @@ enum vfio_ccw_event {
 	VFIO_CCW_EVENT_NOT_OPER,
 	VFIO_CCW_EVENT_IO_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
+	VFIO_CCW_EVENT_ASYNC_REQ,
 	/* last element! */
 	NR_VFIO_CCW_EVENTS
 };
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 56e2413d3e00..8f10748dac79 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -354,6 +354,8 @@ struct vfio_region_gfx_edid {
 };
 
 #define VFIO_REGION_TYPE_CCW			(2)
+/* ccw sub-types */
+#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
 
 /*
  * 10de vendor sub-type
diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.h
index 2ec5f367ff78..cbecbf0cd54f 100644
--- a/include/uapi/linux/vfio_ccw.h
+++ b/include/uapi/linux/vfio_ccw.h
@@ -12,6 +12,7 @@
 
 #include <linux/types.h>
 
+/* used for START SUBCHANNEL, always present */
 struct ccw_io_region {
 #define ORB_AREA_SIZE 12
 	__u8	orb_area[ORB_AREA_SIZE];
@@ -22,4 +23,15 @@ struct ccw_io_region {
 	__u32	ret_code;
 } __packed;
 
+/*
+ * used for processing commands that trigger asynchronous actions
+ * Note: this is controlled by a capability
+ */
+#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
+#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
+struct ccw_cmd_region {
+	__u32 command;
+	__u32 ret_code;
+} __packed;
+
 #endif
-- 
2.17.2
