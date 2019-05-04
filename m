Received: from eggs.gnu.org ([209.51.188.92]:50545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQN-0007Kj-Ee
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQL-0001Hv-BN
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:51 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:28 -0600
Message-Id: <20190504120528.6389-11-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/9] coroutine-asm: add x86 CET shadow stack
 support
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

Note that the ABI is not yet part of Linux; this patch is
not intended to be committed until that is approved.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure            | 14 ++++++++
 util/Makefile.objs   |  2 ++
 util/coroutine-asm.c | 82 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index c02a5f4b79..8e81d08ef1 100755
--- a/configure
+++ b/configure
@@ -5192,6 +5192,20 @@ if test "$cf_protection" != no; then
       feature_not_found "cf_protection" 'Control-flow protection is not supported by your toolchain'
     fi
     cf_protection=no
+  else
+    if test $cpu = x86_64; then
+      # only needed by coroutine-asm.c, however it should be rare to have
+      # CET support in the compiler but not in binutils
+      cat > $TMPC << EOF
+int main(void) { asm("rdsspq %%rax" : : : "rax"); }
+EOF
+      if ! compile_prog "" "" ; then
+        if test "$cf_protection" = yes; then
+          feature_not_found "cf_protection" 'CET is not supported by your toolchain'
+        fi
+        cf_protection=no
+      fi
+    fi
   fi
 fi
 if test "$cf_protection" = ""; then
diff --git a/util/Makefile.objs b/util/Makefile.objs
index d7add70b63..cf08b4d1c4 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -45,8 +45,10 @@ endif
 ifeq ($(CONFIG_CF_PROTECTION),y)
 coroutine-sigaltstack.o-cflags := -fcf-protection=branch
 coroutine-ucontext.o-cflags := -fcf-protection=branch
+ifneq ($(ARCH),x86_64)
 coroutine-asm.o-cflags += -fcf-protection=branch
 endif
+endif
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
 util-obj-y += base64.o
diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
index a9a80e9c71..01875acfc4 100644
--- a/util/coroutine-asm.c
+++ b/util/coroutine-asm.c
@@ -22,6 +22,13 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/coroutine_int.h"
+#include "qemu/error-report.h"
+
+#ifdef CONFIG_CF_PROTECTION
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+int arch_prctl(int code, unsigned long addr);
+#endif
 
 #ifdef CONFIG_VALGRIND_H
 #include <valgrind/valgrind.h>
@@ -42,12 +49,16 @@ typedef struct {
 
     /*
      * aarch64, s390x: instruction pointer
+     * x86: shadow stack pointer
      */
     void *scratch;
 
     void *stack;
     size_t stack_size;
 
+    /* x86: CET shadow stack */
+    void *sstack;
+    size_t sstack_size;
 #ifdef CONFIG_VALGRIND_H
     unsigned int valgrind_stack_id;
 #endif
@@ -82,6 +93,35 @@ static void start_switch_fiber(void **fake_stack_save,
 #endif
 }
 
+static bool have_sstack(void)
+{
+#if defined CONFIG_CF_PROTECTION && defined __x86_64__
+    uint64_t ssp;
+    asm ("xor %0, %0; rdsspq %0\n" : "=r" (ssp));
+    return !!ssp;
+#else
+    return 0;
+#endif
+}
+
+static void *alloc_sstack(size_t sz)
+{
+#if defined CONFIG_CF_PROTECTION && defined __x86_64__
+#ifndef ARCH_X86_CET_ALLOC_SHSTK
+#define ARCH_X86_CET_ALLOC_SHSTK 0x3004
+#endif
+
+    uint64_t arg = sz;
+    if (arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, (unsigned long) &arg) < 0) {
+        abort();
+    }
+
+    return (void *)arg;
+#else
+    abort();
+#endif
+}
+
 #ifdef __x86_64__
 /*
  * We hardcode all operands to specific registers so that we can write down all the
@@ -93,6 +133,26 @@ static void start_switch_fiber(void **fake_stack_save,
  * Note that push and call would clobber the red zone.  Makefile.objs compiles this
  * file with -mno-red-zone.  The alternative is to subtract/add 128 bytes from rsp
  * around the switch, with slightly lower cache performance.
+ *
+ * The RSTORSSP and SAVEPREVSSP instructions are intricate.  In a nutshell they are:
+ *
+ *      RSTORSSP(mem):    oldSSP = SSP
+ *                        SSP = mem
+ *                        *SSP = oldSSP
+ *
+ *      SAVEPREVSSP:      oldSSP = shadow_stack_pop()
+ *                        *(oldSSP - 8) = oldSSP       # "push" to old shadow stack
+ *
+ * Therefore, RSTORSSP(mem) followed by SAVEPREVSSP is the same as
+ *
+ *     shadow_stack_push(SSP)
+ *     SSP = mem
+ *     shadow_stack_pop()
+ *
+ * From the simplified description you can see that co->ssp, being stored before
+ * the RSTORSSP+SAVEPREVSSP sequence, points to the top actual entry of the shadow
+ * stack, not to the restore token.  Hence we use an offset of -8 in the operand
+ * of rstorssp.
  */
 #define CO_SWITCH(from, to, action, jump) ({                                          \
     int action_ = action;                                                             \
@@ -105,7 +165,15 @@ static void start_switch_fiber(void **fake_stack_save,
         "jmp 2f\n"                          /* switch back continues at label 2 */    \
                                                                                       \
         "1: .cfi_adjust_cfa_offset 8\n"                                               \
-        "movq %%rsp, %c[SP](%[FROM])\n"     /* save source SP */                      \
+        "xor %%rbp, %%rbp\n"                /* use old frame pointer as scratch reg */ \
+        "rdsspq %%rbp\n"                                                              \
+        "test %%rbp, %%rbp\n"               /* if CET is enabled... */                \
+        "jz 9f\n"                                                                     \
+        "movq %%rbp, %c[SCRATCH](%[FROM])\n" /* ... save source shadow SP, */         \
+        "movq %c[SCRATCH](%[TO]), %%rbp\n"   /* restore destination shadow stack, */  \
+        "rstorssp -8(%%rbp)\n"                                                        \
+        "saveprevssp\n"                     /* and save source shadow SP token */     \
+        "9: movq %%rsp, %c[SP](%[FROM])\n"  /* save source SP */                      \
         "movq %c[SP](%[TO]), %%rsp\n"       /* load destination SP */                 \
         jump "\n"                           /* coroutine switch */                    \
                                                                                       \
@@ -113,7 +181,8 @@ static void start_switch_fiber(void **fake_stack_save,
         "popq %%rbp\n"                                                                \
         ".cfi_adjust_cfa_offset -8\n"                                                 \
         : "+a" (action_), [FROM] "+b" (from_), [TO] "+D" (to_)                        \
-        : [SP] "i" (offsetof(CoroutineAsm, sp))                                       \
+        : [SP] "i" (offsetof(CoroutineAsm, sp)),                                      \
+          [SCRATCH] "i" (offsetof(CoroutineAsm, scratch))                             \
         : "rcx", "rdx", "rsi", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",  \
           "memory");                                                                  \
     action_;                                                                          \
@@ -220,6 +289,12 @@ Coroutine *qemu_coroutine_new(void)
     co->stack = qemu_alloc_stack(&co->stack_size);
     co->sp = co->stack + co->stack_size;
 
+    if (have_sstack()) {
+        co->sstack_size = COROUTINE_SHADOW_STACK_SIZE;
+        co->sstack = alloc_sstack(co->sstack_size);
+        co->scratch = co->sstack + co->sstack_size;
+    }
+
 #ifdef CONFIG_VALGRIND_H
     co->valgrind_stack_id =
         VALGRIND_STACK_REGISTER(co->stack, co->stack + co->stack_size);
@@ -265,6 +340,9 @@ void qemu_coroutine_delete(Coroutine *co_)
 #endif
 
     qemu_free_stack(co->stack, co->stack_size);
+    if (co->sstack) {
+        munmap(co->sstack, co->sstack_size);
+    }
     g_free(co);
 }
 
-- 
2.21.0
