Received: from eggs.gnu.org ([2001:4830:134:3::10]:44596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTBK-00057O-OV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTBE-0003AC-O4
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eZTBE-00039J-3Q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0B34KFu040381
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:23 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fdxxqsmhx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:22 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 20:05:22 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 11 Jan 2018 04:04:59 +0100
In-Reply-To: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180111030459.33757-6-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 5/5] vfio/ccw: build schib with real schib
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

The current implementation grabs chpids and path masks from
sysfs to build the schib and chp for the virtual subchannels.

Since now vfio-ccw provides a schib region for store subchannel
information. Let's leverage it to get the chipids and the masks,
and serve the virtual subchannels.

While we are at it, touch one line of the comment around by
adding white space to make it aligned.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/css.c              | 83 ++++-----------------------------------------
 hw/s390x/s390-ccw.c         | 20 +++++++----
 hw/vfio/ccw.c               | 28 +++++++++------
 include/hw/s390x/s390-ccw.h |  3 +-
 4 files changed, 39 insertions(+), 95 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c1ec83f08f..b9bc489e55 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2417,72 +2417,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool squash_mcss, Error **errp)
     return sch;
 }
 
-static int css_sch_get_chpids(SubchDev *sch, CssDevId *dev_id)
-{
-    char *fid_path;
-    FILE *fd;
-    uint32_t chpid[8];
-    int i;
-    PMCW *p = &sch->curr_status.pmcw;
-
-    fid_path = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/chpids",
-                               dev_id->cssid, dev_id->ssid, dev_id->devid);
-    fd = fopen(fid_path, "r");
-    if (fd == NULL) {
-        error_report("%s: open %s failed", __func__, fid_path);
-        g_free(fid_path);
-        return -EINVAL;
-    }
-
-    if (fscanf(fd, "%x %x %x %x %x %x %x %x",
-        &chpid[0], &chpid[1], &chpid[2], &chpid[3],
-        &chpid[4], &chpid[5], &chpid[6], &chpid[7]) != 8) {
-        fclose(fd);
-        g_free(fid_path);
-        return -EINVAL;
-    }
-
-    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
-        p->chpid[i] = chpid[i];
-    }
-
-    fclose(fd);
-    g_free(fid_path);
-
-    return 0;
-}
-
-static int css_sch_get_path_masks(SubchDev *sch, CssDevId *dev_id)
-{
-    char *fid_path;
-    FILE *fd;
-    uint32_t pim, pam, pom;
-    PMCW *p = &sch->curr_status.pmcw;
-
-    fid_path = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/pimpampom",
-                               dev_id->cssid, dev_id->ssid, dev_id->devid);
-    fd = fopen(fid_path, "r");
-    if (fd == NULL) {
-        error_report("%s: open %s failed", __func__, fid_path);
-        g_free(fid_path);
-        return -EINVAL;
-    }
-
-    if (fscanf(fd, "%x %x %x", &pim, &pam, &pom) != 3) {
-        fclose(fd);
-        g_free(fid_path);
-        return -EINVAL;
-    }
-
-    p->pim = pim;
-    p->pam = pam;
-    p->pom = pom;
-    fclose(fd);
-    g_free(fid_path);
-
-    return 0;
-}
-
 static int css_sch_get_chpid_type(uint8_t chpid, uint32_t *type,
                                   CssDevId *dev_id)
 {
@@ -2529,19 +2463,14 @@ int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id)
     /* We are dealing with I/O subchannels only. */
     p->devno = sch->devno;
 
-    /* Grab path mask from sysfs. */
-    ret = css_sch_get_path_masks(sch, dev_id);
-    if (ret) {
-        return ret;
-    }
-
-    /* Grab chpids from sysfs. */
-    ret = css_sch_get_chpids(sch, dev_id);
-    if (ret) {
-        return ret;
+    /* Read schib from the physical device. */
+    /* g_assert(sch->update_schib != NULL) ? */
+    if (sch->update_schib &&
+        (sch->update_schib(sch) != IOINST_CC_EXPECTED)) {
+        return -ENODEV;
     }
 
-   /* Build chpid type. */
+    /* Build chpid type. */
     for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
         if (p->chpid[i] && !css->chpids[p->chpid[i]].in_use) {
             ret = css_sch_get_chpid_type(p->chpid[i], &type, dev_id);
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 491697137c..f658b87131 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -72,7 +72,18 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
     cdev->hostid.valid = true;
 }
 
-static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
+static void s390_ccw_pre_realize(S390CCWDevice *cdev, char *sysfsdev,
+                                 Error **errp)
+{
+    Error *err = NULL;
+
+    s390_ccw_get_dev_info(cdev, sysfsdev, &err);
+    if (err) {
+        error_propagate(errp, err);
+    }
+}
+
+static void s390_ccw_realize(S390CCWDevice *cdev, Error **errp)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(cdev);
     CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
@@ -83,11 +94,6 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     int ret;
     Error *err = NULL;
 
-    s390_ccw_get_dev_info(cdev, sysfsdev, &err);
-    if (err) {
-        goto out_err_propagate;
-    }
-
     sch = css_create_sch(ccw_dev->devno, cbus->squash_mcss, &err);
     if (!sch) {
         goto out_mdevid_free;
@@ -119,7 +125,6 @@ out_err:
     g_free(sch);
 out_mdevid_free:
     g_free(cdev->mdevid);
-out_err_propagate:
     error_propagate(errp, err);
 }
 
@@ -143,6 +148,7 @@ static void s390_ccw_class_init(ObjectClass *klass, void *data)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    cdc->pre_realize = s390_ccw_pre_realize;
     cdc->realize = s390_ccw_realize;
     cdc->unrealize = s390_ccw_unrealize;
 }
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 0eca3453af..549ef3f8ed 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -146,6 +146,8 @@ static IOInstEnding vfio_ccw_update_schib(SubchDev *sch)
         p->chpid[i] = schib->pmcw.chpid[i];
     }
 
+    /* TODO: add chpid? */
+
     return region->cc;
 }
 
@@ -454,9 +456,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     Error *err = NULL;
 
-    /* Call the class init function for subchannel. */
-    if (cdc->realize) {
-        cdc->realize(cdev, vcdev->vdev.sysfsdev, &err);
+    if (cdc->pre_realize) {
+        cdc->pre_realize(cdev, vcdev->vdev.sysfsdev, &err);
         if (err) {
             goto out_err_propagate;
         }
@@ -464,7 +465,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 
     group = vfio_ccw_get_group(cdev, &err);
     if (!group) {
-        goto out_group_err;
+        goto out_err_propagate;
     }
 
     vcdev->vdev.ops = &vfio_ccw_ops;
@@ -491,27 +492,34 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 
     vfio_ccw_register_event_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
     if (err) {
-        goto out_notifier_err;
+        goto out_io_notifier_err;
     }
     vfio_ccw_register_event_notifier(vcdev, VFIO_CCW_CHP_IRQ_INDEX, &err);
     if (err) {
-        goto out_notifier_err;
+        goto out_chp_notifier_err;
     }
 
     vcdev->schib_need_update = true;
+    /* Call the class init function for subchannel. */
+    if (cdc->realize) {
+        cdc->realize(cdev, &err);
+        if (err) {
+            goto out_notifier_err;
+        }
+    }
 
     return;
 
 out_notifier_err:
+    vfio_ccw_unregister_event_notifier(vcdev, VFIO_CCW_CHP_IRQ_INDEX);
+out_chp_notifier_err:
+    vfio_ccw_unregister_event_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
+out_io_notifier_err:
     vfio_ccw_put_region(vcdev);
 out_region_err:
     vfio_put_device(vcdev);
 out_device_err:
     vfio_put_group(group);
-out_group_err:
-    if (cdc->unrealize) {
-        cdc->unrealize(cdev, NULL);
-    }
 out_err_propagate:
     error_propagate(errp, err);
 }
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 96e6a00e3e..3bbf31dd00 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -31,7 +31,8 @@ typedef struct S390CCWDevice {
 
 typedef struct S390CCWDeviceClass {
     CCWDeviceClass parent_class;
-    void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
+    void (*pre_realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
+    void (*realize)(S390CCWDevice *dev, Error **errp);
     void (*unrealize)(S390CCWDevice *dev, Error **errp);
     IOInstEnding (*handle_request) (SubchDev *sch);
     IOInstEnding (*update_schib) (SubchDev *);
-- 
2.13.5
