Received: from eggs.gnu.org ([2001:4830:134:3::10]:54137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT7-00011t-FH
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT5-0007Te-G3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:43248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncT5-0007Sq-6B
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id j26-v6so2186491pfi.10
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:22:04 -0700
Message-Id: <20180809042206.15726-19-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/20] target/arm: Rewrite vector gather stores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

This fixes the endianness problem for softmmu, and does
move the main loop out of a macro and into an inlined function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  52 ++++++++++----
 target/arm/sve_helper.c    | 139 ++++++++++++++++++++++++-------------
 target/arm/translate-sve.c |  74 +++++++++++++-------
 3 files changed, 177 insertions(+), 88 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 49d1c09e30..6b9b93af45 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1468,41 +1468,67 @@ DEF_HELPER_FLAGS_6(sve_ldffsds_zd, TCG_CALL_NO_WG,
 
 DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sths_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sths_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sths_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sths_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sthd_le_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sthd_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_zsu, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_stsd_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_be_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_le_zsu, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_be_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sthd_le_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sthd_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_zss, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_stsd_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_be_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_le_zss, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_be_zss, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sthd_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_sthd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_zd, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_6(sve_stsd_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 76d3f021e4..0a4756bff9 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5235,61 +5235,100 @@ DO_LDFF1_ZPZ_D(sve_ldffsds_zd, uint64_t, int32_t,  cpu_ldl_data_ra)
 
 /* Stores with a vector index.  */
 
-#define DO_ST1_ZPZ_S(NAME, TYPEI, FN)                                   \
-void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
-                  target_ulong base, uint32_t desc)                     \
-{                                                                       \
-    intptr_t i, oprsz = simd_oprsz(desc);                               \
-    unsigned scale = simd_data(desc);                                   \
-    uintptr_t ra = GETPC();                                             \
-    for (i = 0; i < oprsz; ) {                                          \
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
-        do {                                                            \
-            if (likely(pg & 1)) {                                       \
-                target_ulong off = *(TYPEI *)(vm + H1_4(i));            \
-                uint32_t d = *(uint32_t *)(vd + H1_4(i));               \
-                FN(env, base + (off << scale), d, ra);                  \
-            }                                                           \
-            i += sizeof(uint32_t), pg >>= sizeof(uint32_t);             \
-        } while (i & 15);                                               \
-    }                                                                   \
+static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
+                       target_ulong base, uint32_t desc, uintptr_t ra,
+                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc);
+    unsigned scale = simd_data(desc);
+
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; ) {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                target_ulong off = off_fn(vm, i);
+                tlb_fn(env, vd, i, base + (off << scale), mmu_idx, ra);
+            }
+            i += 4, pg >>= 4;
+        } while (i & 15);
+    }
+    set_helper_retaddr(0);
 }
 
-#define DO_ST1_ZPZ_D(NAME, TYPEI, FN)                                   \
-void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
-                  target_ulong base, uint32_t desc)                     \
-{                                                                       \
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;                           \
-    unsigned scale = simd_data(desc);                                   \
-    uintptr_t ra = GETPC();                                             \
-    uint64_t *d = vd, *m = vm; uint8_t *pg = vg;                        \
-    for (i = 0; i < oprsz; i++) {                                       \
-        if (likely(pg[H1(i)] & 1)) {                                    \
-            target_ulong off = (target_ulong)(TYPEI)m[i] << scale;      \
-            FN(env, base + off, d[i], ra);                              \
-        }                                                               \
-    }                                                                   \
+static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
+                       target_ulong base, uint32_t desc, uintptr_t ra,
+                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+{
+    const int mmu_idx = cpu_mmu_index(env, false);
+    intptr_t i, oprsz = simd_oprsz(desc) / 8;
+    unsigned scale = simd_data(desc);
+
+    set_helper_retaddr(ra);
+    for (i = 0; i < oprsz; i++) {
+        uint8_t pg = *(uint8_t *)(vg + H1(i));
+        if (pg & 1) {
+            target_ulong off = off_fn(vm, i * 8);
+            tlb_fn(env, vd, i * 8, base + (off << scale), mmu_idx, ra);
+        }
+    }
+    set_helper_retaddr(0);
 }
 
-DO_ST1_ZPZ_S(sve_stbs_zsu, uint32_t, cpu_stb_data_ra)
-DO_ST1_ZPZ_S(sve_sths_zsu, uint32_t, cpu_stw_data_ra)
-DO_ST1_ZPZ_S(sve_stss_zsu, uint32_t, cpu_stl_data_ra)
+#define DO_ST1_ZPZ_S(MEM, OFS) \
+void __attribute__((flatten)) HELPER(sve_st##MEM##_##OFS)    \
+    (CPUARMState *env, void *vd, void *vg, void *vm,         \
+     target_ulong base, uint32_t desc)                       \
+{                                                            \
+    sve_st1_zs(env, vd, vg, vm, base, desc, GETPC(),         \
+              off_##OFS##_s, sve_st1##MEM##_tlb);            \
+}
 
-DO_ST1_ZPZ_S(sve_stbs_zss, int32_t, cpu_stb_data_ra)
-DO_ST1_ZPZ_S(sve_sths_zss, int32_t, cpu_stw_data_ra)
-DO_ST1_ZPZ_S(sve_stss_zss, int32_t, cpu_stl_data_ra)
+#define DO_ST1_ZPZ_D(MEM, OFS) \
+void __attribute__((flatten)) HELPER(sve_st##MEM##_##OFS)    \
+    (CPUARMState *env, void *vd, void *vg, void *vm,         \
+     target_ulong base, uint32_t desc)                       \
+{                                                            \
+    sve_st1_zd(env, vd, vg, vm, base, desc, GETPC(),         \
+               off_##OFS##_d, sve_st1##MEM##_tlb);           \
+}
 
-DO_ST1_ZPZ_D(sve_stbd_zsu, uint32_t, cpu_stb_data_ra)
-DO_ST1_ZPZ_D(sve_sthd_zsu, uint32_t, cpu_stw_data_ra)
-DO_ST1_ZPZ_D(sve_stsd_zsu, uint32_t, cpu_stl_data_ra)
-DO_ST1_ZPZ_D(sve_stdd_zsu, uint32_t, cpu_stq_data_ra)
+DO_ST1_ZPZ_S(bs, zsu)
+DO_ST1_ZPZ_S(hs_le, zsu)
+DO_ST1_ZPZ_S(hs_be, zsu)
+DO_ST1_ZPZ_S(ss_le, zsu)
+DO_ST1_ZPZ_S(ss_be, zsu)
 
-DO_ST1_ZPZ_D(sve_stbd_zss, int32_t, cpu_stb_data_ra)
-DO_ST1_ZPZ_D(sve_sthd_zss, int32_t, cpu_stw_data_ra)
-DO_ST1_ZPZ_D(sve_stsd_zss, int32_t, cpu_stl_data_ra)
-DO_ST1_ZPZ_D(sve_stdd_zss, int32_t, cpu_stq_data_ra)
+DO_ST1_ZPZ_S(bs, zss)
+DO_ST1_ZPZ_S(hs_le, zss)
+DO_ST1_ZPZ_S(hs_be, zss)
+DO_ST1_ZPZ_S(ss_le, zss)
+DO_ST1_ZPZ_S(ss_be, zss)
 
-DO_ST1_ZPZ_D(sve_stbd_zd, uint64_t, cpu_stb_data_ra)
-DO_ST1_ZPZ_D(sve_sthd_zd, uint64_t, cpu_stw_data_ra)
-DO_ST1_ZPZ_D(sve_stsd_zd, uint64_t, cpu_stl_data_ra)
-DO_ST1_ZPZ_D(sve_stdd_zd, uint64_t, cpu_stq_data_ra)
+DO_ST1_ZPZ_D(bd, zsu)
+DO_ST1_ZPZ_D(hd_le, zsu)
+DO_ST1_ZPZ_D(hd_be, zsu)
+DO_ST1_ZPZ_D(sd_le, zsu)
+DO_ST1_ZPZ_D(sd_be, zsu)
+DO_ST1_ZPZ_D(dd_le, zsu)
+DO_ST1_ZPZ_D(dd_be, zsu)
+
+DO_ST1_ZPZ_D(bd, zss)
+DO_ST1_ZPZ_D(hd_le, zss)
+DO_ST1_ZPZ_D(hd_be, zss)
+DO_ST1_ZPZ_D(sd_le, zss)
+DO_ST1_ZPZ_D(sd_be, zss)
+DO_ST1_ZPZ_D(dd_le, zss)
+DO_ST1_ZPZ_D(dd_be, zss)
+
+DO_ST1_ZPZ_D(bd, zd)
+DO_ST1_ZPZ_D(hd_le, zd)
+DO_ST1_ZPZ_D(hd_be, zd)
+DO_ST1_ZPZ_D(sd_le, zd)
+DO_ST1_ZPZ_D(sd_be, zd)
+DO_ST1_ZPZ_D(dd_le, zd)
+DO_ST1_ZPZ_D(dd_be, zd)
+
+#undef DO_ST1_ZPZ_S
+#undef DO_ST1_ZPZ_D
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d4d7e9d3ae..fdd9b9b3a0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5299,35 +5299,58 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t insn)
     return true;
 }
 
-/* Indexed by [xs][msz].  */
-static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][3] = {
-    { gen_helper_sve_stbs_zsu,
-      gen_helper_sve_sths_zsu,
-      gen_helper_sve_stss_zsu, },
-    { gen_helper_sve_stbs_zss,
-      gen_helper_sve_sths_zss,
-      gen_helper_sve_stss_zss, },
+/* Indexed by [be][xs][msz].  */
+static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][2][3] = {
+    /* Little-endian */
+    { { gen_helper_sve_stbs_zsu,
+        gen_helper_sve_sths_le_zsu,
+        gen_helper_sve_stss_le_zsu, },
+      { gen_helper_sve_stbs_zss,
+        gen_helper_sve_sths_le_zss,
+        gen_helper_sve_stss_le_zss, } },
+    /* Big-endian */
+    { { gen_helper_sve_stbs_zsu,
+        gen_helper_sve_sths_be_zsu,
+        gen_helper_sve_stss_be_zsu, },
+      { gen_helper_sve_stbs_zss,
+        gen_helper_sve_sths_be_zss,
+        gen_helper_sve_stss_be_zss, } },
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
-static gen_helper_gvec_mem_scatter * const scatter_store_fn64[3][4] = {
-    { gen_helper_sve_stbd_zsu,
-      gen_helper_sve_sthd_zsu,
-      gen_helper_sve_stsd_zsu,
-      gen_helper_sve_stdd_zsu, },
-    { gen_helper_sve_stbd_zss,
-      gen_helper_sve_sthd_zss,
-      gen_helper_sve_stsd_zss,
-      gen_helper_sve_stdd_zss, },
-    { gen_helper_sve_stbd_zd,
-      gen_helper_sve_sthd_zd,
-      gen_helper_sve_stsd_zd,
-      gen_helper_sve_stdd_zd, },
+static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][3][4] = {
+    /* Little-endian */
+    { { gen_helper_sve_stbd_zsu,
+        gen_helper_sve_sthd_le_zsu,
+        gen_helper_sve_stsd_le_zsu,
+        gen_helper_sve_stdd_le_zsu, },
+      { gen_helper_sve_stbd_zss,
+        gen_helper_sve_sthd_le_zss,
+        gen_helper_sve_stsd_le_zss,
+        gen_helper_sve_stdd_le_zss, },
+      { gen_helper_sve_stbd_zd,
+        gen_helper_sve_sthd_le_zd,
+        gen_helper_sve_stsd_le_zd,
+        gen_helper_sve_stdd_le_zd, } },
+    /* Big-endian */
+    { { gen_helper_sve_stbd_zsu,
+        gen_helper_sve_sthd_be_zsu,
+        gen_helper_sve_stsd_be_zsu,
+        gen_helper_sve_stdd_be_zsu, },
+      { gen_helper_sve_stbd_zss,
+        gen_helper_sve_sthd_be_zss,
+        gen_helper_sve_stsd_be_zss,
+        gen_helper_sve_stdd_be_zss, },
+      { gen_helper_sve_stbd_zd,
+        gen_helper_sve_sthd_be_zd,
+        gen_helper_sve_stsd_be_zd,
+        gen_helper_sve_stdd_be_zd, } },
 };
 
 static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
 {
     gen_helper_gvec_mem_scatter *fn;
+    int be = s->be_data == MO_BE;
 
     if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
         return false;
@@ -5337,10 +5360,10 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
     }
     switch (a->esz) {
     case MO_32:
-        fn = scatter_store_fn32[a->xs][a->msz];
+        fn = scatter_store_fn32[be][a->xs][a->msz];
         break;
     case MO_64:
-        fn = scatter_store_fn64[a->xs][a->msz];
+        fn = scatter_store_fn64[be][a->xs][a->msz];
         break;
     default:
         g_assert_not_reached();
@@ -5353,6 +5376,7 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
 static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
+    int be = s->be_data == MO_BE;
     TCGv_i64 imm;
 
     if (a->esz < a->msz) {
@@ -5364,10 +5388,10 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
 
     switch (a->esz) {
     case MO_32:
-        fn = scatter_store_fn32[0][a->msz];
+        fn = scatter_store_fn32[be][0][a->msz];
         break;
     case MO_64:
-        fn = scatter_store_fn64[2][a->msz];
+        fn = scatter_store_fn64[be][2][a->msz];
         break;
     }
     assert(fn != NULL);
-- 
2.17.1
