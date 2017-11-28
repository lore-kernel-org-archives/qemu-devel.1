Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJmZZ-0000pg-8M
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJmZX-0003b1-VD
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:33:41 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 28 Nov 2017 21:33:12 +0100
Message-Id: <20171128203326.6062-3-david@redhat.com>
In-Reply-To: <20171128203326.6062-1-david@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 02/15] s390x/tcg: get rid of
 runtime_exception()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Let's use program_interrupt_ra() instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c  |  2 +-
 target/s390x/int_helper.c  | 14 +++++++-------
 target/s390x/internal.h    |  2 --
 target/s390x/misc_helper.c | 16 ----------------
 4 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index ffbeb3b2df..0ba347668c 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -44,7 +44,7 @@ static void ieee_exception(CPUS390XState *env, uint32_t dxc, uintptr_t retaddr)
     /* Install the DXC code.  */
     env->fpc = (env->fpc & ~0xff00) | (dxc << 8);
     /* Trap.  */
-    runtime_exception(env, PGM_DATA, retaddr);
+    program_interrupt_ra(env, PGM_DATA, ILEN_AUTO, retaddr);
 }
 
 /* Should be called after any operation that may raise IEEE exceptions.  */
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index 0076bea047..f384b14eab 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -39,7 +39,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
     int64_t q;
 
     if (b == 0) {
-        runtime_exception(env, PGM_FIXPT_DIVIDE, GETPC());
+        program_interrupt_ra(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
     }
 
     ret = q = a / b;
@@ -47,7 +47,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
 
     /* Catch non-representable quotient.  */
     if (ret != q) {
-        runtime_exception(env, PGM_FIXPT_DIVIDE, GETPC());
+        program_interrupt_ra(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
     }
 
     return ret;
@@ -60,7 +60,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
     uint64_t q;
 
     if (b == 0) {
-        runtime_exception(env, PGM_FIXPT_DIVIDE, GETPC());
+        program_interrupt_ra(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
     }
 
     ret = q = a / b;
@@ -68,7 +68,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
 
     /* Catch non-representable quotient.  */
     if (ret != q) {
-        runtime_exception(env, PGM_FIXPT_DIVIDE, GETPC());
+        program_interrupt_ra(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
     }
 
     return ret;
@@ -79,7 +79,7 @@ int64_t HELPER(divs64)(CPUS390XState *env, int64_t a, int64_t b)
 {
     /* Catch divide by zero, and non-representable quotient (MIN / -1).  */
     if (b == 0 || (b == -1 && a == (1ll << 63))) {
-        runtime_exception(env, PGM_FIXPT_DIVIDE, GETPC());
+        program_interrupt_ra(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
     }
     env->retxl = a % b;
     return a / b;
@@ -92,7 +92,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
     uint64_t ret;
     /* Signal divide by zero.  */
     if (b == 0) {
-        runtime_exception(env, PGM_FIXPT_DIVIDE, GETPC());
+        program_interrupt_ra(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
     }
     if (ah == 0) {
         /* 64 -> 64/64 case */
@@ -106,7 +106,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
         env->retxl = a % b;
         ret = q;
         if (ret != q) {
-            runtime_exception(env, PGM_FIXPT_DIVIDE, GETPC());
+            program_interrupt_ra(env, PGM_FIXPT_DIVIDE, ILEN_AUTO, GETPC());
         }
 #else
         S390CPU *cpu = s390_env_get_cpu(env);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 3aff54ada4..db39d5bfac 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -408,8 +408,6 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
 
 
 /* misc_helper.c */
-void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
-                                     uintptr_t retaddr);
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
 
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index fbb446db70..6f29f92b94 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -45,22 +45,6 @@
 #define HELPER_LOG(x...)
 #endif
 
-/* Raise an exception dynamically from a helper function.  */
-void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
-                                     uintptr_t retaddr)
-{
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    cs->exception_index = EXCP_PGM;
-    env->int_pgm_code = excp;
-    env->int_pgm_ilen = ILEN_AUTO;
-
-    /* Use the (ultimate) callers address to find the insn that trapped.  */
-    cpu_restore_state(cs, retaddr);
-
-    cpu_loop_exit(cs);
-}
-
 /* Raise an exception statically from a TB.  */
 void HELPER(exception)(CPUS390XState *env, uint32_t excp)
 {
-- 
2.14.3
