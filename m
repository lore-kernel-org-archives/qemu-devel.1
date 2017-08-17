Received: from eggs.gnu.org ([2001:4830:134:3::10]:37478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9S-00043O-Sb
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9N-0005GW-6J
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:14 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9N-0005Fc-0L
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:09 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 49so41956846wrw.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:03:58 +0100
Message-Id: <20170817180404.29334-4-alex.bennee@linaro.org>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/9] tcg: generate ptrs to vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As we operate directly on the vectors in memory we pass around the
address for TCG_TYPE_VECTOR. Currently only helpers ever see these
values but if we were to generate simd backend instructions they would
load directly from the backing store.

We also need to ensure when copying from one temp register to the
other the right size is used.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tcg/tcg.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 35598296c5..e16811d68d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2034,7 +2034,21 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
         break;
     case TEMP_VAL_MEM:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs, ts->indirect_base);
-        tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
+        if (ts->type == TCG_TYPE_VECTOR) {
+            /* Vector registers are ptr's to the memory representation */
+            TCGArg args[TCG_MAX_OP_ARGS];
+            int const_args[TCG_MAX_OP_ARGS];
+            args[0] = reg;
+            args[1] = ts->mem_base->reg;
+            args[2] = ts->mem_offset;
+            const_args[0] = 0;
+            const_args[1] = 0;
+            const_args[2] = 1;
+            /* FIXME: needs to by host_ptr centric */
+            tcg_out_op(s, INDEX_op_add_i64, args, const_args);
+        } else {
+            tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
+        }
         ts->mem_coherent = 1;
         break;
     case TEMP_VAL_DEAD:
@@ -2196,6 +2210,10 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
                 ots->reg = tcg_reg_alloc(s, tcg_target_available_regs[otype],
                                          allocated_regs, ots->indirect_base);
             }
+            /* For the purposes of moving stuff about it is a host ptr */
+            if (otype == TCG_TYPE_VECTOR) {
+                otype = TCG_TYPE_PTR;
+            }
             tcg_out_mov(s, otype, ots->reg, ts->reg);
         }
         ots->val_type = TEMP_VAL_REG;
@@ -2440,7 +2458,11 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
 
             if (ts->val_type == TEMP_VAL_REG) {
                 if (ts->reg != reg) {
-                    tcg_out_mov(s, ts->type, reg, ts->reg);
+                    if (ts->type == TCG_TYPE_VECTOR) {
+                        tcg_out_mov(s, TCG_TYPE_PTR, reg, ts->reg);
+                    } else {
+                        tcg_out_mov(s, ts->type, reg, ts->reg);
+                    }
                 }
             } else {
                 TCGRegSet arg_set;
-- 
2.13.0
