Received: from eggs.gnu.org ([2001:4830:134:3::10]:57568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNo5-0001Ao-Sp
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNo4-0005uC-9w
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:59:33 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 13:58:21 +0100
Message-Id: <20180301125830.24377-19-cohuck@redhat.com>
In-Reply-To: <20180301125830.24377-1-cohuck@redhat.com>
References: <20180301125830.24377-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 18/27] s390x/tcg: add various alignment checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's add proper alignment checks for a handful of instructions that
require a SPECIFICATION exception in case alignment is violated.

Introduce new wout/in functions. As we are right now only using them for
privileged instructions, we have to add ugly ifdefs to silence
compilers.

Convert STORE CPU ID right away to make use of the wout function.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180215103822.15179-1-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def | 16 ++++++++--------
 target/s390x/mem_helper.c  | 25 +++++++++++++++++++++++++
 target/s390x/translate.c   | 43 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 621e10d615..157619403d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1000,13 +1000,13 @@
     /* ??? Not implemented - is it necessary? */
     C(0xb204, SCK,     S,     Z,   0, 0, 0, 0, 0, 0)
 /* SET CLOCK COMPARATOR */
-    C(0xb206, SCKC,    S,     Z,   0, m2_64, 0, 0, sckc, 0)
+    C(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0)
 /* SET CLOCK PROGRAMMABLE FIELD */
     C(0x0107, SCKPF,   E,     Z,   0, 0, 0, 0, sckpf, 0)
 /* SET CPU TIMER */
-    C(0xb208, SPT,     S,     Z,   0, m2_64, 0, 0, spt, 0)
+    C(0xb208, SPT,     S,     Z,   0, m2_64a, 0, 0, spt, 0)
 /* SET PREFIX */
-    C(0xb210, SPX,     S,     Z,   0, m2_32u, 0, 0, spx, 0)
+    C(0xb210, SPX,     S,     Z,   0, m2_32ua, 0, 0, spx, 0)
 /* SET PSW KEY FROM ADDRESS */
     C(0xb20a, SPKA,    S,     Z,   0, a2, 0, 0, spka, 0)
 /* SET STORAGE KEY EXTENDED */
@@ -1021,20 +1021,20 @@
 /* STORE CLOCK EXTENDED */
     C(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0)
 /* STORE CLOCK COMPARATOR */
-    C(0xb207, STCKC,   S,     Z,   la2, 0, new, m1_64, stckc, 0)
+    C(0xb207, STCKC,   S,     Z,   la2, 0, new, m1_64a, stckc, 0)
 /* STORE CONTROL */
     C(0xb600, STCTL,   RS_a,  Z,   0, a2, 0, 0, stctl, 0)
     C(0xeb25, STCTG,   RSY_a, Z,   0, a2, 0, 0, stctg, 0)
 /* STORE CPU ADDRESS */
-    C(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16, stap, 0)
+    C(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16a, stap, 0)
 /* STORE CPU ID */
-    C(0xb202, STIDP,   S,     Z,   la2, 0, new, 0, stidp, 0)
+    C(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64a, stidp, 0)
 /* STORE CPU TIMER */
-    C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64, stpt, 0)
+    C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64a, stpt, 0)
 /* STORE FACILITY LIST */
     C(0xb2b1, STFL,    S,     Z,   0, 0, 0, 0, stfl, 0)
 /* STORE PREFIX */
-    C(0xb211, STPX,    S,     Z,   la2, 0, new, m1_32, stpx, 0)
+    C(0xb211, STPX,    S,     Z,   la2, 0, new, m1_32a, stpx, 0)
 /* STORE SYSTEM INFORMATION */
     C(0xb27d, STSI,    S,     Z,   0, a2, 0, 0, stsi, 0)
 /* STORE THEN AND SYSTEM MASK */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 427b795a78..d5291b246e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -693,6 +693,11 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uintptr_t ra = GETPC();
     int i;
 
+    if (a2 & 0x3) {
+        /* we either came here by lam or lamy, which have different lengths */
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         env->aregs[i] = cpu_ldl_data_ra(env, a2, ra);
         a2 += 4;
@@ -709,6 +714,10 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uintptr_t ra = GETPC();
     int i;
 
+    if (a2 & 0x3) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         cpu_stl_data_ra(env, a2, env->aregs[i], ra);
         a2 += 4;
@@ -1620,6 +1629,10 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint64_t src = a2;
     uint32_t i;
 
+    if (src & 0x7) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         uint64_t val = cpu_ldq_data_ra(env, src, ra);
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
@@ -1650,6 +1663,10 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint64_t src = a2;
     uint32_t i;
 
+    if (src & 0x3) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         uint32_t val = cpu_ldl_data_ra(env, src, ra);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
@@ -1677,6 +1694,10 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint64_t dest = a2;
     uint32_t i;
 
+    if (dest & 0x7) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         cpu_stq_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint64_t);
@@ -1693,6 +1714,10 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint64_t dest = a2;
     uint32_t i;
 
+    if (dest & 0x3) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         cpu_stl_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint32_t);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5aea3bbca6..7d39ab350d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4062,7 +4062,6 @@ static ExitStatus op_stidp(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, cpuid));
-    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -5220,18 +5219,42 @@ static void wout_m1_16(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_wout_m1_16 0
 
+#ifndef CONFIG_USER_ONLY
+static void wout_m1_16a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUW | MO_ALIGN);
+}
+#define SPEC_wout_m1_16a 0
+#endif
+
 static void wout_m1_32(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     tcg_gen_qemu_st32(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_32 0
 
+#ifndef CONFIG_USER_ONLY
+static void wout_m1_32a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUL | MO_ALIGN);
+}
+#define SPEC_wout_m1_32a 0
+#endif
+
 static void wout_m1_64(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     tcg_gen_qemu_st64(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_64 0
 
+#ifndef CONFIG_USER_ONLY
+static void wout_m1_64a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
+}
+#define SPEC_wout_m1_64a 0
+#endif
+
 static void wout_m2_32(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     tcg_gen_qemu_st32(o->out, o->in2, get_mem_index(s));
@@ -5657,6 +5680,15 @@ static void in2_m2_32u(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in2_m2_32u 0
 
+#ifndef CONFIG_USER_ONLY
+static void in2_m2_32ua(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    in2_a2(s, f, o);
+    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_TEUL | MO_ALIGN);
+}
+#define SPEC_in2_m2_32ua 0
+#endif
+
 static void in2_m2_64(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     in2_a2(s, f, o);
@@ -5664,6 +5696,15 @@ static void in2_m2_64(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in2_m2_64 0
 
+#ifndef CONFIG_USER_ONLY
+static void in2_m2_64a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    in2_a2(s, f, o);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEQ | MO_ALIGN);
+}
+#define SPEC_in2_m2_64a 0
+#endif
+
 static void in2_mri2_16u(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     in2_ri2(s, f, o);
-- 
2.13.6
