Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAX-0001Em-DO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAW-000429-9v
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:21 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KAW-00041I-6L
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:20 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so9824539qka.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:40:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 May 2017 16:40:04 -0700
Message-Id: <20170512234009.32557-5-rth@twiddle.net>
In-Reply-To: <20170512234009.32557-1-rth@twiddle.net>
References: <20170512234009.32557-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 4/9] target/s390x: Implement LOAD PAIR DISJOINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Eric Bischoff <ebischoff@nerim.net>

From: Eric Bischoff <ebischoff@nerim.net>

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Eric Bischoff <ebischoff@nerim.net>
Message-Id: <20170228120134.7921-1-ebischoff@suse.com>
[rth: Combine the two via insn->data; free the address temps.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def |  4 +++-
 target/s390x/translate.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 43c5707..0909060 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -504,7 +504,9 @@
     C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
     C(0xebf2, LOC,     RSY_b, LOC, r1, m2_32u, new, r1_32, loc, 0)
     C(0xebe2, LOCG,    RSY_b, LOC, r1, m2_64, r1, 0, loc, 0)
-/* LOAD PAIR DISJOINT TODO */
+/* LOAD PAIR DISJOINT */
+    D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
+    D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_TEQ)
 /* LOAD POSITIVE */
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 2b66a4e..522a5e3 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2559,6 +2559,7 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(r3);
     return NO_EXIT;
 }
+
 static ExitStatus op_lra(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
@@ -2759,6 +2760,31 @@ static ExitStatus op_lm64(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 a1, a2;
+    TCGMemOp mop = s->insn->data;
+
+    /* In a parallel context, stop the world and single step.  */
+    if (parallel_cpus) {
+        potential_page_fault(s);
+        gen_exception(EXCP_ATOMIC);
+        return EXIT_NORETURN;
+    }
+
+    /* In a serial context, perform the two loads ... */
+    a1 = get_address(s, 0, get_field(s->fields, b1), get_field(s->fields, d1));
+    a2 = get_address(s, 0, get_field(s->fields, b2), get_field(s->fields, d2));
+    tcg_gen_qemu_ld_i64(o->out, a1, get_mem_index(s), mop | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->out2, a2, get_mem_index(s), mop | MO_ALIGN);
+    tcg_temp_free_i64(a1);
+    tcg_temp_free_i64(a2);
+
+    /* ... and indicate that we performed them while interlocked.  */
+    gen_op_movi_cc(s, 0);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 {
@@ -4430,6 +4456,22 @@ static void wout_r1_D32(DisasContext *s, DisasFields *f, DisasOps *o)
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
2.9.3
