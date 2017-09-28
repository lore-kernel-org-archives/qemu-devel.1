Received: from eggs.gnu.org ([2001:4830:134:3::10]:53743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaR-00059H-L9
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaQ-0003n9-Eo
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfaQ-0003me-6G
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:10 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:37:07 +0200
Message-Id: <20170928203708.9376-30-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 29/30] s390x/tcg: refactor stfl(e) to use
 s390_get_feat_block()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Refactor it to use s390_get_feat_block(). Directly write into the mapped
lowcore with stfl and make sure it is really only compiled if needed.

While at it, add an alignment check for STFLE and avoid
potential_page_fault() by properly restoring the CPU state.

Due to s390_get_feat_block(), we will now also indicate the
"Configuration-z-architectural-mode", which is with new SIGP code the
right thing to do.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 67 ++++++++++++++++++++--------------------------
 target/s390x/translate.c   |  1 -
 2 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 0b3613ea5f..4afd90b969 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -475,66 +475,57 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
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
 
 #ifndef CONFIG_USER_ONLY
 void HELPER(stfl)(CPUS390XState *env)
 {
-    uint64_t words[MAX_STFL_WORDS];
     LowCore *lowcore;
 
     lowcore = cpu_map_lowcore(env);
-    do_stfle(env, words);
-    lowcore->stfl_fac_list = cpu_to_be32(words[0] >> 32);
+    prepare_stfl();
+    memcpy(&lowcore->stfl_fac_list, stfl_bytes, sizeof(lowcore->stfl_fac_list));
     cpu_unmap_lowcore(lowcore);
 }
 #endif
 
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
index 6a2e084f87..6fad20f75d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4143,7 +4143,6 @@ static ExitStatus op_sturg(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_stfle(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_stfle(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.13.5
