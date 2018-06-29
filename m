Received: from eggs.gnu.org ([2001:4830:134:3::10]:33909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYump-0007VJ-Rq
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumm-0006hn-63
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYuml-0006YJ-D9
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumj-0004cc-Rv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:12 +0100
Message-Id: <20180629145347.652-21-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/55] target/arm: Implement SVE first-fault
 gather loads
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180627043328.11531-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 67 +++++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 88 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 40 ++++++++++++++++-
 3 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index aeb62afc346..55e8a908d4c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1026,6 +1026,73 @@ DEF_HELPER_FLAGS_6(sve_ldhds_zd, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_6(sve_ldsds_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhsu_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffssu_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbss_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbsu_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhsu_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffssu_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbss_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbdu_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffddu_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbds_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbdu_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffddu_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbds_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbdu_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffddu_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbds_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_sths_zsu, TCG_CALL_NO_WG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 24f75a32d3b..81fc9680870 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3791,6 +3791,94 @@ DO_LD1_ZPZ_D(sve_ldbds_zd, uint64_t, int8_t,   cpu_ldub_data_ra)
 DO_LD1_ZPZ_D(sve_ldhds_zd, uint64_t, int16_t,  cpu_lduw_data_ra)
 DO_LD1_ZPZ_D(sve_ldsds_zd, uint64_t, int32_t,  cpu_ldl_data_ra)
 
+/* First fault loads with a vector index.  */
+
+#ifdef CONFIG_USER_ONLY
+
+#define DO_LDFF1_ZPZ(NAME, TYPEE, TYPEI, TYPEM, FN, H)                  \
+void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
+                  target_ulong base, uint32_t desc)                     \
+{                                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);                               \
+    unsigned scale = simd_data(desc);                                   \
+    uintptr_t ra = GETPC();                                             \
+    bool first = true;                                                  \
+    mmap_lock();                                                        \
+    for (i = 0; i < oprsz; i++) {                                       \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
+        do {                                                            \
+            TYPEM m = 0;                                                \
+            if (pg & 1) {                                               \
+                target_ulong off = *(TYPEI *)(vm + H(i));               \
+                target_ulong addr = base + (off << scale);              \
+                if (!first &&                                           \
+                    page_check_range(addr, sizeof(TYPEM), PAGE_READ)) { \
+                    record_fault(env, i, oprsz);                        \
+                    goto exit;                                          \
+                }                                                       \
+                m = FN(env, addr, ra);                                  \
+                first = false;                                          \
+            }                                                           \
+            *(TYPEE *)(vd + H(i)) = m;                                  \
+            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);                   \
+        } while (i & 15);                                               \
+    }                                                                   \
+ exit:                                                                  \
+    mmap_unlock();                                                      \
+}
+
+#else
+
+#define DO_LDFF1_ZPZ(NAME, TYPEE, TYPEI, TYPEM, FN, H)                  \
+void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
+                  target_ulong base, uint32_t desc)                     \
+{                                                                       \
+    g_assert_not_reached();                                             \
+}
+
+#endif
+
+#define DO_LDFF1_ZPZ_S(NAME, TYPEI, TYPEM, FN) \
+    DO_LDFF1_ZPZ(NAME, uint32_t, TYPEI, TYPEM, FN, H1_4)
+#define DO_LDFF1_ZPZ_D(NAME, TYPEI, TYPEM, FN) \
+    DO_LDFF1_ZPZ(NAME, uint64_t, TYPEI, TYPEM, FN, )
+
+DO_LDFF1_ZPZ_S(sve_ldffbsu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffhsu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffssu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffbss_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffhss_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
+
+DO_LDFF1_ZPZ_S(sve_ldffbsu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffhsu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffssu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffbss_zss, int32_t, int8_t,   cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_S(sve_ldffhss_zss, int32_t, int16_t,  cpu_lduw_data_ra)
+
+DO_LDFF1_ZPZ_D(sve_ldffbdu_zsu, uint32_t, uint8_t,  cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffhdu_zsu, uint32_t, uint16_t, cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffsdu_zsu, uint32_t, uint32_t, cpu_ldl_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffddu_zsu, uint32_t, uint64_t, cpu_ldq_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffbds_zsu, uint32_t, int8_t,   cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffhds_zsu, uint32_t, int16_t,  cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffsds_zsu, uint32_t, int32_t,  cpu_ldl_data_ra)
+
+DO_LDFF1_ZPZ_D(sve_ldffbdu_zss, int32_t, uint8_t,  cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffhdu_zss, int32_t, uint16_t, cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffsdu_zss, int32_t, uint32_t, cpu_ldl_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffddu_zss, int32_t, uint64_t, cpu_ldq_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffbds_zss, int32_t, int8_t,   cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffhds_zss, int32_t, int16_t,  cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffsds_zss, int32_t, int32_t,  cpu_ldl_data_ra)
+
+DO_LDFF1_ZPZ_D(sve_ldffbdu_zd, uint64_t, uint8_t,  cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffhdu_zd, uint64_t, uint16_t, cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffsdu_zd, uint64_t, uint32_t, cpu_ldl_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffddu_zd, uint64_t, uint64_t, cpu_ldq_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffbds_zd, uint64_t, int8_t,   cpu_ldub_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffhds_zd, uint64_t, int16_t,  cpu_lduw_data_ra)
+DO_LDFF1_ZPZ_D(sve_ldffsds_zd, uint64_t, int32_t,  cpu_ldl_data_ra)
+
 /* Stores with a vector index.  */
 
 #define DO_ST1_ZPZ_S(NAME, TYPEI, FN)                                   \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b7adc0c8ecf..66d8c94c588 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4269,7 +4269,19 @@ static gen_helper_gvec_mem_scatter * const gather_load_fn32[2][2][2][3] = {
         { gen_helper_sve_ldbsu_zss,
           gen_helper_sve_ldhsu_zss,
           gen_helper_sve_ldssu_zss, } } },
-    /* TODO fill in first-fault handlers */
+
+    { { { gen_helper_sve_ldffbss_zsu,
+          gen_helper_sve_ldffhss_zsu,
+          NULL, },
+        { gen_helper_sve_ldffbsu_zsu,
+          gen_helper_sve_ldffhsu_zsu,
+          gen_helper_sve_ldffssu_zsu, } },
+      { { gen_helper_sve_ldffbss_zss,
+          gen_helper_sve_ldffhss_zss,
+          NULL, },
+        { gen_helper_sve_ldffbsu_zss,
+          gen_helper_sve_ldffhsu_zss,
+          gen_helper_sve_ldffssu_zss, } } }
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
@@ -4298,7 +4310,31 @@ static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][3][2][4] = {
           gen_helper_sve_ldhdu_zd,
           gen_helper_sve_ldsdu_zd,
           gen_helper_sve_ldddu_zd, } } },
-    /* TODO fill in first-fault handlers */
+
+    { { { gen_helper_sve_ldffbds_zsu,
+          gen_helper_sve_ldffhds_zsu,
+          gen_helper_sve_ldffsds_zsu,
+          NULL, },
+        { gen_helper_sve_ldffbdu_zsu,
+          gen_helper_sve_ldffhdu_zsu,
+          gen_helper_sve_ldffsdu_zsu,
+          gen_helper_sve_ldffddu_zsu, } },
+      { { gen_helper_sve_ldffbds_zss,
+          gen_helper_sve_ldffhds_zss,
+          gen_helper_sve_ldffsds_zss,
+          NULL, },
+        { gen_helper_sve_ldffbdu_zss,
+          gen_helper_sve_ldffhdu_zss,
+          gen_helper_sve_ldffsdu_zss,
+          gen_helper_sve_ldffddu_zss, } },
+      { { gen_helper_sve_ldffbds_zd,
+          gen_helper_sve_ldffhds_zd,
+          gen_helper_sve_ldffsds_zd,
+          NULL, },
+        { gen_helper_sve_ldffbdu_zd,
+          gen_helper_sve_ldffhdu_zd,
+          gen_helper_sve_ldffsdu_zd,
+          gen_helper_sve_ldffddu_zd, } } }
 };
 
 static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
-- 
2.17.1
