Received: from eggs.gnu.org ([209.51.188.92]:41741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbn-0007jo-5Y
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbm-0004BK-4H
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbl-0004Ay-Uc
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id bi2so3708742plb.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:37 -0700
Message-Id: <20190504055300.18426-9-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 08/31] tcg: Support cross-class moves
 without instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

PowerPC Altivec does not support direct moves between vector registers
and general registers.  So when tcg_out_mov fails, we can use the
backing memory for the temporary to perform the move.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8ed7cb8654..68d86361e2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3368,7 +3368,20 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                                          ots->indirect_base);
             }
             if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
-                abort();
+                /*
+                 * Cross register class move not supported.
+                 * Store the source register into the destination slot
+                 * and leave the destination temp as TEMP_VAL_MEM.
+                 */
+                assert(!ots->fixed_reg);
+                if (!ts->mem_allocated) {
+                    temp_allocate_frame(s, ots);
+                }
+                tcg_out_st(s, ts->type, ts->reg,
+                           ots->mem_base->reg, ots->mem_offset);
+                ots->mem_coherent = 1;
+                temp_free_or_dead(s, ots, -1);
+                return;
             }
         }
         ots->val_type = TEMP_VAL_REG;
@@ -3470,7 +3483,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
                                 o_preferred_regs, ts->indirect_base);
             if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                abort();
+                /*
+                 * Cross register class move not supported.  Sync the
+                 * temp back to its slot and load from there.
+                 */
+                temp_sync(s, ts, i_allocated_regs, 0, 0);
+                tcg_out_ld(s, ts->type, reg,
+                           ts->mem_base->reg, ts->mem_offset);
             }
         }
         new_args[i] = reg;
@@ -3631,7 +3650,13 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
                 if (ts->reg != reg) {
                     tcg_reg_free(s, reg, allocated_regs);
                     if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                        abort();
+                        /*
+                         * Cross register class move not supported.  Sync the
+                         * temp back to its slot and load from there.
+                         */
+                        temp_sync(s, ts, allocated_regs, 0, 0);
+                        tcg_out_ld(s, ts->type, reg,
+                                   ts->mem_base->reg, ts->mem_offset);
                     }
                 }
             } else {
-- 
2.17.1
