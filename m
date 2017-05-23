Received: from eggs.gnu.org ([2001:4830:134:3::10]:44018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7l0-0007ls-FS
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7kv-00031w-Va
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dD7kv-00031C-MX
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NB4JEx082661
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:36 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amcgatu10-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:36 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 23 May 2017 12:13:33 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 23 May 2017 13:13:03 +0200
In-Reply-To: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
References: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
Message-Id: <20170523111306.25493-19-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 18/21] s390x/css: ccw translation infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

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
Message-Id: <20170517004813.58227-12-bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c         | 89 ++++++++++++++++++++++++++++++++++++++++++++++----
 hw/s390x/s390-ccw.c    | 12 +++++++
 hw/s390x/virtio-ccw.c  |  1 +
 include/hw/s390x/css.h |  4 +++
 target/s390x/ioinst.c  |  9 +++++
 5 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 462a768f9e..1e2f26b65a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -524,7 +524,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     return ret;
 }
 
-static void sch_handle_start_func(SubchDev *sch, ORB *orb)
+static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
@@ -626,13 +626,58 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
 
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
@@ -643,12 +688,45 @@ static void do_subchannel_work(SubchDev *sch, ORB *orb)
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
@@ -967,8 +1045,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    do_subchannel_work(sch, orb);
-    ret = 0;
+    ret = do_subchannel_work(sch, orb);
 
 out:
     return ret;
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index e2b1973fda..8614dda6f8 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -18,6 +18,17 @@
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-ccw.h"
 
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
@@ -72,6 +83,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
         goto out_mdevid_free;
     }
     sch->driver_data = cdev;
+    sch->do_subchannel_work = do_subchannel_work_passthrough;
 
     ccw_dev->sch = sch;
     ret = css_sch_build_schib(sch, &cdev->hostid);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 4e386e9781..e6a6f74be3 100644
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
index a932f91edb..596a2f2ef3 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -91,6 +91,7 @@ struct SubchDev {
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
+    int (*do_subchannel_work) (SubchDev *, ORB *);
     SenseId id;
     void *driver_data;
 };
@@ -148,6 +149,9 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 void css_adapter_interrupt(uint8_t isc);
+int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
+int do_subchannel_work_virtual(SubchDev *sub, ORB *orb);
+int do_subchannel_work_passthrough(SubchDev *sub, ORB *orb);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 590bfa4f12..62a777100c 100644
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
2.13.0
