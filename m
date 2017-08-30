Received: from eggs.gnu.org ([2001:4830:134:3::10]:50200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5ym-0007I2-70
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yj-0006JD-1H
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44875
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5yi-0006It-SF
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGT9OY033495
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:32 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cnxcqv6jp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:31 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:30 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:07 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-8-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 7/9] s390x: refactor error handling for HSCH
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

Simplify the error handling of the HSCH handler avoiding arbitrary and
cryptic error codes being mapped to what a subchannel is supposed to do.
Let the code detecting the condition tell how it's to be handled in a
less ambiguous way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 19 +++++++------------
 include/hw/s390x/css.h |  2 +-
 target/s390x/ioinst.c  | 27 +++++++++------------------
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index e661a87387..eff1b91a8c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1289,28 +1289,27 @@ void css_do_csch(SubchDev *sch)
     do_subchannel_work(sch);
 }
 
-int css_do_hsch(SubchDev *sch)
+void css_do_hsch(SubchDev *sch)
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
 
     if (((s->ctrl & SCSW_CTRL_MASK_STCTL) == SCSW_STCTL_STATUS_PEND) ||
         (s->ctrl & (SCSW_STCTL_PRIMARY |
                     SCSW_STCTL_SECONDARY |
                     SCSW_STCTL_ALERT))) {
-        ret = -EINPROGRESS;
-        goto out;
+        sch->iret.cc = 1;
+        return;
     }
 
     if (s->ctrl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
-        ret = -EBUSY;
-        goto out;
+        sch->iret.cc = 2;
+        return;
     }
 
     /* Trigger the halt function. */
@@ -1324,10 +1323,6 @@ int css_do_hsch(SubchDev *sch)
     s->ctrl |= SCSW_ACTL_HALT_PEND;
 
     do_subchannel_work(sch);
-    ret = 0;
-
-out:
-    return ret;
 }
 
 static void css_update_chnmon(SubchDev *sch)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d5a7e460ec..d8d949da4f 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -206,7 +206,7 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 int css_do_msch(SubchDev *sch, const SCHIB *schib);
 void css_do_xsch(SubchDev *sch);
 void css_do_csch(SubchDev *sch);
-int css_do_hsch(SubchDev *sch);
+void css_do_hsch(SubchDev *sch);
 void css_do_ssch(SubchDev *sch, ORB *orb);
 int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
 void css_do_tsch_update_subch(SubchDev *sch);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 501f3135ad..e91788d586 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -89,8 +89,6 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -98,24 +96,17 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("hsch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_hsch(sch);
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
+    css_do_hsch(sch);
+    if (sch->iret.pgm_chk) {
+        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, sch->iret.cc);
 }
 
 static int ioinst_schib_valid(SCHIB *schib)
-- 
2.13.5
