Received: from eggs.gnu.org ([2001:4830:134:3::10]:59516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cigTV-0002Xf-7k
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cigTR-0003mt-BD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:01:49 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:40722 helo=tegan.suse.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cigTR-0003mg-5j
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:01:45 -0500
From: Eric Bischoff <ebischoff@suse.com>
Date: Tue, 28 Feb 2017 13:01:34 +0100
Message-Id: <20170228120134.7921-1-ebischoff@suse.com>
Subject: [Qemu-devel] [PATCH] Adding support for LPD and LPDG instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Michal Marek <mmarek@suse.cz>, Miroslav Benes <mbenes@suse.cz>, QEmu developers <qemu-devel@nongnu.org>, Eric Bischoff <ebischoff@nerim.net>

From: Eric Bischoff <ebischoff@nerim.net>

LPD = LOAD PAIR DISJOINT
Fourth patch
---
 target/s390x/insn-data.def |  4 ++-
 target/s390x/translate.c   | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 075ff59..72d1017 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -504,7 +504,9 @@
     C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
     C(0xebf2, LOC,     RSY_b, LOC, r1, m2_32u, new, r1_32, loc, 0)
     C(0xebe2, LOCG,    RSY_b, LOC, r1, m2_64, r1, 0, loc, 0)
-/* LOAD PAIR DISJOINT TODO */
+/* LOAD PAIR DISJOINT */
+    C(0xc804, LPD,     SSF,   ILA, 0, 0, 0, r3_P32, lpd32, 0)
+    C(0xc805, LPDG,    SSF,   ILA, 0, 0, 0, r3_P64, lpd64, 0)
 /* LOAD POSITIVE */
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 01c6217..239d12b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2558,6 +2558,7 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r3);
     return NO_EXIT;
 }
+
 static ExitStatus op_lra(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
@@ -2750,6 +2751,52 @@ static ExitStatus op_lm64(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_lpd32(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 a1, a2;
+
+    /* In a parallel context, stop the world and single step.  */
+    if (parallel_cpus) {
+        potential_page_fault(s);
+        gen_helper_exit_atomic(cpu_env);
+        return EXIT_NORETURN;
+    }
+
+    /* In a serial context, perform the two loads and indicate
+       that we performed them while interlocked.  */
+    a1 = get_address(s, 0, get_field(s->fields, b1), get_field(s->fields, d1));
+    a2 = get_address(s, 0, get_field(s->fields, b2), get_field(s->fields, d2));
+    o->out = tcg_temp_new_i64();
+    tcg_gen_qemu_ld32s(o->out, a1, get_mem_index(s));
+    o->out2 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld32s(o->out2, a2, get_mem_index(s));
+    gen_op_movi_cc(s, 0);
+    return NO_EXIT;
+}
+
+static ExitStatus op_lpd64(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 a1, a2;
+
+    /* In a parallel context, stop the world and single step.  */
+    if (parallel_cpus) {
+        potential_page_fault(s);
+        gen_helper_exit_atomic(cpu_env);
+        return EXIT_NORETURN;
+    }
+
+    /* In a serial context, perform the two loads and indicate
+       that we performed them while interlocked.  */
+    a1 = get_address(s, 0, get_field(s->fields, b1), get_field(s->fields, d1));
+    a2 = get_address(s, 0, get_field(s->fields, b2), get_field(s->fields, d2));
+    o->out = tcg_temp_new_i64();
+    tcg_gen_qemu_ld64(o->out, a1, get_mem_index(s));
+    o->out2 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld64(o->out2, a2, get_mem_index(s));
+    gen_op_movi_cc(s, 0);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 {
@@ -4420,6 +4467,22 @@ static void wout_r1_D32(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_wout_r1_D32 SPEC_r1_even
 
+static void wout_r3_P32(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    int r3 = get_field(f, r3);
+    store_reg32_i64(r3, o->out);
+    store_reg32_i64(r3 + 1, o->out2);
+}
+#define SPEC_wout_r3_P32 SPEC_r3_even
+
+static void wout_r3_P64(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    int r3 = get_field(f, r3);
+    store_reg(r3, o->out);
+    store_reg(r3 + 1, o->out2);
+}
+#define SPEC_wout_r3_P64 SPEC_r3_even
+
 static void wout_e1(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     store_freg32_i64(get_field(f, r1), o->out);
-- 
2.10.2
