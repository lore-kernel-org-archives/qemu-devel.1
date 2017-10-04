Received: from eggs.gnu.org ([2001:4830:134:3::10]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzloN-0002Fi-6p
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzloG-0003Zf-FX
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37632
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzloG-0003Yn-9s
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94Fe4lQ083355
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:42:00 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dcxvfp9ya-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:42:00 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:41:58 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 17:41:42 +0200
In-Reply-To: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171004154144.88995-7-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 6/8] s390x: refactor error handling for HSCH
 handler
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

Simplify the error handling of the HSCH.  Let the code detecting the
condition tell (in a less ambiguous way) how it's to be handled. No
changes in behavior.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 18 +++++-------------
 include/hw/s390x/css.h |  2 +-
 target/s390x/ioinst.c  | 23 ++++-------------------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1839f40408..6da3e4ea61 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1272,28 +1272,24 @@ IOInstEnding css_do_csch(SubchDev *sch)
     return do_subchannel_work(sch);
 }
 
-int css_do_hsch(SubchDev *sch)
+IOInstEnding css_do_hsch(SubchDev *sch)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        return (IOInstEnding){.cc = 3};
     }
 
     if (((s->ctrl & SCSW_CTRL_MASK_STCTL) == SCSW_STCTL_STATUS_PEND) ||
         (s->ctrl & (SCSW_STCTL_PRIMARY |
                     SCSW_STCTL_SECONDARY |
                     SCSW_STCTL_ALERT))) {
-        ret = -EINPROGRESS;
-        goto out;
+        return (IOInstEnding){.cc = 1};
     }
 
     if (s->ctrl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
-        ret = -EBUSY;
-        goto out;
+        return (IOInstEnding){.cc = 2};
     }
 
     /* Trigger the halt function. */
@@ -1306,11 +1302,7 @@ int css_do_hsch(SubchDev *sch)
     }
     s->ctrl |= SCSW_ACTL_HALT_PEND;
 
-    do_subchannel_work(sch);
-    ret = 0;
-
-out:
-    return ret;
+    return do_subchannel_work(sch);
 }
 
 static void css_update_chnmon(SubchDev *sch)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 6ca9999077..a4064711e2 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -214,7 +214,7 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 int css_do_msch(SubchDev *sch, const SCHIB *schib);
 IOInstEnding css_do_xsch(SubchDev *sch);
 IOInstEnding css_do_csch(SubchDev *sch);
-int css_do_hsch(SubchDev *sch);
+IOInstEnding css_do_hsch(SubchDev *sch);
 IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb);
 int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
 void css_do_tsch_update_subch(SubchDev *sch);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index b12b3d1d41..12102bab0f 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -78,8 +78,6 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -87,24 +85,11 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("hsch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_hsch(sch);
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
+    setcc(cpu, css_do_hsch(sch).cc);
 }
 
 static int ioinst_schib_valid(SCHIB *schib)
-- 
2.13.5
