Received: from eggs.gnu.org ([209.51.188.92]:52317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqH-0006sh-EV
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqG-0006jl-AJ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:09 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:47 +0100
Message-Id: <20190218111153.22681-5-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/10] target/s390x: Implement STCK et al for
 CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck <cohuck@redhat.com>

From: Richard Henderson <richard.henderson@linaro.org>

This is a non-privileged instruction that was only implemented
for system mode.  However, the stck instruction is used by glibc,
so this was causing SIGILL for programs run under debian stretch.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190212053044.29015-3-richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h      |  2 +-
 target/s390x/insn-data.def | 11 ++++++-----
 target/s390x/misc_helper.c | 34 ++++++++++++++++++++++------------
 target/s390x/translate.c   |  2 ++
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 018e9dd41487..6260b5049621 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -121,13 +121,13 @@ DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
 DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
+DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
 DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
 DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
-DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
 DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
 DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index dab805fd90b4..61582372abb7 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -837,6 +837,12 @@
     C(0xe33e, STRV,    RXY_a, Z,   la2, r1_32u, new, m1_32, rev32, 0)
     C(0xe32f, STRVG,   RXY_a, Z,   la2, r1_o, new, m1_64, rev64, 0)
 
+/* STORE CLOCK */
+    C(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0)
+    C(0xb27c, STCKF,   S,     SCF, la2, 0, new, m1_64, stck, 0)
+/* STORE CLOCK EXTENDED */
+    C(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0)
+
 /* STORE FACILITY LIST EXTENDED */
     C(0xb2b0, STFLE,   S,  SFLE,   0, a2, 0, 0, stfle, 0)
 /* STORE FPC */
@@ -1020,11 +1026,6 @@
     F(0x8000, SSM,     S,     Z,   0, m2_8u, 0, 0, ssm, 0, IF_PRIV)
 /* SIGNAL PROCESSOR */
     F(0xae00, SIGP,    RS_a,  Z,   0, a2, 0, 0, sigp, 0, IF_PRIV)
-/* STORE CLOCK */
-    C(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0)
-    C(0xb27c, STCKF,   S,     SCF, la2, 0, new, m1_64, stck, 0)
-/* STORE CLOCK EXTENDED */
-    C(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0)
 /* STORE CLOCK COMPARATOR */
     F(0xb207, STCKC,   S,     Z,   la2, 0, new, m1_64a, stckc, 0, IF_PRIV)
 /* STORE CONTROL */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 52262f62df26..ee67c1fa0c51 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -30,6 +30,7 @@
 #include "exec/cpu_ldst.h"
 #include "qapi/error.h"
 #include "tcg_s390x.h"
+#include "s390-tod.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "sysemu/cpus.h"
@@ -76,8 +77,28 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+/* Store Clock */
+uint64_t HELPER(stck)(CPUS390XState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    struct timespec ts;
+    uint64_t ns;
+
+    clock_gettime(CLOCK_REALTIME, &ts);
+    ns = ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
+
+    return TOD_UNIX_EPOCH + time2tod(ns);
+#else
+    S390TODState *td = s390_get_todstate();
+    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
+    S390TOD tod;
 
+    tdc->get(td, &tod, &error_abort);
+    return tod.low;
+#endif
+}
+
+#ifndef CONFIG_USER_ONLY
 /* SCLP service call */
 uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
@@ -138,17 +159,6 @@ void HELPER(spx)(CPUS390XState *env, uint64_t a1)
     tlb_flush_page(cs, TARGET_PAGE_SIZE);
 }
 
-/* Store Clock */
-uint64_t HELPER(stck)(CPUS390XState *env)
-{
-    S390TODState *td = s390_get_todstate();
-    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
-    S390TOD tod;
-
-    tdc->get(td, &tod, &error_abort);
-    return tod.low;
-}
-
 static void update_ckc_timer(CPUS390XState *env)
 {
     S390TODState *td = s390_get_todstate();
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 639084af07d0..19072efec655 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4060,6 +4060,7 @@ static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
     return DISAS_NEXT;
 }
+#endif
 
 static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
 {
@@ -4096,6 +4097,7 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+#ifndef CONFIG_USER_ONLY
 static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
-- 
2.17.2
