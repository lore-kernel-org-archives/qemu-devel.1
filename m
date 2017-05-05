Received: from eggs.gnu.org ([2001:4830:134:3::10]:46610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d6Sbn-0002S4-8x
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d6Sbj-0004JR-7u
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d6Sbi-0004Iy-Vh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4523Zlf053619
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 22:04:33 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8dxgmu79-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 22:04:32 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 4 May 2017 22:04:31 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 04:03:50 +0200
In-Reply-To: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170505020352.8984-12-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 11/13] s390x/css: ccw translation
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

Implement a basic infrastructure of handling channel I/O instruction
interception for passed through subchannels:
1. Branch the code path of instruction interception handling by
   SubChannel type.
2. For a passed-through subchannel, issue the ORB to kernel to do ccw
   translation and perform an I/O operation.
3. Assign different condition code based on the I/O result, or
   trigger a program check.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 89 ++++++++++++++++++++++++++++++++++++++++++++++----
 hw/s390x/s390-ccw.c    | 12 +++++++
 hw/s390x/virtio-ccw.c  |  1 +
 include/hw/s390x/css.h |  4 +++
 target/s390x/ioinst.c  |  9 +++++
 5 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 507c60f..4524189 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -524,7 +524,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     return ret;
 }
 
-static void sch_handle_start_func(SubchDev *sch, ORB *orb)
+static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
@@ -623,13 +623,58 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
 
 }
 
+static int sch_handle_start_func_passthrough(SubchDev *sch, ORB *orb)
+{
+
+    PMCW *p = &sch->curr_status.pmcw;
+    SCSW *s = &sch->curr_status.scsw;
+    int ret;
+
+    if (!(s->ctrl & SCSW_ACTL_SUSP)) {
+        assert(orb != NULL);
+        p->intparm = orb->intparm;
+    }
+
+    /*
+     * Only support prefetch enable mode.
+     * Only support 64bit addressing idal.
+     */
+    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
+        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
+        return -EINVAL;
+    }
+
+    ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
+    switch (ret) {
+    /* Currently we don't update control block and just return the cc code. */
+    case 0:
+        break;
+    case -EBUSY:
+        break;
+    case -ENODEV:
+        break;
+    case -EACCES:
+        /* Let's reflect an inaccessible host device by cc 3. */
+        ret = -ENODEV;
+        break;
+    default:
+       /*
+        * All other return codes will trigger a program check,
+        * or set cc to 1.
+        */
+       break;
+    };
+
+    return ret;
+}
+
 /*
  * On real machines, this would run asynchronously to the main vcpus.
  * We might want to make some parts of the ssch handling (interpreting
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-static void do_subchannel_work(SubchDev *sch, ORB *orb)
+int do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -640,12 +685,45 @@ static void do_subchannel_work(SubchDev *sch, ORB *orb)
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
-        sch_handle_start_func(sch, orb);
+        sch_handle_start_func_virtual(sch, orb);
     } else {
         /* Cannot happen. */
-        return;
+        return 0;
     }
     css_inject_io_interrupt(sch);
+    return 0;
+}
+
+int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
+{
+    int ret;
+    SCSW *s = &sch->curr_status.scsw;
+
+    if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
+        /* TODO: Clear handling */
+        sch_handle_clear_func(sch);
+        ret = 0;
+    } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
+        /* TODO: Halt handling */
+        sch_handle_halt_func(sch);
+        ret = 0;
+    } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
+        ret = sch_handle_start_func_passthrough(sch, orb);
+    } else {
+        /* Cannot happen. */
+        return -ENODEV;
+    }
+
+    return ret;
+}
+
+static int do_subchannel_work(SubchDev *sch, ORB *orb)
+{
+    if (sch->do_subchannel_work) {
+        return sch->do_subchannel_work(sch, orb);
+    } else {
+        return -EINVAL;
+    }
 }
 
 static void copy_pmcw_to_guest(PMCW *dest, const PMCW *src)
@@ -964,8 +1042,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    do_subchannel_work(sch, orb);
-    ret = 0;
+    ret = do_subchannel_work(sch, orb);
 
 out:
     return ret;
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index b1aadcd..7681912 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -18,6 +18,17 @@
 #include "hw/s390x/css-bridge.h"
 #include "s390-ccw.h"
 
+int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data)
+{
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(data);
+
+    if (cdc->handle_request) {
+        return cdc->handle_request(orb, scsw, data);
+    } else {
+        return -ENOSYS;
+    }
+}
+
 static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
                                   char *sysfsdev,
                                   Error **errp)
@@ -69,6 +80,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
         goto out_mdevid_free;
     }
     sch->driver_data = cdev;
+    sch->do_subchannel_work = do_subchannel_work_passthrough;
 
     ccw_dev->sch = sch;
     ret = css_sch_build_schib(sch, &cdev->hostid);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 4e386e9..e6a6f74 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -701,6 +701,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     sch->disable_cb = virtio_sch_disable_cb;
     sch->id.reserved = 0xff;
     sch->id.cu_type = VIRTIO_CCW_CU_TYPE;
+    sch->do_subchannel_work = do_subchannel_work_virtual;
     ccw_dev->sch = sch;
     dev->indicators = NULL;
     dev->revision = -1;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index c8c283a..ae687c5 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -90,6 +90,7 @@ struct SubchDev {
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
+    int (*do_subchannel_work) (SubchDev *, ORB *);
     SenseId id;
     void *driver_data;
 };
@@ -146,6 +147,9 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 void css_adapter_interrupt(uint8_t isc);
+int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
+int do_subchannel_work_virtual(SubchDev *sub, ORB *orb);
+int do_subchannel_work_passthrough(SubchDev *sub, ORB *orb);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 590bfa4..62a7771 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -244,6 +244,15 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     case -EBUSY:
         cc = 2;
         break;
+    case -EFAULT:
+        /*
+         * TODO:
+         * I'm wondering whether there is something better
+         * to do for us here (like setting some device or
+         * subchannel status).
+         */
+        program_interrupt(env, PGM_ADDRESSING, 4);
+        return;
     case 0:
         cc = 0;
         break;
-- 
2.10.2
