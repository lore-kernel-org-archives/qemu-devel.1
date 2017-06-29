Received: from eggs.gnu.org ([2001:4830:134:3::10]:55800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFs-0006H8-VJ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFr-0005wR-WF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:49 -0400
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:33050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQUFr-0005wK-Qw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:47 -0400
Received: by mail-yb0-x243.google.com with SMTP id 84so3588645ybe.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 00:52:47 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 29 Jun 2017 03:52:42 -0400
Message-Id: <20170629075243.26984-3-bobby.prani@gmail.com>
In-Reply-To: <20170629075243.26984-1-bobby.prani@gmail.com>
References: <20170629075243.26984-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/3] tcg/aarch64: Use ADRP+ADD to compute
 target address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

We use ADRP+ADD to compute the target address for goto_tb. This patch
introduces the NOP instruction which is used to align the above
instruction pair so that we can use one atomic instruction to patch
the destination offsets.

CC: Richard Henderson <rth@twiddle.net>
CC: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 accel/tcg/translate-all.c    |  2 +-
 tcg/aarch64/tcg-target.inc.c | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ad46b613..b6d122e087 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -522,7 +522,7 @@ static inline PageDesc *page_find(tb_page_addr_t index)
 #elif defined(__powerpc__)
 # define MAX_CODE_GEN_BUFFER_SIZE  (32u * 1024 * 1024)
 #elif defined(__aarch64__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (128ul * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)
 #elif defined(__s390x__)
   /* We have a +- 4GB range on the branches; leave some slop.  */
 # define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 8fce11ace7..b7670ecc90 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -372,6 +372,7 @@ typedef enum {
     I3510_EON       = 0x4a200000,
     I3510_ANDS      = 0x6a000000,
 
+    NOP             = 0xd503201f,
     /* System instructions.  */
     DMB_ISH         = 0xd50338bf,
     DMB_LD          = 0x00000100,
@@ -866,10 +867,18 @@ static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
 void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
 {
     tcg_insn_unit *code_ptr = (tcg_insn_unit *)jmp_addr;
-    tcg_insn_unit *target = (tcg_insn_unit *)addr;
+    tcg_insn_unit adrp_insn = *code_ptr++;
+    tcg_insn_unit addi_insn = *code_ptr;
 
-    reloc_pc26_atomic(code_ptr, target);
-    flush_icache_range(jmp_addr, jmp_addr + 4);
+    ptrdiff_t offset = (addr >> 12) - (jmp_addr >> 12);
+
+    /* patch ADRP */
+    adrp_insn = deposit32(adrp_insn, 29, 2, offset & 0x3);
+    adrp_insn = deposit32(adrp_insn, 5, 19, offset >> 2);
+    /* patch ADDI */
+    addi_insn = deposit32(addi_insn, 10, 12, addr & 0xfff);
+    atomic_set((uint64_t *)jmp_addr, adrp_insn | ((uint64_t)addi_insn << 32));
+    flush_icache_range(jmp_addr, jmp_addr + 8);
 }
 
 static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
@@ -1388,10 +1397,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #endif
         /* consistency for USE_DIRECT_JUMP */
         tcg_debug_assert(s->tb_jmp_insn_offset != NULL);
+        /* Ensure that ADRP+ADD are 8-byte aligned so that an atomic
+           write can be used to patch the target address. */
+        if ((uintptr_t)s->code_ptr & 7) {
+            tcg_out32(s, NOP);
+        }
         s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
         /* actual branch destination will be patched by
-           aarch64_tb_set_jmp_target later, beware retranslation. */
-        tcg_out_goto_noaddr(s);
+           aarch64_tb_set_jmp_target later, beware of retranslation */
+        tcg_out_insn(s, 3406, ADRP, TCG_REG_TMP, 0);
+        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_TMP, TCG_REG_TMP, 0);
+        tcg_out_callr(s, TCG_REG_TMP);
         s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
         break;
 
-- 
2.13.0
