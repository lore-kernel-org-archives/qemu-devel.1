Received: from eggs.gnu.org ([2001:4830:134:3::10]:45510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8g-00019R-3U
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8d-0005Ma-3P
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54850
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8c-0005MN-Tk
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXlfi099553
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:30 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a8wru8dn9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:29 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:27 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:35:07 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-11-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/10] s390x/css: use SubchDev.orb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Instead of passing around a pointer to ORB let us simplify some
functions signatures by using the previously introduced ORB saved at the
subchannel (SubchDev).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b58832a..694365b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -838,7 +838,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     return ret;
 }
 
-static void sch_handle_start_func(SubchDev *sch, ORB *orb)
+static void sch_handle_start_func(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
@@ -852,10 +852,10 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
 
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
@@ -869,8 +869,7 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
         sch->ccw_no_data_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
-        /* Start Function resumed via rsch, i.e. we don't have an
-         * ORB */
+        /* Start Function resumed via rsch */
         s->ctrl &= ~(SCSW_ACTL_SUSP | SCSW_ACTL_RESUME_PEND);
         /* The channel program had been suspended before. */
         suspend_allowed = true;
@@ -943,7 +942,7 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-static void do_subchannel_work(SubchDev *sch, ORB *orb)
+static void do_subchannel_work(SubchDev *sch)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -954,7 +953,7 @@ static void do_subchannel_work(SubchDev *sch, ORB *orb)
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
-        sch_handle_start_func(sch, orb);
+        sch_handle_start_func(sch);
     } else {
         /* Cannot happen. */
         return;
@@ -1163,7 +1162,7 @@ int css_do_csch(SubchDev *sch)
     s->ctrl &= ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
     s->ctrl |= SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1204,7 +1203,7 @@ int css_do_hsch(SubchDev *sch)
     }
     s->ctrl |= SCSW_ACTL_HALT_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1279,7 +1278,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    do_subchannel_work(sch, orb);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1559,7 +1558,7 @@ int css_do_rsch(SubchDev *sch)
     }
 
     s->ctrl |= SCSW_ACTL_RESUME_PEND;
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
-- 
2.10.2
