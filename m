Received: from eggs.gnu.org ([2001:4830:134:3::10]:44269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj6-0000Hi-RH
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj4-0003le-QU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj4-0003kD-IY
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id j10so12586691wru.4
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:55 +0100
Message-Id: <20181123144558.5048-35-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 34/37] tcg/i386: Restrict user-only
 qemu_st_i32 values to q-regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

This is one more step toward the removal of all scratch registers
during user-only guest memory operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5cad31cfe5..79de8d0cd2 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -240,7 +240,17 @@ static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, int hi)
 #else
 static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, int hi)
 {
-    return "L";
+    if (TCG_TARGET_REG_BITS == 64) {
+        /* Temps are still needed for guest_base && !guest_base_flags.  */
+        return "L";
+    } else if (type == ARG_STVAL && !is_64) {
+        /* Byte stores must happen from q-regs.  Because of this, we must
+         * constrain all INDEX_op_qemu_st_i32 to use q-regs.
+         */
+        return "q";
+    } else {
+        return "r";
+    }
 }
 #endif /* CONFIG_SOFTMMU */
 
@@ -2038,15 +2048,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     switch (memop & MO_SIZE) {
     case MO_8:
-        /*
-         * In 32-bit mode, 8-bit stores can only happen from [abcd]x.
-         * ??? Adjust constraints such that this is is forced, then
-         * we won't need a scratch at all for user-only.
-         */
-        if (TCG_TARGET_REG_BITS == 32 && datalo >= 4) {
-            tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
-            datalo = scratch;
-        }
+        /* In 32-bit mode, 8-bit stores can only happen from [abcd]x.  */
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || datalo < 4);
         tcg_out_modrm_offset(s, OPC_MOVB_EvGv + P_REXB_R + seg,
                              datalo, base, ofs);
         break;
-- 
2.17.2
