Received: from eggs.gnu.org ([2001:4830:134:3::10]:59595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vua-0003fb-KS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuZ-00042N-Kr
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:24 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:11 +0200
Message-Id: <20171020115418.2050-40-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 39/46] s390x: refactor error handling for XSCH
 handler
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

Simplify the error handling of the XSCH.  Let the code detecting the
condition tell (in a less ambiguous way) how it's to be handled. No
changes in behavior.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20171017140453.51099-5-pasic@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 17 +++++------------
 include/hw/s390x/css.h |  2 +-
 target/s390x/ioinst.c  | 23 ++++-------------------
 3 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c87c1aecc0..bee12a3e65 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1402,20 +1402,17 @@ out:
     return ret;
 }
 
-int css_do_xsch(SubchDev *sch)
+IOInstEnding css_do_xsch(SubchDev *sch)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        return IOINST_CC_NOT_OPERATIONAL;
     }
 
     if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
-        ret = -EINPROGRESS;
-        goto out;
+        return IOINST_CC_STATUS_PRESENT;
     }
 
     if (!(s->ctrl & SCSW_CTRL_MASK_FCTL) ||
@@ -1423,8 +1420,7 @@ int css_do_xsch(SubchDev *sch)
         (!(s->ctrl &
            (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
         (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
-        ret = -EBUSY;
-        goto out;
+        return IOINST_CC_BUSY;
     }
 
     /* Cancel the current operation. */
@@ -1436,10 +1432,7 @@ int css_do_xsch(SubchDev *sch)
     sch->last_cmd_valid = false;
     s->dstat = 0;
     s->cstat = 0;
-    ret = 0;
-
-out:
-    return ret;
+    return IOINST_CC_EXPECTED;
 }
 
 int css_do_csch(SubchDev *sch)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 666ce1174b..ff1501fc60 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -240,7 +240,7 @@ void css_conditional_io_interrupt(SubchDev *sch);
 int css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 int css_do_msch(SubchDev *sch, const SCHIB *schib);
-int css_do_xsch(SubchDev *sch);
+IOInstEnding css_do_xsch(SubchDev *sch);
 int css_do_csch(SubchDev *sch);
 int css_do_hsch(SubchDev *sch);
 IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 16b5cf2fed..4ad07e9181 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -42,8 +42,6 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -51,24 +49,11 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("xsch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_xsch(sch);
-    }
-    switch (ret) {
-    case -ENODEV:
-        cc = 3;
-        break;
-    case -EBUSY:
-        cc = 2;
-        break;
-    case 0:
-        cc = 0;
-        break;
-    default:
-        cc = 1;
-        break;
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, css_do_xsch(sch));
 }
 
 void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
-- 
2.13.6
