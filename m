Received: from eggs.gnu.org ([2001:4830:134:3::10]:58917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1B-0006FN-1R
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe16-0007Sf-65
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:59 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:44007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe12-00075T-E5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:54 -0500
Received: by mail-oi1-x22c.google.com with SMTP id u18so3450672oie.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:09 -0600
Message-Id: <20181214031923.29527-20-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 18/32] tcg/i386: Propagate is64 to
 tcg_out_qemu_ld_slow_path
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

This helps preserve the invariant that all TCG_TYPE_I32 values
are stored zero-extended in the 64-bit host registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6bf4f84b20..695b406b4e 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1692,7 +1692,8 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
  * Record the context of a call to the out of line helper code for the slow path
  * for a load or store, so that we can later generate the correct helper code
  */
-static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
+static void add_qemu_ldst_label(TCGContext *s, bool is_ld, bool is_64,
+                                TCGMemOpIdx oi,
                                 TCGReg datalo, TCGReg datahi,
                                 TCGReg addrlo, TCGReg addrhi,
                                 tcg_insn_unit *raddr,
@@ -1702,6 +1703,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
 
     label->is_ld = is_ld;
     label->oi = oi;
+    label->type = is_64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
     label->datalo_reg = datalo;
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
@@ -1722,6 +1724,7 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     TCGMemOp opc = get_memop(oi);
     TCGReg data_reg;
     tcg_insn_unit **label_ptr = &l->label_ptr[0];
+    int rexw = (l->type == TCG_TYPE_I64 ? P_REXW : 0);
 
     /* resolve label address */
     tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
@@ -1760,10 +1763,10 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     data_reg = l->datalo_reg;
     switch (opc & MO_SSIZE) {
     case MO_SB:
-        tcg_out_ext8s(s, data_reg, TCG_REG_EAX, P_REXW);
+        tcg_out_ext8s(s, data_reg, TCG_REG_EAX, rexw);
         break;
     case MO_SW:
-        tcg_out_ext16s(s, data_reg, TCG_REG_EAX, P_REXW);
+        tcg_out_ext16s(s, data_reg, TCG_REG_EAX, rexw);
         break;
 #if TCG_TARGET_REG_BITS == 64
     case MO_SL:
@@ -2014,7 +2017,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     tcg_out_qemu_ld_direct(s, datalo, datahi, TCG_REG_L1, -1, 0, 0, is64, opc);
 
     /* Record the current context of a load into ldst label */
-    add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
+    add_qemu_ldst_label(s, true, is64, oi, datalo, datahi, addrlo, addrhi,
                         s->code_ptr, label_ptr);
 #else
     {
@@ -2154,7 +2157,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     tcg_out_qemu_st_direct(s, datalo, datahi, TCG_REG_L1, 0, 0, opc);
 
     /* Record the current context of a store into ldst label */
-    add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
+    add_qemu_ldst_label(s, false, is64, oi, datalo, datahi, addrlo, addrhi,
                         s->code_ptr, label_ptr);
 #else
     {
-- 
2.17.2
