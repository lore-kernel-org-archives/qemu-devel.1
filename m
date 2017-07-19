Received: from eggs.gnu.org ([2001:4830:134:3::10]:41498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3H-0003Fo-KK
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3F-00025E-Oy
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:35 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3F-000258-Ih
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:33 -0400
Received: by mail-pf0-x243.google.com with SMTP id q85so5085907pfq.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:57:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:09 -1000
Message-Id: <20170719045722.25492-2-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 01/14] tcg/mips: reserve a register for the
 guest_base.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jiang Biao <jiang.biao2@zte.com.cn>

From: Jiang Biao <jiang.biao2@zte.com.cn>

Reserve a register for the guest_base using ppc code for reference.
By doing so, we do not have to recompute it for every memory load.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1499677934-2249-1-git-send-email-jiang.biao2@zte.com.cn>
---
 tcg/mips/tcg-target.inc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 85756b8..1a8169f 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -85,6 +85,10 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_TMP2  TCG_REG_T8
 #define TCG_TMP3  TCG_REG_T7
 
+#ifndef CONFIG_SOFTMMU
+#define TCG_GUEST_BASE_REG TCG_REG_S1
+#endif
+
 /* check if we really need so many registers :P */
 static const int tcg_target_reg_alloc_order[] = {
     /* Call saved registers.  */
@@ -1547,8 +1551,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
     } else if (guest_base == (int16_t)guest_base) {
         tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
-        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_GUEST_BASE_REG, addr_regl);
     }
     tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
 #endif
@@ -1652,8 +1655,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
     } else if (guest_base == (int16_t)guest_base) {
         tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
-        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_GUEST_BASE_REG, addr_regl);
     }
     tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
 #endif
@@ -2452,6 +2454,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
+#ifndef CONFIG_SOFTMMU
+    if (guest_base) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    }
+#endif
+
     /* Call generated code */
     tcg_out_opc_reg(s, OPC_JR, 0, tcg_target_call_iarg_regs[1], 0);
     /* delay slot */
-- 
2.9.4
