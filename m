Received: from eggs.gnu.org ([2001:4830:134:3::10]:46319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dZeT4-0004VS-39
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dZeT1-0002Zm-Cs
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37321
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dZeT1-0002Rr-6w
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6OEZrid129569
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 10:36:06 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bwexbu47b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 10:35:59 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 24 Jul 2017 15:35:19 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 24 Jul 2017 16:34:52 +0200
Message-Id: <20170724143452.55534-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x/css: fix ilen in IO instruction
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

When initiating a program check interruption by calling program_interrupt
the instruction length (ilen) of the current instruction is supplied as
the third parameter.

On s390x all the IO instructions are of instruction format S and their
ilen is 4.  The calls to program_interrupt (introduced by commits
7b18aad543 ("s390: Add channel I/O instructions.", 2013-01-24) and
61bf0dcb2e ("s390x/ioinst: Add missing alignment checks for IO
instructions", 2013-06-21)) however use ilen == 2.

This is probably due to a confusion between ilen which specifies the
instruction length in bytes and ILC which does the same but in halfwords.
If kvm_enabled() this does not actually matter, because the ilen
parameter of program_interrupt is effectively unused.

Let's provide the correct ilen to program_interrupt.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes:  7b18aad543 ("s390: Add channel I/O instructions.")
Fixes: 61bf0dcb2e ("s390x/ioinst: Add missing alignment checks for IO instructions")
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/ioinst.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index d5e6b8066b..51fbea620d 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -45,7 +45,7 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
     int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 2);
+        program_interrupt(&cpu->env, PGM_OPERAND, 4);
         return;
     }
     trace_ioinst_sch_id("xsch", cssid, ssid, schid);
@@ -78,7 +78,7 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
     int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 2);
+        program_interrupt(&cpu->env, PGM_OPERAND, 4);
         return;
     }
     trace_ioinst_sch_id("csch", cssid, ssid, schid);
@@ -102,7 +102,7 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
     int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 2);
+        program_interrupt(&cpu->env, PGM_OPERAND, 4);
         return;
     }
     trace_ioinst_sch_id("hsch", cssid, ssid, schid);
@@ -153,7 +153,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
@@ -161,7 +161,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     }
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
         !ioinst_schib_valid(&schib)) {
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return;
     }
     trace_ioinst_sch_id("msch", cssid, ssid, schid);
@@ -224,7 +224,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
@@ -233,7 +233,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     copy_orb_from_guest(&orb, &orig_orb);
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
         !ioinst_orb_valid(&orb)) {
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return;
     }
     trace_ioinst_sch_id("ssch", cssid, ssid, schid);
@@ -277,7 +277,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
         return;
     }
 
@@ -304,7 +304,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
         return;
     }
 
@@ -315,7 +315,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
          * access execption if it is not) first.
          */
         if (!s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib))) {
-            program_interrupt(env, PGM_OPERAND, 2);
+            program_interrupt(env, PGM_OPERAND, 4);
         }
         return;
     }
@@ -363,13 +363,13 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     uint8_t ar;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
         return -EIO;
     }
 
@@ -659,7 +659,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb)
     addr = env->regs[reg];
     /* Page boundary? */
     if (addr & 0xfff) {
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
         return;
     }
     /*
@@ -674,7 +674,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb)
     len = be16_to_cpu(req->len);
     /* Length field valid? */
     if ((len < 16) || (len > 4088) || (len & 7)) {
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return;
     }
     memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
@@ -718,7 +718,7 @@ int ioinst_handle_tpi(S390CPU *cpu, uint32_t ipb)
     trace_ioinst("tpi");
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
         return -EIO;
     }
 
@@ -747,7 +747,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
     trace_ioinst("schm");
 
     if (SCHM_REG1_RES(reg1)) {
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return;
     }
 
@@ -756,7 +756,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
     dct = SCHM_REG1_DCT(reg1);
 
     if (update && (reg2 & 0x000000000000001f)) {
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return;
     }
 
@@ -771,7 +771,7 @@ void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
     int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 2);
+        program_interrupt(&cpu->env, PGM_OPERAND, 4);
         return;
     }
     trace_ioinst_sch_id("rsch", cssid, ssid, schid);
@@ -808,7 +808,7 @@ void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1)
     CPUS390XState *env = &cpu->env;
 
     if (RCHP_REG1_RES(reg1)) {
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return;
     }
 
@@ -831,7 +831,7 @@ void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1)
         break;
     default:
         /* Invalid channel subsystem. */
-        program_interrupt(env, PGM_OPERAND, 2);
+        program_interrupt(env, PGM_OPERAND, 4);
         return;
     }
     setcc(cpu, cc);
@@ -842,6 +842,6 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1)
 {
     /* We do not provide address limit checking, so let's suppress it. */
     if (SAL_REG1_INVALID(reg1) || reg1 & 0x000000000000ffff) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 2);
+        program_interrupt(&cpu->env, PGM_OPERAND, 4);
     }
 }
-- 
2.11.2
