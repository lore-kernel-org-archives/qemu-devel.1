Received: from eggs.gnu.org ([2001:4830:134:3::10]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5I-00010S-Ti
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5G-00072I-EN
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5D-0006iu-RR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W59-0003hL-5s
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:46 +0100
Message-Id: <20181008140004.12612-16-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/33] target/arm: Split contiguous stores for
 endianness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

We can choose the endianness at translation time, rather than
re-computing it at execution time.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181005175350.30752-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 48 +++++++++++++++++--------
 target/arm/sve_helper.c    | 11 ++++--
 target/arm/translate-sve.c | 72 +++++++++++++++++++++++++++++---------
 3 files changed, 96 insertions(+), 35 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 526caec8dac..1ad043101af 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1248,29 +1248,47 @@ DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_st1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_st1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_st1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_st1hs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hs_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hs_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_st1sd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d31988b46ab..426353984e1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4836,12 +4836,17 @@ void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)           \
 }
 
 #define DO_STN_2(N, NAME, ESIZE, MSIZE) \
-void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)             \
+void __attribute__((flatten)) HELPER(sve_st##N##NAME##_le_r)          \
     (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
 {                                                                     \
     sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
-                  arm_cpu_data_is_big_endian(env)                     \
-                  ? sve_st1##NAME##_be_tlb : sve_st1##NAME##_le_tlb); \
+                  sve_st1##NAME##_le_tlb);                            \
+}                                                                     \
+void __attribute__((flatten)) HELPER(sve_st##N##NAME##_be_r)          \
+    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+{                                                                     \
+    sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
+                  sve_st1##NAME##_be_tlb);                            \
 }
 
 DO_STN_1(1, bb, 1)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 8d191df7d8c..05aba50362a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4953,32 +4953,70 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
-    static gen_helper_gvec_mem * const fn_single[4][4] = {
-        { gen_helper_sve_st1bb_r, gen_helper_sve_st1bh_r,
-          gen_helper_sve_st1bs_r, gen_helper_sve_st1bd_r },
-        { NULL,                   gen_helper_sve_st1hh_r,
-          gen_helper_sve_st1hs_r, gen_helper_sve_st1hd_r },
-        { NULL, NULL,
-          gen_helper_sve_st1ss_r, gen_helper_sve_st1sd_r },
-        { NULL, NULL, NULL, gen_helper_sve_st1dd_r },
+    static gen_helper_gvec_mem * const fn_single[2][4][4] = {
+        { { gen_helper_sve_st1bb_r,
+            gen_helper_sve_st1bh_r,
+            gen_helper_sve_st1bs_r,
+            gen_helper_sve_st1bd_r },
+          { NULL,
+            gen_helper_sve_st1hh_le_r,
+            gen_helper_sve_st1hs_le_r,
+            gen_helper_sve_st1hd_le_r },
+          { NULL, NULL,
+            gen_helper_sve_st1ss_le_r,
+            gen_helper_sve_st1sd_le_r },
+          { NULL, NULL, NULL,
+            gen_helper_sve_st1dd_le_r } },
+        { { gen_helper_sve_st1bb_r,
+            gen_helper_sve_st1bh_r,
+            gen_helper_sve_st1bs_r,
+            gen_helper_sve_st1bd_r },
+          { NULL,
+            gen_helper_sve_st1hh_be_r,
+            gen_helper_sve_st1hs_be_r,
+            gen_helper_sve_st1hd_be_r },
+          { NULL, NULL,
+            gen_helper_sve_st1ss_be_r,
+            gen_helper_sve_st1sd_be_r },
+          { NULL, NULL, NULL,
+            gen_helper_sve_st1dd_be_r } },
     };
-    static gen_helper_gvec_mem * const fn_multiple[3][4] = {
-        { gen_helper_sve_st2bb_r, gen_helper_sve_st2hh_r,
-          gen_helper_sve_st2ss_r, gen_helper_sve_st2dd_r },
-        { gen_helper_sve_st3bb_r, gen_helper_sve_st3hh_r,
-          gen_helper_sve_st3ss_r, gen_helper_sve_st3dd_r },
-        { gen_helper_sve_st4bb_r, gen_helper_sve_st4hh_r,
-          gen_helper_sve_st4ss_r, gen_helper_sve_st4dd_r },
+    static gen_helper_gvec_mem * const fn_multiple[2][3][4] = {
+        { { gen_helper_sve_st2bb_r,
+            gen_helper_sve_st2hh_le_r,
+            gen_helper_sve_st2ss_le_r,
+            gen_helper_sve_st2dd_le_r },
+          { gen_helper_sve_st3bb_r,
+            gen_helper_sve_st3hh_le_r,
+            gen_helper_sve_st3ss_le_r,
+            gen_helper_sve_st3dd_le_r },
+          { gen_helper_sve_st4bb_r,
+            gen_helper_sve_st4hh_le_r,
+            gen_helper_sve_st4ss_le_r,
+            gen_helper_sve_st4dd_le_r } },
+        { { gen_helper_sve_st2bb_r,
+            gen_helper_sve_st2hh_be_r,
+            gen_helper_sve_st2ss_be_r,
+            gen_helper_sve_st2dd_be_r },
+          { gen_helper_sve_st3bb_r,
+            gen_helper_sve_st3hh_be_r,
+            gen_helper_sve_st3ss_be_r,
+            gen_helper_sve_st3dd_be_r },
+          { gen_helper_sve_st4bb_r,
+            gen_helper_sve_st4hh_be_r,
+            gen_helper_sve_st4ss_be_r,
+            gen_helper_sve_st4dd_be_r } },
     };
     gen_helper_gvec_mem *fn;
+    int be = s->be_data == MO_BE;
 
     if (nreg == 0) {
         /* ST1 */
-        fn = fn_single[msz][esz];
+        fn = fn_single[be][msz][esz];
     } else {
         /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
         assert(msz == esz);
-        fn = fn_multiple[nreg - 1][msz];
+        fn = fn_multiple[be][nreg - 1][msz];
     }
     assert(fn != NULL);
     do_mem_zpa(s, zt, pg, addr, fn);
-- 
2.19.0
