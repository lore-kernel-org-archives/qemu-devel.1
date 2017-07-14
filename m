Received: from eggs.gnu.org ([2001:4830:134:3::10]:50880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVy2C-0003GG-TF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVy29-0003Ju-MZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43112
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVy29-0003Jj-HI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:41:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EAclP7015753
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:41:17 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpuk7swg8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:41:16 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 11:41:15 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:44 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-18-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 17/40] s390x/css: use SubchDev.orb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Instead of passing around a pointer to ORB let us simplify some
function signatures by using the previously introduced ORB saved at the
subchannel (SubchDev).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Message-Id: <20170711145441.33925-7-pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/css.c         | 30 +++++++++++++++---------------
 include/hw/s390x/css.h |  6 +++---
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 62db7f6..997815c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -909,7 +909,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     return ret;
 }
 
-static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
+static void sch_handle_start_func_virtual(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
@@ -923,10 +923,10 @@ static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
 
     if (!(s->ctrl & SCSW_ACTL_SUSP)) {
         /* Start Function triggered via ssch, i.e. we have an ORB */
+        ORB *orb = &sch->orb;
         s->cstat = 0;
         s->dstat = 0;
         /* Look at the orb and try to execute the channel program. */
-        assert(orb != NULL); /* resume does not pass an orb */
         p->intparm = orb->intparm;
         if (!(orb->lpm & path)) {
             /* Generate a deferred cc 3 condition. */
@@ -940,8 +940,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
         sch->ccw_no_data_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
-        /* Start Function resumed via rsch, i.e. we don't have an
-         * ORB */
+        /* Start Function resumed via rsch */
         s->ctrl &= ~(SCSW_ACTL_SUSP | SCSW_ACTL_RESUME_PEND);
         /* The channel program had been suspended before. */
         suspend_allowed = true;
@@ -1011,13 +1010,14 @@ static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
 
 }
 
-static int sch_handle_start_func_passthrough(SubchDev *sch, ORB *orb)
+static int sch_handle_start_func_passthrough(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
     SCSW *s = &sch->curr_status.scsw;
     int ret;
 
+    ORB *orb = &sch->orb;
     if (!(s->ctrl & SCSW_ACTL_SUSP)) {
         assert(orb != NULL);
         p->intparm = orb->intparm;
@@ -1062,7 +1062,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch, ORB *orb)
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-int do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
+int do_subchannel_work_virtual(SubchDev *sch)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -1073,7 +1073,7 @@ int do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
-        sch_handle_start_func_virtual(sch, orb);
+        sch_handle_start_func_virtual(sch);
     } else {
         /* Cannot happen. */
         return 0;
@@ -1082,7 +1082,7 @@ int do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
     return 0;
 }
 
-int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
+int do_subchannel_work_passthrough(SubchDev *sch)
 {
     int ret;
     SCSW *s = &sch->curr_status.scsw;
@@ -1096,7 +1096,7 @@ int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
         sch_handle_halt_func(sch);
         ret = 0;
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
-        ret = sch_handle_start_func_passthrough(sch, orb);
+        ret = sch_handle_start_func_passthrough(sch);
     } else {
         /* Cannot happen. */
         return -ENODEV;
@@ -1105,10 +1105,10 @@ int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
     return ret;
 }
 
-static int do_subchannel_work(SubchDev *sch, ORB *orb)
+static int do_subchannel_work(SubchDev *sch)
 {
     if (sch->do_subchannel_work) {
-        return sch->do_subchannel_work(sch, orb);
+        return sch->do_subchannel_work(sch);
     } else {
         return -EINVAL;
     }
@@ -1315,7 +1315,7 @@ int css_do_csch(SubchDev *sch)
     s->ctrl &= ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
     s->ctrl |= SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1356,7 +1356,7 @@ int css_do_hsch(SubchDev *sch)
     }
     s->ctrl |= SCSW_ACTL_HALT_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1431,7 +1431,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    ret = do_subchannel_work(sch, orb);
+    ret = do_subchannel_work(sch);
 
 out:
     return ret;
@@ -1710,7 +1710,7 @@ int css_do_rsch(SubchDev *sch)
     }
 
     s->ctrl |= SCSW_ACTL_RESUME_PEND;
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 71076cb..c9edd07 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -94,7 +94,7 @@ struct SubchDev {
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
-    int (*do_subchannel_work) (SubchDev *, ORB *);
+    int (*do_subchannel_work) (SubchDev *);
     SenseId id;
     void *driver_data;
 };
@@ -157,8 +157,8 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
-int do_subchannel_work_virtual(SubchDev *sub, ORB *orb);
-int do_subchannel_work_passthrough(SubchDev *sub, ORB *orb);
+int do_subchannel_work_virtual(SubchDev *sub);
+int do_subchannel_work_passthrough(SubchDev *sub);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
-- 
2.7.4
