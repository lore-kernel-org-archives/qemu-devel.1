Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPY-0003q6-4W
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPW-00038a-0m
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:36 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPV-00036b-OH
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:33 -0400
Received: by mail-pf0-x241.google.com with SMTP id h75so859450pfh.5
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:33 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:08 -0700
Message-Id: <20170804054426.10590-6-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 05/23] tcg/s390: Introduce TCG_REG_TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.h     |  2 +-
 tcg/s390/tcg-target.inc.c | 71 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 8fea9646b4..8c5a30ccf8 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -95,7 +95,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_extrl_i64_i32  0
 #define TCG_TARGET_HAS_extrh_i64_i32  0
 #define TCG_TARGET_HAS_goto_ptr       1
-#define TCG_TARGET_HAS_direct_jump    1
+#define TCG_TARGET_HAS_direct_jump    (s390_facilities & FACILITY_GEN_INST_EXT)
 
 #define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index ee0dff995a..e007586315 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -51,6 +51,12 @@
 /* A scratch register that may be be used throughout the backend.  */
 #define TCG_TMP0        TCG_REG_R1
 
+/* A scratch register that holds a pointer to the beginning of the TB.
+   We don't need this when we have pc-relative loads with the general
+   instructions extension facility.  */
+#define TCG_REG_TB      TCG_REG_R12
+#define USE_REG_TB      (!(s390_facilities & FACILITY_GEN_INST_EXT))
+
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG TCG_REG_R13
 #endif
@@ -556,8 +562,8 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
 }
 
 /* load a register with an immediate value */
-static void tcg_out_movi(TCGContext *s, TCGType type,
-                         TCGReg ret, tcg_target_long sval)
+static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long sval, bool in_prologue)
 {
     static const S390Opcode lli_insns[4] = {
         RI_LLILL, RI_LLILH, RI_LLIHL, RI_LLIHH
@@ -601,13 +607,22 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
         }
     }
 
-    /* Try for PC-relative address load.  */
+    /* Try for PC-relative address load.  For odd addresses,
+       attempt to use an offset from the start of the TB.  */
     if ((sval & 1) == 0) {
         ptrdiff_t off = tcg_pcrel_diff(s, (void *)sval) >> 1;
         if (off == (int32_t)off) {
             tcg_out_insn(s, RIL, LARL, ret, off);
             return;
         }
+    } else if (USE_REG_TB && !in_prologue) {
+        ptrdiff_t off = sval - (uintptr_t)s->code_gen_ptr;
+        if (off == sextract64(off, 0, 20)) {
+            /* This is certain to be an address within TB, and therefore
+               OFF will be negative; don't try RX_LA.  */
+            tcg_out_insn(s, RXY, LAY, ret, TCG_REG_TB, TCG_REG_NONE, off);
+            return;
+        }
     }
 
     /* If extended immediates are not present, then we may have to issue
@@ -663,6 +678,11 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 }
 
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long sval)
+{
+    tcg_out_movi_int(s, type, ret, sval, false);
+}
 
 /* Emit a load/store type instruction.  Inputs are:
    DATA:     The register to be loaded or stored.
@@ -739,6 +759,13 @@ static void tcg_out_ld_abs(TCGContext *s, TCGType type, TCGReg dest, void *abs)
             return;
         }
     }
+    if (USE_REG_TB) {
+        ptrdiff_t disp = abs - (void *)s->code_gen_ptr;
+        if (disp == sextract64(disp, 0, 20)) {
+            tcg_out_ld(s, type, dest, TCG_REG_TB, disp);
+            return;
+        }
+    }
 
     tcg_out_movi(s, TCG_TYPE_PTR, dest, addr & ~0xffff);
     tcg_out_ld(s, type, dest, dest, addr & 0xffff);
@@ -1690,6 +1717,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_goto_tb:
+        a0 = args[0];
         if (s->tb_jmp_insn_offset) {
             /* branch displacement must be aligned for atomic patching;
              * see if we need to add extra nop before branch
@@ -1697,21 +1725,34 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             if (!QEMU_PTR_IS_ALIGNED(s->code_ptr + 1, 4)) {
                 tcg_out16(s, NOP);
             }
+            tcg_debug_assert(!USE_REG_TB);
             tcg_out16(s, RIL_BRCL | (S390_CC_ALWAYS << 4));
-            s->tb_jmp_insn_offset[args[0]] = tcg_current_code_size(s);
+            s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
             s->code_ptr += 2;
         } else {
-            /* load address stored at s->tb_jmp_target_addr + args[0] */
-            tcg_out_ld_abs(s, TCG_TYPE_PTR, TCG_TMP0,
-                           s->tb_jmp_target_addr + args[0]);
+            /* load address stored at s->tb_jmp_target_addr + a0 */
+            tcg_out_ld_abs(s, TCG_TYPE_PTR, TCG_REG_TB,
+                           s->tb_jmp_target_addr + a0);
             /* and go there */
-            tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, TCG_TMP0);
+            tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, TCG_REG_TB);
+        }
+        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
+
+        /* For the unlinked path of goto_tb, we need to reset
+           TCG_REG_TB to the beginning of this TB.  */
+        if (USE_REG_TB) {
+            int ofs = -tcg_current_code_size(s);
+            assert(ofs == (int16_t)ofs);
+            tcg_out_insn(s, RI, AGHI, TCG_REG_TB, ofs);
         }
-        s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
         break;
 
     case INDEX_op_goto_ptr:
-        tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, args[0]);
+        a0 = args[0];
+        if (USE_REG_TB) {
+            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
+        }
+        tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, a0);
         break;
 
     OP_32_64(ld8u):
@@ -2476,6 +2517,9 @@ static void tcg_target_init(TCGContext *s)
     /* XXX many insns can't be used with R0, so we better avoid it for now */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
+    if (USE_REG_TB) {
+        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);
+    }
 }
 
 #define FRAME_SIZE  ((int)(TCG_TARGET_CALL_STACK_OFFSET          \
@@ -2496,12 +2540,17 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 #ifndef CONFIG_SOFTMMU
     if (guest_base >= 0x80000) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base, true);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
 #endif
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
+    if (USE_REG_TB) {
+        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB,
+                    tcg_target_call_iarg_regs[1]);
+    }
+
     /* br %r3 (go to TB) */
     tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, tcg_target_call_iarg_regs[1]);
 
-- 
2.13.3
