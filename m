Received: from eggs.gnu.org ([2001:4830:134:3::10]:50204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5ym-0007I3-AG
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yj-0006JJ-4n
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5yi-0006Io-SN
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGYBjx061708
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:31 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cnyf4p6a9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:31 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:28 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:05 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-6-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/9] s390x: refactor error handling for XSCH
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

Simplify the error handling of the XSCH handler avoiding arbitrary and
cryptic error codes being mapped to what a subchannel is supposed to do.
Let the code detecting the condition tell how it's to be handled in a
less ambiguous way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 19 +++++++------------
 include/hw/s390x/css.h |  2 +-
 target/s390x/ioinst.c  | 27 +++++++++------------------
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1102642c10..7880c2c025 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1237,15 +1237,14 @@ out:
     return ret;
 }
 
-int css_do_xsch(SubchDev *sch)
+void css_do_xsch(SubchDev *sch)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        sch->iret.cc = 3;
+        return;
     }
 
     if (!(s->ctrl & SCSW_CTRL_MASK_FCTL) ||
@@ -1253,13 +1252,13 @@ int css_do_xsch(SubchDev *sch)
         (!(s->ctrl &
            (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
         (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
-        ret = -EBUSY;
-        goto out;
+        sch->iret.cc = 2;
+        return;
     }
 
     if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
-        ret = -EINPROGRESS;
-        goto out;
+        sch->iret.cc = 1;
+        return;
     }
 
     /* Cancel the current operation. */
@@ -1271,10 +1270,6 @@ int css_do_xsch(SubchDev *sch)
     sch->last_cmd_valid = false;
     s->dstat = 0;
     s->cstat = 0;
-    ret = 0;
-
-out:
-    return ret;
 }
 
 int css_do_csch(SubchDev *sch)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d093181a9e..d78ee5714b 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -204,7 +204,7 @@ void css_conditional_io_interrupt(SubchDev *sch);
 int css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 int css_do_msch(SubchDev *sch, const SCHIB *schib);
-int css_do_xsch(SubchDev *sch);
+void css_do_xsch(SubchDev *sch);
 int css_do_csch(SubchDev *sch);
 int css_do_hsch(SubchDev *sch);
 void css_do_ssch(SubchDev *sch, ORB *orb);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index e8044068c2..f8e038fac7 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -41,8 +41,6 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -50,24 +48,17 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("xsch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_xsch(sch);
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
+    css_do_xsch(sch);
+    if (sch->iret.pgm_chk) {
+        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, sch->iret.cc);
 }
 
 void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
-- 
2.13.5
