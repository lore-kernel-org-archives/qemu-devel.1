Received: from eggs.gnu.org ([2001:4830:134:3::10]:41599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqS-0008O1-In
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqL-0001c1-Fd
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:28 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:35362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqL-0001bV-6n
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:21 -0400
Received: by mail-pf0-x22f.google.com with SMTP id g13so13482247pfm.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:44 -0700
Message-Id: <20170906160612.22769-5-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/32] target: [tcg] Use a generic enum for
 DISAS_ values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Used later. An enum makes expected values explicit and
bounds the value space of switches.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <150002049746.22386.2316077281615710615.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h       | 30 ------------------------------
 include/exec/translator.h     | 40 ++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.h        | 23 ++++++++++++++---------
 target/arm/translate.c        |  2 +-
 target/cris/translate.c       |  7 ++++++-
 target/i386/translate.c       |  3 +--
 target/lm32/translate.c       |  6 ++++++
 target/m68k/translate.c       |  7 ++++++-
 target/microblaze/translate.c |  6 ++++++
 target/nios2/translate.c      |  6 ++++++
 target/openrisc/translate.c   |  6 ++++++
 target/s390x/translate.c      |  3 ++-
 target/unicore32/translate.c  |  7 ++++++-
 target/xtensa/translate.c     |  4 ++++
 14 files changed, 104 insertions(+), 46 deletions(-)
 create mode 100644 include/exec/translator.h

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b434988979..ff8fbe423d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -35,36 +35,6 @@ typedef abi_ulong tb_page_addr_t;
 typedef ram_addr_t tb_page_addr_t;
 #endif
 
-/* DisasContext is_jmp field values
- *
- * is_jmp starts as DISAS_NEXT. The translator will keep processing
- * instructions until an exit condition is reached. If we reach the
- * exit condition and is_jmp is still DISAS_NEXT (because of some
- * other condition) we simply "jump" to the next address.
- * The remaining exit cases are:
- *
- *   DISAS_JUMP    - Only the PC was modified dynamically (e.g computed)
- *   DISAS_TB_JUMP - Only the PC was modified statically (e.g. branch)
- *
- * In these cases as long as the PC is updated we can chain to the
- * next TB either by exiting the loop or looking up the next TB via
- * the loookup helper.
- *
- *   DISAS_UPDATE  - CPU State was modified dynamically
- *
- * This covers any other CPU state which necessities us exiting the
- * TCG code to the main run-loop. Typically this includes anything
- * that might change the interrupt state.
- *
- * Individual translators may define additional exit cases to deal
- * with per-target special conditions.
- */
-#define DISAS_NEXT    0 /* next instruction can be analyzed */
-#define DISAS_JUMP    1 /* only pc was modified dynamically */
-#define DISAS_TB_JUMP 2 /* only pc was modified statically */
-#define DISAS_UPDATE  3 /* cpu state was modified dynamically */
-#define DISAS_NORETURN 4 /* the tb has already been exited */
-
 #include "qemu/log.h"
 
 void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb);
diff --git a/include/exec/translator.h b/include/exec/translator.h
new file mode 100644
index 0000000000..b51b8f8a4e
--- /dev/null
+++ b/include/exec/translator.h
@@ -0,0 +1,40 @@
+/*
+ * Generic intermediate code generation.
+ *
+ * Copyright (C) 2016-2017 Lluís Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef EXEC__TRANSLATOR_H
+#define EXEC__TRANSLATOR_H
+
+/**
+ * DisasJumpType:
+ * @DISAS_NEXT: Next instruction in program order.
+ * @DISAS_TOO_MANY: Too many instructions translated.
+ * @DISAS_NORETURN: Following code is dead.
+ * @DISAS_TARGET_*: Start of target-specific conditions.
+ *
+ * What instruction to disassemble next.
+ */
+typedef enum DisasJumpType {
+    DISAS_NEXT,
+    DISAS_TOO_MANY,
+    DISAS_NORETURN,
+    DISAS_TARGET_0,
+    DISAS_TARGET_1,
+    DISAS_TARGET_2,
+    DISAS_TARGET_3,
+    DISAS_TARGET_4,
+    DISAS_TARGET_5,
+    DISAS_TARGET_6,
+    DISAS_TARGET_7,
+    DISAS_TARGET_8,
+    DISAS_TARGET_9,
+    DISAS_TARGET_10,
+    DISAS_TARGET_11,
+} DisasJumpType;
+
+#endif  /* EXEC__TRANSLATOR_H */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 90f64d9716..1eb432dc2c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -1,6 +1,9 @@
 #ifndef TARGET_ARM_TRANSLATE_H
 #define TARGET_ARM_TRANSLATE_H
 
+#include "exec/translator.h"
+
+
 /* internal defines */
 typedef struct DisasContext {
     target_ulong pc;
@@ -119,29 +122,31 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
     s->insn_start_idx = 0;
 }
 
-/* target-specific extra values for is_jmp */
+/* is_jmp field values */
+#define DISAS_JUMP      DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE    DISAS_TARGET_1 /* cpu state was modified dynamically */
 /* These instructions trap after executing, so the A32/T32 decoder must
  * defer them until after the conditional execution state has been updated.
  * WFI also needs special handling when single-stepping.
  */
-#define DISAS_WFI 5
-#define DISAS_SWI 6
+#define DISAS_WFI       DISAS_TARGET_2
+#define DISAS_SWI       DISAS_TARGET_3
 /* WFE */
-#define DISAS_WFE 7
-#define DISAS_HVC 8
-#define DISAS_SMC 9
-#define DISAS_YIELD 10
+#define DISAS_WFE       DISAS_TARGET_4
+#define DISAS_HVC       DISAS_TARGET_5
+#define DISAS_SMC       DISAS_TARGET_6
+#define DISAS_YIELD     DISAS_TARGET_7
 /* M profile branch which might be an exception return (and so needs
  * custom end-of-TB code)
  */
-#define DISAS_BX_EXCRET 11
+#define DISAS_BX_EXCRET DISAS_TARGET_8
 /* For instructions which want an immediate exit to the main loop,
  * as opposed to attempting to use lookup_and_goto_ptr. Unlike
  * DISAS_UPDATE this doesn't write the PC on exiting the translation
  * loop so you need to ensure something (gen_a64_set_pc_im or runtime
  * helper) has done so before we reach return from cpu_tb_exec.
  */
-#define DISAS_EXIT 12
+#define DISAS_EXIT      DISAS_TARGET_9
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b14329dc27..0c39c2b996 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4174,7 +4174,7 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
         gen_set_pc_im(s, dest);
         gen_goto_ptr();
     }
-    s->is_jmp = DISAS_TB_JUMP;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static inline void gen_jmp (DisasContext *s, uint32_t dest)
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 12b96eb68f..38a999e6f1 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -31,6 +31,7 @@
 #include "exec/helper-proto.h"
 #include "mmu.h"
 #include "exec/cpu_ldst.h"
+#include "exec/translator.h"
 #include "crisv32-decode.h"
 
 #include "exec/helper-gen.h"
@@ -50,7 +51,11 @@
 #define BUG() (gen_BUG(dc, __FILE__, __LINE__))
 #define BUG_ON(x) ({if (x) BUG();})
 
-#define DISAS_SWI 5
+/* is_jmp field values */
+#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
+#define DISAS_SWI     DISAS_TARGET_3
 
 /* Used by the decoder.  */
 #define EXTRACT_FIELD(src, start, end) \
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 26e8002433..a0d8788c57 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
+#include "exec/translator.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -31,8 +32,6 @@
 #include "trace-tcg.h"
 #include "exec/log.h"
 
-#define DISAS_TOO_MANY 5
-
 #define PREFIX_REPZ   0x01
 #define PREFIX_REPNZ  0x02
 #define PREFIX_LOCK   0x04
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index f68f372f15..65bc9c0bf6 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -22,6 +22,7 @@
 #include "disas/disas.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/translator.h"
 #include "tcg-op.h"
 
 #include "exec/cpu_ldst.h"
@@ -47,6 +48,11 @@
 
 #define MEM_INDEX 0
 
+/* is_jmp field values */
+#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
+
 static TCGv_env cpu_env;
 static TCGv cpu_R[32];
 static TCGv cpu_pc;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index be24355080..d738f32f9c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -25,6 +25,7 @@
 #include "tcg-op.h"
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
+#include "exec/translator.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -173,7 +174,11 @@ static void do_writebacks(DisasContext *s)
     }
 }
 
-#define DISAS_JUMP_NEXT 4
+/* is_jmp field values */
+#define DISAS_JUMP      DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE    DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_TB_JUMP   DISAS_TARGET_2 /* only pc was modified statically */
+#define DISAS_JUMP_NEXT DISAS_TARGET_3
 
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 83e2ef4960..067b0878d6 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -27,6 +27,7 @@
 #include "microblaze-decode.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-gen.h"
+#include "exec/translator.h"
 
 #include "trace-tcg.h"
 #include "exec/log.h"
@@ -46,6 +47,11 @@
 #define EXTRACT_FIELD(src, start, end) \
             (((src) >> start) & ((1 << (end - start + 1)) - 1))
 
+/* is_jmp field values */
+#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
+
 static TCGv env_debug;
 static TCGv_env cpu_env;
 static TCGv cpu_R[32];
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 8b97d6585f..6b0961837d 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -29,6 +29,12 @@
 #include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "exec/cpu_ldst.h"
+#include "exec/translator.h"
+
+/* is_jmp field values */
+#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
 #define INSTRUCTION_FLG(func, flags) { (func), (flags) }
 #define INSTRUCTION(func)                  \
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a01413113b..112db1ad0f 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/bitops.h"
 #include "exec/cpu_ldst.h"
+#include "exec/translator.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -37,6 +38,11 @@
 #define LOG_DIS(str, ...) \
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "%08x: " str, dc->pc, ## __VA_ARGS__)
 
+/* is_jmp field values */
+#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
+
 typedef struct DisasContext {
     TranslationBlock *tb;
     target_ulong pc;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4b0db7b7bd..909b12818d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -77,7 +77,8 @@ typedef struct {
     } u;
 } DisasCompare;
 
-#define DISAS_EXCP 4
+/* is_jmp field values */
+#define DISAS_EXCP DISAS_TARGET_0
 
 #ifdef DEBUG_INLINE_BRANCHES
 static uint64_t inline_branch_hit[CC_OP_MAX];
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 8f30cff932..6c094d59d7 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -16,6 +16,7 @@
 #include "tcg-op.h"
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
+#include "exec/translator.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -45,9 +46,13 @@ typedef struct DisasContext {
 #define IS_USER(s)      1
 #endif
 
+/* is_jmp field values */
+#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
+#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 /* These instructions trap after executing, so defer them until after the
    conditional executions state has been updated.  */
-#define DISAS_SYSCALL 5
+#define DISAS_SYSCALL DISAS_TARGET_3
 
 static TCGv_env cpu_env;
 static TCGv_i32 cpu_R[32];
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f3f0ff589c..d7bf07e8e6 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -38,6 +38,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/semihost.h"
+#include "exec/translator.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -46,6 +47,9 @@
 #include "exec/log.h"
 
 
+/* is_jmp field values */
+#define DISAS_UPDATE  DISAS_TARGET_0 /* cpu state was modified dynamically */
+
 typedef struct DisasContext {
     const XtensaConfig *config;
     TranslationBlock *tb;
-- 
2.13.5
