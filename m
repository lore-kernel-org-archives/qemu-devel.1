Received: from eggs.gnu.org ([2001:4830:134:3::10]:50233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yp-0007K5-C8
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5ym-0006Ma-LU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55705
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5ym-0006LM-FM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGTHjX091217
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:35 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cp0gja0mv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:35 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:33 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:09 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-10-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 9/9] s390x: factor out common ioinst handler
 logic
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

Some of ioinst the handlers look very much the same: they basically
delegate the work to the appropriate css function (doing some always the
same stuff before and after the call to the appropriate css function).
Let us create a template and get rid of some code.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Suggested-by: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
---

The handlers for MSCH and SSCH look very similar to our template too.
It's just that there is one more parameter to the corresponding css
function. Maybe one could do something to unify that too (e.g. some
crazy macro) but I don't think it's worth the effort. Another idea
was to make the two corresponding functions single argument too
(by Dong Jia).
---
 target/s390x/ioinst.c | 77 ++++++++++-----------------------------------------
 1 file changed, 14 insertions(+), 63 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index a286495219..6583e5216d 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -37,7 +37,10 @@ int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
     return 0;
 }
 
-void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
+/* many ionst handlers look the same: they just delegate to a some css func */
+static void ioinst_handler_template_sch(S390CPU *cpu, uint64_t reg1,
+                                      const char *iname,
+                                      void (*handler_css)(SubchDev *))
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
@@ -46,14 +49,14 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
         return;
     }
-    trace_ioinst_sch_id("xsch", cssid, ssid, schid);
+    trace_ioinst_sch_id(iname, cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
     if (!sch || !css_subch_visible(sch)) {
         setcc(cpu, 3);
         return;
     }
     css_subch_clear_iret(sch);
-    css_do_xsch(sch);
+    handler_css(sch);
     if (sch->iret.pgm_chk) {
         program_interrupt(&cpu->env, sch->iret.irq_code, 4);
         return;
@@ -61,52 +64,19 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
     setcc(cpu, sch->iret.cc);
 }
 
-void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
+void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
 {
-    int cssid, ssid, schid, m;
-    SubchDev *sch;
+    ioinst_handler_template_sch(cpu, reg1, "xsch", css_do_xsch);
+}
 
-    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
-        return;
-    }
-    trace_ioinst_sch_id("csch", cssid, ssid, schid);
-    sch = css_find_subch(m, cssid, ssid, schid);
-    if (!sch || !css_subch_visible(sch)) {
-        setcc(cpu, 3);
-        return;
-    }
-    css_subch_clear_iret(sch);
-    css_do_csch(sch);
-    if (sch->iret.pgm_chk) {
-        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
-        return;
-    }
-    setcc(cpu, sch->iret.cc);
+void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
+{
+    ioinst_handler_template_sch(cpu, reg1, "csch", css_do_csch);
 }
 
 void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
 {
-    int cssid, ssid, schid, m;
-    SubchDev *sch;
-
-    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
-        return;
-    }
-    trace_ioinst_sch_id("hsch", cssid, ssid, schid);
-    sch = css_find_subch(m, cssid, ssid, schid);
-    if (!sch || !css_subch_visible(sch)) {
-        setcc(cpu, 3);
-        return;
-    }
-    css_subch_clear_iret(sch);
-    css_do_hsch(sch);
-    if (sch->iret.pgm_chk) {
-        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
-        return;
-    }
-    setcc(cpu, sch->iret.cc);
+    ioinst_handler_template_sch(cpu, reg1, "hsch", css_do_hsch);
 }
 
 static int ioinst_schib_valid(SCHIB *schib)
@@ -720,26 +690,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
 
 void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
 {
-    int cssid, ssid, schid, m;
-    SubchDev *sch;
-
-    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
-        return;
-    }
-    trace_ioinst_sch_id("rsch", cssid, ssid, schid);
-    sch = css_find_subch(m, cssid, ssid, schid);
-    if (!sch || !css_subch_visible(sch)) {
-        setcc(cpu, 3);
-        return;
-    }
-    css_subch_clear_iret(sch);
-    css_do_rsch(sch);
-    if (sch->iret.pgm_chk) {
-        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
-        return;
-    }
-    setcc(cpu, sch->iret.cc);
+    ioinst_handler_template_sch(cpu, reg1, "rsch", css_do_rsch);
 }
 
 #define RCHP_REG1_RES(_reg) (_reg & 0x00000000ff00ff00)
-- 
2.13.5
