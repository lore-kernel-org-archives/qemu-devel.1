Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzloC-00027U-TF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzlo8-0003MH-Aj
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzlo8-0003LR-2I
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94Ff3YY037750
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:41:59 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcyft4cac-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:41:58 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:41:56 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 17:41:41 +0200
In-Reply-To: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171004154144.88995-6-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 5/8] s390x: refactor error handling for CSCH
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

Simplify the error handling of the cSCH.  Let the code detecting the
condition tell (in a less ambiguous way) how it's to be handled. No
changes in behavior.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 12 +++---------
 include/hw/s390x/css.h |  2 +-
 target/s390x/ioinst.c  | 14 ++++----------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 175624d1c8..1839f40408 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1256,26 +1256,20 @@ IOInstEnding css_do_xsch(SubchDev *sch)
     return (IOInstEnding){.cc = 0};
 }
 
-int css_do_csch(SubchDev *sch)
+IOInstEnding css_do_csch(SubchDev *sch)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        return (IOInstEnding){.cc = 3};
     }
 
     /* Trigger the clear function. */
     s->ctrl &= ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
     s->ctrl |= SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
 
-    do_subchannel_work(sch);
-    ret = 0;
-
-out:
-    return ret;
+    return do_subchannel_work(sch);
 }
 
 int css_do_hsch(SubchDev *sch)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 4c89d77893..6ca9999077 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -213,7 +213,7 @@ int css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 int css_do_msch(SubchDev *sch, const SCHIB *schib);
 IOInstEnding css_do_xsch(SubchDev *sch);
-int css_do_csch(SubchDev *sch);
+IOInstEnding css_do_csch(SubchDev *sch);
 int css_do_hsch(SubchDev *sch);
 IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb);
 int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 85f5be6ca3..b12b3d1d41 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -60,8 +60,6 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -69,15 +67,11 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("csch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_csch(sch);
-    }
-    if (ret == -ENODEV) {
-        cc = 3;
-    } else {
-        cc = 0;
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, css_do_csch(sch).cc);
 }
 
 void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
-- 
2.13.5
