Received: from eggs.gnu.org ([2001:4830:134:3::10]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsOAX-0001r4-Nd
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsO1e-0000zF-Mj
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:57:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 22 Aug 2018 09:57:43 +0200
Message-Id: <20180822075750.12399-2-david@redhat.com>
In-Reply-To: <20180822075750.12399-1-david@redhat.com>
References: <20180822075750.12399-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/8] s390x/tcg: factor out and fix DATA
 exception injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

The DXC is to be stored in the low core, and only in the FPC in case AFP
is enabled in CR0.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  1 +
 target/s390x/excp_helper.c | 28 ++++++++++++++++++++++++++++
 target/s390x/fpu_helper.c  | 13 +++----------
 target/s390x/helper.h      |  1 +
 target/s390x/tcg_s390x.h   |  2 ++
 target/s390x/translate.c   | 19 +++++++++----------
 6 files changed, 44 insertions(+), 20 deletions(-)

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
index f0ce60cff2..f5cab94ec5 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -21,11 +21,13 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "exec/helper-proto.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "hw/s390x/ioinst.h"
 #include "exec/address-spaces.h"
+#include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #include "hw/s390x/s390_flic.h"
@@ -48,6 +50,32 @@
     do { } while (0)
 #endif
 
+void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
+                                           uintptr_t ra)
+{
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+
+    g_assert(!(dxc & ~0xff));
+#if !defined(CONFIG_USER_ONLY)
+    /* Store the DXC into the lowcore */
+    stw_phys(cs->as, env->psa + offsetof(LowCore, data_exc_code), dxc);
+#endif
+
+    /* Store the DXC into the FPC if AFP is enabled */
+    if (env->cregs[0] & CR0_AFP) {
+        env->fpc = (env->fpc & ~0xff00) | (dxc << 8);
+    }
+    s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
+
+    /* the following is not necessary, but allows us to use noreturn */
+    cpu_loop_exit_restore(cs, ra);
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
diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index 4e308aa0ce..f2c88d7402 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -14,5 +14,7 @@
 #define TCG_S390X_H
 
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
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
