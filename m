Received: from eggs.gnu.org ([2001:4830:134:3::10]:39861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1em0ti-00033F-CS
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1em0te-0001Vp-A0
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:31:10 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 14 Feb 2018 18:31:02 +0100
Message-Id: <20180214173102.9363-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2] s390x/tcg: add various alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

Let's add proper alignment checks for a handful of instructions that
require a SPECIFICATION exception in case alignment is violated.

Introduce new wout/in functions. Declare them as "static inline" to avoid
warnings about not being used for CONFIG_USER_ONLY (as we are right
now only using them for privileged instructions).

Convert STORE CPU ID right away to make use of the wout function.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 16 ++++++++--------
 target/s390x/mem_helper.c  | 25 +++++++++++++++++++++++++
 target/s390x/translate.c   | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 9 deletions(-)

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
index 5aea3bbca6..4ea4e195bb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4062,7 +4062,6 @@ static ExitStatus op_stidp(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, cpuid));
-    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -5220,18 +5219,36 @@ static void wout_m1_16(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_wout_m1_16 0
 
+static inline void wout_m1_16a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUW | MO_ALIGN);
+}
+#define SPEC_wout_m1_16a 0
+
 static void wout_m1_32(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     tcg_gen_qemu_st32(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_32 0
 
+static inline void wout_m1_32a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUL | MO_ALIGN);
+}
+#define SPEC_wout_m1_32a 0
+
 static void wout_m1_64(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     tcg_gen_qemu_st64(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_64 0
 
+static inline void wout_m1_64a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
+}
+#define SPEC_wout_m1_64a 0
+
 static void wout_m2_32(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     tcg_gen_qemu_st32(o->out, o->in2, get_mem_index(s));
@@ -5657,6 +5674,13 @@ static void in2_m2_32u(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in2_m2_32u 0
 
+static inline void in2_m2_32ua(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    in2_a2(s, f, o);
+    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_TEUL | MO_ALIGN);
+}
+#define SPEC_in2_m2_32ua 0
+
 static void in2_m2_64(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     in2_a2(s, f, o);
@@ -5664,6 +5688,13 @@ static void in2_m2_64(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in2_m2_64 0
 
+static inline void in2_m2_64a(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    in2_a2(s, f, o);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEQ | MO_ALIGN);
+}
+#define SPEC_in2_m2_64a 0
+
 static void in2_mri2_16u(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     in2_ri2(s, f, o);
-- 
2.14.3
