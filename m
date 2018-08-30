Received: from eggs.gnu.org ([2001:4830:134:3::10]:42103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3R-0008WQ-4G
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3Q-0000OP-4M
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:05 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Aug 2018 14:27:49 +0200
Message-Id: <20180830122756.13991-3-david@redhat.com>
In-Reply-To: <20180830122756.13991-1-david@redhat.com>
References: <20180830122756.13991-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/9] s390x/tcg: factor out and fix DATA
 exception injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

The DXC is to be stored in the low core, and only in the FPC in case AFP
is enabled in CR0. Stub is not required in current code, but this way
we never run into problems.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  1 +
 target/s390x/excp_helper.c | 23 +++++++++++++++++++++++
 target/s390x/fpu_helper.c  | 13 +++----------
 target/s390x/helper.h      |  1 +
 target/s390x/tcg-stub.c    |  5 +++++
 target/s390x/tcg_s390x.h   |  2 ++
 target/s390x/translate.c   | 19 +++++++++----------
 7 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6f8861e554..5e50c3a303 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -322,6 +322,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #define CR0_LOWPROT             0x0000000010000000ULL
 #define CR0_SECONDARY           0x0000000004000000ULL
 #define CR0_EDAT                0x0000000000800000ULL
+#define CR0_AFP                 0x0000000000040000ULL
 #define CR0_EMERGENCY_SIGNAL_SC 0x0000000000004000ULL
 #define CR0_EXTERNAL_CALL_SC    0x0000000000002000ULL
 #define CR0_CKC_SC              0x0000000000000800ULL
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 5dab3387c3..2b23105f41 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "exec/helper-proto.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
@@ -61,6 +62,28 @@ void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
     cpu_loop_exit(cs);
 }
 
+void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
+                                           uintptr_t ra)
+{
+    g_assert(!(dxc & ~0xff));
+#if !defined(CONFIG_USER_ONLY)
+    /* Store the DXC into the lowcore */
+    stl_phys(CPU(s390_env_get_cpu(env))->as,
+             env->psa + offsetof(LowCore, data_exc_code), dxc);
+#endif
+
+    /* Store the DXC into the FPC if AFP is enabled */
+    if (env->cregs[0] & CR0_AFP) {
+        env->fpc = (env->fpc & ~0xff00) | (dxc << 8);
+    }
+    tcg_s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
+}
+
+void HELPER(data_exception)(CPUS390XState *env, uint32_t dxc)
+{
+    tcg_s390_data_exception(env, dxc, GETPC());
+}
+
 #if defined(CONFIG_USER_ONLY)
 
 void s390_cpu_do_interrupt(CPUState *cs)
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 5c5b451b3b..1b662d2520 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
@@ -40,14 +41,6 @@
      ? (mask / (from / to)) & to    \
      : (mask & from) * (to / from))
 
-static void ieee_exception(CPUS390XState *env, uint32_t dxc, uintptr_t retaddr)
-{
-    /* Install the DXC code.  */
-    env->fpc = (env->fpc & ~0xff00) | (dxc << 8);
-    /* Trap.  */
-    s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, retaddr);
-}
-
 /* Should be called after any operation that may raise IEEE exceptions.  */
 static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
 {
@@ -75,7 +68,7 @@ static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
     /* Send signals for enabled exceptions.  */
     s390_exc &= env->fpc >> 24;
     if (s390_exc) {
-        ieee_exception(env, s390_exc, retaddr);
+        tcg_s390_data_exception(env, s390_exc, retaddr);
     }
 }
 
@@ -773,6 +766,6 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t val)
        is also 1, a simulated-iee-exception trap occurs.  */
     s390_exc = (signalling >> 16) & (source >> 24);
     if (s390_exc) {
-        ieee_exception(env, s390_exc | 3, GETPC());
+        tcg_s390_data_exception(env, s390_exc | 3, GETPC());
     }
 }
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 97c60ca7bc..018e9dd414 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -1,4 +1,5 @@
 DEF_HELPER_2(exception, noreturn, env, i32)
+DEF_HELPER_2(data_exception, noreturn, env, i32)
 DEF_HELPER_FLAGS_4(nc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(oc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(xc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
index dc444fc867..32adb7276a 100644
--- a/target/s390x/tcg-stub.c
+++ b/target/s390x/tcg-stub.c
@@ -23,3 +23,8 @@ void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
 {
     g_assert_not_reached();
 }
+void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
+                                           uintptr_t ra)
+{
+    g_assert_not_reached();
+}
diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index d1fe01ef7e..ab2c4ba703 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -16,5 +16,7 @@
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
 void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
                                               int ilen, uintptr_t ra);
+void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
+                                           uintptr_t ra);
 
 #endif /* TCG_S390X_H */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 57c03cbf58..fa8468f0e1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -307,18 +307,17 @@ static inline void gen_illegal_opcode(DisasContext *s)
     gen_program_exception(s, PGM_OPERATION);
 }
 
-static inline void gen_trap(DisasContext *s)
+static inline void gen_data_exception(uint8_t dxc)
 {
-    TCGv_i32 t;
-
-    /* Set DXC to 0xff.  */
-    t = tcg_temp_new_i32();
-    tcg_gen_ld_i32(t, cpu_env, offsetof(CPUS390XState, fpc));
-    tcg_gen_ori_i32(t, t, 0xff00);
-    tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, fpc));
-    tcg_temp_free_i32(t);
+    TCGv_i32 tmp = tcg_const_i32(dxc);
+    gen_helper_data_exception(cpu_env, tmp);
+    tcg_temp_free_i32(tmp);
+}
 
-    gen_program_exception(s, PGM_DATA);
+static inline void gen_trap(DisasContext *s)
+{
+    /* Set DXC to 0xff */
+    gen_data_exception(0xff);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.17.1
