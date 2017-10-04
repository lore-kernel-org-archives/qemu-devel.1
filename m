Received: from eggs.gnu.org ([2001:4830:134:3::10]:37149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzloD-00027h-4A
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzlo7-0003Le-Hd
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53558
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzlo7-0003Kt-CG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:41:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94FdbTB139038
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:41:53 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dd0qef8vg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:41:52 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:41:51 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 17:41:37 +0200
In-Reply-To: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171004154144.88995-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/8] s390x/css: be more consistent if broken
 beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Calling do_subchannel_work with no function control flags set in SCSW is
a programming error. Currently the handle this differently in
do_subchannel_work_virtual and do_subchannel_work_passthrough. Let's be
consistent and guard with a common assert against this programming error.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c59be1aad1..4f47dbc8b0 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1067,9 +1067,6 @@ int do_subchannel_work_virtual(SubchDev *sch)
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
         sch_handle_start_func_virtual(sch);
-    } else {
-        /* Cannot happen. */
-        return 0;
     }
     css_inject_io_interrupt(sch);
     return 0;
@@ -1077,22 +1074,17 @@ int do_subchannel_work_virtual(SubchDev *sch)
 
 int do_subchannel_work_passthrough(SubchDev *sch)
 {
-    int ret;
+    int ret = 0;
     SCSW *s = &sch->curr_status.scsw;
 
     if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
         /* TODO: Clear handling */
         sch_handle_clear_func(sch);
-        ret = 0;
     } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
         /* TODO: Halt handling */
         sch_handle_halt_func(sch);
-        ret = 0;
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         ret = sch_handle_start_func_passthrough(sch);
-    } else {
-        /* Cannot happen. */
-        return -ENODEV;
     }
 
     return ret;
@@ -1100,11 +1092,11 @@ int do_subchannel_work_passthrough(SubchDev *sch)
 
 static int do_subchannel_work(SubchDev *sch)
 {
-    if (sch->do_subchannel_work) {
-        return sch->do_subchannel_work(sch);
-    } else {
+    if (!sch->do_subchannel_work) {
         return -EINVAL;
     }
+    g_assert(sch->curr_status.scsw.ctrl & SCSW_CTRL_MASK_FCTL);
+    return sch->do_subchannel_work(sch);
 }
 
 static void copy_pmcw_to_guest(PMCW *dest, const PMCW *src)
-- 
2.13.5
