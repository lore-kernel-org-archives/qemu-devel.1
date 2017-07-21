Received: from eggs.gnu.org ([2001:4830:134:3::10]:58779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXUD-0004CQ-C9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXU8-0002aC-Nj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dYXU8-0002ZC-Di
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:48 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 21 Jul 2017 14:56:09 +0200
Message-Id: <20170721125609.11117-7-david@redhat.com>
In-Reply-To: <20170721125609.11117-1-david@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/6] target/s390x: various alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Let's add proper alignment checks for a handful of instructions that
require a SPECIFICATION exception in case alignment is violated.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 14 +++++++-------
 target/s390x/mem_helper.c  | 35 +++++++++++++++++++++++++++++++++++
 target/s390x/misc_helper.c |  8 +++++++-
 target/s390x/translate.c   |  7 +++++++
 4 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d09f2ed..7ba7304 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -998,11 +998,11 @@
     /* ??? Not implemented - is it necessary? */
     C(0xb204, SCK,     S,     Z,   0, 0, 0, 0, 0, 0)
 /* SET CLOCK COMPARATOR */
-    C(0xb206, SCKC,    S,     Z,   0, m2_64, 0, 0, sckc, 0)
+    C(0xb206, SCKC,    S,     Z,   0, a2, 0, 0, sckc, 0)
 /* SET CPU TIMER */
-    C(0xb208, SPT,     S,     Z,   0, m2_64, 0, 0, spt, 0)
+    C(0xb208, SPT,     S,     Z,   0, a2, 0, 0, spt, 0)
 /* SET PREFIX */
-    C(0xb210, SPX,     S,     Z,   0, m2_32u, 0, 0, spx, 0)
+    C(0xb210, SPX,     S,     Z,   0, a2, 0, 0, spx, 0)
 /* SET PSW KEY FROM ADDRESS */
     C(0xb20a, SPKA,    S,     Z,   0, a2, 0, 0, spka, 0)
 /* SET STORAGE KEY EXTENDED */
@@ -1017,20 +1017,20 @@
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
index 369d291..87bdbba 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -683,8 +683,15 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
 void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
+    CPUState *cs = CPU(s390_env_get_cpu(env));
     int i;
 
+    if (a2 & 0x3) {
+        /* we can come here either by lam or lamy, which have different size */
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         env->aregs[i] = cpu_ldl_data_ra(env, a2, ra);
         a2 += 4;
@@ -699,8 +706,14 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
+    CPUState *cs = CPU(s390_env_get_cpu(env));
     int i;
 
+    if (a2 & 0x3) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         cpu_stl_data_ra(env, a2, env->aregs[i], ra);
         a2 += 4;
@@ -1588,6 +1601,11 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint64_t src = a2;
     uint32_t i;
 
+    if (src & 0x7) {
+        cpu_restore_state(CPU(cpu), ra);
+        program_interrupt(env, PGM_SPECIFICATION, 6);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         uint64_t val = cpu_ldq_data_ra(env, src, ra);
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
@@ -1618,6 +1636,11 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     uint64_t src = a2;
     uint32_t i;
 
+    if (src & 0x3) {
+        cpu_restore_state(CPU(cpu), ra);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         uint32_t val = cpu_ldl_data_ra(env, src, ra);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
@@ -1642,9 +1665,15 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
+    CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t dest = a2;
     uint32_t i;
 
+    if (dest & 0x7) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIFICATION, 6);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         cpu_stq_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint64_t);
@@ -1658,9 +1687,15 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
     uintptr_t ra = GETPC();
+    CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t dest = a2;
     uint32_t i;
 
+    if (dest & 0x3) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+    }
+
     for (i = r1;; i = (i + 1) % 16) {
         cpu_stl_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint32_t);
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 2ec49c9..a8694da 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -391,7 +391,9 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
     sel1 = r0 & STSI_R0_SEL1_MASK;
     sel2 = r1 & STSI_R1_SEL2_MASK;
 
-    /* XXX: spec exception if sysib is not 4k-aligned */
+    if (a0 & 0xfff) {
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+    }
 
     switch (r0 & STSI_LEVEL_MASK) {
     case STSI_LEVEL_1:
@@ -728,6 +730,10 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
     unsigned max_m1 = do_stfle(env, words);
     unsigned i;
 
+    if (addr & 0x7) {
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+    }
+
     for (i = 0; i <= count_m1; ++i) {
         cpu_stq_data(env, addr + 8 * i, words[i]);
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 2d975b4..36d13a6 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3953,6 +3953,7 @@ static ExitStatus op_stap(DisasContext *s, DisasOps *o)
        version of this stored more than the required half-word, so it
        is unlikely this has ever been tested.  */
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, cpu_num));
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUW | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -3989,6 +3990,7 @@ static ExitStatus op_stcke(DisasContext *s, DisasOps *o)
 static ExitStatus op_sckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEQ | MO_ALIGN);
     gen_helper_sckc(cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -3997,6 +3999,7 @@ static ExitStatus op_stckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stckc(o->out, cpu_env);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -4033,6 +4036,7 @@ static ExitStatus op_stidp(DisasContext *s, DisasOps *o)
 static ExitStatus op_spt(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEQ | MO_ALIGN);
     gen_helper_spt(cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -4048,6 +4052,7 @@ static ExitStatus op_stpt(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     gen_helper_stpt(o->out, cpu_env);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     return NO_EXIT;
 }
 
@@ -4063,6 +4068,7 @@ static ExitStatus op_stsi(DisasContext *s, DisasOps *o)
 static ExitStatus op_spx(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
+    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_TEUL | MO_ALIGN);
     gen_helper_spx(cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -4162,6 +4168,7 @@ static ExitStatus op_stpx(DisasContext *s, DisasOps *o)
     check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, psa));
     tcg_gen_andi_i64(o->out, o->out, 0x7fffe000);
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUL | MO_ALIGN);
     return NO_EXIT;
 }
 
-- 
2.9.4
