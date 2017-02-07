Received: from eggs.gnu.org ([2001:4830:134:3::10]:32812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe4-0007b1-V3
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe2-0002ks-Cg
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:40 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe1-0002gg-W2
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:38 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdu-0005V8-Vl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:22 +0000
Message-Id: <1486492645-27803-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/13] target/arm: A32,
 T32: Create Instruction Syndromes for Data Aborts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add support for generating the ISS (Instruction Specific Syndrome)
for Data Abort exceptions taken from AArch32. These syndromes are
used by hypervisors for example to trap and emulate memory accesses.

This is the equivalent for AArch32 guests of the work done for AArch64
guests in commit aaa1f954d4cab243.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/translate.h     |  14 ++++
 target/arm/translate-a64.c |  14 ----
 target/arm/translate.c     | 184 +++++++++++++++++++++++++++++++++------------
 3 files changed, 149 insertions(+), 63 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 285e96f..abb0760 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -104,6 +104,20 @@ static inline int default_exception_el(DisasContext *s)
             ? 3 : MAX(1, s->current_el);
 }
 
+static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
+{
+    /* We don't need to save all of the syndrome so we mask and shift
+     * out unneeded bits to help the sleb128 encoder do a better job.
+     */
+    syn &= ARM_INSN_START_WORD2_MASK;
+    syn >>= ARM_INSN_START_WORD2_SHIFT;
+
+    /* We check and clear insn_start_idx to catch multiple updates.  */
+    assert(s->insn_start_idx != 0);
+    tcg_set_insn_param(s->insn_start_idx, 2, syn);
+    s->insn_start_idx = 0;
+}
+
 /* target-specific extra values for is_jmp */
 /* These instructions trap after executing, so the A32/T32 decoder must
  * defer them until after the conditional execution state has been updated.
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d0352e2..e61bbd6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -379,20 +379,6 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
     }
 }
 
-static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
-{
-    /* We don't need to save all of the syndrome so we mask and shift
-     * out uneeded bits to help the sleb128 encoder do a better job.
-     */
-    syn &= ARM_INSN_START_WORD2_MASK;
-    syn >>= ARM_INSN_START_WORD2_SHIFT;
-
-    /* We check and clear insn_start_idx to catch multiple updates.  */
-    assert(s->insn_start_idx != 0);
-    tcg_set_insn_param(s->insn_start_idx, 2, syn);
-    s->insn_start_idx = 0;
-}
-
 static void unallocated_encoding(DisasContext *s)
 {
     /* Unallocated and reserved encodings are uncategorized */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 175b4c1..a14f74c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -102,6 +102,49 @@ void arm_translate_init(void)
     a64_translate_init();
 }
 
+/* Flags for the disas_set_da_iss info argument:
+ * lower bits hold the Rt register number, higher bits are flags.
+ */
+typedef enum ISSInfo {
+    ISSNone = 0,
+    ISSRegMask = 0x1f,
+    ISSInvalid = (1 << 5),
+    ISSIsAcqRel = (1 << 6),
+    ISSIsWrite = (1 << 7),
+    ISSIs16Bit = (1 << 8),
+} ISSInfo;
+
+/* Save the syndrome information for a Data Abort */
+static void disas_set_da_iss(DisasContext *s, TCGMemOp memop, ISSInfo issinfo)
+{
+    uint32_t syn;
+    int sas = memop & MO_SIZE;
+    bool sse = memop & MO_SIGN;
+    bool is_acqrel = issinfo & ISSIsAcqRel;
+    bool is_write = issinfo & ISSIsWrite;
+    bool is_16bit = issinfo & ISSIs16Bit;
+    int srt = issinfo & ISSRegMask;
+
+    if (issinfo & ISSInvalid) {
+        /* Some callsites want to conditionally provide ISS info,
+         * eg "only if this was not a writeback"
+         */
+        return;
+    }
+
+    if (srt == 15) {
+        /* For AArch32, insns where the src/dest is R15 never generate
+         * ISS information. Catching that here saves checking at all
+         * the call sites.
+         */
+        return;
+    }
+
+    syn = syn_data_abort_with_iss(0, sas, sse, srt, 0, is_acqrel,
+                                  0, 0, 0, is_write, 0, is_16bit);
+    disas_set_insn_syndrome(s, syn);
+}
+
 static inline ARMMMUIdx get_a32_user_mem_index(DisasContext *s)
 {
     /* Return the mmu_idx to use for A32/T32 "unprivileged load/store"
@@ -933,6 +976,14 @@ static inline void gen_aa32_ld##SUFF(DisasContext *s, TCGv_i32 val,      \
                                      TCGv_i32 a32, int index)            \
 {                                                                        \
     gen_aa32_ld_i32(s, val, a32, index, OPC | s->be_data);               \
+}                                                                        \
+static inline void gen_aa32_ld##SUFF##_iss(DisasContext *s,              \
+                                           TCGv_i32 val,                 \
+                                           TCGv_i32 a32, int index,      \
+                                           ISSInfo issinfo)              \
+{                                                                        \
+    gen_aa32_ld_i32(s, val, a32, index, OPC | s->be_data);               \
+    disas_set_da_iss(s, OPC, issinfo);                                   \
 }
 
 #define DO_GEN_ST(SUFF, OPC)                                             \
@@ -940,6 +991,14 @@ static inline void gen_aa32_st##SUFF(DisasContext *s, TCGv_i32 val,      \
                                      TCGv_i32 a32, int index)            \
 {                                                                        \
     gen_aa32_st_i32(s, val, a32, index, OPC | s->be_data);               \
+}                                                                        \
+static inline void gen_aa32_st##SUFF##_iss(DisasContext *s,              \
+                                           TCGv_i32 val,                 \
+                                           TCGv_i32 a32, int index,      \
+                                           ISSInfo issinfo)              \
+{                                                                        \
+    gen_aa32_st_i32(s, val, a32, index, OPC | s->be_data);               \
+    disas_set_da_iss(s, OPC, issinfo | ISSIsWrite);                      \
 }
 
 static inline void gen_aa32_frob64(DisasContext *s, TCGv_i64 val)
@@ -8682,16 +8741,19 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                                 tmp = tcg_temp_new_i32();
                                 switch (op1) {
                                 case 0: /* lda */
-                                    gen_aa32_ld32u(s, tmp, addr,
-                                                   get_mem_index(s));
+                                    gen_aa32_ld32u_iss(s, tmp, addr,
+                                                       get_mem_index(s),
+                                                       rd | ISSIsAcqRel);
                                     break;
                                 case 2: /* ldab */
-                                    gen_aa32_ld8u(s, tmp, addr,
-                                                  get_mem_index(s));
+                                    gen_aa32_ld8u_iss(s, tmp, addr,
+                                                      get_mem_index(s),
+                                                      rd | ISSIsAcqRel);
                                     break;
                                 case 3: /* ldah */
-                                    gen_aa32_ld16u(s, tmp, addr,
-                                                   get_mem_index(s));
+                                    gen_aa32_ld16u_iss(s, tmp, addr,
+                                                       get_mem_index(s),
+                                                       rd | ISSIsAcqRel);
                                     break;
                                 default:
                                     abort();
@@ -8702,16 +8764,19 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                                 tmp = load_reg(s, rm);
                                 switch (op1) {
                                 case 0: /* stl */
-                                    gen_aa32_st32(s, tmp, addr,
-                                                  get_mem_index(s));
+                                    gen_aa32_st32_iss(s, tmp, addr,
+                                                      get_mem_index(s),
+                                                      rm | ISSIsAcqRel);
                                     break;
                                 case 2: /* stlb */
-                                    gen_aa32_st8(s, tmp, addr,
-                                                 get_mem_index(s));
+                                    gen_aa32_st8_iss(s, tmp, addr,
+                                                     get_mem_index(s),
+                                                     rm | ISSIsAcqRel);
                                     break;
                                 case 3: /* stlh */
-                                    gen_aa32_st16(s, tmp, addr,
-                                                  get_mem_index(s));
+                                    gen_aa32_st16_iss(s, tmp, addr,
+                                                      get_mem_index(s),
+                                                      rm | ISSIsAcqRel);
                                     break;
                                 default:
                                     abort();
@@ -8785,10 +8850,15 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 bool wbit = insn & (1 << 21);
                 bool pbit = insn & (1 << 24);
                 bool doubleword = false;
+                ISSInfo issinfo;
+
                 /* Misc load/store */
                 rn = (insn >> 16) & 0xf;
                 rd = (insn >> 12) & 0xf;
 
+                /* ISS not valid if writeback */
+                issinfo = (pbit & !wbit) ? rd : ISSInvalid;
+
                 if (!load && (sh & 2)) {
                     /* doubleword */
                     ARCH(5TE);
@@ -8832,20 +8902,23 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     tmp = tcg_temp_new_i32();
                     switch (sh) {
                     case 1:
-                        gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
+                        gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s),
+                                           issinfo);
                         break;
                     case 2:
-                        gen_aa32_ld8s(s, tmp, addr, get_mem_index(s));
+                        gen_aa32_ld8s_iss(s, tmp, addr, get_mem_index(s),
+                                          issinfo);
                         break;
                     default:
                     case 3:
-                        gen_aa32_ld16s(s, tmp, addr, get_mem_index(s));
+                        gen_aa32_ld16s_iss(s, tmp, addr, get_mem_index(s),
+                                           issinfo);
                         break;
                     }
                 } else {
                     /* store */
                     tmp = load_reg(s, rd);
-                    gen_aa32_st16(s, tmp, addr, get_mem_index(s));
+                    gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s), issinfo);
                     tcg_temp_free_i32(tmp);
                 }
                 /* Perform base writeback before the loaded value to
@@ -9198,17 +9271,17 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 /* load */
                 tmp = tcg_temp_new_i32();
                 if (insn & (1 << 22)) {
-                    gen_aa32_ld8u(s, tmp, tmp2, i);
+                    gen_aa32_ld8u_iss(s, tmp, tmp2, i, rd);
                 } else {
-                    gen_aa32_ld32u(s, tmp, tmp2, i);
+                    gen_aa32_ld32u_iss(s, tmp, tmp2, i, rd);
                 }
             } else {
                 /* store */
                 tmp = load_reg(s, rd);
                 if (insn & (1 << 22)) {
-                    gen_aa32_st8(s, tmp, tmp2, i);
+                    gen_aa32_st8_iss(s, tmp, tmp2, i, rd);
                 } else {
-                    gen_aa32_st32(s, tmp, tmp2, i);
+                    gen_aa32_st32_iss(s, tmp, tmp2, i, rd);
                 }
                 tcg_temp_free_i32(tmp);
             }
@@ -9669,13 +9742,16 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         tmp = tcg_temp_new_i32();
                         switch (op) {
                         case 0: /* ldab */
-                            gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
+                            gen_aa32_ld8u_iss(s, tmp, addr, get_mem_index(s),
+                                              rs | ISSIsAcqRel);
                             break;
                         case 1: /* ldah */
-                            gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
+                            gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s),
+                                               rs | ISSIsAcqRel);
                             break;
                         case 2: /* lda */
-                            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+                            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s),
+                                               rs | ISSIsAcqRel);
                             break;
                         default:
                             abort();
@@ -9685,13 +9761,16 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         tmp = load_reg(s, rs);
                         switch (op) {
                         case 0: /* stlb */
-                            gen_aa32_st8(s, tmp, addr, get_mem_index(s));
+                            gen_aa32_st8_iss(s, tmp, addr, get_mem_index(s),
+                                             rs | ISSIsAcqRel);
                             break;
                         case 1: /* stlh */
-                            gen_aa32_st16(s, tmp, addr, get_mem_index(s));
+                            gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s),
+                                              rs | ISSIsAcqRel);
                             break;
                         case 2: /* stl */
-                            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
+                            gen_aa32_st32_iss(s, tmp, addr, get_mem_index(s),
+                                              rs | ISSIsAcqRel);
                             break;
                         default:
                             abort();
@@ -10637,6 +10716,8 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
         int postinc = 0;
         int writeback = 0;
         int memidx;
+        ISSInfo issinfo;
+
         if ((insn & 0x01100000) == 0x01000000) {
             if (disas_neon_ls_insn(s, insn)) {
                 goto illegal_op;
@@ -10740,24 +10821,27 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                 }
             }
         }
+
+        issinfo = writeback ? ISSInvalid : rs;
+
         if (insn & (1 << 20)) {
             /* Load.  */
             tmp = tcg_temp_new_i32();
             switch (op) {
             case 0:
-                gen_aa32_ld8u(s, tmp, addr, memidx);
+                gen_aa32_ld8u_iss(s, tmp, addr, memidx, issinfo);
                 break;
             case 4:
-                gen_aa32_ld8s(s, tmp, addr, memidx);
+                gen_aa32_ld8s_iss(s, tmp, addr, memidx, issinfo);
                 break;
             case 1:
-                gen_aa32_ld16u(s, tmp, addr, memidx);
+                gen_aa32_ld16u_iss(s, tmp, addr, memidx, issinfo);
                 break;
             case 5:
-                gen_aa32_ld16s(s, tmp, addr, memidx);
+                gen_aa32_ld16s_iss(s, tmp, addr, memidx, issinfo);
                 break;
             case 2:
-                gen_aa32_ld32u(s, tmp, addr, memidx);
+                gen_aa32_ld32u_iss(s, tmp, addr, memidx, issinfo);
                 break;
             default:
                 tcg_temp_free_i32(tmp);
@@ -10774,13 +10858,13 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
             tmp = load_reg(s, rs);
             switch (op) {
             case 0:
-                gen_aa32_st8(s, tmp, addr, memidx);
+                gen_aa32_st8_iss(s, tmp, addr, memidx, issinfo);
                 break;
             case 1:
-                gen_aa32_st16(s, tmp, addr, memidx);
+                gen_aa32_st16_iss(s, tmp, addr, memidx, issinfo);
                 break;
             case 2:
-                gen_aa32_st32(s, tmp, addr, memidx);
+                gen_aa32_st32_iss(s, tmp, addr, memidx, issinfo);
                 break;
             default:
                 tcg_temp_free_i32(tmp);
@@ -10917,7 +11001,8 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
             addr = tcg_temp_new_i32();
             tcg_gen_movi_i32(addr, val);
             tmp = tcg_temp_new_i32();
-            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s),
+                               rd | ISSIs16Bit);
             tcg_temp_free_i32(addr);
             store_reg(s, rd, tmp);
             break;
@@ -11120,28 +11205,28 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
 
         switch (op) {
         case 0: /* str */
-            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
+            gen_aa32_st32_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         case 1: /* strh */
-            gen_aa32_st16(s, tmp, addr, get_mem_index(s));
+            gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         case 2: /* strb */
-            gen_aa32_st8(s, tmp, addr, get_mem_index(s));
+            gen_aa32_st8_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         case 3: /* ldrsb */
-            gen_aa32_ld8s(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld8s_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         case 4: /* ldr */
-            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         case 5: /* ldrh */
-            gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         case 6: /* ldrb */
-            gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld8u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         case 7: /* ldrsh */
-            gen_aa32_ld16s(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld16s_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             break;
         }
         if (op >= 3) { /* load */
@@ -11185,12 +11270,12 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
         if (insn & (1 << 11)) {
             /* load */
             tmp = tcg_temp_new_i32();
-            gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld8u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             store_reg(s, rd, tmp);
         } else {
             /* store */
             tmp = load_reg(s, rd);
-            gen_aa32_st8(s, tmp, addr, get_mem_index(s));
+            gen_aa32_st8_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             tcg_temp_free_i32(tmp);
         }
         tcg_temp_free_i32(addr);
@@ -11207,12 +11292,12 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
         if (insn & (1 << 11)) {
             /* load */
             tmp = tcg_temp_new_i32();
-            gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             store_reg(s, rd, tmp);
         } else {
             /* store */
             tmp = load_reg(s, rd);
-            gen_aa32_st16(s, tmp, addr, get_mem_index(s));
+            gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             tcg_temp_free_i32(tmp);
         }
         tcg_temp_free_i32(addr);
@@ -11228,12 +11313,12 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
         if (insn & (1 << 11)) {
             /* load */
             tmp = tcg_temp_new_i32();
-            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             store_reg(s, rd, tmp);
         } else {
             /* store */
             tmp = load_reg(s, rd);
-            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
+            gen_aa32_st32_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
             tcg_temp_free_i32(tmp);
         }
         tcg_temp_free_i32(addr);
@@ -11715,6 +11800,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
         store_cpu_field(tmp, condexec_bits);
       }
     do {
+        dc->insn_start_idx = tcg_op_buf_count();
         tcg_gen_insn_start(dc->pc,
                            (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
                            0);
-- 
2.7.4
