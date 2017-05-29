Received: from eggs.gnu.org ([2001:4830:134:3::10]:33731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFL96-0008CG-8b
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFL92-0005EA-Bg
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33155
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dFL92-0005E1-60
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4TDrW8w115281
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 09:55:39 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2arghbb7am-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 09:55:39 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 29 May 2017 14:55:37 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 29 May 2017 15:55:20 +0200
In-Reply-To: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170529135520.101429-8-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 7/7] s390x/css: use SubchDev.orb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Instead of passing around a pointer to ORB let us simplify some
functions signatures by using the previously introduced ORB saved at the
subchannel (SubchDev).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 9857eb3d6f..0229cb9412 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -854,7 +854,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     return ret;
 }
 
-static void sch_handle_start_func(SubchDev *sch, ORB *orb)
+static void sch_handle_start_func(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
@@ -868,10 +868,10 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
 
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
@@ -885,8 +885,7 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
         sch->ccw_no_data_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
-        /* Start Function resumed via rsch, i.e. we don't have an
-         * ORB */
+        /* Start Function resumed via rsch */
         s->ctrl &= ~(SCSW_ACTL_SUSP | SCSW_ACTL_RESUME_PEND);
         /* The channel program had been suspended before. */
         suspend_allowed = true;
@@ -962,7 +961,7 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-static void do_subchannel_work(SubchDev *sch, ORB *orb)
+static void do_subchannel_work(SubchDev *sch)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -973,7 +972,7 @@ static void do_subchannel_work(SubchDev *sch, ORB *orb)
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
-        sch_handle_start_func(sch, orb);
+        sch_handle_start_func(sch);
     } else {
         /* Cannot happen. */
         return;
@@ -1182,7 +1181,7 @@ int css_do_csch(SubchDev *sch)
     s->ctrl &= ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
     s->ctrl |= SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1223,7 +1222,7 @@ int css_do_hsch(SubchDev *sch)
     }
     s->ctrl |= SCSW_ACTL_HALT_PEND;
 
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1298,7 +1297,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    do_subchannel_work(sch, orb);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
@@ -1578,7 +1577,7 @@ int css_do_rsch(SubchDev *sch)
     }
 
     s->ctrl |= SCSW_ACTL_RESUME_PEND;
-    do_subchannel_work(sch, NULL);
+    do_subchannel_work(sch);
     ret = 0;
 
 out:
-- 
2.11.2
