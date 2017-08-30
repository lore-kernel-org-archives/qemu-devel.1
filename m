Received: from eggs.gnu.org ([2001:4830:134:3::10]:50197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5ym-0007I1-51
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yl-0006KT-20
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59972
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5yk-0006K7-Rp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGTAGC111723
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:34 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cnx1vp5qh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:34 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:32 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:08 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-9-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 8/9] s390x: refactor error handling for MSCH
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Simplify the error handling of the MSCH handler avoiding arbitrary and
cryptic error codes being mapped to what a subchannel is supposed to do.
Let the code detecting the condition tell how it's to be handled in a
less ambiguous way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 20 +++++++-------------
 include/hw/s390x/css.h |  2 +-
 target/s390x/ioinst.c  | 27 +++++++++------------------
 3 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index eff1b91a8c..931a097d6a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1182,28 +1182,27 @@ static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
     }
 }
 
-int css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
+void css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
     uint16_t oldflags;
-    int ret;
     SCHIB schib;
 
     if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_DNV)) {
-        ret = 0;
-        goto out;
+        sch->iret.cc = 0;
+        return;
     }
 
     if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
-        ret = -EINPROGRESS;
-        goto out;
+        sch->iret.cc = 1;
+        return;
     }
 
     if (s->ctrl &
         (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC)) {
-        ret = -EBUSY;
-        goto out;
+        sch->iret.cc = 2;
+        return;
     }
 
     copy_schib_from_guest(&schib, orig_schib);
@@ -1230,11 +1229,6 @@ int css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
         && (p->flags & PMCW_FLAGS_MASK_ENA) == 0) {
         sch->disable_cb(sch);
     }
-
-    ret = 0;
-
-out:
-    return ret;
 }
 
 void css_do_xsch(SubchDev *sch)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d8d949da4f..37ac36b014 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -203,7 +203,7 @@ bool css_subch_visible(SubchDev *sch);
 void css_conditional_io_interrupt(SubchDev *sch);
 int css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
-int css_do_msch(SubchDev *sch, const SCHIB *schib);
+void css_do_msch(SubchDev *sch, const SCHIB *schib);
 void css_do_xsch(SubchDev *sch);
 void css_do_csch(SubchDev *sch);
 void css_do_hsch(SubchDev *sch);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index e91788d586..a286495219 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -128,8 +128,6 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     SubchDev *sch;
     SCHIB schib;
     uint64_t addr;
-    int ret = -ENODEV;
-    int cc;
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
@@ -148,24 +146,17 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     }
     trace_ioinst_sch_id("msch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_msch(sch, &schib);
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
+        return;
     }
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
+    css_subch_clear_iret(sch);
+    css_do_msch(sch, &schib);
+    if (sch->iret.pgm_chk) {
+        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, sch->iret.cc);
 }
 
 static void copy_orb_from_guest(ORB *dest, const ORB *src)
-- 
2.13.5
