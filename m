Received: from eggs.gnu.org ([2001:4830:134:3::10]:47264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPS-0005V0-MD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPR-0001Bm-Kq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:14 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d7kPR-0001Ba-FQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:13 -0400
Received: by mail-qt0-x244.google.com with SMTP id l39so9955978qtb.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 08:17:13 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	r55sm7864331qte.22.2017.05.08.08.17.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 May 2017 08:17:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  8 May 2017 08:17:02 -0700
Message-Id: <20170508151707.5434-2-rth@twiddle.net>
In-Reply-To: <20170508151707.5434-1-rth@twiddle.net>
References: <20170508151707.5434-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 1/6] target/s390x: Implement STORE
 FACILITIES LIST EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

At the same time, improve STORE FACILITIES LIST
so that we don't hard-code the list for all cpus.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  2 ++
 target/s390x/insn-data.def |  2 ++
 target/s390x/misc_helper.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 17 ++++++++-------
 4 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9102071..01adb50 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -83,6 +83,8 @@ DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
+DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_2(stfle, i32, env, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 075ff59..b6702da 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -747,6 +747,8 @@
     C(0xe33e, STRV,    RXY_a, Z,   la2, r1_32u, new, m1_32, rev32, 0)
     C(0xe32f, STRVG,   RXY_a, Z,   la2, r1_o, new, m1_64, rev64, 0)
 
+/* STORE FACILITY LIST EXTENDED */
+    C(0xb2b0, STFLE,   S,  SFLE,   0, a2, 0, 0, stfle, 0)
 /* STORE FPC */
     C(0xb29c, STFPC,   S,     Z,   0, a2, new, m2_32, efpc, 0)
 
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index eca8244..5263726 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -678,3 +678,57 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
     }
 }
 #endif
+
+/* The maximum bit defined at the moment is 129.  */
+#define MAX_STFL_WORDS  3
+
+/* Canonicalize the current cpu's features into the 64-bit words required
+   by STFLE.  Return the index-1 of the max word that is non-zero.  */
+static unsigned do_stfle(CPUS390XState *env, uint64_t words[MAX_STFL_WORDS])
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+    const unsigned long *features = cpu->model->features;
+    unsigned max_bit = 0;
+    S390Feat feat;
+
+    memset(words, 0, sizeof(uint64_t) * MAX_STFL_WORDS);
+
+    for (feat = find_first_bit(features, S390_FEAT_MAX);
+         feat < S390_FEAT_MAX;
+         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1)) {
+        const S390FeatDef *def = s390_feat_def(feat);
+        if (def->type == S390_FEAT_TYPE_STFL) {
+            unsigned bit = def->bit;
+            if (bit > max_bit) {
+                max_bit = bit;
+            }
+            assert(bit / 64 < MAX_STFL_WORDS);
+            words[bit / 64] |= 1ULL << (63 - bit % 64);
+        }
+    }
+
+    return max_bit / 64;
+}
+
+void HELPER(stfl)(CPUS390XState *env)
+{
+    uint64_t words[MAX_STFL_WORDS];
+
+    do_stfle(env, words);
+    cpu_stl_data(env, 200, words[0] >> 32);
+}
+
+uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
+{
+    uint64_t words[MAX_STFL_WORDS];
+    unsigned count_m1 = env->regs[0] & 0xff;
+    unsigned max_m1 = do_stfle(env, words);
+    unsigned i;
+
+    for (i = 0; i <= count_m1; ++i) {
+        cpu_stq_data(env, addr + 8 * i, words[i]);
+    }
+
+    env->regs[0] = deposit64(env->regs[0], 0, 8, max_m1);
+    return (count_m1 >= max_m1 ? 0 : 3);
+}
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 01c6217..69940e3 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3628,15 +3628,8 @@ static ExitStatus op_spt(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_stfl(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 f, a;
-    /* We really ought to have more complete indication of facilities
-       that we implement.  Address this when STFLE is implemented.  */
     check_privileged(s);
-    f = tcg_const_i64(0xc0000000);
-    a = tcg_const_i64(200);
-    tcg_gen_qemu_st32(f, a, get_mem_index(s));
-    tcg_temp_free_i64(f);
-    tcg_temp_free_i64(a);
+    gen_helper_stfl(cpu_env);
     return NO_EXIT;
 }
 
@@ -3802,6 +3795,14 @@ static ExitStatus op_sturg(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static ExitStatus op_stfle(DisasContext *s, DisasOps *o)
+{
+    potential_page_fault(s);
+    gen_helper_stfle(cc_op, cpu_env, o->in2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_st8(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st8(o->in1, o->in2, get_mem_index(s));
-- 
2.9.3
