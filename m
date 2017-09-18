Received: from eggs.gnu.org ([2001:4830:134:3::10]:38082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyV0-0007y6-8o
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUx-0008Nj-LO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUx-0008NR-DV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:15 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:12 +0200
Message-Id: <20170918160012.4317-28-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 27/27] s390x/tcg: refactor stfl(e) to use
 s390_get_feat_block()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Refactor it to use s390_get_feat_block(). Directly write into the mapped
lowcore with stfl and make sure it is really only compiled if needed.

While at it, add an alignment check for STFLE and avoid
potential_page_fault() by properly restoring the CPU state.

Due to s390_get_feat_block(), we will now also indicate the
"Configuration-z-architectural-mode", which is with new SIGP code the
right thing to do.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      |  2 +-
 target/s390x/misc_helper.c | 72 ++++++++++++++++++++++------------------------
 target/s390x/translate.c   |  1 -
 3 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a0e4bfb850..a6d94d2d82 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -104,7 +104,6 @@ DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
@@ -152,6 +151,7 @@ DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
+DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_2(xsch, void, env, i64)
 DEF_HELPER_2(csch, void, env, i64)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 1e4d3c8526..4afd90b969 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -475,61 +475,57 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
 }
 #endif
 
-/* The maximum bit defined at the moment is 129.  */
-#define MAX_STFL_WORDS  3
+static uint8_t stfl_bytes[2048];
+static unsigned int used_stfl_bytes;
 
-/* Canonicalize the current cpu's features into the 64-bit words required
-   by STFLE.  Return the index-1 of the max word that is non-zero.  */
-static unsigned do_stfle(CPUS390XState *env, uint64_t words[MAX_STFL_WORDS])
+static void prepare_stfl(void)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-    const unsigned long *features = cpu->model->features;
-    unsigned max_bit = 0;
-    S390Feat feat;
-
-    memset(words, 0, sizeof(uint64_t) * MAX_STFL_WORDS);
+    static bool initialized;
+    int i;
 
-    if (test_bit(S390_FEAT_ZARCH, features)) {
-        /* z/Architecture is always active if around */
-        words[0] = 1ull << (63 - 2);
+    /* racy, but we don't care, the same values are always written */
+    if (initialized) {
+        return;
     }
 
-    for (feat = find_first_bit(features, S390_FEAT_MAX);
-         feat < S390_FEAT_MAX;
-         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1)) {
-        const S390FeatDef *def = s390_feat_def(feat);
-        if (def->type == S390_FEAT_TYPE_STFL) {
-            unsigned bit = def->bit;
-            if (bit > max_bit) {
-                max_bit = bit;
-            }
-            assert(bit / 64 < MAX_STFL_WORDS);
-            words[bit / 64] |= 1ULL << (63 - bit % 64);
+    s390_get_feat_block(S390_FEAT_TYPE_STFL, stfl_bytes);
+    for (i = 0; i < sizeof(stfl_bytes); i++) {
+        if (stfl_bytes[i]) {
+            used_stfl_bytes = i + 1;
         }
     }
-
-    return max_bit / 64;
+    initialized = true;
 }
 
+#ifndef CONFIG_USER_ONLY
 void HELPER(stfl)(CPUS390XState *env)
 {
-    uint64_t words[MAX_STFL_WORDS];
+    LowCore *lowcore;
 
-    do_stfle(env, words);
-    cpu_stl_data(env, 200, words[0] >> 32);
+    lowcore = cpu_map_lowcore(env);
+    prepare_stfl();
+    memcpy(&lowcore->stfl_fac_list, stfl_bytes, sizeof(lowcore->stfl_fac_list));
+    cpu_unmap_lowcore(lowcore);
 }
+#endif
 
 uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
 {
-    uint64_t words[MAX_STFL_WORDS];
-    unsigned count_m1 = env->regs[0] & 0xff;
-    unsigned max_m1 = do_stfle(env, words);
-    unsigned i;
+    const uintptr_t ra = GETPC();
+    const int count_bytes = ((env->regs[0] & 0xff) + 1) * 8;
+    const int max_bytes = ROUND_UP(used_stfl_bytes, 8);
+    int i;
+
+    if (addr & 0x7) {
+        cpu_restore_state(ENV_GET_CPU(env), ra);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+    }
 
-    for (i = 0; i <= count_m1; ++i) {
-        cpu_stq_data(env, addr + 8 * i, words[i]);
+    prepare_stfl();
+    for (i = 0; i < count_bytes; ++i) {
+        cpu_stb_data_ra(env, addr + i, stfl_bytes[i], ra);
     }
 
-    env->regs[0] = deposit64(env->regs[0], 0, 8, max_m1);
-    return (count_m1 >= max_m1 ? 0 : 3);
+    env->regs[0] = deposit64(env->regs[0], 0, 8, (max_bytes / 8) - 1);
+    return count_bytes >= max_bytes ? 0 : 3;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index abf2feb7aa..0e05942fe9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4082,7 +4082,6 @@ static ExitStatus op_sturg(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_stfle(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_stfle(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.13.5
