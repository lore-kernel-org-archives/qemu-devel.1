Received: from eggs.gnu.org ([2001:4830:134:3::10]:60542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elzJy-0001iT-CZ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elzJt-0004su-FZ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:50:10 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 14 Feb 2018 16:25:44 +0100
Message-Id: <20180214152544.26925-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/tcg: add various alignment check
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---

With this, all upstream kvm-unit-tests pass under TCG.

 target/s390x/insn-data.def | 14 +++++++-------
 target/s390x/mem_helper.c  | 25 +++++++++++++++++++++++++
 target/s390x/translate.c   |  7 +++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 621e10d615..740de0a6de 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1000,13 +1000,13 @@
     /* ??? Not implemented - is it necessary? */
     C(0xb204, SCK,     S,     Z,   0, 0, 0, 0, 0, 0)
 /* SET CLOCK COMPARATOR */
-    C(0xb206, SCKC,    S,     Z,   0, m2_64, 0, 0, sckc, 0)
+    C(0xb206, SCKC,    S,     Z,   0, a2, 0, 0, sckc, 0)
 /* SET CLOCK PROGRAMMABLE FIELD */
     C(0x0107, SCKPF,   E,     Z,   0, 0, 0, 0, sckpf, 0)
 /* SET CPU TIMER */
-    C(0xb208, SPT,     S,     Z,   0, m2_64, 0, 0, spt, 0)
+    C(0xb208, SPT,     S,     Z,   0, a2, 0, 0, spt, 0)
 /* SET PREFIX */
-    C(0xb210, SPX,     S,     Z,   0, m2_32u, 0, 0, spx, 0)
+    C(0xb210, SPX,     S,     Z,   0, a2, 0, 0, spx, 0)
 /* SET PSW KEY FROM ADDRESS */
     C(0xb20a, SPKA,    S,     Z,   0, a2, 0, 0, spka, 0)
 /* SET STORAGE KEY EXTENDED */
@@ -1021,20 +1021,20 @@
 /* STORE CLOCK EXTENDED */
     C(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0)
 /* STORE CLOCK COMPARATOR */
-    C(0xb207, STCKC,   S,     Z,   la2, 0, new, m1_64, stckc, 0)
+    C(0xb207, STCKC,   S,     Z,   la2, 0, new, 0, stckc, 0)
 /* STORE CONTROL */
     C(0xb600, STCTL,   RS_a,  Z,   0, a2, 0, 0, stctl, 0)
     C(0xeb25, STCTG,   RSY_a, Z,   0, a2, 0, 0, stctg, 0)
 /* STORE CPU ADDRESS */
-    C(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16, stap, 0)
+    C(0xb212, STAP,    S,     Z,   la2, 0, new, 0, stap, 0)
 /* STORE CPU ID */
     C(0xb202, STIDP,   S,     Z,   la2, 0, new, 0, stidp, 0)
 /* STORE CPU TIMER */
-    C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64, stpt, 0)
+    C(0xb209, STPT,    S,     Z,   la2, 0, new, 0, stpt, 0)
 /* STORE FACILITY LIST */
     C(0xb2b1, STFL,    S,     Z,   0, 0, 0, 0, stfl, 0)
 /* STORE PREFIX */
-    C(0xb211, STPX,    S,     Z,   la2, 0, new, m1_32, stpx, 0)
+    C(0xb211, STPX,    S,     Z,   la2, 0, new, 0, stpx, 0)
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
index 5aea3bbca6..d48f87f6ca 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3977,6 +3977,7 @@ static ExitStatus op_stap(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUW | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -4018,6 +4019,7 @@ static ExitStatus op_stcke(DisasContext *s, DisasOps *o)
 static ExitStatus op_sckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEQ | MO_ALIGN);
     gen_helper_sckc(cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -4033,6 +4035,7 @@ static ExitStatus op_stckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stckc(o->out, cpu_env);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -4069,6 +4072,7 @@ static ExitStatus op_stidp(DisasContext *s, DisasOps *o)
 static ExitStatus op_spt(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEQ | MO_ALIGN);
     gen_helper_spt(cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -4084,6 +4088,7 @@ static ExitStatus op_stpt(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stpt(o->out, cpu_env);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -4098,6 +4103,7 @@ static ExitStatus op_stsi(DisasContext *s, DisasOps *o)
 static ExitStatus op_spx(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
+    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_TEUL | MO_ALIGN);
     gen_helper_spx(cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -4232,6 +4238,7 @@ static ExitStatus op_stpx(DisasContext *s, DisasOps *o)
     check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, psa));
     tcg_gen_andi_i64(o->out, o->out, 0x7fffe000);
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUL | MO_ALIGN);
     return NO_EXIT;
 }
 
-- 
2.14.3
