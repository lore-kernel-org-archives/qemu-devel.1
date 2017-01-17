Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkp-0003HM-6l
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPko-0003yr-52
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:35 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50386 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkn-0003yL-NX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:34 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:57 +0300
Message-Id: <1484644078-21312-18-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 17/18] tcg/i386: add support for
 qemu_ld_v128/qemu_st_v128 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/i386/tcg-target.inc.c | 63 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index c28fd09..a48da20 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1265,6 +1265,7 @@ static void * const qemu_ld_helpers[] = {
     [MO_BEUW] = helper_be_lduw_mmu,
     [MO_BEUL] = helper_be_ldul_mmu,
     [MO_BEQ]  = helper_be_ldq_mmu,
+    [MO_128]  = helper_te_ldv128_mmu,
 };
 
 /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
@@ -1278,6 +1279,7 @@ static void * const qemu_st_helpers[] = {
     [MO_BEUW] = helper_be_stw_mmu,
     [MO_BEUL] = helper_be_stl_mmu,
     [MO_BEQ]  = helper_be_stq_mmu,
+    [MO_128]  = helper_te_stv128_mmu,
 };
 
 /* Perform the TLB load and compare.
@@ -1444,12 +1446,27 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
         ofs += 4;
 
         tcg_out_sti(s, TCG_TYPE_PTR, (uintptr_t)l->raddr, TCG_REG_ESP, ofs);
+
+        if ((opc & MO_SSIZE) == MO_128) {
+            ofs += 4;
+            tcg_out_sti(s, TCG_TYPE_PTR, (uintptr_t)s->v128_swap,
+                        TCG_REG_ESP, ofs);
+        }
     } else {
         tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
         /* The second argument is already loaded with addrlo.  */
         tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[2], oi);
         tcg_out_movi(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[3],
                      (uintptr_t)l->raddr);
+        if ((opc & MO_SSIZE) == MO_128) {
+            if (ARRAY_SIZE(tcg_target_call_iarg_regs) > 4) {
+                tcg_out_movi(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[4],
+                             (uintptr_t)s->v128_swap);
+            } else {
+                tcg_out_sti(s, TCG_TYPE_PTR, (uintptr_t)s->v128_swap,
+                            TCG_REG_ESP, TCG_TARGET_CALL_STACK_OFFSET);
+            }
+        }
     }
 
     tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)]);
@@ -1485,6 +1502,10 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
             tcg_out_mov(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_EDX);
         }
         break;
+    case MO_128:
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_EAX, (uintptr_t)s->v128_swap);
+        tcg_out_ld(s, TCG_TYPE_V128, l->datalo_reg, TCG_REG_EAX, 0);
+        break;
     default:
         tcg_abort();
     }
@@ -1524,12 +1545,19 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
             ofs += 4;
         }
 
-        tcg_out_st(s, TCG_TYPE_I32, l->datalo_reg, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        if (s_bits == MO_64) {
-            tcg_out_st(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_ESP, ofs);
+        if (s_bits == MO_128) {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_EAX, (uintptr_t)s->v128_swap);
+            tcg_out_st(s, TCG_TYPE_V128, l->datalo_reg, TCG_REG_EAX, 0);
+            tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_EAX, TCG_REG_ESP, ofs);
+            ofs += 4;
+        } else {
+            tcg_out_st(s, TCG_TYPE_I32, l->datalo_reg, TCG_REG_ESP, ofs);
             ofs += 4;
+
+            if (s_bits == MO_64) {
+                tcg_out_st(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_ESP, ofs);
+                ofs += 4;
+            }
         }
 
         tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, ofs);
@@ -1541,8 +1569,16 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     } else {
         tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
         /* The second argument is already loaded with addrlo.  */
-        tcg_out_mov(s, (s_bits == MO_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
-                    tcg_target_call_iarg_regs[2], l->datalo_reg);
+        if (s_bits == MO_128) {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_RAX,
+                         (uintptr_t)s->v128_swap);
+            tcg_out_st(s, TCG_TYPE_V128, l->datalo_reg, TCG_REG_RAX, 0);
+            tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[2],
+                        TCG_REG_RAX);
+        } else {
+            tcg_out_mov(s, (s_bits == MO_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        tcg_target_call_iarg_regs[2], l->datalo_reg);
+        }
         tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[3], oi);
 
         if (ARRAY_SIZE(tcg_target_call_iarg_regs) > 4) {
@@ -1674,6 +1710,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             }
         }
         break;
+    case MO_128:
+        tcg_out_modrm_sib_offset(s, OPC_MOVDQU_M2R + seg, datalo,
+                                 base, index, 0, ofs);
+        break;
     default:
         tcg_abort();
     }
@@ -1817,6 +1857,9 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             tcg_out_modrm_offset(s, movop + seg, datahi, base, ofs+4);
         }
         break;
+    case MO_128:
+        tcg_out_modrm_offset(s, OPC_MOVDQU_R2M + seg, datalo, base, ofs);
+        break;
     default:
         tcg_abort();
     }
@@ -2145,12 +2188,18 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_qemu_ld_i64:
         tcg_out_qemu_ld(s, args, 1);
         break;
+    case INDEX_op_qemu_ld_v128:
+        tcg_out_qemu_ld(s, args, 0);
+        break;
     case INDEX_op_qemu_st_i32:
         tcg_out_qemu_st(s, args, 0);
         break;
     case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, args, 1);
         break;
+    case INDEX_op_qemu_st_v128:
+        tcg_out_qemu_st(s, args, 0);
+        break;
 
     OP_32_64(mulu2):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, args[3]);
-- 
2.1.4
