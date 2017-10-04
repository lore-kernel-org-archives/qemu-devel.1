Received: from eggs.gnu.org ([2001:4830:134:3::10]:37162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzloF-00029D-1F
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzloA-0003RB-Ie
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44604
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzloA-0003QG-Cn
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94FeSrn116281
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:42:01 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dcxvfe6fq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:42:01 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:41:59 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 17:41:44 +0200
In-Reply-To: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171004154144.88995-9-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 8/8] s390x: factor out common ioinst handler
 logic
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

Some of ioinst the handlers look very much the same: they basically
delegate the work to the appropriate css function (doing some always the
same stuff before and after the call to the appropriate css function).
Let us create a template and get rid of some code.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Suggested-by: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>
---
 target/s390x/ioinst.c | 59 ++++++++++++---------------------------------------
 1 file changed, 14 insertions(+), 45 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 0c256baa70..9c7d6a222c 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -38,7 +38,10 @@ int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
     return 0;
 }
 
-void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
+/* many ionst handlers look the same: they just delegate to a some css func */
+static void ioinst_handler_template_sch(S390CPU *cpu, uint64_t reg1,
+                                      const char *iname,
+                                      IOInstEnding (*handler_css)(SubchDev *))
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
@@ -47,49 +50,28 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
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
-    setcc(cpu, css_do_xsch(sch).cc);
+    setcc(cpu, handler_css(sch).cc);
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
-    setcc(cpu, css_do_csch(sch).cc);
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
-    setcc(cpu, css_do_hsch(sch).cc);
+    ioinst_handler_template_sch(cpu, reg1, "hsch", css_do_hsch);
 }
 
 static int ioinst_schib_valid(SCHIB *schib)
@@ -707,20 +689,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
 
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
-    setcc(cpu, css_do_rsch(sch).cc);
+   ioinst_handler_template_sch(cpu, reg1, "rsch", css_do_rsch);
 }
 
 #define RCHP_REG1_RES(_reg) (_reg & 0x00000000ff00ff00)
-- 
2.13.5
