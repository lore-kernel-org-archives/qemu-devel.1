Received: from eggs.gnu.org ([2001:4830:134:3::10]:44535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTBG-00052F-BM
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTBC-00038k-MX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39810
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eZTBC-00038J-Fz
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:22 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0B34NTA023457
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:20 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fdx9ubctu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:20 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 20:05:19 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 11 Jan 2018 04:04:58 +0100
In-Reply-To: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180111030459.33757-5-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 4/5] vfio/ccw: update subchanel information
 block lazily
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

We want to sync up channel path related information between the
physical device and the virtual device. Thus here we read out
subchannel information block from the schib region, and update
the virtual sbuchannel information block.

Since the kernel side will signal userland once it has channel
path information update, we only do update if we were signaled.

We sets scsw.pno and pmcw.pnom to indicate path related event
for a guest. This is a bit lazy, but it works.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/css.c              | 14 +++++++++--
 hw/s390x/s390-ccw.c         | 12 +++++++++
 hw/vfio/ccw.c               | 59 ++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/s390x/css.h      |  3 ++-
 include/hw/s390x/s390-ccw.h |  1 +
 target/s390x/ioinst.c       |  3 +--
 6 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1c526fd7e2..c1ec83f08f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1297,11 +1297,16 @@ static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
     }
 }
 
-int css_do_stsch(SubchDev *sch, SCHIB *schib)
+IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib)
 {
+    if (sch->update_schib &&
+        (sch->update_schib(sch) != IOINST_CC_EXPECTED)) {
+        return IOINST_CC_NOT_OPERATIONAL;
+    }
+
     /* Use current status. */
     copy_schib_to_guest(schib, &sch->curr_status);
-    return 0;
+    return IOINST_CC_EXPECTED;
 }
 
 static void copy_pmcw_from_guest(PMCW *dest, const PMCW *src)
@@ -1586,6 +1591,11 @@ int css_do_tsch_get_irb(SubchDev *sch, IRB *target_irb, int *irb_len)
     uint16_t stctl;
     IRB irb;
 
+    if (sch->update_schib &&
+        (sch->update_schib(sch) != IOINST_CC_EXPECTED)) {
+        return IOINST_CC_NOT_OPERATIONAL;
+    }
+
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
         return 3;
     }
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 4a9d4d2534..491697137c 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -28,6 +28,17 @@ IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
     return cdc->handle_request(sch);
 }
 
+static IOInstEnding s390_ccw_update_schib(SubchDev *sch)
+{
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
+
+    if (!cdc->update_schib) {
+        /* g_assert_not_reached()? */
+        return IOINST_CC_NOT_OPERATIONAL;
+    }
+    return cdc->update_schib(sch);
+}
+
 static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
                                   char *sysfsdev,
                                   Error **errp)
@@ -83,6 +94,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     }
     sch->driver_data = cdev;
     sch->do_subchannel_work = do_subchannel_work_passthrough;
+    sch->update_schib = s390_ccw_update_schib;
 
     ccw_dev->sch = sch;
     ret = css_sch_build_schib(sch, &cdev->hostid);
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d812cecfe0..0eca3453af 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -33,6 +33,7 @@ typedef struct VFIOCCWDevice {
     struct ccw_io_region *io_region;
     EventNotifier io_notifier;
 
+    bool schib_need_update;
     uint64_t schib_region_size;
     uint64_t schib_region_offset;
     struct ccw_schib_region *schib_region;
@@ -97,6 +98,57 @@ again:
     }
 }
 
+static IOInstEnding vfio_ccw_update_schib(SubchDev *sch)
+{
+
+    S390CCWDevice *cdev = sch->driver_data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    struct ccw_schib_region *region = vcdev->schib_region;
+    PMCW *p = &sch->curr_status.pmcw;
+    SCSW *s = &sch->curr_status.scsw;
+    SCHIB *schib;
+    int size;
+    int i;
+
+    /*
+     * If there is no update that interested us since last read,
+     * we do not read then.
+     */
+    if (!vcdev->schib_need_update) {
+        return IOINST_CC_EXPECTED;
+    }
+    vcdev->schib_need_update = false;
+
+    /* Read schib region, and update schib for virtual subchannel. */
+    size = pread(vcdev->vdev.fd, region, vcdev->schib_region_size,
+                 vcdev->schib_region_offset);
+    if (size != vcdev->schib_region_size) {
+        return IOINST_CC_NOT_OPERATIONAL;
+    }
+    if (region->cc) {
+        g_assert(region->cc == IOINST_CC_NOT_OPERATIONAL);
+        return region->cc;
+    }
+
+    schib = (SCHIB *)region->schib_area;
+
+    /* Path mask. */
+    p->pim = schib->pmcw.pim;
+    p->pam = schib->pmcw.pam;
+    p->pom = schib->pmcw.pom;
+
+    /* We use PNO and PNOM to indicate path related events. */
+    p->pnom = ~schib->pmcw.pam;
+    s->flags |= SCSW_FLAGS_MASK_PNO;
+
+    /* Chp id. */
+    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
+        p->chpid[i] = schib->pmcw.chpid[i];
+    }
+
+    return region->cc;
+}
+
 static void vfio_ccw_reset(DeviceState *dev)
 {
     CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
@@ -182,7 +234,9 @@ static void vfio_ccw_chp_notifier_handler(void *opaque)
         return;
     }
 
-    /* TODO: further process on path informaion. */
+    vcdev->schib_need_update = true;
+
+    /* TODO: Generate channel path crw? */
 }
 
 static void vfio_ccw_register_event_notifier(VFIOCCWDevice *vcdev, int irq,
@@ -444,6 +498,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_notifier_err;
     }
 
+    vcdev->schib_need_update = true;
+
     return;
 
 out_notifier_err:
@@ -503,6 +559,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     dc->reset = vfio_ccw_reset;
 
     cdc->handle_request = vfio_ccw_handle_request;
+    cdc->update_schib = vfio_ccw_update_schib;
 }
 
 static const TypeInfo vfio_ccw_info = {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 35facb47d2..bcb433af4a 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -137,6 +137,7 @@ struct SubchDev {
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
     IOInstEnding (*do_subchannel_work) (SubchDev *);
+    IOInstEnding (*update_schib) (SubchDev *);
     SenseId id;
     void *driver_data;
 };
@@ -237,7 +238,7 @@ SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
 void css_conditional_io_interrupt(SubchDev *sch);
-int css_do_stsch(SubchDev *sch, SCHIB *schib);
+IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *schib);
 IOInstEnding css_do_xsch(SubchDev *sch);
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 7d15a1a5d4..96e6a00e3e 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -34,6 +34,7 @@ typedef struct S390CCWDeviceClass {
     void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
     void (*unrealize)(S390CCWDevice *dev, Error **errp);
     IOInstEnding (*handle_request) (SubchDev *sch);
+    IOInstEnding (*update_schib) (SubchDev *);
 } S390CCWDeviceClass;
 
 #endif
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 83c164a168..2c841bb66f 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -257,8 +257,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     sch = css_find_subch(m, cssid, ssid, schid);
     if (sch) {
         if (css_subch_visible(sch)) {
-            css_do_stsch(sch, &schib);
-            cc = 0;
+            cc = css_do_stsch(sch, &schib);
         } else {
             /* Indicate no more subchannels in this css/ss */
             cc = 3;
-- 
2.13.5
