Received: from eggs.gnu.org ([209.51.188.92]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQD-0007BQ-Sl
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQA-0001Dd-EB
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:40 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:22 -0600
Message-Id: <20190504120528.6389-5-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/9] coroutine: add host specific coroutine
 backend for 64-bit ARM
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

The speedup is similar to x86, 120 ns vs 180 ns on an APM Mustang.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                        |  2 +-
 scripts/qemugdb/coroutine_asm.py |  6 ++++-
 util/Makefile.objs               |  2 ++
 util/coroutine-asm.c             | 45 ++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index c01f57a3ae..26e62a4ab1 100755
--- a/configure
+++ b/configure
@@ -5200,7 +5200,7 @@ fi
 if test "$coroutine" = ""; then
   if test "$mingw32" = "yes"; then
     coroutine=win32
-  elif test "$cpu" = "x86_64"; then
+  elif test "$cpu" = "x86_64" || test "$cpu" = "aarch64"; then
      coroutine=asm
   elif test "$ucontext_works" = "yes"; then
     coroutine=ucontext
diff --git a/scripts/qemugdb/coroutine_asm.py b/scripts/qemugdb/coroutine_asm.py
index b4ac1291db..181b77287b 100644
--- a/scripts/qemugdb/coroutine_asm.py
+++ b/scripts/qemugdb/coroutine_asm.py
@@ -17,4 +17,8 @@ U64_PTR = gdb.lookup_type('uint64_t').pointer()
 def get_coroutine_regs(addr):
     addr = addr.cast(gdb.lookup_type('CoroutineAsm').pointer())
     rsp = addr['sp'].cast(U64_PTR)
-    return {'sp': rsp, 'pc': rsp.dereference()}
+    arch = gdb.selected_frame().architecture.name().split(':'):
+    if arch[0] == 'i386' and arch[1] == 'x86-64':
+        return {'rsp': rsp, 'pc': rsp.dereference()}
+    else:
+        return {'sp': rsp, 'pc': addr['scratch'].cast(U64_PTR) }
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41a10539cf..2167ffc862 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -39,7 +39,9 @@ util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
 util-obj-y += qemu-coroutine-sleep.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
+ifeq ($(ARCH),x86_64)
 coroutine-asm.o-cflags := -mno-red-zone
+endif
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
 util-obj-y += base64.o
diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
index a06ecbcb0a..de68e98622 100644
--- a/util/coroutine-asm.c
+++ b/util/coroutine-asm.c
@@ -40,6 +40,11 @@ typedef struct {
     Coroutine base;
     void *sp;
 
+    /*
+     * aarch64: instruction pointer
+     */
+    void *scratch;
+
     void *stack;
     size_t stack_size;
 
@@ -116,6 +121,49 @@ static void start_switch_fiber(void **fake_stack_save,
 /* Use "call" to ensure the stack  is aligned correctly.  */
 #define CO_SWITCH_NEW(from, to) CO_SWITCH(from, to, 0, "call coroutine_trampoline")
 #define CO_SWITCH_RET(from, to, action) CO_SWITCH(from, to, action, "ret")
+
+#elif defined __aarch64__
+/*
+ * GCC does not support clobbering the frame pointer, so we save it ourselves.
+ * Saving the link register as well generates slightly better code because then
+ * qemu_coroutine_switch can be treated as a leaf procedure.
+ */
+#define CO_SWITCH_RET(from, to, action) ({                                            \
+    register uintptr_t action_ __asm__("x0") = action;                                \
+    register void *from_ __asm__("x16") = from;                                       \
+    register void *to_ __asm__("x1") = to;                                            \
+    asm volatile(                                                                     \
+        ".cfi_remember_state\n"                                                       \
+        "stp x29, x30, [sp, #-16]!\n"    /* GCC does not save it, do it ourselves */  \
+        ".cfi_adjust_cfa_offset 16\n"                                                 \
+        ".cfi_def_cfa_register sp\n"                                                  \
+        "adr x30, 2f\n"                  /* source PC will be after the BR */         \
+        "str x30, [x16, %[SCRATCH]]\n"   /* save it */                                \
+        "mov x30, sp\n"                  /* save source SP */                         \
+        "str x30, [x16, %[SP]]\n"                                                     \
+        "ldr x30, [x1, %[SCRATCH]]\n"    /* load destination PC */                    \
+        "ldr x1, [x1, %[SP]]\n"          /* load destination SP */                    \
+        "mov sp, x1\n"                                                                \
+        "br x30\n"                                                                    \
+        "2: \n"                                                                       \
+        "ldp x29, x30, [sp], #16\n"                                                   \
+        ".cfi_restore_state\n"                                                        \
+        : "+r" (action_), "+r" (from_), "+r" (to_)                                    \
+        : [SP] "i" (offsetof(CoroutineAsm, sp)),                                      \
+          [SCRATCH] "i" (offsetof(CoroutineAsm, scratch))                             \
+        : "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", "x12",        \
+          "x13", "x14", "x15", "x17", "x18", "x19", "x20", "x21", "x22", "x23",       \
+          "x24", "x25", "x26", "x27", "x28",                                          \
+          "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7", "v8", "v9", "v10", "v11",   \
+          "v12", "v13", "v14", "v15", v16", "v17", "v18", "v19", "v20", "v21", "v22", \
+          "v23", "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31", "memory",    \
+    action_;                                                                          \
+})
+
+#define CO_SWITCH_NEW(from, to) do {                                                  \
+  (to)->scratch = (void *) coroutine_trampoline;                                      \
+  (void) CO_SWITCH_RET(from, to, (uintptr_t) to);                                     \
+} while(0)
 #else
 #error coroutine-asm.c not ported to this architecture.
 #endif
-- 
2.21.0
