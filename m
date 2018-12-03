Received: from eggs.gnu.org ([2001:4830:134:3::10]:35418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqmD-0001ej-Hl
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqmB-0003RO-9o
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:53 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqmB-0003R6-5Q
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:51 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so11385676oia.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:08:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 10:08:39 -0600
Message-Id: <20181203160840.15115-5-richard.henderson@linaro.org>
In-Reply-To: <20181203160840.15115-1-richard.henderson@linaro.org>
References: <20181203160840.15115-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 4/5] tcg/i386: Precompute all
 guest_base parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

These values are constant between all qemu_ld/st invocations;
there is no need to figure this out each time.  If we cannot
use a segment or an offset directly for guest_base, load the
value into a register in the prologue.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 101 +++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 61 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 853c3c8465..b8d2dd5ba3 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1854,22 +1854,31 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_push(s, retaddr);
     tcg_out_jmp(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
 }
-#elif defined(__x86_64__) && defined(__linux__)
-# include <asm/prctl.h>
-# include <sys/prctl.h>
-
+#elif TCG_TARGET_REG_BITS == 32
+# define x86_guest_base_seg     0
+# define x86_guest_base_index   -1
+# define x86_guest_base_offset  guest_base
+#else
+static int x86_guest_base_seg;
+static int x86_guest_base_index = -1;
+static int32_t x86_guest_base_offset;
+# if defined(__x86_64__) && defined(__linux__)
+#  include <asm/prctl.h>
+#  include <sys/prctl.h>
 int arch_prctl(int code, unsigned long addr);
-
-static int guest_base_flags;
-static inline void setup_guest_base_seg(void)
+static inline int setup_guest_base_seg(void)
 {
     if (arch_prctl(ARCH_SET_GS, guest_base) == 0) {
-        guest_base_flags = P_GS;
+        return P_GS;
     }
+    return 0;
 }
-#else
-# define guest_base_flags 0
-static inline void setup_guest_base_seg(void) { }
+# else
+static inline int setup_guest_base_seg(void)
+{
+    return 0;
+}
+# endif
 #endif /* SOFTMMU */
 
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
@@ -2008,27 +2017,9 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
                         s->code_ptr, label_ptr);
 #else
-    {
-        int32_t offset = guest_base;
-        int index = -1;
-        int seg = 0;
-
-        /*
-         * Recall we store 32-bit values zero-extended.  No need for
-         * further manual extension or an addr32 (0x67) prefix.
-         */
-        if (guest_base == 0 || guest_base_flags) {
-            seg = guest_base_flags;
-            offset = 0;
-        } else if (TCG_TARGET_REG_BITS == 64 && offset != guest_base) {
-            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
-            index = TCG_REG_L1;
-            offset = 0;
-        }
-
-        tcg_out_qemu_ld_direct(s, datalo, datahi,
-                               addrlo, index, offset, seg, is64, opc);
-    }
+    tcg_out_qemu_ld_direct(s, datalo, datahi, addrlo, x86_guest_base_index,
+                           x86_guest_base_offset, x86_guest_base_seg,
+                           is64, opc);
 #endif
 }
 
@@ -2144,28 +2135,8 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
                         s->code_ptr, label_ptr);
 #else
-    {
-        int32_t offset = guest_base;
-        int index = -1;
-        int seg = 0;
-
-        /*
-         * Recall we store 32-bit values zero-extended.  No need for
-         * further manual extension or an addr32 (0x67) prefix.
-         */
-        if (guest_base == 0 || guest_base_flags) {
-            seg = guest_base_flags;
-            offset = 0;
-        } else if (TCG_TARGET_REG_BITS == 64 && offset != guest_base) {
-            /* ??? Note that we require L0 free for bswap.  */
-            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
-            index = TCG_REG_L1;
-            offset = 0;
-        }
-
-        tcg_out_qemu_st_direct(s, datalo, datahi,
-                               addrlo, index, offset, seg, opc);
-    }
+    tcg_out_qemu_st_direct(s, datalo, datahi, addrlo, x86_guest_base_index,
+                           x86_guest_base_offset, x86_guest_base_seg, opc);
 #endif
 }
 
@@ -3412,6 +3383,21 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 		         (ARRAY_SIZE(tcg_target_callee_save_regs) + 2) * 4
 			 + stack_addend);
 #else
+# ifndef CONFIG_SOFTMMU
+    if (guest_base) {
+        int seg = setup_guest_base_seg();
+        if (seg != 0) {
+            x86_guest_base_seg = seg;
+        } else if (guest_base == (int32_t)guest_base) {
+            x86_guest_base_offset = guest_base;
+        } else {
+            /* Choose R12 because, as a base, it requires a SIB byte. */
+            x86_guest_base_index = TCG_REG_R12;
+            tcg_out_mov(s, TCG_TYPE_PTR, x86_guest_base_index, guest_base);
+            tcg_regset_set_reg(s->reserved_regs, x86_guest_base_index);
+        }
+    }
+# endif
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
     /* jmp *tb.  */
@@ -3437,13 +3423,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         tcg_out_pop(s, tcg_target_callee_save_regs[i]);
     }
     tcg_out_opc(s, OPC_RET, 0, 0, 0);
-
-#if !defined(CONFIG_SOFTMMU)
-    /* Try to set up a segment register to point to guest_base.  */
-    if (guest_base) {
-        setup_guest_base_seg();
-    }
-#endif
 }
 
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
-- 
2.17.2
