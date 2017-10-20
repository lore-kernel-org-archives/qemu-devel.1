Received: from eggs.gnu.org ([2001:4830:134:3::10]:58339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vss-000237-DO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vsr-0002kD-MC
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:38 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:34 +0200
Message-Id: <20171020115418.2050-3-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/46] s390x/css: be more consistent if broken
 beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Calling do_subchannel_work with no function control flags set in SCSW is
a programming error. Currently we handle this differently in
do_subchannel_work_virtual and do_subchannel_work_passthrough. Let's be
consistent and guard with a common assert against this programming error.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20171004154144.88995-2-pasic@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b6d4fcaf06..4f964b7691 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1245,9 +1245,6 @@ int do_subchannel_work_virtual(SubchDev *sch)
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         /* Triggered by both ssch and rsch. */
         sch_handle_start_func_virtual(sch);
-    } else {
-        /* Cannot happen. */
-        return 0;
     }
     css_inject_io_interrupt(sch);
     return 0;
@@ -1255,22 +1252,17 @@ int do_subchannel_work_virtual(SubchDev *sch)
 
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
@@ -1278,11 +1270,11 @@ int do_subchannel_work_passthrough(SubchDev *sch)
 
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
2.13.6
