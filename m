Received: from eggs.gnu.org ([2001:4830:134:3::10]:35323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU3-0005Ms-P4
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU0-0005S5-Hh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:35 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39802 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITz-0005Ok-Uj
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:32 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:57 +0300
Message-Id: <1486046099-17726-20-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 19/21] tcg/i386: add support for
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
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/i386/tcg-target.inc.c | 68 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1e6edc0..4647e97 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1342,6 +1342,7 @@ static void * const qemu_ld_helpers[] = {
     [MO_BEUW] = helper_be_lduw_mmu,
     [MO_BEUL] = helper_be_ldul_mmu,
     [MO_BEQ]  = helper_be_ldq_mmu,
+    [MO_128]  = helper_te_ldv128_mmu,
 };
 
 /* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
@@ -1355,6 +1356,7 @@ static void * const qemu_st_helpers[] = {
     [MO_BEUW] = helper_be_stw_mmu,
     [MO_BEUL] = helper_be_stl_mmu,
     [MO_BEQ]  = helper_be_stq_mmu,
+    [MO_128]  = helper_te_stv128_mmu,
 };
 
 /* Perform the TLB load and compare.
@@ -1521,12 +1523,30 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
         ofs += 4;
 
         tcg_out_sti(s, TCG_TYPE_PTR, (uintptr_t)l->raddr, TCG_REG_ESP, ofs);
+
+        if ((opc & MO_SSIZE) == MO_128) {
+            ofs += 4;
+            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_EAX, TCG_REG_ESP);
+            tcg_out_addi(s, TCG_REG_EAX, TCG_STATIC_CALL_ARGS_SIZE - 16);
+            tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_EAX, TCG_REG_ESP, ofs);
+        }
     } else {
         tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
         /* The second argument is already loaded with addrlo.  */
         tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[2], oi);
         tcg_out_movi(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[3],
                      (uintptr_t)l->raddr);
+        if ((opc & MO_SSIZE) == MO_128) {
+            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_EAX, TCG_REG_ESP);
+            tcg_out_addi(s, TCG_REG_EAX, TCG_STATIC_CALL_ARGS_SIZE - 16);
+            if (ARRAY_SIZE(tcg_target_call_iarg_regs) > 4) {
+                tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[4],
+                            TCG_REG_EAX);
+            } else {
+                tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_EAX,
+                            TCG_REG_ESP, TCG_TARGET_CALL_STACK_OFFSET);
+            }
+        }
     }
 
     tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)]);
@@ -1562,6 +1582,11 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
             tcg_out_mov(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_EDX);
         }
         break;
+    case MO_128:
+        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_EAX, TCG_REG_ESP);
+        tcg_out_addi(s, TCG_REG_EAX, TCG_STATIC_CALL_ARGS_SIZE - 16);
+        tcg_out_ld(s, TCG_TYPE_V128, l->datalo_reg, TCG_REG_EAX, 0);
+        break;
     default:
         tcg_abort();
     }
@@ -1601,12 +1626,20 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
             ofs += 4;
         }
 
-        tcg_out_st(s, TCG_TYPE_I32, l->datalo_reg, TCG_REG_ESP, ofs);
-        ofs += 4;
-
-        if (s_bits == MO_64) {
-            tcg_out_st(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_ESP, ofs);
+        if (s_bits == MO_128) {
+            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_EAX, TCG_REG_ESP);
+            tcg_out_addi(s, TCG_REG_EAX, TCG_STATIC_CALL_ARGS_SIZE - 16);
+            tcg_out_st(s, TCG_TYPE_V128, l->datalo_reg, TCG_REG_EAX, 0);
+            tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_EAX, TCG_REG_ESP, ofs);
             ofs += 4;
+        } else {
+            tcg_out_st(s, TCG_TYPE_I32, l->datalo_reg, TCG_REG_ESP, ofs);
+            ofs += 4;
+
+            if (s_bits == MO_64) {
+                tcg_out_st(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_ESP, ofs);
+                ofs += 4;
+            }
         }
 
         tcg_out_sti(s, TCG_TYPE_I32, oi, TCG_REG_ESP, ofs);
@@ -1618,8 +1651,16 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     } else {
         tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
         /* The second argument is already loaded with addrlo.  */
-        tcg_out_mov(s, (s_bits == MO_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
-                    tcg_target_call_iarg_regs[2], l->datalo_reg);
+        if (s_bits == MO_128) {
+            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_RAX, TCG_REG_ESP);
+            tcg_out_addi(s, TCG_REG_RAX, TCG_STATIC_CALL_ARGS_SIZE - 16);
+            tcg_out_st(s, TCG_TYPE_V128, l->datalo_reg, TCG_REG_RAX, 0);
+            tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[2],
+                        TCG_REG_RAX);
+        } else {
+            tcg_out_mov(s, (s_bits == MO_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        tcg_target_call_iarg_regs[2], l->datalo_reg);
+        }
         tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[3], oi);
 
         if (ARRAY_SIZE(tcg_target_call_iarg_regs) > 4) {
@@ -1751,6 +1792,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
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
@@ -1894,6 +1939,9 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             tcg_out_modrm_offset(s, movop + seg, datahi, base, ofs+4);
         }
         break;
+    case MO_128:
+        tcg_out_modrm_offset(s, OPC_MOVDQU_R2M + seg, datalo, base, ofs);
+        break;
     default:
         tcg_abort();
     }
@@ -2264,12 +2312,18 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
