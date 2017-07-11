Received: from eggs.gnu.org ([2001:4830:134:3::10]:48156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwZ1-00009j-PT
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwZ0-000562-LR
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43021
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dUwZ0-00055r-Eo
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BEsuBS068276
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:57 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bn0mvrksh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:57 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 15:54:55 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:54:41 +0200
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170711145441.33925-7-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 6/6] s390x/css: use SubchDev.orb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Instead of passing around a pointer to ORB let us simplify some
function signatures by using the previously introduced ORB saved at the
subchannel (SubchDev).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c         | 30 +++++++++++++++---------------
 include/hw/s390x/css.h |  6 +++---
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b89b60751a..abc77f7d4c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -865,7 +865,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     return ret;
 }
 
-static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
+static void sch_handle_start_func_virtual(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
@@ -879,10 +879,10 @@ static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
 
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
@@ -896,8 +896,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
         sch->ccw_no_data_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
-        /* Start Function resumed via rsch, i.e. we don't have an
-         * ORB */
+        /* Start Function resumed via rsch */
         s->ctrl &= ~(SCSW_ACTL_SUSP | SCSW_ACTL_RESUME_PEND);
         /* The channel program had been suspended before. */
         suspend_allowed = true;
@@ -967,13 +966,14 @@ static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
 
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
@@ -1018,7 +1018,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch, ORB *orb)
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-int do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
+int do_subchannel_work_virtual(SubchDev *sch)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -1029,7 +1029,7 @@ int do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
-        sch_handle_start_func_virtual(sch, orb);
+        sch_handle_start_func_virtual(sch);
     } else {
         /* Cannot happen. */
         return 0;
@@ -1038,7 +1038,7 @@ int do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
     return 0;
 }
 
-int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
+int do_subchannel_work_passthrough(SubchDev *sch)
 {
     int ret;
     SCSW *s = &sch->curr_status.scsw;
@@ -1052,7 +1052,7 @@ int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
         sch_handle_halt_func(sch);
         ret = 0;
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
-        ret = sch_handle_start_func_passthrough(sch, orb);
+        ret = sch_handle_start_func_passthrough(sch);
     } else {
         /* Cannot happen. */
         return -ENODEV;
@@ -1061,10 +1061,10 @@ int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
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
@@ -1271,7 +1271,7 @@ int css_do_csch(SubchDev *sch)
     s->ctrl &= ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
     s->ctrl |= SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1312,7 +1312,7 @@ int css_do_hsch(SubchDev *sch)
     }
     s->ctrl |= SCSW_ACTL_HALT_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1387,7 +1387,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    ret = do_subchannel_work(sch, orb);
+    ret = do_subchannel_work(sch);
 
 out:
     return ret;
@@ -1666,7 +1666,7 @@ int css_do_rsch(SubchDev *sch)
     }
 
     s->ctrl |= SCSW_ACTL_RESUME_PEND;
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 949e0f0a28..165ca2f4e9 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -93,7 +93,7 @@ struct SubchDev {
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
-    int (*do_subchannel_work) (SubchDev *, ORB *);
+    int (*do_subchannel_work) (SubchDev *);
     SenseId id;
     void *driver_data;
 };
@@ -157,8 +157,8 @@ void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 void css_adapter_interrupt(uint8_t isc);
 int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
-int do_subchannel_work_virtual(SubchDev *sub, ORB *orb);
-int do_subchannel_work_passthrough(SubchDev *sub, ORB *orb);
+int do_subchannel_work_virtual(SubchDev *sub);
+int do_subchannel_work_passthrough(SubchDev *sub);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
-- 
2.11.2
