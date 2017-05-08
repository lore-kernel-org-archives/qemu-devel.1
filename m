Received: from eggs.gnu.org ([2001:4830:134:3::10]:47355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPe-0005gW-7U
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPd-0001H4-0M
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:26 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d7kPc-0001GN-Rr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so9959499qta.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 08:17:24 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	r55sm7864331qte.22.2017.05.08.08.17.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 May 2017 08:17:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  8 May 2017 08:17:07 -0700
Message-Id: <20170508151707.5434-7-rth@twiddle.net>
In-Reply-To: <20170508151707.5434-1-rth@twiddle.net>
References: <20170508151707.5434-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 6/6] target/s390x: Use atomic operations for
 LOAD AND OP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def | 20 ++++++------
 target/s390x/translate.c   | 78 +++++++++++++++++++++++++++++-----------------
 2 files changed, 60 insertions(+), 38 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0909060..09cfb41 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -390,20 +390,20 @@
 /* LOAD ADDRESS RELATIVE LONG */
     C(0xc000, LARL,    RIL_b, Z,   0, ri2, 0, r1, mov2, 0)
 /* LOAD AND ADD */
-    C(0xebf8, LAA,     RSY_a, ILA, r3_32s, m2_32s_atomic, new, m2_32_r1_atomic, add, adds32)
-    C(0xebe8, LAAG,    RSY_a, ILA, r3, m2_64_atomic, new, m2_64_r1_atomic, add, adds64)
+    D(0xebf8, LAA,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, laa, adds32, MO_TESL)
+    D(0xebe8, LAAG,    RSY_a, ILA, r3, a2, new, in2_r1, laa, adds64, MO_TEQ)
 /* LOAD AND ADD LOGICAL */
-    C(0xebfa, LAAL,    RSY_a, ILA, r3_32s, m2_32s_atomic, new, m2_32_r1_atomic, add, addu32)
-    C(0xebea, LAALG,   RSY_a, ILA, r3, m2_64_atomic, new, m2_64_r1_atomic, add, addu64)
+    D(0xebfa, LAAL,    RSY_a, ILA, r3_32u, a2, new, in2_r1_32, laa, addu32, MO_TEUL)
+    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa, addu64, MO_TEQ)
 /* LOAD AND AND */
-    C(0xebf4, LAN,     RSY_a, ILA, r3_32s, m2_32s_atomic, new, m2_32_r1_atomic, and, nz32)
-    C(0xebe4, LANG,    RSY_a, ILA, r3, m2_64_atomic, new, m2_64_r1_atomic, and, nz64)
+    D(0xebf4, LAN,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lan, nz32, MO_TESL)
+    D(0xebe4, LANG,    RSY_a, ILA, r3, a2, new, in2_r1, lan, nz64, MO_TEQ)
 /* LOAD AND EXCLUSIVE OR */
-    C(0xebf7, LAX,     RSY_a, ILA, r3_32s, m2_32s_atomic, new, m2_32_r1_atomic, xor, nz32)
-    C(0xebe7, LAXG,    RSY_a, ILA, r3, m2_64_atomic, new, m2_64_r1_atomic, xor, nz64)
+    D(0xebf7, LAX,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lax, nz32, MO_TESL)
+    D(0xebe7, LAXG,    RSY_a, ILA, r3, a2, new, in2_r1, lax, nz64, MO_TEQ)
 /* LOAD AND OR */
-    C(0xebf6, LAO,     RSY_a, ILA, r3_32s, m2_32s_atomic, new, m2_32_r1_atomic, or, nz32)
-    C(0xebe6, LAOG,    RSY_a, ILA, r3, m2_64_atomic, new, m2_64_r1_atomic, or, nz64)
+    D(0xebf6, LAO,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lao, nz32, MO_TESL)
+    D(0xebe6, LAOG,    RSY_a, ILA, r3, a2, new, in2_r1, lao, nz64, MO_TEQ)
 /* LOAD AND TEST */
     C(0x1200, LTR,     RR_a,  Z,   0, r2_o, 0, cond_r1r2_32, mov2, s32)
     C(0xb902, LTGR,    RRE,   Z,   0, r2_o, 0, r1, mov2, s64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 414378c..1ad46f4 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2311,6 +2311,50 @@ static ExitStatus op_iske(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static ExitStatus op_laa(DisasContext *s, DisasOps *o)
+{
+    /* The real output is indeed the original value in memory;
+       recompute the addition for the computation of CC.  */
+    tcg_gen_atomic_fetch_add_i64(o->in2, o->in2, o->in1, get_mem_index(s),
+                                 s->insn->data | MO_ALIGN);
+    /* However, we need to recompute the addition for setting CC.  */
+    tcg_gen_add_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
+static ExitStatus op_lan(DisasContext *s, DisasOps *o)
+{
+    /* The real output is indeed the original value in memory;
+       recompute the addition for the computation of CC.  */
+    tcg_gen_atomic_fetch_and_i64(o->in2, o->in2, o->in1, get_mem_index(s),
+                                 s->insn->data | MO_ALIGN);
+    /* However, we need to recompute the operation for setting CC.  */
+    tcg_gen_and_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
+static ExitStatus op_lao(DisasContext *s, DisasOps *o)
+{
+    /* The real output is indeed the original value in memory;
+       recompute the addition for the computation of CC.  */
+    tcg_gen_atomic_fetch_or_i64(o->in2, o->in2, o->in1, get_mem_index(s),
+                                s->insn->data | MO_ALIGN);
+    /* However, we need to recompute the operation for setting CC.  */
+    tcg_gen_or_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
+static ExitStatus op_lax(DisasContext *s, DisasOps *o)
+{
+    /* The real output is indeed the original value in memory;
+       recompute the addition for the computation of CC.  */
+    tcg_gen_atomic_fetch_xor_i64(o->in2, o->in2, o->in1, get_mem_index(s),
+                                 s->insn->data | MO_ALIGN);
+    /* However, we need to recompute the operation for setting CC.  */
+    tcg_gen_xor_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
 static ExitStatus op_ldeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_ldeb(o->out, cpu_env, o->in2);
@@ -4485,21 +4529,17 @@ static void wout_m2_32(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_wout_m2_32 0
 
-static void wout_m2_32_r1_atomic(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_in2_r1(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    /* XXX release reservation */
-    tcg_gen_qemu_st32(o->out, o->addr1, get_mem_index(s));
-    store_reg32_i64(get_field(f, r1), o->in2);
+    store_reg(get_field(f, r1), o->in2);
 }
-#define SPEC_wout_m2_32_r1_atomic 0
+#define SPEC_wout_in2_r1 0
 
-static void wout_m2_64_r1_atomic(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_in2_r1_32(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    /* XXX release reservation */
-    tcg_gen_qemu_st64(o->out, o->addr1, get_mem_index(s));
-    store_reg(get_field(f, r1), o->in2);
+    store_reg32_i64(get_field(f, r1), o->in2);
 }
-#define SPEC_wout_m2_64_r1_atomic 0
+#define SPEC_wout_in2_r1_32 0
 
 /* ====================================================================== */
 /* The "INput 1" generators.  These load the first operand to an insn.  */
@@ -4943,24 +4983,6 @@ static void in2_mri2_64(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in2_mri2_64 0
 
-static void in2_m2_32s_atomic(DisasContext *s, DisasFields *f, DisasOps *o)
-{
-    /* XXX should reserve the address */
-    in1_la2(s, f, o);
-    o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld32s(o->in2, o->addr1, get_mem_index(s));
-}
-#define SPEC_in2_m2_32s_atomic 0
-
-static void in2_m2_64_atomic(DisasContext *s, DisasFields *f, DisasOps *o)
-{
-    /* XXX should reserve the address */
-    in1_la2(s, f, o);
-    o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld64(o->in2, o->addr1, get_mem_index(s));
-}
-#define SPEC_in2_m2_64_atomic 0
-
 static void in2_i2(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     o->in2 = tcg_const_i64(get_field(f, i2));
-- 
2.9.3
