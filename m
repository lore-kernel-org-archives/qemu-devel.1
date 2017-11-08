Received: from eggs.gnu.org ([2001:4830:134:3::10]:55294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCTd2-0003aY-C3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCTcx-0000VO-RJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:55:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eCTcx-0000V7-LH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:54:59 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8GqEth128504
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 11:54:52 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e448sxem7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 11:54:51 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 16:54:50 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 17:54:22 +0100
In-Reply-To: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171108165422.46267-4-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH NOT QEMU v2 3/3] ccw-tester: add tic test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Let's add a test verifying that the channel subsystlem responds to a
format 1 transfer in channel ccw with non-zero count properly -- with a
channel program check.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 ccw_tester.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/ccw_tester.c b/ccw_tester.c
index b8e632b..6253ae7 100644
--- a/ccw_tester.c
+++ b/ccw_tester.c
@@ -347,8 +347,73 @@ static ssize_t w_fib_idal_store(struct device *dev,
 	return ret ? ret : count;
 }
 
+static void tic_setup(struct ccw_test_work *w)
+{
+	struct ccw_tester_device *tdev;
+	struct subchannel_id schid;
+
+	tdev = container_of(w, struct ccw_tester_device, work);
+	ccw_device_get_schid(tdev->cdev, &schid);
+	w->ret = set_mode_diag(schid, OP_MODE_NOP);
+	if (w->ret) {
+		printk(KERN_WARNING "tic_setup ret = %d\n", w->ret);
+		w->ret = 0;
+		return;
+	}
+	w->private = kzalloc(sizeof(*w->ccw), GFP_DMA | GFP_KERNEL);
+
+	w->ccw->count = 0x0666; /* we are evil */
+	w->ccw->cmd_code = CCW_CMD_TIC;
+	/* hope this won't get used */
+	w->ccw->cda = (__u32)(unsigned long) w->private;
+}
+
+static void tic_teardown(struct ccw_test_work *w)
+{
+	if (w->private) {
+		idal_buffer_free(w->private);
+		w->private = NULL;
+	}
+	if (w->ret)
+		printk(KERN_WARNING "tic_teardown ret = %d\n", w->ret);
+}
+
+static bool expect_pgm_chk(struct irb *irb)
+{
+	if (irb_is_error(irb)
+		&& (scsw_cstat(&irb->scsw) & SCHN_STAT_PROG_CHECK)
+		&& scsw_stctl(&irb->scsw) & SCSW_STCTL_ALERT_STATUS)
+		return true;
+	printk(KERN_NOTICE
+		"expected program check but got none (is_error == %d)\n",
+		 irb_is_error(irb));
+	return false;
+}
+
+static void do_tic_test(struct ccw_test_work *w)
+{
+	/* we have one already set up, fire it */
+	do_test_do_io(w);
+	/* TODO: check for pgm-check */
+	ccw_test_assert(expect_pgm_chk(&w->irb),
+			"expected pgm check for tic with count != 0 fib");
+}
+
+static ssize_t w_tic_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+	struct ccw_tester_device *tdev = to_mydev(to_ccwdev(dev));
+
+	ret = queue_ccw_test_work(tdev,
+			tic_setup, do_tic_test, tic_teardown);
+	return ret ? ret : count;
+}
+
 static DEVICE_ATTR_WO(w_fib);
 static DEVICE_ATTR_WO(w_fib_idal);
+static DEVICE_ATTR_WO(w_tic);
 
 static void do_ccw_test_work(struct work_struct *work)
 {
@@ -378,6 +443,7 @@ static int ccw_tester_offline(struct ccw_device *cdev)
 		return 0;
 	device_remove_file(&(cdev->dev), &dev_attr_w_fib);
 	device_remove_file(&(cdev->dev), &dev_attr_w_fib_idal);
+	device_remove_file(&(cdev->dev), &dev_attr_w_tic);
 	spin_lock(&tdev->lock);
 	tdev->work_pending = true;
 	spin_unlock(&tdev->lock);
@@ -416,6 +482,9 @@ static int ccw_tester_online(struct ccw_device *cdev)
 	ret = device_create_file(&(cdev->dev), &dev_attr_w_fib_idal);
 	if (ret)
 		goto out_free;
+	ret = device_create_file(&(cdev->dev), &dev_attr_w_tic);
+	if (ret)
+		goto out_free;
 	return ret;
 out_free:
 	ccw_tester_offline(cdev);
-- 
2.13.5
