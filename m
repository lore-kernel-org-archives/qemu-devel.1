Received: from eggs.gnu.org ([2001:4830:134:3::10]:56926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiL-0004fH-9G
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiJ-0005mj-JH
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:49 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZpiJ-0005ma-EO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:47 -0400
Received: by mail-qk0-x243.google.com with SMTP id d136so11595206qkg.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:36:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 19:36:09 -0700
Message-Id: <20170725023611.9169-3-rth@twiddle.net>
In-Reply-To: <20170725023611.9169-1-rth@twiddle.net>
References: <20170725023611.9169-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 2/4] target/s390x: Use ILEN_UNWIND in trivial
 cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

All of these uses also have an immediately visible
call to cpu_restore_state.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.c      |  7 +++----
 target/s390x/mem_helper.c  | 26 +++++++++++++-------------
 target/s390x/misc_helper.c |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 6d67d6b5a1..c83772bec3 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -763,9 +763,8 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    if (retaddr) {
-        cpu_restore_state(cs, retaddr);
-    }
-    program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+    g_assert(retaddr != 0);
+    cpu_restore_state(cs, retaddr);
+    program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
 }
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index cdc78aa3d4..026189aefd 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -75,7 +75,7 @@ static inline void check_alignment(CPUS390XState *env, uint64_t v,
     if (v % wordsize) {
         CPUState *cs = CPU(s390_env_get_cpu(env));
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
     }
 }
 
@@ -548,7 +548,7 @@ void HELPER(srst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     /* Bits 32-55 must contain all 0.  */
     if (env->regs[0] & 0xffffff00u) {
         cpu_restore_state(ENV_GET_CPU(env), ra);
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
     }
 
     str = get_address(env, r2);
@@ -586,7 +586,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     /* Bits 32-47 of R0 must be zero.  */
     if (env->regs[0] & 0xffff0000u) {
         cpu_restore_state(ENV_GET_CPU(env), ra);
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
     }
 
     str = get_address(env, r2);
@@ -1589,7 +1589,7 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
 
  spec_exception:
     cpu_restore_state(ENV_GET_CPU(env), ra);
-    program_interrupt(env, PGM_SPECIFICATION, 6);
+    program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
     g_assert_not_reached();
 }
 
@@ -1697,14 +1697,14 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     if (!address_space_access_valid(&address_space_memory, abs_addr,
                                     TARGET_PAGE_SIZE, true)) {
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_ADDRESSING, 4);
+        program_interrupt(env, PGM_ADDRESSING, ILEN_UNWIND);
         return 1;
     }
 
     /* Check low-address protection */
     if ((env->cregs[0] & CR0_LOWPROT) && real_addr < 0x2000) {
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_PROTECTION, 4);
+        program_interrupt(env, PGM_PROTECTION, ILEN_UNWIND);
         return 1;
     }
 
@@ -1859,7 +1859,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
 
     if (r2 & 0xff000) {
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
     }
 
     if (!(r2 & 0x800)) {
@@ -2015,7 +2015,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
         cpu_restore_state(cs, GETPC());
-        program_interrupt(env, PGM_SPECIAL_OP, 2);
+        program_interrupt(env, PGM_SPECIAL_OP, ILEN_UNWIND);
     }
 
     old_exc = cs->exception_index;
@@ -2174,7 +2174,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
 
     if (!(env->psw.mask & PSW_MASK_DAT)) {
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIAL_OP, 6);
+        program_interrupt(env, PGM_SPECIAL_OP, ILEN_UNWIND);
     }
 
     /* OAC (operand access control) for the first operand -> dest */
@@ -2206,16 +2206,16 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
 
     if (dest_a && dest_as == AS_HOME && (env->psw.mask & PSW_MASK_PSTATE)) {
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIAL_OP, 6);
+        program_interrupt(env, PGM_SPECIAL_OP, ILEN_UNWIND);
     }
     if (!(env->cregs[0] & CR0_SECONDARY) &&
         (dest_as == AS_SECONDARY || src_as == AS_SECONDARY)) {
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_SPECIAL_OP, 6);
+        program_interrupt(env, PGM_SPECIAL_OP, ILEN_UNWIND);
     }
     if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key)) {
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_PRIVILEGED, 6);
+        program_interrupt(env, PGM_PRIVILEGED, ILEN_UNWIND);
     }
 
     len = wrap_length(env, len);
@@ -2230,7 +2230,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
         qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missing\n",
                       __func__);
         cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_ADDRESSING, 6);
+        program_interrupt(env, PGM_ADDRESSING, ILEN_UNWIND);
     }
 
     /* FIXME: a) LAP
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 452b2bd902..376dbd68c2 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -57,7 +57,7 @@ void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = excp;
-    env->int_pgm_ilen = ILEN_AUTO;
+    env->int_pgm_ilen = ILEN_UNWIND;
 
     /* Use the (ultimate) callers address to find the insn that trapped.  */
     cpu_restore_state(cs, retaddr);
-- 
2.13.3
