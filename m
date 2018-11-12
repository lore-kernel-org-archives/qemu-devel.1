Received: from eggs.gnu.org ([2001:4830:134:3::10]:54054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK35-0003U8-4F
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK33-0004uR-MV
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK33-0004uC-Fz
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id s11so182944wmh.1
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:48 +0100
Message-Id: <20181112214503.22941-3-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 02/17] tcg/i386: Return a base register
 from tcg_out_tlb_load
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

We will shortly be asking the hot path not to assume TCG_REG_L1
for the host base address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 56 ++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e4d9be57ff..4435a7bb52 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1611,9 +1611,9 @@ static void * const qemu_st_helpers[16] = {
 
    First argument register is clobbered.  */
 
-static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
-                                    int mem_index, TCGMemOp opc,
-                                    tcg_insn_unit **label_ptr, int which)
+static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
+                               int mem_index, TCGMemOp opc,
+                               tcg_insn_unit **label_ptr, int which)
 {
     const TCGReg r0 = TCG_REG_L0;
     const TCGReg r1 = TCG_REG_L1;
@@ -1693,6 +1693,8 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     /* add addend(r0), r1 */
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
                          offsetof(CPUTLBEntry, addend) - which);
+
+    return r1;
 }
 
 /*
@@ -1998,10 +2000,6 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     TCGReg addrhi __attribute__((unused));
     TCGMemOpIdx oi;
     TCGMemOp opc;
-#if defined(CONFIG_SOFTMMU)
-    int mem_index;
-    tcg_insn_unit *label_ptr[2];
-#endif
 
     datalo = *args++;
     datahi = (TCG_TARGET_REG_BITS == 32 && is64 ? *args++ : 0);
@@ -2011,17 +2009,21 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
-    mem_index = get_mmuidx(oi);
+    {
+        int mem_index = get_mmuidx(oi);
+        tcg_insn_unit *label_ptr[2];
+        TCGReg base;
 
-    tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
-                     label_ptr, offsetof(CPUTLBEntry, addr_read));
+        base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
+                                label_ptr, offsetof(CPUTLBEntry, addr_read));
 
-    /* TLB Hit.  */
-    tcg_out_qemu_ld_direct(s, datalo, datahi, TCG_REG_L1, -1, 0, 0, opc);
+        /* TLB Hit.  */
+        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, opc);
 
-    /* Record the current context of a load into ldst label */
-    add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
-                        s->code_ptr, label_ptr);
+        /* Record the current context of a load into ldst label */
+        add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
+                            s->code_ptr, label_ptr);
+    }
 #else
     {
         int32_t offset = guest_base;
@@ -2138,10 +2140,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     TCGReg addrhi __attribute__((unused));
     TCGMemOpIdx oi;
     TCGMemOp opc;
-#if defined(CONFIG_SOFTMMU)
-    int mem_index;
-    tcg_insn_unit *label_ptr[2];
-#endif
 
     datalo = *args++;
     datahi = (TCG_TARGET_REG_BITS == 32 && is64 ? *args++ : 0);
@@ -2151,17 +2149,21 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     opc = get_memop(oi);
 
 #if defined(CONFIG_SOFTMMU)
-    mem_index = get_mmuidx(oi);
+    {
+        int mem_index = get_mmuidx(oi);
+        tcg_insn_unit *label_ptr[2];
+        TCGReg base;
 
-    tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
-                     label_ptr, offsetof(CPUTLBEntry, addr_write));
+        base = tcg_out_tlb_load(s, addrlo, addrhi, mem_index, opc,
+                                label_ptr, offsetof(CPUTLBEntry, addr_write));
 
-    /* TLB Hit.  */
-    tcg_out_qemu_st_direct(s, datalo, datahi, TCG_REG_L1, 0, 0, opc);
+        /* TLB Hit.  */
+        tcg_out_qemu_st_direct(s, datalo, datahi, base, 0, 0, opc);
 
-    /* Record the current context of a store into ldst label */
-    add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
-                        s->code_ptr, label_ptr);
+        /* Record the current context of a store into ldst label */
+        add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
+                            s->code_ptr, label_ptr);
+    }
 #else
     {
         int32_t offset = guest_base;
-- 
2.17.2
