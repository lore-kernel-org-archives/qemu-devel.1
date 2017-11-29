Received: from eggs.gnu.org ([2001:4830:134:3::10]:46325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8wz-0006EK-Sa
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8wx-0007tB-E4
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:21 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Nov 2017 21:26:49 +0100
Message-Id: <20171129202701.16117-5-david@redhat.com>
In-Reply-To: <20171129202701.16117-1-david@redhat.com>
References: <20171129202701.16117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 04/16] s390x/ioinst: pass the
 retaddr to all IO instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

TCG needs the retaddr when injecting an interrupt. Let's just pass it
along and use RA_IGNORED for KVM. The value will be completely ignored for
KVM.

Convert program_interrupt() to s390_program_interrupt() directly, making
use of the passed address.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  1 +
 target/s390x/internal.h    | 29 +++++++++++---------
 target/s390x/ioinst.c      | 67 +++++++++++++++++++++++-----------------------
 target/s390x/kvm.c         | 27 ++++++++++---------
 target/s390x/misc_helper.c | 20 +++++++-------
 5 files changed, 75 insertions(+), 69 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3340fdf4b5..96abb2976b 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -720,6 +720,7 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
+#define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
                             uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 603b0d7a7c..9db5f2d49d 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -379,20 +379,23 @@ void cpu_inject_stop(S390CPU *cpu);
 
 
 /* ioinst.c */
-void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb);
-void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb);
+void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
+                        uintptr_t ra);
+void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
+                        uintptr_t ra);
+void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra);
+void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
+                         uintptr_t ra);
+int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra);
+void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra);
 void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
-                        uint32_t ipb);
-void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1);
+                        uint32_t ipb, uintptr_t ra);
+void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 
 
 /* mem_helper.c */
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 1d6857c14d..25e0ad6f77 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -38,13 +38,13 @@ int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
     return 0;
 }
 
-void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
+void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
         return;
     }
     trace_ioinst_sch_id("xsch", cssid, ssid, schid);
@@ -56,13 +56,13 @@ void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1)
     setcc(cpu, css_do_xsch(sch));
 }
 
-void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
+void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
         return;
     }
     trace_ioinst_sch_id("csch", cssid, ssid, schid);
@@ -74,13 +74,13 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
     setcc(cpu, css_do_csch(sch));
 }
 
-void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
+void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
         return;
     }
     trace_ioinst_sch_id("hsch", cssid, ssid, schid);
@@ -105,7 +105,7 @@ static int ioinst_schib_valid(SCHIB *schib)
     return 1;
 }
 
-void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
+void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
@@ -116,7 +116,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
@@ -124,7 +124,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     }
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
         !ioinst_schib_valid(&schib)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return;
     }
     trace_ioinst_sch_id("msch", cssid, ssid, schid);
@@ -161,7 +161,7 @@ static int ioinst_orb_valid(ORB *orb)
     return 1;
 }
 
-void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
+void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
@@ -172,7 +172,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
@@ -181,7 +181,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     copy_orb_from_guest(&orb, &orig_orb);
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
         !ioinst_orb_valid(&orb)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return;
     }
     trace_ioinst_sch_id("ssch", cssid, ssid, schid);
@@ -193,7 +193,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     setcc(cpu, css_do_ssch(sch, &orb));
 }
 
-void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
+void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 {
     CRW crw;
     uint64_t addr;
@@ -203,7 +203,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return;
     }
 
@@ -218,7 +218,8 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
     }
 }
 
-void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
+void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
+                         uintptr_t ra)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
@@ -230,7 +231,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
 
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return;
     }
 
@@ -241,7 +242,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
          * access execption if it is not) first.
          */
         if (!s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib))) {
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         }
         return;
     }
@@ -278,7 +279,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     setcc(cpu, cc);
 }
 
-int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
+int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     int cssid, ssid, schid, m;
@@ -289,13 +290,13 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     uint8_t ar;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
     addr = decode_basedisp_s(env, ipb, &ar);
     if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return -EIO;
     }
 
@@ -585,7 +586,7 @@ static void ioinst_handle_chsc_unimplemented(ChscResp *res)
     res->param = 0;
 }
 
-void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb)
+void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 {
     ChscReq *req;
     ChscResp *res;
@@ -601,7 +602,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb)
     addr = env->regs[reg];
     /* Page boundary? */
     if (addr & 0xfff) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return;
     }
     /*
@@ -616,7 +617,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb)
     len = be16_to_cpu(req->len);
     /* Length field valid? */
     if ((len < 16) || (len > 4088) || (len & 7)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return;
     }
     memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
@@ -653,7 +654,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb)
 #define SCHM_REG1_DCT(_reg) (_reg & 0x0000000000000001)
 
 void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
-                        uint32_t ipb)
+                        uint32_t ipb, uintptr_t ra)
 {
     uint8_t mbk;
     int update;
@@ -663,7 +664,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
     trace_ioinst("schm");
 
     if (SCHM_REG1_RES(reg1)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return;
     }
 
@@ -672,20 +673,20 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
     dct = SCHM_REG1_DCT(reg1);
 
     if (update && (reg2 & 0x000000000000001f)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return;
     }
 
     css_do_schm(mbk, update, dct, update ? reg2 : 0);
 }
 
-void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
+void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
         return;
     }
     trace_ioinst_sch_id("rsch", cssid, ssid, schid);
@@ -700,7 +701,7 @@ void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
 #define RCHP_REG1_RES(_reg) (_reg & 0x00000000ff00ff00)
 #define RCHP_REG1_CSSID(_reg) ((_reg & 0x0000000000ff0000) >> 16)
 #define RCHP_REG1_CHPID(_reg) (_reg & 0x00000000000000ff)
-void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1)
+void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
 {
     int cc;
     uint8_t cssid;
@@ -709,7 +710,7 @@ void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1)
     CPUS390XState *env = &cpu->env;
 
     if (RCHP_REG1_RES(reg1)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return;
     }
 
@@ -732,17 +733,17 @@ void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1)
         break;
     default:
         /* Invalid channel subsystem. */
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return;
     }
     setcc(cpu, cc);
 }
 
 #define SAL_REG1_INVALID(_reg) (_reg & 0x0000000080000000)
-void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1)
+void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra)
 {
     /* We do not provide address limit checking, so let's suppress it. */
     if (SAL_REG1_INVALID(reg1) || reg1 & 0x000000000000ffff) {
-        program_interrupt(&cpu->env, PGM_OPERAND, 4);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, 4, ra);
     }
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b03f583032..b3ed3db2c2 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1124,32 +1124,32 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
 
     switch (ipa1) {
     case PRIV_B2_XSCH:
-        ioinst_handle_xsch(cpu, env->regs[1]);
+        ioinst_handle_xsch(cpu, env->regs[1], RA_IGNORED);
         break;
     case PRIV_B2_CSCH:
-        ioinst_handle_csch(cpu, env->regs[1]);
+        ioinst_handle_csch(cpu, env->regs[1], RA_IGNORED);
         break;
     case PRIV_B2_HSCH:
-        ioinst_handle_hsch(cpu, env->regs[1]);
+        ioinst_handle_hsch(cpu, env->regs[1], RA_IGNORED);
         break;
     case PRIV_B2_MSCH:
-        ioinst_handle_msch(cpu, env->regs[1], run->s390_sieic.ipb);
+        ioinst_handle_msch(cpu, env->regs[1], run->s390_sieic.ipb, RA_IGNORED);
         break;
     case PRIV_B2_SSCH:
-        ioinst_handle_ssch(cpu, env->regs[1], run->s390_sieic.ipb);
+        ioinst_handle_ssch(cpu, env->regs[1], run->s390_sieic.ipb, RA_IGNORED);
         break;
     case PRIV_B2_STCRW:
-        ioinst_handle_stcrw(cpu, run->s390_sieic.ipb);
+        ioinst_handle_stcrw(cpu, run->s390_sieic.ipb, RA_IGNORED);
         break;
     case PRIV_B2_STSCH:
-        ioinst_handle_stsch(cpu, env->regs[1], run->s390_sieic.ipb);
+        ioinst_handle_stsch(cpu, env->regs[1], run->s390_sieic.ipb, RA_IGNORED);
         break;
     case PRIV_B2_TSCH:
         /* We should only get tsch via KVM_EXIT_S390_TSCH. */
         fprintf(stderr, "Spurious tsch intercept\n");
         break;
     case PRIV_B2_CHSC:
-        ioinst_handle_chsc(cpu, run->s390_sieic.ipb);
+        ioinst_handle_chsc(cpu, run->s390_sieic.ipb, RA_IGNORED);
         break;
     case PRIV_B2_TPI:
         /* This should have been handled by kvm already. */
@@ -1157,19 +1157,19 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
         break;
     case PRIV_B2_SCHM:
         ioinst_handle_schm(cpu, env->regs[1], env->regs[2],
-                           run->s390_sieic.ipb);
+                           run->s390_sieic.ipb, RA_IGNORED);
         break;
     case PRIV_B2_RSCH:
-        ioinst_handle_rsch(cpu, env->regs[1]);
+        ioinst_handle_rsch(cpu, env->regs[1], RA_IGNORED);
         break;
     case PRIV_B2_RCHP:
-        ioinst_handle_rchp(cpu, env->regs[1]);
+        ioinst_handle_rchp(cpu, env->regs[1], RA_IGNORED);
         break;
     case PRIV_B2_STCPS:
         /* We do not provide this instruction, it is suppressed. */
         break;
     case PRIV_B2_SAL:
-        ioinst_handle_sal(cpu, env->regs[1]);
+        ioinst_handle_sal(cpu, env->regs[1], RA_IGNORED);
         break;
     case PRIV_B2_SIGA:
         /* Not provided, set CC = 3 for subchannel not operational */
@@ -1673,7 +1673,8 @@ static int handle_tsch(S390CPU *cpu)
 
     cpu_synchronize_state(cs);
 
-    ret = ioinst_handle_tsch(cpu, cpu->env.regs[1], run->s390_tsch.ipb);
+    ret = ioinst_handle_tsch(cpu, cpu->env.regs[1], run->s390_tsch.ipb,
+                             RA_IGNORED);
     if (ret < 0) {
         /*
          * Failure.
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 67628e690d..9b53abbfa7 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -323,7 +323,7 @@ void HELPER(xsch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_xsch(cpu, r1);
+    ioinst_handle_xsch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -331,7 +331,7 @@ void HELPER(csch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_csch(cpu, r1);
+    ioinst_handle_csch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -339,7 +339,7 @@ void HELPER(hsch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_hsch(cpu, r1);
+    ioinst_handle_hsch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -347,7 +347,7 @@ void HELPER(msch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_msch(cpu, r1, inst >> 16);
+    ioinst_handle_msch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -355,7 +355,7 @@ void HELPER(rchp)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_rchp(cpu, r1);
+    ioinst_handle_rchp(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -363,7 +363,7 @@ void HELPER(rsch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_rsch(cpu, r1);
+    ioinst_handle_rsch(cpu, r1, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -371,7 +371,7 @@ void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_ssch(cpu, r1, inst >> 16);
+    ioinst_handle_ssch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -379,7 +379,7 @@ void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_stsch(cpu, r1, inst >> 16);
+    ioinst_handle_stsch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -387,7 +387,7 @@ void HELPER(tsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_tsch(cpu, r1, inst >> 16);
+    ioinst_handle_tsch(cpu, r1, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
 }
 
@@ -395,7 +395,7 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     qemu_mutex_lock_iothread();
-    ioinst_handle_chsc(cpu, inst >> 16);
+    ioinst_handle_chsc(cpu, inst >> 16, GETPC());
     qemu_mutex_unlock_iothread();
 }
 #endif
-- 
2.14.3
