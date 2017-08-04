Received: from eggs.gnu.org ([2001:4830:134:3::10]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPa-0003uS-Hj
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPY-0003Eo-Cg
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:38 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPY-0003Cc-0R
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:36 -0400
Received: by mail-pg0-x244.google.com with SMTP id y192so836589pgd.1
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:35 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.33 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:10 -0700
Message-Id: <20170804054426.10590-8-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 07/23] tcg/s390: Use constant pool for
 movi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Split out maybe_out_small_movi for use with other operations
that want to add to the constant pool.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/elf.h             |   3 +-
 tcg/s390/tcg-target.h     |   1 +
 tcg/s390/tcg-target.inc.c | 130 +++++++++++++++++++++++++++-------------------
 3 files changed, 80 insertions(+), 54 deletions(-)

diff --git a/include/elf.h b/include/elf.h
index cd51434877..e8a515ce3d 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -942,8 +942,9 @@ typedef struct {
 #define R_390_TLS_DTPOFF	55	/* Offset in TLS block.  */
 #define R_390_TLS_TPOFF		56	/* Negate offset in static TLS
                                            block.  */
+#define R_390_20                57
 /* Keep this the last entry.  */
-#define R_390_NUM	57
+#define R_390_NUM               58
 
 /* x86-64 relocation types */
 #define R_X86_64_NONE		0	/* No reloc */
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 8c5a30ccf8..18a0efac3e 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -156,5 +156,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
+#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 59c0da0922..29b77ff67f 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -29,6 +29,7 @@
 #error "unsupported code generation mode"
 #endif
 
+#include "tcg-pool.inc.c"
 #include "elf.h"
 
 /* ??? The translation blocks produced by TCG are generally small enough to
@@ -361,6 +362,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     intptr_t pcrel2;
+    uint32_t old;
 
     value += addend;
     pcrel2 = (tcg_insn_unit *)value - code_ptr;
@@ -374,6 +376,12 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
         assert(pcrel2 == (int32_t)pcrel2);
         tcg_patch32(code_ptr, pcrel2);
         break;
+    case R_390_20:
+        assert(value == sextract64(value, 0, 20));
+        old = *(uint32_t *)code_ptr & 0xf00000ff;
+        old |= ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
+        tcg_patch32(code_ptr, old);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -562,14 +570,16 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
     }
 }
 
-/* load a register with an immediate value */
-static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
-                             tcg_target_long sval, bool in_prologue)
-{
-    static const S390Opcode lli_insns[4] = {
-        RI_LLILL, RI_LLILH, RI_LLIHL, RI_LLIHH
-    };
+static const S390Opcode lli_insns[4] = {
+    RI_LLILL, RI_LLILH, RI_LLIHL, RI_LLIHH
+};
+static const S390Opcode ii_insns[4] = {
+    RI_IILL, RI_IILH, RI_IIHL, RI_IIHH
+};
 
+static bool maybe_out_small_movi(TCGContext *s, TCGType type,
+                                 TCGReg ret, tcg_target_long sval)
+{
     tcg_target_ulong uval = sval;
     int i;
 
@@ -581,17 +591,37 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     /* Try all 32-bit insns that can load it in one go.  */
     if (sval >= -0x8000 && sval < 0x8000) {
         tcg_out_insn(s, RI, LGHI, ret, sval);
-        return;
+        return true;
     }
 
     for (i = 0; i < 4; i++) {
         tcg_target_long mask = 0xffffull << i*16;
         if ((uval & mask) == uval) {
             tcg_out_insn_RI(s, lli_insns[i], ret, uval >> i*16);
-            return;
+            return true;
         }
     }
 
+    return false;
+}
+
+/* load a register with an immediate value */
+static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long sval, bool in_prologue)
+{
+    tcg_target_ulong uval;
+
+    /* Try all 32-bit insns that can load it in one go.  */
+    if (maybe_out_small_movi(s, type, ret, sval)) {
+        return;
+    }
+
+    uval = sval;
+    if (type == TCG_TYPE_I32) {
+        uval = (uint32_t)sval;
+        sval = (int32_t)sval;
+    }
+
     /* Try all 48-bit insns that can load it in one go.  */
     if (s390_facilities & FACILITY_EXT_IMM) {
         if (sval == (int32_t)sval) {
@@ -603,7 +633,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
             return;
         }
         if ((uval & 0xffffffff) == 0) {
-            tcg_out_insn(s, RIL, LLIHF, ret, uval >> 31 >> 1);
+            tcg_out_insn(s, RIL, LLIHF, ret, uval >> 32);
             return;
         }
     }
@@ -626,55 +656,44 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         }
     }
 
-    /* If extended immediates are not present, then we may have to issue
-       several instructions to load the low 32 bits.  */
-    if (!(s390_facilities & FACILITY_EXT_IMM)) {
-        /* A 32-bit unsigned value can be loaded in 2 insns.  And given
-           that the lli_insns loop above did not succeed, we know that
-           both insns are required.  */
-        if (uval <= 0xffffffff) {
-            tcg_out_insn(s, RI, LLILL, ret, uval);
-            tcg_out_insn(s, RI, IILH, ret, uval >> 16);
-            return;
-        }
+    /* A 32-bit unsigned value can be loaded in 2 insns.  And given
+       that LLILL, LLIHL, LLILF above did not succeed, we know that
+       both insns are required.  */
+    if (uval <= 0xffffffff) {
+        tcg_out_insn(s, RI, LLILL, ret, uval);
+        tcg_out_insn(s, RI, IILH, ret, uval >> 16);
+        return;
+    }
 
-        /* If all high bits are set, the value can be loaded in 2 or 3 insns.
-           We first want to make sure that all the high bits get set.  With
-           luck the low 16-bits can be considered negative to perform that for
-           free, otherwise we load an explicit -1.  */
-        if (sval >> 31 >> 1 == -1) {
-            if (uval & 0x8000) {
-                tcg_out_insn(s, RI, LGHI, ret, uval);
-            } else {
-                tcg_out_insn(s, RI, LGHI, ret, -1);
-                tcg_out_insn(s, RI, IILL, ret, uval);
-            }
-            tcg_out_insn(s, RI, IILH, ret, uval >> 16);
-            return;
+    /* When allowed, stuff it in the constant pool.  */
+    if (!in_prologue) {
+        if (USE_REG_TB) {
+            tcg_out_insn(s, RXY, LG, ret, TCG_REG_TB, TCG_REG_NONE, 0);
+            new_pool_label(s, sval, R_390_20, s->code_ptr - 2,
+                           -(intptr_t)s->code_gen_ptr);
+        } else {
+            tcg_out_insn(s, RIL, LGRL, ret, 0);
+            new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
         }
+        return;
     }
 
-    /* If we get here, both the high and low parts have non-zero bits.  */
-
-    /* Recurse to load the lower 32-bits.  */
-    tcg_out_movi(s, TCG_TYPE_I64, ret, uval & 0xffffffff);
-
-    /* Insert data into the high 32-bits.  */
-    uval = uval >> 31 >> 1;
+    /* What's left is for the prologue, loading GUEST_BASE, and because
+       it failed to match above, is known to be a full 64-bit quantity.
+       We could try more than this, but it probably wouldn't pay off.  */
     if (s390_facilities & FACILITY_EXT_IMM) {
-        if (uval < 0x10000) {
-            tcg_out_insn(s, RI, IIHL, ret, uval);
-        } else if ((uval & 0xffff) == 0) {
-            tcg_out_insn(s, RI, IIHH, ret, uval >> 16);
-        } else {
-            tcg_out_insn(s, RIL, IIHF, ret, uval);
-        }
+        tcg_out_insn(s, RIL, LLILF, ret, uval);
+        tcg_out_insn(s, RIL, IIHF, ret, uval >> 32);
     } else {
-        if (uval & 0xffff) {
-            tcg_out_insn(s, RI, IIHL, ret, uval);
-        }
-        if (uval & 0xffff0000) {
-            tcg_out_insn(s, RI, IIHH, ret, uval >> 16);
+        const S390Opcode *insns = lli_insns;
+        int i;
+
+        for (i = 0; i < 4; i++) {
+            uint16_t part = uval >> (16 * i);
+            if (part) {
+                tcg_out_insn_RI(s, insns[i], ret, part);
+                insns = ii_insns;
+            }
         }
     }
 }
@@ -2573,6 +2592,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, TCG_REG_R14);
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0x07, count * sizeof(tcg_insn_unit));
+}
+
 typedef struct {
     DebugFrameHeader h;
     uint8_t fde_def_cfa[4];
-- 
2.13.3
