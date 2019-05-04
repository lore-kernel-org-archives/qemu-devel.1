Received: from eggs.gnu.org ([209.51.188.92]:50448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQI-0007F9-2A
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQE-0001FI-BY
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:44 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:23 -0600
Message-Id: <20190504120528.6389-6-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/9] coroutine: add host specific coroutine
 backend for 64-bit s390
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/coroutine-asm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
index de68e98622..a9a80e9c71 100644
--- a/util/coroutine-asm.c
+++ b/util/coroutine-asm.c
@@ -41,7 +41,7 @@ typedef struct {
     void *sp;
 
     /*
-     * aarch64: instruction pointer
+     * aarch64, s390x: instruction pointer
      */
     void *scratch;
 
@@ -161,6 +161,40 @@ static void start_switch_fiber(void **fake_stack_save,
   (to)->scratch = (void *) coroutine_trampoline;                                      \
   (void) CO_SWITCH_RET(from, to, (uintptr_t) to);                                     \
 } while(0)
+
+#elif defined __s390x__
+#define CO_SWITCH_RET(from, to, action) ({                                            \
+    register uintptr_t action_ __asm__("r2") = action;                                \
+    register void *from_ __asm__("r1") = from;                                        \
+    register void *to_ __asm__("r3") = to;                                            \
+    register void *pc_ __asm__("r4") = to->scratch;                                   \
+    void *save_r13;                                                                   \
+    asm volatile(                                                                     \
+        "stg %%r13, %[SAVE_R13]\n"                                                    \
+        "stg %%r15, %[SP](%%r1)\n"       /* save source SP */                         \
+        "lg %%r15, %[SP](%%r3)\n"        /* load destination SP */                    \
+        "bras %%r3, 1f\n"                /* source PC will be after the BR */         \
+        "1: aghi %%r3, 12\n"             /* 4 */                                      \
+        "stg %%r3, %[SCRATCH](%%r1)\n"   /* 6 save switch-back PC */                  \
+        "br %%r4\n"                      /* 2 jump to destination PC */               \
+        "lg %%r13, %[SAVE_R13]\n"                                                     \
+        : "+r" (action_), "+r" (from_), "+r" (to_), "+r" (pc_),                       \
+          [SAVE_R13] "+m" (r13)                                                       \
+        : [SP] "i" (offsetof(CoroutineAsm, sp)),                                      \
+          [SCRATCH] "i" (offsetof(CoroutineAsm, scratch))                             \
+        : "r0", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "r14",             \
+          "a2", "a3", "a4", "a5", "a6", "a7",                                         \
+          "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15",                       \
+          "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",                             \
+          "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15", "memory");            \
+    action_;                                                                          \
+})
+
+#define CO_SWITCH_NEW(from, to) do {                                                  \
+  (to)->scratch = (void *) coroutine_trampoline;                                      \
+  (to)->sp -= 160;                                                                    \
+  (void) CO_SWITCH_RET(from, to, (uintptr_t) to);                                     \
+} while(0)
 #else
 #error coroutine-asm.c not ported to this architecture.
 #endif
-- 
2.21.0
