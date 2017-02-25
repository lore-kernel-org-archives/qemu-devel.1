Received: from eggs.gnu.org ([2001:4830:134:3::10]:34705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmarek@suse.cz>) id 1chlap-0007YR-ST
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 18:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmarek@suse.cz>) id 1chlam-0006Je-Kg
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 18:17:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mmarek@suse.cz>) id 1chlam-0006J5-BH
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 18:17:32 -0500
From: Michal Marek <mmarek@suse.com>
Date: Sun, 26 Feb 2017 00:16:53 +0100
Message-Id: <20170225231653.14942-1-mmarek@suse.com>
In-Reply-To: <a634716c-c998-c422-6802-946a283f8837@twiddle.net>
References: <a634716c-c998-c422-6802-946a283f8837@twiddle.net>
Subject: [Qemu-devel] [PATCH v2] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

The implementation is partially cargo cult based, but it works for the
linux kernel use case.

Signed-off-by: Michal Marek <mmarek@suse.com>
---
v2:
 - STFLE is not a privileged instruction, go through the MMU to store the
   result
 - annotate the stfl helper with TCG_CALL_NO_RWG
 - Use a large enough buffer to hold the feature bitmap
 - Fix coding style of the stfle helper
---
 target/s390x/cpu_features.c |  6 ++++--
 target/s390x/cpu_features.h |  2 +-
 target/s390x/helper.h       |  2 ++
 target/s390x/insn-data.def  |  2 ++
 target/s390x/misc_helper.c  | 35 +++++++++++++++++++++++++++++++++++
 target/s390x/translate.c    | 17 +++++++++--------
 6 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 42fd9d792bc8..d77c560380c4 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -286,11 +286,11 @@ void s390_init_feat_bitmap(const S390FeatInit init, S390FeatBitmap bitmap)
     }
 }
 
-void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
+int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
                           uint8_t *data)
 {
     S390Feat feat;
-    int bit_nr;
+    int bit_nr, res = 0;
 
     if (type == S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, features)) {
         /* z/Architecture is always active if around */
@@ -303,9 +303,11 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
             bit_nr = s390_features[feat].bit;
             /* big endian on uint8_t array */
             data[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
+            res = MAX(res, bit_nr / 8 + 1);
         }
         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1);
     }
+    return res;
 }
 
 void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index d66912178680..e3c41be08060 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -56,7 +56,7 @@ typedef uint64_t S390FeatInit[S390_FEAT_MAX / 64 + 1];
 const S390FeatDef *s390_feat_def(S390Feat feat);
 S390Feat s390_feat_by_type_and_bit(S390FeatType type, int bit);
 void s390_init_feat_bitmap(const S390FeatInit init, S390FeatBitmap bitmap);
-void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
+int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
                           uint8_t *data);
 void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
                           uint8_t *data);
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9102071d0aa4..fa4a617cd1ab 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -95,6 +95,8 @@ DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
 DEF_HELPER_FLAGS_2(spt, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
 DEF_HELPER_4(stsi, i32, env, i64, i64, i64)
+DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_3(stfle, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 075ff597c3de..be830a42ed8d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -899,6 +899,8 @@
     C(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64, stidp, 0)
 /* STORE CPU TIMER */
     C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64, stpt, 0)
+/* STORE FACILITY LIST EXTENDED */
+    C(0xb2b0, STFLE,   S,  SFLE,   0, a2, 0, 0, stfle, 0)
 /* STORE FACILITY LIST */
     C(0xb2b1, STFL,    S,     Z,   0, 0, 0, 0, stfl, 0)
 /* STORE PREFIX */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index c9604ea9c728..3baee27d40ce 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -500,6 +500,41 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
     return cc;
 }
 
+static int do_stfle(CPUS390XState *env, uint64_t addr, int len)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+    uint8_t data[256 * 8]; /* 256 doublewords as per STFLE documentation */
+    int i, res;
+
+    memset(data, 0, sizeof(data));
+    res = s390_fill_feat_block(cpu->model->features, S390_FEAT_TYPE_STFL, data);
+    for (i = 0; i < MIN(res, len); i++) {
+        cpu_stb_data(env, addr + i, data[i]);
+    }
+
+    return res;
+}
+
+uint64_t HELPER(stfle)(CPUS390XState *env, uint64_t a0, uint64_t r0)
+{
+    int need, len = r0 & 0xff;
+
+    need = do_stfle(env, a0, len * 8);
+    need = DIV_ROUND_UP(need, 8);
+    if (need <= len) {
+        env->cc_op = 0;
+    } else {
+        env->cc_op = 3;
+    }
+
+    return (r0 & ~0xffLL) | (need - 1);
+}
+
+void HELPER(stfl)(CPUS390XState *env)
+{
+    do_stfle(env, 200, 4);
+}
+
 uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
                       uint64_t cpu_addr)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 01c62176bf70..3a569d3cc0ad 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3628,15 +3628,16 @@ static ExitStatus op_spt(DisasContext *s, DisasOps *o)
 
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
+    return NO_EXIT;
+}
+
+static ExitStatus op_stfle(DisasContext *s, DisasOps *o)
+{
+    potential_page_fault(s);
+    gen_helper_stfle(regs[0], cpu_env, o->in2, regs[0]);
+    set_cc_static(s);
     return NO_EXIT;
 }
 
-- 
2.10.2
