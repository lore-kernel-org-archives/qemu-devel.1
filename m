Received: from eggs.gnu.org ([2001:4830:134:3::10]:40461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds7iD-0008W3-3U
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds7i9-0006MC-Rz
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:28:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45222
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds7i9-0006Ls-Le
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:28:13 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DDO5Bj097576
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:28:13 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cy3ddqbtr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:28:12 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 14:28:10 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 15:27:52 +0200
In-Reply-To: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170913132752.8484-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2 NOT QEMU] a tester device for ccw I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Let's introduce a device driver for doing ccw I/O tests. The initial
focus is on indirect data access.

The driver is impemented as an out-of-tree Linux kernel module. A module
parameter cu_type is used for matching ccw devices. The parameter
defaults to 0x3831 which is the default cu_type for the qemu
counterpart of this (a fully emulated ccw device just for test).

The current status of the module is means to an end where the end
is testing my IDA implementation.

Usage:

You load the module.  The driver is supposed to auto detect and auto
online the device and provide sysfs atributes for the tests available.
Tests are triggered by writing to the attributes. Reoprting is done via
printk in almost TAP format (could use improvement if more ambitious).
We run one test at a time and do that async to the write. If you try to
start more in parallel you will get -EBUSY.

Currently all you can do something like:
* echo 1 > /sys/bus/ccw/devices/<devno>/w_fib
  To test good old ccw.
* echo 1 > /sys/bus/ccw/devices/<devno>/w_fib_idal
  To test IDA ccw.

These tests are designed to wrok together with the qemu device mentioned
before. The basic idea is that a device is expecting a stream of words
such that the sequence words interpreted as uint32_t is a Fibonacci
sequence (that is for n > 2 a_{n} = a_{n-1} + a{n-2}).

Using his simple scheme one can check that the right bytes are
transferred (with reasonable confidence). If the device detects an
element violating the Fibonacci property the driver expects the device
posts a device exception indicating that element.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

Do not try to apply this to a QEMU tree. Use an empty repo.

---
 .gitignore   |   8 ++
 Makefile     |  10 ++
 ccw_tester.c | 420 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 438 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 Makefile
 create mode 100644 ccw_tester.c

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..1b9eac9
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,8 @@
+#ignore these
+*.o
+*.cmd
+*.ko
+*.mod.c
+Module.symvers
+modules.order
+.tmp_versions/
diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..0583456
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,10 @@
+ifneq ($(KERNELRELEASE),)
+obj-m  := ccw_tester.o
+else
+# normal makefile
+KDIR ?= /lib/modules/`uname -r`/build
+
+default:
+	$(MAKE) -C $(KDIR) M=$$PWD
+
+endif
diff --git a/ccw_tester.c b/ccw_tester.c
new file mode 100644
index 0000000..320486a
--- /dev/null
+++ b/ccw_tester.c
@@ -0,0 +1,420 @@
+#include <linux/kernel_stat.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pfn.h>
+#include <linux/async.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/io.h>
+#include <linux/kvm_para.h>
+#include <linux/notifier.h>
+#include <asm/diag.h>
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/cio.h>
+#include <asm/ccwdev.h>
+#include <asm/isc.h>
+#include <asm/airq.h>
+#include <asm/idals.h>
+
+inline bool _ccw_test_assert(bool expr, const char *loc, int ln,
+			     const char *expl)
+{
+	if (expr)
+		printk(KERN_NOTICE "ok -- %s:%d\n", loc, ln);
+	else
+		printk(KERN_WARNING "not ok  -- %s:%d (%s)\n", loc, ln, expl);
+	return expr;
+}
+
+
+#define ccw_test_assert(_expr, _expl) ({_ccw_test_assert((_expr), \
+			__func__,  __LINE__, (_expl)); })
+
+struct workqueue_struct *work_q;
+
+static __u16 cu_type = 0x3831;
+module_param(cu_type, ushort, 0000);
+MODULE_PARM_DESC(cu_type, "Use this cu type for matching (default 0x3831)");
+
+
+static struct ccw_device_id ccw_tester_ids[] = {
+	{ CCW_DEVICE(0, 0) }, /* placeholder */
+	{},
+};
+
+struct ccw_test_work {
+	struct work_struct work;
+	struct ccw1 *ccw;
+	__u32  intparm;
+	void *private;
+	void (*setup)(struct ccw_test_work *w);
+	void (*do_test)(struct ccw_test_work *w);
+	void (*teardown)(struct ccw_test_work *w);
+	struct irb irb;
+	int ret;
+	bool doing_io;
+};
+
+struct ccw_tester_device {
+	spinlock_t lock;
+	wait_queue_head_t wait_q;
+	struct ccw_device *cdev;
+	struct ccw_test_work work;
+	bool work_pending;
+};
+
+static struct ccw_tester_device *to_mydev(struct ccw_device *cdev)
+{
+	return dev_get_drvdata(&(cdev->dev));
+}
+
+
+static void ccw_tester_auto_online(void *data, async_cookie_t cookie)
+{
+	struct ccw_device *cdev = data;
+	int ret;
+
+	ret = ccw_device_set_online(cdev);
+	if (ret)
+		dev_warn(&cdev->dev, "Failed to set online: %d\n", ret);
+}
+
+static void do_io_work(struct ccw_tester_device *tdev)
+{
+	struct ccw_test_work *w = &tdev->work;
+	unsigned long flags;
+	int retry = 124;
+
+	do {
+		spin_lock_irqsave(get_ccwdev_lock(tdev->cdev), flags);
+		tdev->work.doing_io = true;
+		w->ret = ccw_device_start(tdev->cdev, w->ccw, w->intparm, 0, 0);
+		spin_unlock_irqrestore(get_ccwdev_lock(tdev->cdev), flags);
+		cpu_relax();
+	} while (w->ret == -EBUSY && --retry > 0);
+	wait_event(tdev->wait_q, w->doing_io == false);
+}
+
+
+static void w_fib_w_setup(struct ccw_test_work *w)
+{
+	const int test_fib_length = 32;
+	u32 *test_fib;
+	int i;
+
+	test_fib = kcalloc(test_fib_length, sizeof(u32),
+				       GFP_DMA | GFP_KERNEL);
+	if (!test_fib)
+		w->ret = -ENOMEM;
+	w->private = test_fib;
+
+	test_fib[0] = 1;
+	test_fib[1] = 2;
+	for (i = 2; i < test_fib_length; ++i)
+		test_fib[i] = test_fib[i - 1] + test_fib[i - 2];
+
+	w->ccw->cmd_code = 0x02;
+	w->ccw->count = sizeof(*test_fib) * test_fib_length;
+	w->ccw->cda = (__u32)(unsigned long) test_fib;
+}
+
+static void do_test_do_io(struct ccw_test_work *w)
+{
+	struct ccw_tester_device *tdev;
+
+	tdev = container_of(w, struct ccw_tester_device, work);
+	do_io_work(tdev);
+}
+
+static void basic_teardown(struct ccw_test_work *w)
+{
+	kfree(w->private);
+	w->private = NULL;
+	if (w->ret)
+		printk(KERN_WARNING "w_fib_w_teardown ret = %d\n", w->ret);
+}
+
+static int irb_is_error(struct irb *irb)
+{
+	if (scsw_cstat(&irb->scsw) != 0)
+		return 1;
+	if (scsw_dstat(&irb->scsw) & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END))
+		return 1;
+	if (scsw_cc(&irb->scsw) != 0)
+		return 1;
+	return 0;
+}
+
+static void ccw_tester_int_handler(struct ccw_device *cdev,
+				   unsigned long intparm,
+				   struct irb *irb)
+{
+	struct ccw_tester_device *tdev = to_mydev(cdev);
+
+	memcpy(&tdev->work.irb, irb, sizeof(*irb));
+	tdev->work.doing_io = false;
+	wake_up(&tdev->wait_q);
+}
+
+static bool expect_is_not_fib(struct irb *irb, int count_expected)
+{
+	if (!(irb_is_error(irb)
+		&& (scsw_dstat(&irb->scsw) & DEV_STAT_UNIT_EXCEP)
+		&& scsw_stctl(&irb->scsw) & SCSW_STCTL_ALERT_STATUS))
+		return false;
+	if (irb->scsw.cmd.count == count_expected)
+		return true;
+	printk(KERN_NOTICE
+		"expected residual count of %d got %d (fib at wrong place)\n",
+		count_expected, irb->scsw.cmd.count);
+	return false;
+}
+
+
+static void w_fib_do_test(struct ccw_test_work *w)
+{
+	u32 *test_fib = w->private;
+
+	do_test_do_io(w);
+	ccw_test_assert(!irb_is_error(&w->irb), "completion expected");
+	test_fib[25] = 0;
+	do_test_do_io(w);
+	ccw_test_assert(expect_is_not_fib(&w->irb,
+		(31-25)*sizeof(u32)), "expected non fib");
+}
+
+
+static int queue_ccw_test_work(struct ccw_tester_device *tdev,
+		void (*setup)(struct ccw_test_work *),
+		void (*do_test)(struct ccw_test_work *),
+		void (*teardown)(struct ccw_test_work *))
+{
+	if (!spin_trylock(&tdev->lock))
+		return -EBUSY;
+	if (tdev->work_pending) {
+		spin_unlock(&tdev->lock);
+		return -EBUSY;
+	}
+	tdev->work_pending = true;
+	tdev->work.setup = setup;
+	tdev->work.do_test = do_test;
+	tdev->work.teardown = teardown;
+	queue_work(work_q, &tdev->work.work);
+	spin_unlock(&tdev->lock);
+	return 0;
+}
+
+
+static ssize_t w_fib_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct ccw_tester_device *tdev = to_mydev(to_ccwdev(dev));
+	int ret;
+
+	ret = queue_ccw_test_work(tdev,
+		w_fib_w_setup, w_fib_do_test, basic_teardown);
+	return ret ? ret : count;
+}
+
+static u32 *u32_arr_in_idal_buf_at(struct idal_buffer const *ib, int i)
+{
+	u64 b = IDA_BLOCK_SIZE/sizeof(u32);
+
+	return  (u32 *)(ib->data[i/b]) + i % b;
+}
+
+#define IDAL_TEST_BYTES  (IDA_BLOCK_SIZE * 3 + IDA_BLOCK_SIZE/2)
+#define IDAL_TEST_ELEMENTS  (IDAL_TEST_BYTES/sizeof(u32))
+
+static void w_fib_idal_setup(struct ccw_test_work *w)
+{
+	struct idal_buffer *ib = NULL;
+	u32 n, n_1 = 2, n_2 = 1;
+	int i = 0;
+
+	ib = idal_buffer_alloc(IDAL_TEST_BYTES, 0);
+	if (IS_ERR(ib)) {
+		w->ret = PTR_ERR(ib);
+		return;
+	}
+	w->private = ib;
+	*u32_arr_in_idal_buf_at(ib, 0) = n_2;
+	*u32_arr_in_idal_buf_at(ib, 1) = n_1;
+	for (i = 2; i < IDAL_TEST_ELEMENTS; ++i) {
+		n = n_1 + n_2;
+		n_2 = n_1;
+		n_1 = n;
+		*u32_arr_in_idal_buf_at(ib, i) = n;
+	}
+	idal_buffer_set_cda(ib, w->ccw);
+	w->ccw->count = IDAL_TEST_BYTES;
+	w->ccw->cmd_code = 0x02;
+}
+
+static void idal_teardown(struct ccw_test_work *w)
+{
+	if (w->private) {
+		idal_buffer_free(w->private);
+		w->private = NULL;
+	}
+	if (w->ret)
+		printk(KERN_WARNING "w_fib_w_teardown ret = %d\n", w->ret);
+}
+
+static void w_fib_do_idal_test(struct ccw_test_work *w)
+{
+	struct idal_buffer *ib = w->private;
+
+	/* we have one already set up, fire it */
+	do_test_do_io(w);
+	ccw_test_assert(!irb_is_error(&w->irb), "completion expected");
+
+	/* let's break fib and check if the device detects it */
+	++(*u32_arr_in_idal_buf_at(ib, IDAL_TEST_ELEMENTS - 5));
+	do_test_do_io(w);
+	ccw_test_assert(expect_is_not_fib(&w->irb,
+			4 * sizeof(u32)), "expected non fib");
+	/* shorten the seq so the broken element is not included */
+	w->ccw->count = IDAL_TEST_BYTES - 5 * sizeof(u32);
+	do_test_do_io(w);
+	ccw_test_assert(!irb_is_error(&w->irb), "completion expected");
+}
+
+static ssize_t w_fib_idal_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+	struct ccw_tester_device *tdev = to_mydev(to_ccwdev(dev));
+
+	ret = queue_ccw_test_work(tdev,
+			w_fib_idal_setup, w_fib_do_idal_test, idal_teardown);
+	return ret ? ret : count;
+}
+
+
+static DEVICE_ATTR_WO(w_fib);
+static DEVICE_ATTR_WO(w_fib_idal);
+
+static void do_ccw_test_work(struct work_struct *work)
+{
+
+	struct ccw_test_work *w;
+	struct ccw_tester_device *tdev;
+
+	w = container_of(work, struct ccw_test_work, work);
+	tdev = container_of(w, struct ccw_tester_device, work);
+
+	w->ret = 0;
+	w->setup(w);
+	w->do_test(w);
+	w->teardown(w);
+	spin_lock(&tdev->lock);
+	tdev->work_pending = false;
+	spin_unlock(&tdev->lock);
+	memset(w->ccw, 0, sizeof(*(w->ccw)));
+	memset(&w->irb, 0, sizeof(w->irb));
+}
+
+static int ccw_tester_offline(struct ccw_device *cdev)
+{
+	struct ccw_tester_device *tdev = to_mydev(cdev);
+
+	if (!tdev)
+		return 0;
+	device_remove_file(&(cdev->dev), &dev_attr_w_fib);
+	device_remove_file(&(cdev->dev), &dev_attr_w_fib_idal);
+	spin_lock(&tdev->lock);
+	tdev->work_pending = true;
+	spin_unlock(&tdev->lock);
+	kfree(tdev->work.ccw);
+	tdev->work.ccw = NULL;
+	kfree(tdev);
+	dev_set_drvdata(&cdev->dev, NULL);
+	return 0;
+}
+
+static int ccw_tester_online(struct ccw_device *cdev)
+{
+	int ret;
+	struct ccw_tester_device *tdev;
+
+	tdev = kzalloc(sizeof(*tdev), GFP_KERNEL);
+	if (!tdev) {
+		dev_warn(&cdev->dev, "Could not get memory\n");
+		return -ENOMEM;
+	}
+	init_waitqueue_head(&tdev->wait_q);
+	INIT_WORK(&(tdev->work.work), do_ccw_test_work);
+	spin_lock_init(&tdev->lock);
+	tdev->work.ccw = kzalloc(sizeof(*tdev->work.ccw), GFP_DMA | GFP_KERNEL);
+	if (!tdev) {
+		dev_warn(&cdev->dev, "Could not get memory\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	dev_set_drvdata(&cdev->dev, tdev);
+	tdev->cdev = cdev;
+
+	ret = device_create_file(&(cdev->dev), &dev_attr_w_fib);
+	if (ret)
+		goto out_free;
+	ret = device_create_file(&(cdev->dev), &dev_attr_w_fib_idal);
+	if (ret)
+		goto out_free;
+	return ret;
+out_free:
+	ccw_tester_offline(cdev);
+	return ret;
+}
+
+static void ccw_tester_remove(struct ccw_device *cdev)
+{
+	ccw_device_set_offline(cdev);
+}
+
+static int ccw_tester_probe(struct ccw_device *cdev)
+{
+	cdev->handler = ccw_tester_int_handler;
+	async_schedule(ccw_tester_auto_online, cdev);
+	return 0;
+}
+
+static struct ccw_driver ccw_tester_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "ccw_tester",
+	},
+	.ids = ccw_tester_ids,
+	.probe = ccw_tester_probe,
+	.set_online = ccw_tester_online,
+	.set_offline = ccw_tester_offline,
+	.remove = ccw_tester_remove,
+	.int_class = IRQIO_VIR,
+};
+
+
+static int __init ccw_tester_init(void)
+{
+	work_q = create_singlethread_workqueue("ccw-tester");
+	ccw_tester_ids[0].cu_type = cu_type;
+	return ccw_driver_register(&ccw_tester_driver);
+}
+module_init(ccw_tester_init);
+
+static void __exit ccw_tester_exit(void)
+{
+	ccw_driver_unregister(&ccw_tester_driver);
+}
+module_exit(ccw_tester_exit);
+
+MODULE_DESCRIPTION("ccw test driver -- throw ccws at devices");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Halil Pasic <pasic@linux.vnet.ibm.com>");
-- 
2.13.5
