Received: from eggs.gnu.org ([2001:4830:134:3::10]:59607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KM-0006hZ-UA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KJ-0008EI-2y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:54 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fG4KI-0008DI-RW
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:51 -0400
Received: by mail-pl0-x242.google.com with SMTP id 59-v6so2415346plc.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:14:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  8 May 2018 08:14:34 -0700
Message-Id: <20180508151437.4232-8-richard.henderson@linaro.org>
In-Reply-To: <20180508151437.4232-1-richard.henderson@linaro.org>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 07/10] target/arm: Introduce
 ARM_FEATURE_V8_ATOMICS and initial decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The insns in the ARMv8.1-Atomics are added to the existing
load/store exclusive and load/store reg opcode spaces.
Rearrange the top-level decoders for these to accomodate.
The Atomics insns themselves still generate Unallocated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |   2 +
 linux-user/elfload.c       |   1 +
 target/arm/translate-a64.c | 182 +++++++++++++++++++++++++++----------
 3 files changed, 139 insertions(+), 46 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 44e6b77151..f71a78d908 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1449,6 +1449,8 @@ enum arm_features {
     ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_1,
+    ARM_FEATURE_V8_ATOMICS = ARM_FEATURE_V8_1, /* mandatory extension */
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 36d52194bc..13bc78d0c8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -581,6 +581,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_SHA512, ARM_HWCAP_A64_SHA512);
     GET_FEATURE(ARM_FEATURE_V8_FP16,
                 ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
+    GET_FEATURE(ARM_FEATURE_V8_ATOMICS, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
 #undef GET_FEATURE
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d916fea3a3..6acad791e6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2147,62 +2147,98 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     int rt = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int rt2 = extract32(insn, 10, 5);
-    int is_lasr = extract32(insn, 15, 1);
     int rs = extract32(insn, 16, 5);
-    int is_pair = extract32(insn, 21, 1);
-    int is_store = !extract32(insn, 22, 1);
-    int is_excl = !extract32(insn, 23, 1);
+    int is_lasr = extract32(insn, 15, 1);
+    int o2_L_o1_o0 = extract32(insn, 21, 3) * 2 | is_lasr;
     int size = extract32(insn, 30, 2);
     TCGv_i64 tcg_addr;
 
-    if ((!is_excl && !is_pair && !is_lasr) ||
-        (!is_excl && is_pair) ||
-        (is_pair && size < 2)) {
-        unallocated_encoding(s);
+    switch (o2_L_o1_o0) {
+    case 0x0: /* STXR */
+    case 0x1: /* STLXR */
+        if (rn == 31) {
+            gen_check_sp_alignment(s);
+        }
+        if (is_lasr) {
+            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        }
+        tcg_addr = read_cpu_reg_sp(s, rn, 1);
+        gen_store_exclusive(s, rs, rt, rt2, tcg_addr, size, false);
         return;
-    }
 
-    if (rn == 31) {
-        gen_check_sp_alignment(s);
-    }
-    tcg_addr = read_cpu_reg_sp(s, rn, 1);
-
-    /* Note that since TCG is single threaded load-acquire/store-release
-     * semantics require no extra if (is_lasr) { ... } handling.
-     */
-
-    if (is_excl) {
-        if (!is_store) {
-            s->is_ldex = true;
-            gen_load_exclusive(s, rt, rt2, tcg_addr, size, is_pair);
-            if (is_lasr) {
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-            }
-        } else {
-            if (is_lasr) {
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-            }
-            gen_store_exclusive(s, rs, rt, rt2, tcg_addr, size, is_pair);
+    case 0x4: /* LDXR */
+    case 0x5: /* LDAXR */
+        if (rn == 31) {
+            gen_check_sp_alignment(s);
         }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        bool iss_sf = disas_ldst_compute_iss_sf(size, false, 0);
+        tcg_addr = read_cpu_reg_sp(s, rn, 1);
+        s->is_ldex = true;
+        gen_load_exclusive(s, rt, rt2, tcg_addr, size, false);
+        if (is_lasr) {
+            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+        }
+        return;
 
+    case 0x9: /* STLR */
         /* Generate ISS for non-exclusive accesses including LASR.  */
-        if (is_store) {
+        if (rn == 31) {
+            gen_check_sp_alignment(s);
+        }
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        tcg_addr = read_cpu_reg_sp(s, rn, 1);
+        do_gpr_st(s, cpu_reg(s, rt), tcg_addr, size, true, rt,
+                  disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
+        return;
+
+    case 0xd: /* LDAR */
+        /* Generate ISS for non-exclusive accesses including LASR.  */
+        if (rn == 31) {
+            gen_check_sp_alignment(s);
+        }
+        tcg_addr = read_cpu_reg_sp(s, rn, 1);
+        do_gpr_ld(s, cpu_reg(s, rt), tcg_addr, size, false, false, true, rt,
+                  disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+        return;
+
+    case 0x2: case 0x3: /* CASP / STXP */
+        if (size & 2) { /* STXP / STLXP */
+            if (rn == 31) {
+                gen_check_sp_alignment(s);
+            }
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
             }
-            do_gpr_st(s, tcg_rt, tcg_addr, size,
-                      true, rt, iss_sf, is_lasr);
-        } else {
-            do_gpr_ld(s, tcg_rt, tcg_addr, size, false, false,
-                      true, rt, iss_sf, is_lasr);
+            tcg_addr = read_cpu_reg_sp(s, rn, 1);
+            gen_store_exclusive(s, rs, rt, rt2, tcg_addr, size, true);
+            return;
+        }
+        /* CASP / CASPL */
+        break;
+
+    case 0x6: case 0x7: /* CASP / LDXP */
+        if (size & 2) { /* LDXP / LDAXP */
+            if (rn == 31) {
+                gen_check_sp_alignment(s);
+            }
+            tcg_addr = read_cpu_reg_sp(s, rn, 1);
+            s->is_ldex = true;
+            gen_load_exclusive(s, rt, rt2, tcg_addr, size, true);
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
             }
+            return;
         }
+        /* CASPA / CASPAL */
+        break;
+
+    case 0xa: /* CAS */
+    case 0xb: /* CASL */
+    case 0xe: /* CASA */
+    case 0xf: /* CASAL */
+        break;
     }
+    unallocated_encoding(s);
 }
 
 /*
@@ -2715,6 +2751,55 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     }
 }
 
+/* Atomic memory operations
+ *
+ *  31  30      27  26    24    22  21   16   15    12    10    5     0
+ * +------+-------+---+-----+-----+---+----+----+-----+-----+----+-----+
+ * | size | 1 1 1 | V | 0 0 | A R | 1 | Rs | o3 | opc | 0 0 | Rn |  Rt |
+ * +------+-------+---+-----+-----+--------+----+-----+-----+----+-----+
+ *
+ * Rt: the result register
+ * Rn: base address or SP
+ * Rs: the source register for the operation
+ * V: vector flag (always 0 as of v8.3)
+ * A: acquire flag
+ * R: release flag
+ */
+static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
+                              int size, int rt, bool is_vector)
+{
+    int rs = extract32(insn, 16, 5);
+    int rn = extract32(insn, 5, 5);
+    int o3_opc = extract32(insn, 12, 4);
+    int feature = ARM_FEATURE_V8_ATOMICS;
+
+    if (is_vector) {
+        unallocated_encoding(s);
+        return;
+    }
+    switch (o3_opc) {
+    case 000: /* LDADD */
+    case 001: /* LDCLR */
+    case 002: /* LDEOR */
+    case 003: /* LDSET */
+    case 004: /* LDSMAX */
+    case 005: /* LDSMIN */
+    case 006: /* LDUMAX */
+    case 007: /* LDUMIN */
+    case 010: /* SWP */
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+    if (!arm_dc_feature(s, feature)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    (void)rs;
+    (void)rn;
+}
+
 /* Load/store register (all forms) */
 static void disas_ldst_reg(DisasContext *s, uint32_t insn)
 {
@@ -2725,23 +2810,28 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
 
     switch (extract32(insn, 24, 2)) {
     case 0:
-        if (extract32(insn, 21, 1) == 1 && extract32(insn, 10, 2) == 2) {
-            disas_ldst_reg_roffset(s, insn, opc, size, rt, is_vector);
-        } else {
+        if (extract32(insn, 21, 1) == 0) {
             /* Load/store register (unscaled immediate)
              * Load/store immediate pre/post-indexed
              * Load/store register unprivileged
              */
             disas_ldst_reg_imm9(s, insn, opc, size, rt, is_vector);
+            return;
+        }
+        switch (extract32(insn, 10, 2)) {
+        case 0:
+            disas_ldst_atomic(s, insn, size, rt, is_vector);
+            return;
+        case 2:
+            disas_ldst_reg_roffset(s, insn, opc, size, rt, is_vector);
+            return;
         }
         break;
     case 1:
         disas_ldst_reg_unsigned_imm(s, insn, opc, size, rt, is_vector);
-        break;
-    default:
-        unallocated_encoding(s);
-        break;
+        return;
     }
+    unallocated_encoding(s);
 }
 
 /* AdvSIMD load/store multiple structures
-- 
2.17.0
