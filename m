Received: from eggs.gnu.org ([2001:4830:134:3::10]:38126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0E-0001py-Oz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0D-00078d-ON
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:34 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:38132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro0D-000783-J1
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:33 -0400
Received: by mail-pg0-x22f.google.com with SMTP id v66so22136981pgb.5
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:09 -0700
Message-Id: <20170912162513.21694-13-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 12/16] tcg: Remove tcg_regset_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 1 -
 tcg/tcg.c | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 7226727ee4..e168bd2c44 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -210,7 +210,6 @@ typedef enum TCGOpcode {
     NB_OPS,
 } TCGOpcode;
 
-#define tcg_regset_set(d, s) (d) = (s)
 #define tcg_regset_set32(d, reg, val32) (d) |= (val32) << (reg)
 #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
 #define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f40cce3364..873915925f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2452,7 +2452,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
     TCGTemp *ts, *ots;
     TCGType otype, itype;
 
-    tcg_regset_set(allocated_regs, s->reserved_regs);
+    allocated_regs = s->reserved_regs;
     ots = &s->temps[args[0]];
     ts = &s->temps[args[1]];
 
@@ -2540,8 +2540,8 @@ static void tcg_reg_alloc_op(TCGContext *s,
            args + nb_oargs + nb_iargs, 
            sizeof(TCGArg) * def->nb_cargs);
 
-    tcg_regset_set(i_allocated_regs, s->reserved_regs);
-    tcg_regset_set(o_allocated_regs, s->reserved_regs);
+    i_allocated_regs = s->reserved_regs;
+    o_allocated_regs = s->reserved_regs;
 
     /* satisfy input constraints */ 
     for(k = 0; k < nb_iargs; k++) {
@@ -2741,7 +2741,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
     }
     
     /* assign input registers */
-    tcg_regset_set(allocated_regs, s->reserved_regs);
+    allocated_regs = s->reserved_regs;
     for(i = 0; i < nb_regs; i++) {
         arg = args[nb_oargs + i];
         if (arg != TCG_CALL_DUMMY_ARG) {
-- 
2.13.5
