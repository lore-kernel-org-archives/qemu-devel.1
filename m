Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSoMt-0007j0-AT
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSoMo-00083y-SN
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:27 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSoMo-00083L-Mf
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:22 -0500
Received: by mail-pg1-x531.google.com with SMTP id 80so2907734pge.4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:22:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 11:22:16 -0800
Message-Id: <20181130192216.26987-3-richard.henderson@linaro.org>
In-Reply-To: <20181130192216.26987-1-richard.henderson@linaro.org>
References: <20181130192216.26987-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 2/2] target/s390x: Implement STCK et al
 for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, david@redhat.com, qemu-s390x@nongnu.org

This is a non-privileged instruction that was only implemented
for system mode.  However, the stck instruction is used by glibc,
so this was causing SIGILL for programs run under debian stretch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h      |  2 +-
 target/s390x/misc_helper.c | 13 ++++++++++++-
 target/s390x/translate.c   |  2 ++
 target/s390x/insn-data.def | 11 ++++++-----
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 018e9dd414..6260b50496 100644
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
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 3f91579570..c2940afecb 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -76,8 +76,19 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+/* Store Clock */
+uint64_t HELPER(stck)(CPUS390XState *env)
+{
+    struct timespec ts;
+    uint64_t ms;
 
+    clock_gettime(CLOCK_REALTIME, &ts);
+    ms = (ts.tv_nsec / 1000) + (ts.tv_sec * 100000ull);
+
+    return TOD_UNIX_EPOCH + ms;
+}
+#else
 /* SCLP service call */
 uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b5bd56b7ee..8bb9c0529a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4010,6 +4010,7 @@ static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
     return DISAS_NEXT;
 }
+#endif
 
 static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
 {
@@ -4046,6 +4047,7 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+#ifndef CONFIG_USER_ONLY
 static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 54e39df831..922227bada 100644
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
-- 
2.17.2
