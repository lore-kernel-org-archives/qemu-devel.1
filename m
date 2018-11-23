Received: from eggs.gnu.org ([2001:4830:134:3::10]:44331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj9-0000LP-CM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj7-0003qN-F9
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj7-0003pL-9N
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id v13so9118649wrw.5
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:58 +0100
Message-Id: <20181123144558.5048-38-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 37/37] tcg/i386: Remove L constraint
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

We no longer need any scratch registers for user-only memory ops.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 19a0fa8a03..2815dd25a0 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -240,10 +240,7 @@ static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, int hi)
 #else
 static const char *constrain_memop_arg(QemuMemArgType type, bool is_64, int hi)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        /* Temps are still needed for guest_base && !guest_base_flags.  */
-        return "L";
-    } else if (type == ARG_STVAL && !is_64) {
+    if (TCG_TARGET_REG_BITS == 32 && type == ARG_STVAL && !is_64) {
         /* Byte stores must happen from q-regs.  Because of this, we must
          * constrain all INDEX_op_qemu_st_i32 to use q-regs.
          */
@@ -353,14 +350,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->u.regs |= ALL_VECTOR_REGS;
         break;
 
-        /* qemu_ld/st address constraint */
-    case 'L':
-        ct->ct |= TCG_CT_REG;
-        ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_L0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_L1);
-        break;
-
     case 'e':
         ct->ct |= (type == TCG_TYPE_I32 ? TCG_CT_CONST : TCG_CT_CONST_S32);
         break;
-- 
2.17.2
