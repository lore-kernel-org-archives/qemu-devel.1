Received: from eggs.gnu.org ([209.51.188.92]:50502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQL-0007IS-CZ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQJ-0001H5-Na
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:49 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:25 -0600
Message-Id: <20190504120528.6389-8-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/9] tcg: add tcg_out_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org

This function is called at the beginning of any translation block.  We will
use it to emit ENDBR32 or ENDBR64 annotations for x86 CET.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/aarch64/tcg-target.inc.c | 4 ++++
 tcg/arm/tcg-target.inc.c     | 4 ++++
 tcg/i386/tcg-target.inc.c    | 4 ++++
 tcg/mips/tcg-target.inc.c    | 4 ++++
 tcg/ppc/tcg-target.inc.c     | 4 ++++
 tcg/riscv/tcg-target.inc.c   | 4 ++++
 tcg/s390/tcg-target.inc.c    | 4 ++++
 tcg/sparc/tcg-target.inc.c   | 4 ++++
 tcg/tcg.c                    | 2 ++
 tcg/tci/tcg-target.inc.c     | 4 ++++
 10 files changed, 38 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index eefa929948..c66f3cb857 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2539,6 +2539,10 @@ QEMU_BUILD_BUG_ON(FRAME_SIZE >= (1 << 14));
 /* We're expecting to use a single ADDI insn.  */
 QEMU_BUILD_BUG_ON(FRAME_SIZE - PUSH_SIZE > 0xfff);
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
     TCGReg r;
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index abf0c444b4..8f919c7641 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2284,6 +2284,10 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Compute frame size via macros, to share between tcg_target_qemu_prologue
    and tcg_register_jit.  */
 
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index d5ed9f1ffd..b210977800 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3510,6 +3510,10 @@ static const int tcg_target_callee_save_regs[] = {
       + TCG_TARGET_STACK_ALIGN - 1) \
      & ~(TCG_TARGET_STACK_ALIGN - 1))
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Generate global QEMU prologue and epilogue code */
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 412cacdcb9..2bb976a9a5 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2471,6 +2471,10 @@ static tcg_insn_unit *align_code_ptr(TCGContext *s)
     return s->code_ptr;
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Stack frame parameters.  */
 #define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 36b4791707..f4efca8f7b 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1904,6 +1904,10 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Parameters for function call generation, used in tcg.c.  */
 #define TCG_TARGET_STACK_ALIGN       16
 #define TCG_TARGET_EXTEND_ARGS       1
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 2932505094..5780537b73 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1798,6 +1798,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 static const int tcg_target_callee_save_regs[] = {
     TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
     TCG_REG_S1,
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 3d6150b10e..924bd01afd 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -2499,6 +2499,10 @@ static void query_s390_facilities(void)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     query_s390_facilities();
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 7a61839dc1..f795e78153 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1004,6 +1004,10 @@ static void build_trampolines(TCGContext *s)
 }
 #endif
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Generate global QEMU prologue and epilogue code */
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f7bef51de8..c8832c3ccf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -101,6 +101,7 @@ static void tcg_register_jit_int(void *buf, size_t size,
 /* Forward declarations for functions declared and used in tcg-target.inc.c. */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type);
+static void tcg_out_start(TCGContext *s);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
 static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
@@ -3925,6 +3926,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #endif
 
     num_insns = -1;
+    tcg_out_start(s);
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
 
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 0015a98485..cb90012999 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -889,6 +889,10 @@ static void tcg_target_init(TCGContext *s)
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 }
 
+static inline void tcg_out_start(void)
+{
+}
+
 /* Generate global QEMU prologue and epilogue code. */
 static inline void tcg_target_qemu_prologue(TCGContext *s)
 {
-- 
2.21.0
