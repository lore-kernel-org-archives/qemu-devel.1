Received: from eggs.gnu.org ([208.118.235.92]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtoN-0000bA-Kv
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtoL-0002Ky-Nf
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:23 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:38018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtoJ-0002IV-Ph
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id e5so6811399plb.5
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 13:00:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:29 +1100
Message-Id: <20181225205529.10874-43-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 42/42] tcg: Improve call argument loading
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

Free the argument register only after we have verified that the
temporary is not already in that register.  This case is likely
now that we are back propagating the preferred register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5f8c09b0b4..c54b119020 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3611,15 +3611,16 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
         if (arg != TCG_CALL_DUMMY_ARG) {
             ts = arg_temp(arg);
             reg = tcg_target_call_iarg_regs[i];
-            tcg_reg_free(s, reg, allocated_regs);
 
             if (ts->val_type == TEMP_VAL_REG) {
                 if (ts->reg != reg) {
+                    tcg_reg_free(s, reg, allocated_regs);
                     tcg_out_mov(s, ts->type, reg, ts->reg);
                 }
             } else {
                 TCGRegSet arg_set = 0;
 
+                tcg_reg_free(s, reg, allocated_regs);
                 tcg_regset_set_reg(arg_set, reg);
                 temp_load(s, ts, arg_set, allocated_regs, 0);
             }
-- 
2.17.2
