Received: from eggs.gnu.org ([2001:4830:134:3::10]:51609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW18-0003Zf-DR
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW17-0005VH-9P
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:26 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddW17-0005Ub-1t
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:25 -0400
Received: by mail-pg0-x244.google.com with SMTP id u185so936780pgb.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:23:24 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	q199sm1335819pfq.135.2017.08.03.23.23.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 23:23:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 23:23:14 -0700
Message-Id: <20170804062314.12594-7-rth@twiddle.net>
In-Reply-To: <20170804062314.12594-1-rth@twiddle.net>
References: <20170804062314.12594-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 6/6] tcg/i386: Use pdep for deposit
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
 tcg/i386/tcg-target.h     |  4 ++-
 tcg/i386/tcg-target.inc.c | 82 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 85b0ccd98c..e512648c95 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -148,7 +148,9 @@ extern bool have_popcnt;
 #endif
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
-    (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
+    (have_bmi2 ||                              \
+     ((ofs) == 0 && (len) == 8) ||             \
+     ((ofs) == 8 && (len) == 8) ||             \
      ((ofs) == 0 && (len) == 16))
 #define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
 
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 69587c82de..aeefb72aa0 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -329,6 +329,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_PDEP        (0xf5 | P_EXT38 | P_SIMDF2)
 #define OPC_PEXT        (0xf5 | P_EXT38 | P_SIMDF3)
 #define OPC_POP_r32	(0x58)
 #define OPC_POPCNT      (0xb8 | P_EXT | P_SIMDF3)
@@ -554,14 +555,12 @@ static void tcg_out_sfx_pool_imm(TCGContext *s, int r, tcg_target_ulong data)
     tcg_out32(s, 0);
 }
 
-#if 0
 static void tcg_out_opc_pool_imm(TCGContext *s, int opc, int r,
                                  tcg_target_ulong data)
 {
     tcg_out_opc(s, opc, r, 0, 0);
     tcg_out_sfx_pool_imm(s, r, data);
 }
-#endif
 
 static void tcg_out_vex_pool_imm(TCGContext *s, int opc, int r, int v,
                                  tcg_target_ulong data)
@@ -1902,7 +1901,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                               const TCGArg *args, const int *const_args)
 {
-    TCGArg a0, a1, a2, a3;
+    TCGArg a0, a1, a2, a3, a4;
     int c, const_a2, vexop, rexw = 0;
 
 #if TCG_TARGET_REG_BITS == 64
@@ -2262,17 +2261,68 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #endif
 
     OP_32_64(deposit):
-        if (args[3] == 0 && args[4] == 8) {
-            /* load bits 0..7 */
-            tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
-        } else if (args[3] == 8 && args[4] == 8) {
-            /* load bits 8..15 */
-            tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
-        } else if (args[3] == 0 && args[4] == 16) {
-            /* load bits 0..15 */
-            tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
-        } else {
-            tcg_abort();
+        a3 = args[3];
+        a4 = args[4];
+        {
+            tcg_target_ulong mask = deposit64(0, a3, a4, -1);
+
+            if (const_args[1]) {
+                tcg_debug_assert(have_bmi2);
+                if (a3 == 0 && a0 == a2) {
+                    if (a4 <= 32) {
+                        tgen_arithi(s, ARITH_AND, a0, mask, 0);
+                    } else {
+                        tcg_out_opc_pool_imm(s, OPC_ARITH_GvEv + P_REXW
+                                             + ARITH_AND * 8, a0, mask);
+                    }
+                } else {
+                    tcg_out_vex_pool_imm(s, OPC_PDEP
+                                         + (a3 + a4 > 32) * P_REXW,
+                                         a0, a2, mask);
+                }
+                a1 &= ~mask;
+                if (a1 != 0) {
+                    if (!rexw || a1 == (int)a1) {
+                        tgen_arithi(s, ARITH_OR + rexw, a0, a1, 0);
+                    } else {
+                        tcg_out_opc_pool_imm(s, OPC_ARITH_GvEv + P_REXW
+                                             + ARITH_OR * 8, a0, a1);
+                    }
+                }
+            } else if (a0 == a1 && a3 == 0 && a4 == 8) {
+                /* load bits 0..7 */
+                tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
+            } else if (a0 == a1 && a3 == 8 && a4 == 8 && a0 < 4 && a2 < 8) {
+                /* load bits 8..15 */
+                tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
+            } else if (a0 == a1 && a3 == 0 && a4 == 16) {
+                /* load bits 0..15 */
+                tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
+            } else {
+                TCGType type = rexw ? TCG_TYPE_I64 : TCG_TYPE_I32;
+                TCGReg t1 = tcg_reg_alloc_new(s, type);
+                TCGReg t2 = t1;
+
+                tcg_debug_assert(have_bmi2);
+                tcg_out_movi(s, type, t1, mask);
+                if (a0 == a2) {
+                    t2 = tcg_reg_alloc_new(s, type);
+                    tcg_out_vex_modrm(s, OPC_ANDN + rexw, t2, t1, a1);
+                    if (a3 == 0) {
+                        tgen_arithr(s, ARITH_AND + rexw, a0, t1);
+                    } else {
+                        tcg_out_vex_modrm(s, OPC_PDEP + rexw, a0, a2, t1);
+                    }
+                } else {
+                    tcg_out_vex_modrm(s, OPC_ANDN + rexw, a0, t1, a1);
+                    if (a3 == 0) {
+                        tgen_arithr(s, ARITH_AND + rexw, t1, a2);
+                    } else {
+                        tcg_out_vex_modrm(s, OPC_PDEP + rexw, t1, a2, t1);
+                    }
+                }
+                tgen_arithr(s, ARITH_OR + rexw, a0, t2);
+            }
         }
         break;
 
@@ -2480,7 +2530,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         {
             static const TCGTargetOpDef dep
                 = { .args_ct_str = { "Q", "0", "Q" } };
-            return &dep;
+            static const TCGTargetOpDef pdep
+                = { .args_ct_str = { "r", "ri", "r" } };
+            return have_bmi2 ? &pdep : &dep;
         }
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-- 
2.13.3
