Received: from eggs.gnu.org ([2001:4830:134:3::10]:34098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSryM-00031i-CO
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSryJ-00019e-8U
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:04:18 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSryJ-00018y-3I
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:04:15 -0500
Received: by mail-pg0-x243.google.com with SMTP id 75so3578576pgf.3
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:04:14 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:03:56 -0800
Message-Id: <1484514236-11584-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: add static vectors selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Xtensa cores may have two distinct addresses for the static vectors
group. Provide a function to select one of them.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c          |  2 +-
 target/xtensa/cpu.h          | 10 +++++++++-
 target/xtensa/overlay_tool.h | 11 ++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index e8e9f91..09b53c7 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -60,7 +60,7 @@ static void xtensa_cpu_reset(CPUState *s)
     xcc->parent_reset(s);
 
     env->exception_taken = 0;
-    env->pc = env->config->exception_vector[EXC_RESET];
+    env->pc = env->config->exception_vector[EXC_RESET0 + env->static_vectors];
     env->sregs[LITBASE] &= ~1;
     env->sregs[PS] = xtensa_option_enabled(env->config,
             XTENSA_OPTION_INTERRUPT) ? 0x1f : 0x10;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 7fe82a3..6b044d3 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -209,7 +209,8 @@ enum {
 
 enum {
     /* Static vectors */
-    EXC_RESET,
+    EXC_RESET0,
+    EXC_RESET1,
     EXC_MEMORY_ERROR,
 
     /* Dynamic vectors */
@@ -373,6 +374,7 @@ typedef struct CPUXtensaState {
     int64_t halt_clock;
 
     int exception_taken;
+    unsigned static_vectors;
 
     /* Watchpoints for DBREAK registers */
     struct CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
@@ -461,6 +463,12 @@ void reset_mmu(CPUXtensaState *env);
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUXtensaState *env);
 void debug_exception_env(CPUXtensaState *new_env, uint32_t cause);
 
+static inline void xtensa_select_static_vectors(CPUXtensaState *env,
+                                                unsigned n)
+{
+    assert(n < 2);
+    env->static_vectors = n;
+}
 
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index e8a7fda..5357142 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -47,6 +47,14 @@
 #define XCHAL_VECBASE_RESET_VADDR 0
 #endif
 
+#ifndef XCHAL_RESET_VECTOR0_VADDR
+#define XCHAL_RESET_VECTOR0_VADDR XCHAL_RESET_VECTOR_VADDR
+#endif
+
+#ifndef XCHAL_RESET_VECTOR1_VADDR
+#define XCHAL_RESET_VECTOR1_VADDR XCHAL_RESET_VECTOR_VADDR
+#endif
+
 #ifndef XCHAL_HW_MIN_VERSION
 #define XCHAL_HW_MIN_VERSION 0
 #endif
@@ -133,7 +141,8 @@
 #endif
 
 #define EXCEPTION_VECTORS { \
-        [EXC_RESET] = XCHAL_RESET_VECTOR_VADDR, \
+        [EXC_RESET0] = XCHAL_RESET_VECTOR0_VADDR, \
+        [EXC_RESET1] = XCHAL_RESET_VECTOR1_VADDR, \
         WINDOW_VECTORS \
         [EXC_KERNEL] = XCHAL_KERNEL_VECTOR_VADDR, \
         [EXC_USER] = XCHAL_USER_VECTOR_VADDR, \
-- 
2.1.4
