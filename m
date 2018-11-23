Received: from eggs.gnu.org ([2001:4830:134:3::10]:43774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCif-0007yV-Qw
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCid-000380-KD
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCib-00036V-Me
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:06 -0500
Received: by mail-wm1-x344.google.com with SMTP id y1so8891142wmi.3
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:24 +0100
Message-Id: <20181123144558.5048-4-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 03/37] tcg: Return success from
 patch_reloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

This moves the assert for success from inside patch_reloc
to outside patch_reloc.  This touches all tcg backends.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 44 ++++++++++++++-------------------
 tcg/arm/tcg-target.inc.c     | 26 +++++++++-----------
 tcg/i386/tcg-target.inc.c    | 17 +++++++------
 tcg/mips/tcg-target.inc.c    | 29 +++++++++-------------
 tcg/ppc/tcg-target.inc.c     | 47 ++++++++++++++++++++++--------------
 tcg/s390/tcg-target.inc.c    | 37 +++++++++++++++++++---------
 tcg/sparc/tcg-target.inc.c   | 13 ++++++----
 tcg/tcg-pool.inc.c           |  5 +++-
 tcg/tcg.c                    |  8 +++---
 tcg/tci/tcg-target.inc.c     |  3 ++-
 10 files changed, 125 insertions(+), 104 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 083592a4d7..30091f6a69 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -78,48 +78,40 @@ static const int tcg_target_call_oarg_regs[1] = {
 #define TCG_REG_GUEST_BASE TCG_REG_X28
 #endif
 
-static inline void reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - code_ptr;
-    tcg_debug_assert(offset == sextract64(offset, 0, 26));
-    /* read instruction, mask away previous PC_REL26 parameter contents,
-       set the proper offset, then write back the instruction. */
-    *code_ptr = deposit32(*code_ptr, 0, 26, offset);
+    if (offset == sextract64(offset, 0, 26)) {
+        /* read instruction, mask away previous PC_REL26 parameter contents,
+           set the proper offset, then write back the instruction. */
+        *code_ptr = deposit32(*code_ptr, 0, 26, offset);
+        return true;
+    }
+    return false;
 }
 
-static inline void reloc_pc26_atomic(tcg_insn_unit *code_ptr,
-                                     tcg_insn_unit *target)
+static inline bool reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - code_ptr;
-    tcg_insn_unit insn;
-    tcg_debug_assert(offset == sextract64(offset, 0, 26));
-    /* read instruction, mask away previous PC_REL26 parameter contents,
-       set the proper offset, then write back the instruction. */
-    insn = atomic_read(code_ptr);
-    atomic_set(code_ptr, deposit32(insn, 0, 26, offset));
+    if (offset == sextract64(offset, 0, 19)) {
+        *code_ptr = deposit32(*code_ptr, 5, 19, offset);
+        return true;
+    }
+    return false;
 }
 
-static inline void reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
-{
-    ptrdiff_t offset = target - code_ptr;
-    tcg_debug_assert(offset == sextract64(offset, 0, 19));
-    *code_ptr = deposit32(*code_ptr, 5, 19, offset);
-}
-
-static inline void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                                intptr_t value, intptr_t addend)
 {
     tcg_debug_assert(addend == 0);
     switch (type) {
     case R_AARCH64_JUMP26:
     case R_AARCH64_CALL26:
-        reloc_pc26(code_ptr, (tcg_insn_unit *)value);
-        break;
+        return reloc_pc26(code_ptr, (tcg_insn_unit *)value);
     case R_AARCH64_CONDBR19:
-        reloc_pc19(code_ptr, (tcg_insn_unit *)value);
-        break;
+        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index e1fbf465cb..80d174ef44 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -187,27 +187,23 @@ static const uint8_t tcg_cond_to_arm_cond[] = {
     [TCG_COND_GTU] = COND_HI,
 };
 
-static inline void reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
-    *code_ptr = (*code_ptr & ~0xffffff) | (offset & 0xffffff);
+    if (offset == sextract32(offset, 0, 24)) {
+        *code_ptr = (*code_ptr & ~0xffffff) | (offset & 0xffffff);
+        return true;
+    }
+    return false;
 }
 
-static inline void reloc_pc24_atomic(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
-{
-    ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
-    tcg_insn_unit insn = atomic_read(code_ptr);
-    tcg_debug_assert(offset == sextract32(offset, 0, 24));
-    atomic_set(code_ptr, deposit32(insn, 0, 24, offset));
-}
-
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_debug_assert(addend == 0);
 
     if (type == R_ARM_PC24) {
-        reloc_pc24(code_ptr, (tcg_insn_unit *)value);
+        return reloc_pc24(code_ptr, (tcg_insn_unit *)value);
     } else if (type == R_ARM_PC13) {
         intptr_t diff = value - (uintptr_t)(code_ptr + 2);
         tcg_insn_unit insn = *code_ptr;
@@ -218,10 +214,9 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
             if (!u) {
                 diff = -diff;
             }
-        } else {
+        } else if (diff >= 0x1000 && diff < 0x100000) {
             int rd = extract32(insn, 12, 4);
             int rt = rd == TCG_REG_PC ? TCG_REG_TMP : rd;
-            assert(diff >= 0x1000 && diff < 0x100000);
             /* add rt, pc, #high */
             *code_ptr++ = ((insn & 0xf0000000) | (1 << 25) | ARITH_ADD
                            | (TCG_REG_PC << 16) | (rt << 12)
@@ -230,10 +225,13 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
             insn = deposit32(insn, 12, 4, rt);
             diff &= 0xfff;
             u = 1;
+        } else {
+            return false;
         }
         insn = deposit32(insn, 23, 1, u);
         insn = deposit32(insn, 0, 12, diff);
         *code_ptr = insn;
+        return true;
     } else {
         g_assert_not_reached();
     }
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 436195894b..4f66a0c5ae 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -167,29 +167,32 @@ static bool have_lzcnt;
 
 static tcg_insn_unit *tb_ret_addr;
 
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     value += addend;
-    switch(type) {
+
+    switch (type) {
     case R_386_PC32:
         value -= (uintptr_t)code_ptr;
         if (value != (int32_t)value) {
-            tcg_abort();
+            return false;
         }
         /* FALLTHRU */
     case R_386_32:
         tcg_patch32(code_ptr, value);
-        break;
+        return true;
+
     case R_386_PC8:
         value -= (uintptr_t)code_ptr;
         if (value != (int8_t)value) {
-            tcg_abort();
+            return false;
         }
         tcg_patch8(code_ptr, value);
-        break;
+        return true;
+
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index cff525373b..e59c66b607 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -144,36 +144,29 @@ static tcg_insn_unit *bswap32_addr;
 static tcg_insn_unit *bswap32u_addr;
 static tcg_insn_unit *bswap64_addr;
 
-static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc16_cond(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
     /* Let the compiler perform the right-shift as part of the arithmetic.  */
     ptrdiff_t disp = target - (pc + 1);
-    tcg_debug_assert(disp == (int16_t)disp);
-    return disp & 0xffff;
+    if (disp == (int16_t)disp) {
+        *pc = deposit32(*pc, 0, 16, disp);
+        return true;
+    } else {
+        return false;
+    }
 }
 
-static inline void reloc_pc16(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc16(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
-    *pc = deposit32(*pc, 0, 16, reloc_pc16_val(pc, target));
+    tcg_debug_assert(reloc_pc16_cond(pc, target));
 }
 
-static inline uint32_t reloc_26_val(tcg_insn_unit *pc, tcg_insn_unit *target)
-{
-    tcg_debug_assert((((uintptr_t)pc ^ (uintptr_t)target) & 0xf0000000) == 0);
-    return ((uintptr_t)target >> 2) & 0x3ffffff;
-}
-
-static inline void reloc_26(tcg_insn_unit *pc, tcg_insn_unit *target)
-{
-    *pc = deposit32(*pc, 0, 26, reloc_26_val(pc, target));
-}
-
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_debug_assert(type == R_MIPS_PC16);
     tcg_debug_assert(addend == 0);
-    reloc_pc16(code_ptr, (tcg_insn_unit *)value);
+    return reloc_pc16_cond(code_ptr, (tcg_insn_unit *)value);
 }
 
 #define TCG_CT_CONST_ZERO 0x100
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c2f729ee8f..656a9ff603 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -186,16 +186,14 @@ static inline bool in_range_b(tcg_target_long target)
     return target == sextract64(target, 0, 26);
 }
 
-static uint32_t reloc_pc24_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc24_cond(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
-    tcg_debug_assert(in_range_b(disp));
-    return disp & 0x3fffffc;
-}
-
-static void reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
-{
-    *pc = (*pc & ~0x3fffffc) | reloc_pc24_val(pc, target);
+    if (in_range_b(disp)) {
+        *pc = (*pc & ~0x3fffffc) | (disp & 0x3fffffc);
+        return true;
+    }
+    return false;
 }
 
 static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
@@ -205,10 +203,22 @@ static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
     return disp & 0xfffc;
 }
 
+static bool reloc_pc14_cond(tcg_insn_unit *pc, tcg_insn_unit *target)
+{
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
+    if (disp == (int16_t) disp) {
+        *pc = (*pc & ~0xfffc) | (disp & 0xfffc);
+        return true;
+    }
+    return false;
+}
+
+#ifdef CONFIG_SOFTMMU
 static void reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
-    *pc = (*pc & ~0xfffc) | reloc_pc14_val(pc, target);
+    tcg_debug_assert(reloc_pc14_cond(pc, target));
 }
+#endif
 
 static inline void tcg_out_b_noaddr(TCGContext *s, int insn)
 {
@@ -525,7 +535,7 @@ static const uint32_t tcg_to_isel[] = {
     [TCG_COND_GTU] = ISEL | BC_(7, CR_GT),
 };
 
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_insn_unit *target;
@@ -536,11 +546,9 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 
     switch (type) {
     case R_PPC_REL14:
-        reloc_pc14(code_ptr, target);
-        break;
+        return reloc_pc14_cond(code_ptr, target);
     case R_PPC_REL24:
-        reloc_pc24(code_ptr, target);
-        break;
+        return reloc_pc24_cond(code_ptr, target);
     case R_PPC_ADDR16:
         /* We are abusing this relocation type.  This points to a pair
            of insns, addis + load.  If the displacement is small, we
@@ -552,11 +560,14 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
         } else {
             int16_t lo = value;
             int hi = value - lo;
-            assert(hi + lo == value);
-            code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
-            code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
+            if (hi + lo == value) {
+                code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
+                code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
+            } else {
+                return false;
+            }
         }
-        break;
+        return true;
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 17c435ade5..a8d72dd630 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -366,7 +366,7 @@ static void * const qemu_st_helpers[16] = {
 static tcg_insn_unit *tb_ret_addr;
 uint64_t s390_facilities;
 
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     intptr_t pcrel2;
@@ -377,22 +377,35 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 
     switch (type) {
     case R_390_PC16DBL:
-        assert(pcrel2 == (int16_t)pcrel2);
-        tcg_patch16(code_ptr, pcrel2);
+        if (pcrel2 == (int16_t)pcrel2) {
+            tcg_patch16(code_ptr, pcrel2);
+            return true;
+        }
         break;
     case R_390_PC32DBL:
-        assert(pcrel2 == (int32_t)pcrel2);
-        tcg_patch32(code_ptr, pcrel2);
+        if (pcrel2 == (int32_t)pcrel2) {
+            tcg_patch32(code_ptr, pcrel2);
+            return true;
+        }
         break;
     case R_390_20:
-        assert(value == sextract64(value, 0, 20));
-        old = *(uint32_t *)code_ptr & 0xf00000ff;
-        old |= ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
-        tcg_patch32(code_ptr, old);
+        if (value == sextract64(value, 0, 20)) {
+            old = *(uint32_t *)code_ptr & 0xf00000ff;
+            old |= ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
+            tcg_patch32(code_ptr, old);
+            return true;
+        }
         break;
     default:
         g_assert_not_reached();
     }
+    return false;
+}
+
+static void patch_reloc_force(tcg_insn_unit *code_ptr, int type,
+                              intptr_t value, intptr_t addend)
+{
+    tcg_debug_assert(patch_reloc(code_ptr, type, value, addend));
 }
 
 /* parse target specific constraints */
@@ -1618,7 +1631,8 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, 2);
+    patch_reloc_force(lb->label_ptr[0], R_390_PC16DBL,
+                      (intptr_t)s->code_ptr, 2);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
@@ -1639,7 +1653,8 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, 2);
+    patch_reloc_force(lb->label_ptr[0], R_390_PC16DBL,
+                      (intptr_t)s->code_ptr, 2);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 04bdc3df5e..111f3312d3 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -291,32 +291,34 @@ static inline int check_fit_i32(int32_t val, unsigned int bits)
 # define check_fit_ptr  check_fit_i32
 #endif
 
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     uint32_t insn = *code_ptr;
     intptr_t pcrel;
+    bool ret;
 
     value += addend;
     pcrel = tcg_ptr_byte_diff((tcg_insn_unit *)value, code_ptr);
 
     switch (type) {
     case R_SPARC_WDISP16:
-        assert(check_fit_ptr(pcrel >> 2, 16));
+        ret = check_fit_ptr(pcrel >> 2, 16);
         insn &= ~INSN_OFF16(-1);
         insn |= INSN_OFF16(pcrel);
         break;
     case R_SPARC_WDISP19:
-        assert(check_fit_ptr(pcrel >> 2, 19));
+        ret = check_fit_ptr(pcrel >> 2, 19);
         insn &= ~INSN_OFF19(-1);
         insn |= INSN_OFF19(pcrel);
         break;
     case R_SPARC_13:
         /* Note that we're abusing this reloc type for our own needs.  */
+        ret = true;
         if (!check_fit_ptr(value, 13)) {
             int adj = (value > 0 ? 0xff8 : -0x1000);
             value -= adj;
-            assert(check_fit_ptr(value, 13));
+            ret = check_fit_ptr(value, 13);
             *code_ptr++ = (ARITH_ADD | INSN_RD(TCG_REG_T2)
                            | INSN_RS1(TCG_REG_TB) | INSN_IMM13(adj));
             insn ^= INSN_RS1(TCG_REG_TB) ^ INSN_RS1(TCG_REG_T2);
@@ -328,12 +330,13 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
         /* Note that we're abusing this reloc type for our own needs.  */
         code_ptr[0] = deposit32(code_ptr[0], 0, 22, value >> 10);
         code_ptr[1] = deposit32(code_ptr[1], 0, 10, value);
-        return;
+        return value == (intptr_t)(uint32_t)value;
     default:
         g_assert_not_reached();
     }
 
     *code_ptr = insn;
+    return ret;
 }
 
 /* parse target specific constraints */
diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
index 7af5513ff3..ab8f6df8b0 100644
--- a/tcg/tcg-pool.inc.c
+++ b/tcg/tcg-pool.inc.c
@@ -140,6 +140,8 @@ static bool tcg_out_pool_finalize(TCGContext *s)
 
     for (; p != NULL; p = p->next) {
         size_t size = sizeof(tcg_target_ulong) * p->nlong;
+        bool ok;
+
         if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
             if (unlikely(a > s->code_gen_highwater)) {
                 return false;
@@ -148,7 +150,8 @@ static bool tcg_out_pool_finalize(TCGContext *s)
             a += size;
             l = p;
         }
-        patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend);
+        ok = patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend);
+        tcg_debug_assert(ok);
     }
 
     s->code_ptr = a;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e85133ef05..54f1272187 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -66,7 +66,7 @@
 static void tcg_target_init(TCGContext *s);
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode);
 static void tcg_target_qemu_prologue(TCGContext *s);
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend);
 
 /* The CIE and FDE header definitions will be common to all hosts.  */
@@ -268,7 +268,8 @@ static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
         /* FIXME: This may break relocations on RISC targets that
            modify instruction fields in place.  The caller may not have 
            written the initial value.  */
-        patch_reloc(code_ptr, type, l->u.value, addend);
+        bool ok = patch_reloc(code_ptr, type, l->u.value, addend);
+        tcg_debug_assert(ok);
     } else {
         /* add a new relocation entry */
         r = tcg_malloc(sizeof(TCGRelocation));
@@ -288,7 +289,8 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
     tcg_debug_assert(!l->has_value);
 
     for (r = l->u.first_reloc; r != NULL; r = r->next) {
-        patch_reloc(r->ptr, r->type, value, r->addend);
+        bool ok = patch_reloc(r->ptr, r->type, value, r->addend);
+        tcg_debug_assert(ok);
     }
 
     l->has_value = 1;
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 62ed097254..0015a98485 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -369,7 +369,7 @@ static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 };
 #endif
 
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     /* tcg_out_reloc always uses the same type, addend. */
@@ -381,6 +381,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
     } else {
         tcg_patch64(code_ptr, value);
     }
+    return true;
 }
 
 /* Parse target specific constraints. */
-- 
2.17.2
