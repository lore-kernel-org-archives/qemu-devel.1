Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK35-0003UX-J1
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK34-0004v1-PR
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK34-0004ud-Il
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id t15-v6so9576476wmt.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:49 +0100
Message-Id: <20181112214503.22941-4-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 03/17] tcg/i386: Change TCG_REG_L[01]
 to not overlap function arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

We will shortly be forcing qemu_ld/st arguments into registers
that match the function call abi of the host, which means that
the temps must be elsewhere.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 4435a7bb52..2a96ca4274 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -121,12 +121,16 @@ static const int tcg_target_call_oarg_regs[] = {
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
 
-/* Registers used with L constraint, which are the first argument
-   registers on x86_64, and two random call clobbered registers on
-   i386. */
+/* Registers used with L constraint, which are two random
+ * call clobbered registers.  These should be free.
+ */
 #if TCG_TARGET_REG_BITS == 64
-# define TCG_REG_L0 tcg_target_call_iarg_regs[0]
-# define TCG_REG_L1 tcg_target_call_iarg_regs[1]
+# define TCG_REG_L0   TCG_REG_RAX
+# ifdef _WIN64
+#  define TCG_REG_L1  TCG_REG_R10
+# else
+#  define TCG_REG_L1  TCG_REG_RDI
+# endif
 #else
 # define TCG_REG_L0 TCG_REG_EAX
 # define TCG_REG_L1 TCG_REG_EDX
@@ -1625,6 +1629,7 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     unsigned a_mask = (1 << a_bits) - 1;
     unsigned s_mask = (1 << s_bits) - 1;
     target_ulong tlb_mask;
+    TCGReg base;
 
     if (TCG_TARGET_REG_BITS == 64) {
         if (TARGET_LONG_BITS == 64) {
@@ -1671,7 +1676,12 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
        before the fastpath ADDQ below.  For 64-bit guest and x32 host, MOVQ
        copies the entire guest address for the slow path, while truncation
        for the 32-bit host happens with the fastpath ADDL below.  */
-    tcg_out_mov(s, ttype, r1, addrlo);
+    if (TCG_TARGET_REG_BITS == 64) {
+        base = tcg_target_call_iarg_regs[1];
+    } else {
+        base = r1;
+    }
+    tcg_out_mov(s, ttype, base, addrlo);
 
     /* jne slow_path */
     tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
@@ -1690,11 +1700,11 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 
     /* TLB Hit.  */
 
-    /* add addend(r0), r1 */
-    tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
+    /* add addend(r0), base */
+    tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, base, r0,
                          offsetof(CPUTLBEntry, addend) - which);
 
-    return r1;
+    return base;
 }
 
 /*
-- 
2.17.2
