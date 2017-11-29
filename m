Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8wq-00062i-6U
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8wo-0007rG-Ag
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:11 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Nov 2017 21:26:46 +0100
Message-Id: <20171129202701.16117-2-david@redhat.com>
In-Reply-To: <20171129202701.16117-1-david@redhat.com>
References: <20171129202701.16117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 01/16] s390x/tcg: introduce and use
 s390_program_interrupt()
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

Allows to easily convert more callers of program_interrupt() and to
easily introduce new exceptions without forgetting about the cpu state
reset.

Use s390_program_interrupt() in places where we already had the same
pattern. We will later get rid of program_interrupt().

RA != 0 checks are already done behind the scenes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h           |  2 ++
 target/s390x/crypto_helper.c |  7 ++-----
 target/s390x/excp_helper.c   |  5 +----
 target/s390x/interrupt.c     | 13 +++++++++++++
 target/s390x/mem_helper.c    | 35 +++++++++++------------------------
 target/s390x/misc_helper.c   |  3 +--
 6 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4db8b5409e..3340fdf4b5 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -720,6 +720,8 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
+void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
+                            uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
 void s390_sclp_extint(uint32_t parm);
 
diff --git a/target/s390x/crypto_helper.c b/target/s390x/crypto_helper.c
index fa360a2d6e..5c79790187 100644
--- a/target/s390x/crypto_helper.c
+++ b/target/s390x/crypto_helper.c
@@ -23,7 +23,6 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     const uintptr_t ra = GETPC();
     const uint8_t mod = env->regs[0] & 0x80ULL;
     const uint8_t fc = env->regs[0] & 0x7fULL;
-    CPUState *cs = CPU(s390_env_get_cpu(env));
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
     int i;
@@ -35,8 +34,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
         if (mod) {
-            cpu_restore_state(cs, ra);
-            program_interrupt(env, PGM_SPECIFICATION, 4);
+            s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
             return 0;
         }
         break;
@@ -44,8 +42,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
 
     s390_get_feat_block(type, subfunc);
     if (!test_be_bit(fc, subfunc)) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return 0;
     }
 
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index e04b670663..d831537544 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -554,10 +554,7 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    if (retaddr) {
-        cpu_restore_state(cs, retaddr);
-    }
-    program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+    s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, retaddr);
 }
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index ce6177c141..b07e75daed 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -53,6 +53,19 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
     }
 }
 
+void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
+                            uintptr_t ra)
+{
+#ifdef CONFIG_TCG
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    if (tcg_enabled()) {
+        cpu_restore_state(CPU(cpu), ra);
+    }
+#endif
+    program_interrupt(env, code, ilen);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void cpu_inject_service(S390CPU *cpu, uint32_t param)
 {
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a1652d4849..2625d843b3 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -85,9 +85,7 @@ static inline void check_alignment(CPUS390XState *env, uint64_t v,
                                    int wordsize, uintptr_t ra)
 {
     if (v % wordsize) {
-        CPUState *cs = CPU(s390_env_get_cpu(env));
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
     }
 }
 
@@ -545,8 +543,7 @@ void HELPER(srst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
     /* Bits 32-55 must contain all 0.  */
     if (env->regs[0] & 0xffffff00u) {
-        cpu_restore_state(ENV_GET_CPU(env), ra);
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
     }
 
     str = get_address(env, r2);
@@ -583,8 +580,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 
     /* Bits 32-47 of R0 must be zero.  */
     if (env->regs[0] & 0xffff0000u) {
-        cpu_restore_state(ENV_GET_CPU(env), ra);
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
     }
 
     str = get_address(env, r2);
@@ -1600,8 +1596,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
     return cc;
 
  spec_exception:
-    cpu_restore_state(ENV_GET_CPU(env), ra);
-    program_interrupt(env, PGM_SPECIFICATION, 6);
+    s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
     g_assert_not_reached();
 }
 
@@ -1865,8 +1860,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
     uint16_t entries, i, index = 0;
 
     if (r2 & 0xff000) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
     }
 
     if (!(r2 & 0x800)) {
@@ -2014,8 +2008,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
-        cpu_restore_state(cs, GETPC());
-        program_interrupt(env, PGM_SPECIAL_OP, 2);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, 2, GETPC());
     }
 
     old_exc = cs->exception_index;
@@ -2185,7 +2178,6 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
     const uint8_t psw_as = (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT_ASC;
     const uint64_t r0 = env->regs[0];
     const uintptr_t ra = GETPC();
-    CPUState *cs = CPU(s390_env_get_cpu(env));
     uint8_t dest_key, dest_as, dest_k, dest_a;
     uint8_t src_key, src_as, src_k, src_a;
     uint64_t val;
@@ -2195,8 +2187,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
                __func__, dest, src, len);
 
     if (!(env->psw.mask & PSW_MASK_DAT)) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIAL_OP, 6);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, 6, ra);
     }
 
     /* OAC (operand access control) for the first operand -> dest */
@@ -2227,17 +2218,14 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
     }
 
     if (dest_a && dest_as == AS_HOME && (env->psw.mask & PSW_MASK_PSTATE)) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIAL_OP, 6);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, 6, ra);
     }
     if (!(env->cregs[0] & CR0_SECONDARY) &&
         (dest_as == AS_SECONDARY || src_as == AS_SECONDARY)) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIAL_OP, 6);
+        s390_program_interrupt(env, PGM_SPECIAL_OP, 6, ra);
     }
     if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key)) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_PRIVILEGED, 6);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
     }
 
     len = wrap_length(env, len);
@@ -2251,8 +2239,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
         (env->psw.mask & PSW_MASK_PSTATE)) {
         qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missing\n",
                       __func__);
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_ADDRESSING, 6);
+        s390_program_interrupt(env, PGM_ADDRESSING, 6, ra);
     }
 
     /* FIXME: a) LAP
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index d272851e1c..1ccbafbb7d 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -519,8 +519,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
     int i;
 
     if (addr & 0x7) {
-        cpu_restore_state(ENV_GET_CPU(env), ra);
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
     }
 
     prepare_stfl();
-- 
2.14.3
