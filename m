Received: from eggs.gnu.org ([2001:4830:134:3::10]:54112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT4-0000zL-CJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncT1-0007Pt-Hf
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:34 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncT1-0007P0-67
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:31 -0400
Received: by mail-pf1-x42b.google.com with SMTP id e13-v6so2191099pff.7
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:22:01 -0700
Message-Id: <20180809042206.15726-16-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/20] target/arm: Split contiguous loads for
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

We can choose the endianness at translation time, rather than
re-computing it at execution time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 117 +++++++++++++++-------
 target/arm/sve_helper.c    |  70 ++++++-------
 target/arm/translate-sve.c | 196 +++++++++++++++++++++++++------------
 3 files changed, 252 insertions(+), 131 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 023952a9a4..526caec8da 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1128,20 +1128,35 @@ DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ld1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ld1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ld1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1150,13 +1165,21 @@ DEF_HELPER_FLAGS_4(sve_ld1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ld1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ld1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1166,17 +1189,28 @@ DEF_HELPER_FLAGS_4(sve_ldff1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ldff1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ldff1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ldff1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1186,17 +1220,28 @@ DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4eae6569cc..56e2f523c5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4362,18 +4362,18 @@ void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
               sve_##NAME##_host, sve_##NAME##_tlb);            \
 }
 
-/* TODO: Propagate the endian check back to the translator.  */
 #define DO_LD1_2(NAME, ESZ, MSZ) \
-void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
-                            target_ulong addr, uint32_t desc)  \
-{                                                              \
-    if (arm_cpu_data_is_big_endian(env)) {                     \
-        sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,      \
-                  sve_##NAME##_be_host, sve_##NAME##_be_tlb);  \
-    } else {                                                   \
-        sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,      \
-                  sve_##NAME##_le_host, sve_##NAME##_le_tlb);  \
-    }                                                          \
+void HELPER(sve_##NAME##_le_r)(CPUARMState *env, void *vg,        \
+                               target_ulong addr, uint32_t desc)  \
+{                                                                 \
+    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+              sve_##NAME##_le_host, sve_##NAME##_le_tlb);         \
+}                                                                 \
+void HELPER(sve_##NAME##_be_r)(CPUARMState *env, void *vg,        \
+                               target_ulong addr, uint32_t desc)  \
+{                                                                 \
+    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+              sve_##NAME##_be_host, sve_##NAME##_be_tlb);         \
 }
 
 DO_LD1_1(ld1bb,  0)
@@ -4500,12 +4500,17 @@ void __attribute__((flatten)) HELPER(sve_ld##N##bb_r)               \
 }
 
 #define DO_LDN_2(N, SUFF, SIZE)                                       \
-void __attribute__((flatten)) HELPER(sve_ld##N##SUFF##_r)             \
+void __attribute__((flatten)) HELPER(sve_ld##N##SUFF##_le_r)          \
     (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
 {                                                                     \
     sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
-                  arm_cpu_data_is_big_endian(env)                     \
-                  ? sve_ld1##SUFF##_be_tlb : sve_ld1##SUFF##_le_tlb); \
+                  sve_ld1##SUFF##_le_tlb);                            \
+}                                                                     \
+void __attribute__((flatten)) HELPER(sve_ld##N##SUFF##_be_r)          \
+    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+{                                                                     \
+    sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
+                  sve_ld1##SUFF##_be_tlb);                            \
 }
 
 DO_LDN_1(2)
@@ -4722,29 +4727,28 @@ void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
     sve_ldnf1_r(env, vg, addr, desc, ESZ, 0, sve_ld1##PART##_host);     \
 }
 
-/* TODO: Propagate the endian check back to the translator.  */
 #define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
-void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    if (arm_cpu_data_is_big_endian(env)) {                              \
-        sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
-                    sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);   \
-    } else {                                                            \
-        sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
-                    sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);   \
-    }                                                                   \
+    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,                 \
+                sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);       \
 }                                                                       \
-void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    if (arm_cpu_data_is_big_endian(env)) {                              \
-        sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ,                      \
-                    sve_ld1##PART##_be_host);                           \
-    } else {                                                            \
-        sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ,                      \
-                    sve_ld1##PART##_le_host);                           \
-    }                                                                   \
+    sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ, sve_ld1##PART##_le_host); \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,                 \
+                sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);       \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ, sve_ld1##PART##_be_host); \
 }
 
 DO_LDFF1_LDNF1_1(bb,  0)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index bef6b8242d..de12c01e7d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4624,32 +4624,58 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 static void do_ld_zpa(DisasContext *s, int zt, int pg,
                       TCGv_i64 addr, int dtype, int nreg)
 {
-    static gen_helper_gvec_mem * const fns[16][4] = {
-        { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
-          gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
-        { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+    static gen_helper_gvec_mem * const fns[2][16][4] = {
+        /* Little-endian */
+        { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+            gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
+          { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1sds_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hh_r, gen_helper_sve_ld2hh_r,
-          gen_helper_sve_ld3hh_r, gen_helper_sve_ld4hh_r },
-        { gen_helper_sve_ld1hsu_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hdu_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1sds_le_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1hh_le_r, gen_helper_sve_ld2hh_le_r,
+            gen_helper_sve_ld3hh_le_r, gen_helper_sve_ld4hh_le_r },
+          { gen_helper_sve_ld1hsu_le_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1hdu_le_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1hds_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hss_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1ss_r, gen_helper_sve_ld2ss_r,
-          gen_helper_sve_ld3ss_r, gen_helper_sve_ld4ss_r },
-        { gen_helper_sve_ld1sdu_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1hds_le_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1hss_le_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld2ss_le_r,
+            gen_helper_sve_ld3ss_le_r, gen_helper_sve_ld4ss_le_r },
+          { gen_helper_sve_ld1sdu_le_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1dd_r, gen_helper_sve_ld2dd_r,
-          gen_helper_sve_ld3dd_r, gen_helper_sve_ld4dd_r },
+          { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
+            gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
+
+        /* Big-endian */
+        { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+            gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
+          { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+
+          { gen_helper_sve_ld1sds_be_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1hh_be_r, gen_helper_sve_ld2hh_be_r,
+            gen_helper_sve_ld3hh_be_r, gen_helper_sve_ld4hh_be_r },
+          { gen_helper_sve_ld1hsu_be_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1hdu_be_r, NULL, NULL, NULL },
+
+          { gen_helper_sve_ld1hds_be_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1hss_be_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld2ss_be_r,
+            gen_helper_sve_ld3ss_be_r, gen_helper_sve_ld4ss_be_r },
+          { gen_helper_sve_ld1sdu_be_r, NULL, NULL, NULL },
+
+          { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+          { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
+            gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } }
     };
-    gen_helper_gvec_mem *fn = fns[dtype][nreg];
+    gen_helper_gvec_mem *fn = fns[s->be_data == MO_BE][dtype][nreg];
 
     /* While there are holes in the table, they are not
      * accessible via the instruction encoding.
@@ -4689,59 +4715,103 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
 
 static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
 {
-    static gen_helper_gvec_mem * const fns[16] = {
-        gen_helper_sve_ldff1bb_r,
-        gen_helper_sve_ldff1bhu_r,
-        gen_helper_sve_ldff1bsu_r,
-        gen_helper_sve_ldff1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][16] = {
+        /* Little-endian */
+        { gen_helper_sve_ldff1bb_r,
+          gen_helper_sve_ldff1bhu_r,
+          gen_helper_sve_ldff1bsu_r,
+          gen_helper_sve_ldff1bdu_r,
 
-        gen_helper_sve_ldff1sds_r,
-        gen_helper_sve_ldff1hh_r,
-        gen_helper_sve_ldff1hsu_r,
-        gen_helper_sve_ldff1hdu_r,
+          gen_helper_sve_ldff1sds_le_r,
+          gen_helper_sve_ldff1hh_le_r,
+          gen_helper_sve_ldff1hsu_le_r,
+          gen_helper_sve_ldff1hdu_le_r,
 
-        gen_helper_sve_ldff1hds_r,
-        gen_helper_sve_ldff1hss_r,
-        gen_helper_sve_ldff1ss_r,
-        gen_helper_sve_ldff1sdu_r,
+          gen_helper_sve_ldff1hds_le_r,
+          gen_helper_sve_ldff1hss_le_r,
+          gen_helper_sve_ldff1ss_le_r,
+          gen_helper_sve_ldff1sdu_le_r,
 
-        gen_helper_sve_ldff1bds_r,
-        gen_helper_sve_ldff1bss_r,
-        gen_helper_sve_ldff1bhs_r,
-        gen_helper_sve_ldff1dd_r,
+          gen_helper_sve_ldff1bds_r,
+          gen_helper_sve_ldff1bss_r,
+          gen_helper_sve_ldff1bhs_r,
+          gen_helper_sve_ldff1dd_le_r },
+
+        /* Big-endian */
+        { gen_helper_sve_ldff1bb_r,
+          gen_helper_sve_ldff1bhu_r,
+          gen_helper_sve_ldff1bsu_r,
+          gen_helper_sve_ldff1bdu_r,
+
+          gen_helper_sve_ldff1sds_be_r,
+          gen_helper_sve_ldff1hh_be_r,
+          gen_helper_sve_ldff1hsu_be_r,
+          gen_helper_sve_ldff1hdu_be_r,
+
+          gen_helper_sve_ldff1hds_be_r,
+          gen_helper_sve_ldff1hss_be_r,
+          gen_helper_sve_ldff1ss_be_r,
+          gen_helper_sve_ldff1sdu_be_r,
+
+          gen_helper_sve_ldff1bds_r,
+          gen_helper_sve_ldff1bss_r,
+          gen_helper_sve_ldff1bhs_r,
+          gen_helper_sve_ldff1dd_be_r },
     };
 
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
-        do_mem_zpa(s, a->rd, a->pg, addr, fns[a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
 
 static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
 {
-    static gen_helper_gvec_mem * const fns[16] = {
-        gen_helper_sve_ldnf1bb_r,
-        gen_helper_sve_ldnf1bhu_r,
-        gen_helper_sve_ldnf1bsu_r,
-        gen_helper_sve_ldnf1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][16] = {
+        /* Little-endian */
+        { gen_helper_sve_ldnf1bb_r,
+          gen_helper_sve_ldnf1bhu_r,
+          gen_helper_sve_ldnf1bsu_r,
+          gen_helper_sve_ldnf1bdu_r,
 
-        gen_helper_sve_ldnf1sds_r,
-        gen_helper_sve_ldnf1hh_r,
-        gen_helper_sve_ldnf1hsu_r,
-        gen_helper_sve_ldnf1hdu_r,
+          gen_helper_sve_ldnf1sds_le_r,
+          gen_helper_sve_ldnf1hh_le_r,
+          gen_helper_sve_ldnf1hsu_le_r,
+          gen_helper_sve_ldnf1hdu_le_r,
 
-        gen_helper_sve_ldnf1hds_r,
-        gen_helper_sve_ldnf1hss_r,
-        gen_helper_sve_ldnf1ss_r,
-        gen_helper_sve_ldnf1sdu_r,
+          gen_helper_sve_ldnf1hds_le_r,
+          gen_helper_sve_ldnf1hss_le_r,
+          gen_helper_sve_ldnf1ss_le_r,
+          gen_helper_sve_ldnf1sdu_le_r,
 
-        gen_helper_sve_ldnf1bds_r,
-        gen_helper_sve_ldnf1bss_r,
-        gen_helper_sve_ldnf1bhs_r,
-        gen_helper_sve_ldnf1dd_r,
+          gen_helper_sve_ldnf1bds_r,
+          gen_helper_sve_ldnf1bss_r,
+          gen_helper_sve_ldnf1bhs_r,
+          gen_helper_sve_ldnf1dd_le_r },
+
+        /* Big-endian */
+        { gen_helper_sve_ldnf1bb_r,
+          gen_helper_sve_ldnf1bhu_r,
+          gen_helper_sve_ldnf1bsu_r,
+          gen_helper_sve_ldnf1bdu_r,
+
+          gen_helper_sve_ldnf1sds_be_r,
+          gen_helper_sve_ldnf1hh_be_r,
+          gen_helper_sve_ldnf1hsu_be_r,
+          gen_helper_sve_ldnf1hdu_be_r,
+
+          gen_helper_sve_ldnf1hds_be_r,
+          gen_helper_sve_ldnf1hss_be_r,
+          gen_helper_sve_ldnf1ss_be_r,
+          gen_helper_sve_ldnf1sdu_be_r,
+
+          gen_helper_sve_ldnf1bds_r,
+          gen_helper_sve_ldnf1bss_r,
+          gen_helper_sve_ldnf1bhs_r,
+          gen_helper_sve_ldnf1dd_be_r },
     };
 
     if (sve_access_check(s)) {
@@ -4751,16 +4821,18 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
         TCGv_i64 addr = new_tmp_a64(s);
 
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
-        do_mem_zpa(s, a->rd, a->pg, addr, fns[a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
 
 static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
 {
-    static gen_helper_gvec_mem * const fns[4] = {
-        gen_helper_sve_ld1bb_r, gen_helper_sve_ld1hh_r,
-        gen_helper_sve_ld1ss_r, gen_helper_sve_ld1dd_r,
+    static gen_helper_gvec_mem * const fns[2][4] = {
+        { gen_helper_sve_ld1bb_r,    gen_helper_sve_ld1hh_le_r,
+          gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld1dd_le_r },
+        { gen_helper_sve_ld1bb_r,    gen_helper_sve_ld1hh_be_r,
+          gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld1dd_be_r },
     };
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
@@ -4792,7 +4864,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_pg, cpu_env, poff);
 
-    fns[msz](cpu_env, t_pg, addr, desc);
+    fns[s->be_data == MO_BE][msz](cpu_env, t_pg, addr, desc);
 
     tcg_temp_free_ptr(t_pg);
     tcg_temp_free_i32(desc);
-- 
2.17.1
