Received: from eggs.gnu.org ([2001:4830:134:3::10]:50181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yl-0007Hw-6O
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yj-0006JS-9s
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59888
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5yj-0006J9-4F
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGTBKp111808
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:32 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cnx1vp5pc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:32 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:30 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:06 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-7-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 6/9] s390x: refactor error handling for CSCH
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

Simplify the error handling of the CSCH handler avoiding arbitrary and
cryptic error codes being mapped to what a subchannel is supposed to do.
Let the code detecting the condition tell how it's to be handled in a
less ambiguous way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 11 +++--------
 include/hw/s390x/css.h |  2 +-
 target/s390x/ioinst.c  | 18 +++++++++---------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 7880c2c025..e661a87387 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1272,15 +1272,14 @@ void css_do_xsch(SubchDev *sch)
     s->cstat = 0;
 }
 
-int css_do_csch(SubchDev *sch)
+void css_do_csch(SubchDev *sch)
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
 
     /* Trigger the clear function. */
@@ -1288,10 +1287,6 @@ int css_do_csch(SubchDev *sch)
     s->ctrl |= SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
 
     do_subchannel_work(sch);
-    ret = 0;
-
-out:
-    return ret;
 }
 
 int css_do_hsch(SubchDev *sch)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d78ee5714b..d5a7e460ec 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -205,7 +205,7 @@ int css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 int css_do_msch(SubchDev *sch, const SCHIB *schib);
 void css_do_xsch(SubchDev *sch);
-int css_do_csch(SubchDev *sch);
+void css_do_csch(SubchDev *sch);
 int css_do_hsch(SubchDev *sch);
 void css_do_ssch(SubchDev *sch, ORB *orb);
 int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index f8e038fac7..501f3135ad 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -65,8 +65,6 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -74,15 +72,17 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("csch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_csch(sch);
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
+        return;
     }
-    if (ret == -ENODEV) {
-        cc = 3;
-    } else {
-        cc = 0;
+    css_subch_clear_iret(sch);
+    css_do_csch(sch);
+    if (sch->iret.pgm_chk) {
+        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, sch->iret.cc);
 }
 
 void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
-- 
2.13.5
