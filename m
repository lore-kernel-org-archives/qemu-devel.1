Received: from eggs.gnu.org ([209.51.188.92]:44765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix0A-0006Vt-Fn
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix08-00022O-CS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:42 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gix08-0001qI-0B
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:40 -0500
Received: by mail-lf1-x142.google.com with SMTP id c16so14854654lfj.8
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 23:49:23 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 Jan 2019 23:48:50 -0800
Message-Id: <20190114074855.16891-3-jcmvbkbc@gmail.com>
In-Reply-To: <20190114074855.16891-1-jcmvbkbc@gmail.com>
References: <20190114074855.16891-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] target/xtensa: extract windowed registers
 helpers
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

Move helper functions related to register windows from op_helper.c to
win_helper.c. No functional changes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/Makefile.objs |   1 +
 target/xtensa/op_helper.c   | 190 -------------------------------------
 target/xtensa/win_helper.c  | 222 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+), 190 deletions(-)
 create mode 100644 target/xtensa/win_helper.c

diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index 1508714c4475..cc550c2ccb51 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -9,3 +9,4 @@ obj-y += xtensa-isa.o
 obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += fpu_helper.o
 obj-y += gdbstub.o
+obj-y += win_helper.o
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 47517359ca67..946ae1f91b0c 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -172,196 +172,6 @@ void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
     HELPER(exception)(env, EXC_DEBUG);
 }
 
-static void copy_window_from_phys(CPUXtensaState *env,
-        uint32_t window, uint32_t phys, uint32_t n)
-{
-    assert(phys < env->config->nareg);
-    if (phys + n <= env->config->nareg) {
-        memcpy(env->regs + window, env->phys_regs + phys,
-                n * sizeof(uint32_t));
-    } else {
-        uint32_t n1 = env->config->nareg - phys;
-        memcpy(env->regs + window, env->phys_regs + phys,
-                n1 * sizeof(uint32_t));
-        memcpy(env->regs + window + n1, env->phys_regs,
-                (n - n1) * sizeof(uint32_t));
-    }
-}
-
-static void copy_phys_from_window(CPUXtensaState *env,
-        uint32_t phys, uint32_t window, uint32_t n)
-{
-    assert(phys < env->config->nareg);
-    if (phys + n <= env->config->nareg) {
-        memcpy(env->phys_regs + phys, env->regs + window,
-                n * sizeof(uint32_t));
-    } else {
-        uint32_t n1 = env->config->nareg - phys;
-        memcpy(env->phys_regs + phys, env->regs + window,
-                n1 * sizeof(uint32_t));
-        memcpy(env->phys_regs, env->regs + window + n1,
-                (n - n1) * sizeof(uint32_t));
-    }
-}
-
-
-static inline unsigned windowbase_bound(unsigned a, const CPUXtensaState *env)
-{
-    return a & (env->config->nareg / 4 - 1);
-}
-
-static inline unsigned windowstart_bit(unsigned a, const CPUXtensaState *env)
-{
-    return 1 << windowbase_bound(a, env);
-}
-
-void xtensa_sync_window_from_phys(CPUXtensaState *env)
-{
-    copy_window_from_phys(env, 0, env->sregs[WINDOW_BASE] * 4, 16);
-}
-
-void xtensa_sync_phys_from_window(CPUXtensaState *env)
-{
-    copy_phys_from_window(env, env->sregs[WINDOW_BASE] * 4, 0, 16);
-}
-
-static void xtensa_rotate_window_abs(CPUXtensaState *env, uint32_t position)
-{
-    xtensa_sync_phys_from_window(env);
-    env->sregs[WINDOW_BASE] = windowbase_bound(position, env);
-    xtensa_sync_window_from_phys(env);
-}
-
-void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta)
-{
-    xtensa_rotate_window_abs(env, env->sregs[WINDOW_BASE] + delta);
-}
-
-void HELPER(wsr_windowbase)(CPUXtensaState *env, uint32_t v)
-{
-    xtensa_rotate_window_abs(env, v);
-}
-
-void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
-{
-    int callinc = (env->sregs[PS] & PS_CALLINC) >> PS_CALLINC_SHIFT;
-
-    env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
-    xtensa_rotate_window(env, callinc);
-    env->sregs[WINDOW_START] |=
-        windowstart_bit(env->sregs[WINDOW_BASE], env);
-}
-
-void HELPER(window_check)(CPUXtensaState *env, uint32_t pc, uint32_t w)
-{
-    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
-    uint32_t windowstart = xtensa_replicate_windowstart(env) >>
-        (env->sregs[WINDOW_BASE] + 1);
-    uint32_t n = ctz32(windowstart) + 1;
-
-    assert(n <= w);
-
-    xtensa_rotate_window(env, n);
-    env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
-        (windowbase << PS_OWB_SHIFT) | PS_EXCM;
-    env->sregs[EPC1] = env->pc = pc;
-
-    switch (ctz32(windowstart >> n)) {
-    case 0:
-        HELPER(exception)(env, EXC_WINDOW_OVERFLOW4);
-        break;
-    case 1:
-        HELPER(exception)(env, EXC_WINDOW_OVERFLOW8);
-        break;
-    default:
-        HELPER(exception)(env, EXC_WINDOW_OVERFLOW12);
-        break;
-    }
-}
-
-void HELPER(test_ill_retw)(CPUXtensaState *env, uint32_t pc)
-{
-    int n = (env->regs[0] >> 30) & 0x3;
-    int m = 0;
-    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
-    uint32_t windowstart = env->sregs[WINDOW_START];
-
-    if (windowstart & windowstart_bit(windowbase - 1, env)) {
-        m = 1;
-    } else if (windowstart & windowstart_bit(windowbase - 2, env)) {
-        m = 2;
-    } else if (windowstart & windowstart_bit(windowbase - 3, env)) {
-        m = 3;
-    }
-
-    if (n == 0 || (m != 0 && m != n)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Illegal retw instruction(pc = %08x), "
-                      "PS = %08x, m = %d, n = %d\n",
-                      pc, env->sregs[PS], m, n);
-        HELPER(exception_cause)(env, pc, ILLEGAL_INSTRUCTION_CAUSE);
-    }
-}
-
-void HELPER(test_underflow_retw)(CPUXtensaState *env, uint32_t pc)
-{
-    int n = (env->regs[0] >> 30) & 0x3;
-
-    if (!(env->sregs[WINDOW_START] &
-          windowstart_bit(env->sregs[WINDOW_BASE] - n, env))) {
-        uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
-
-        xtensa_rotate_window(env, -n);
-        /* window underflow */
-        env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
-            (windowbase << PS_OWB_SHIFT) | PS_EXCM;
-        env->sregs[EPC1] = env->pc = pc;
-
-        if (n == 1) {
-            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW4);
-        } else if (n == 2) {
-            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW8);
-        } else if (n == 3) {
-            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW12);
-        }
-    }
-}
-
-uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
-{
-    int n = (env->regs[0] >> 30) & 0x3;
-    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
-    uint32_t ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
-
-    xtensa_rotate_window(env, -n);
-    env->sregs[WINDOW_START] &= ~windowstart_bit(windowbase, env);
-    return ret_pc;
-}
-
-void HELPER(rotw)(CPUXtensaState *env, uint32_t imm4)
-{
-    xtensa_rotate_window(env, imm4);
-}
-
-void xtensa_restore_owb(CPUXtensaState *env)
-{
-    xtensa_rotate_window_abs(env, (env->sregs[PS] & PS_OWB) >> PS_OWB_SHIFT);
-}
-
-void HELPER(restore_owb)(CPUXtensaState *env)
-{
-    xtensa_restore_owb(env);
-}
-
-void HELPER(movsp)(CPUXtensaState *env, uint32_t pc)
-{
-    if ((env->sregs[WINDOW_START] &
-            (windowstart_bit(env->sregs[WINDOW_BASE] - 3, env) |
-             windowstart_bit(env->sregs[WINDOW_BASE] - 2, env) |
-             windowstart_bit(env->sregs[WINDOW_BASE] - 1, env))) == 0) {
-        HELPER(exception_cause)(env, pc, ALLOCA_CAUSE);
-    }
-}
-
 void HELPER(dump_state)(CPUXtensaState *env)
 {
     XtensaCPU *cpu = xtensa_env_get_cpu(env);
diff --git a/target/xtensa/win_helper.c b/target/xtensa/win_helper.c
new file mode 100644
index 000000000000..7d793d4f9cff
--- /dev/null
+++ b/target/xtensa/win_helper.c
@@ -0,0 +1,222 @@
+/*
+ * Copyright (c) 2011 - 2019, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "qemu/host-utils.h"
+#include "exec/exec-all.h"
+
+static void copy_window_from_phys(CPUXtensaState *env,
+                                  uint32_t window, uint32_t phys, uint32_t n)
+{
+    assert(phys < env->config->nareg);
+    if (phys + n <= env->config->nareg) {
+        memcpy(env->regs + window, env->phys_regs + phys,
+               n * sizeof(uint32_t));
+    } else {
+        uint32_t n1 = env->config->nareg - phys;
+        memcpy(env->regs + window, env->phys_regs + phys,
+               n1 * sizeof(uint32_t));
+        memcpy(env->regs + window + n1, env->phys_regs,
+               (n - n1) * sizeof(uint32_t));
+    }
+}
+
+static void copy_phys_from_window(CPUXtensaState *env,
+                                  uint32_t phys, uint32_t window, uint32_t n)
+{
+    assert(phys < env->config->nareg);
+    if (phys + n <= env->config->nareg) {
+        memcpy(env->phys_regs + phys, env->regs + window,
+               n * sizeof(uint32_t));
+    } else {
+        uint32_t n1 = env->config->nareg - phys;
+        memcpy(env->phys_regs + phys, env->regs + window,
+               n1 * sizeof(uint32_t));
+        memcpy(env->phys_regs, env->regs + window + n1,
+               (n - n1) * sizeof(uint32_t));
+    }
+}
+
+static inline unsigned windowbase_bound(unsigned a, const CPUXtensaState *env)
+{
+    return a & (env->config->nareg / 4 - 1);
+}
+
+static inline unsigned windowstart_bit(unsigned a, const CPUXtensaState *env)
+{
+    return 1 << windowbase_bound(a, env);
+}
+
+void xtensa_sync_window_from_phys(CPUXtensaState *env)
+{
+    copy_window_from_phys(env, 0, env->sregs[WINDOW_BASE] * 4, 16);
+}
+
+void xtensa_sync_phys_from_window(CPUXtensaState *env)
+{
+    copy_phys_from_window(env, env->sregs[WINDOW_BASE] * 4, 0, 16);
+}
+
+static void xtensa_rotate_window_abs(CPUXtensaState *env, uint32_t position)
+{
+    xtensa_sync_phys_from_window(env);
+    env->sregs[WINDOW_BASE] = windowbase_bound(position, env);
+    xtensa_sync_window_from_phys(env);
+}
+
+void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta)
+{
+    xtensa_rotate_window_abs(env, env->sregs[WINDOW_BASE] + delta);
+}
+
+void HELPER(wsr_windowbase)(CPUXtensaState *env, uint32_t v)
+{
+    xtensa_rotate_window_abs(env, v);
+}
+
+void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
+{
+    int callinc = (env->sregs[PS] & PS_CALLINC) >> PS_CALLINC_SHIFT;
+
+    env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
+    xtensa_rotate_window(env, callinc);
+    env->sregs[WINDOW_START] |=
+        windowstart_bit(env->sregs[WINDOW_BASE], env);
+}
+
+void HELPER(window_check)(CPUXtensaState *env, uint32_t pc, uint32_t w)
+{
+    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
+    uint32_t windowstart = xtensa_replicate_windowstart(env) >>
+        (env->sregs[WINDOW_BASE] + 1);
+    uint32_t n = ctz32(windowstart) + 1;
+
+    assert(n <= w);
+
+    xtensa_rotate_window(env, n);
+    env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
+        (windowbase << PS_OWB_SHIFT) | PS_EXCM;
+    env->sregs[EPC1] = env->pc = pc;
+
+    switch (ctz32(windowstart >> n)) {
+    case 0:
+        HELPER(exception)(env, EXC_WINDOW_OVERFLOW4);
+        break;
+    case 1:
+        HELPER(exception)(env, EXC_WINDOW_OVERFLOW8);
+        break;
+    default:
+        HELPER(exception)(env, EXC_WINDOW_OVERFLOW12);
+        break;
+    }
+}
+
+void HELPER(test_ill_retw)(CPUXtensaState *env, uint32_t pc)
+{
+    int n = (env->regs[0] >> 30) & 0x3;
+    int m = 0;
+    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
+    uint32_t windowstart = env->sregs[WINDOW_START];
+
+    if (windowstart & windowstart_bit(windowbase - 1, env)) {
+        m = 1;
+    } else if (windowstart & windowstart_bit(windowbase - 2, env)) {
+        m = 2;
+    } else if (windowstart & windowstart_bit(windowbase - 3, env)) {
+        m = 3;
+    }
+
+    if (n == 0 || (m != 0 && m != n)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Illegal retw instruction(pc = %08x), "
+                      "PS = %08x, m = %d, n = %d\n",
+                      pc, env->sregs[PS], m, n);
+        HELPER(exception_cause)(env, pc, ILLEGAL_INSTRUCTION_CAUSE);
+    }
+}
+
+void HELPER(test_underflow_retw)(CPUXtensaState *env, uint32_t pc)
+{
+    int n = (env->regs[0] >> 30) & 0x3;
+
+    if (!(env->sregs[WINDOW_START] &
+          windowstart_bit(env->sregs[WINDOW_BASE] - n, env))) {
+        uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
+
+        xtensa_rotate_window(env, -n);
+        /* window underflow */
+        env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
+            (windowbase << PS_OWB_SHIFT) | PS_EXCM;
+        env->sregs[EPC1] = env->pc = pc;
+
+        if (n == 1) {
+            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW4);
+        } else if (n == 2) {
+            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW8);
+        } else if (n == 3) {
+            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW12);
+        }
+    }
+}
+
+uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
+{
+    int n = (env->regs[0] >> 30) & 0x3;
+    uint32_t windowbase = windowbase_bound(env->sregs[WINDOW_BASE], env);
+    uint32_t ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
+
+    xtensa_rotate_window(env, -n);
+    env->sregs[WINDOW_START] &= ~windowstart_bit(windowbase, env);
+    return ret_pc;
+}
+
+void HELPER(rotw)(CPUXtensaState *env, uint32_t imm4)
+{
+    xtensa_rotate_window(env, imm4);
+}
+
+void xtensa_restore_owb(CPUXtensaState *env)
+{
+    xtensa_rotate_window_abs(env, (env->sregs[PS] & PS_OWB) >> PS_OWB_SHIFT);
+}
+
+void HELPER(restore_owb)(CPUXtensaState *env)
+{
+    xtensa_restore_owb(env);
+}
+
+void HELPER(movsp)(CPUXtensaState *env, uint32_t pc)
+{
+    if ((env->sregs[WINDOW_START] &
+         (windowstart_bit(env->sregs[WINDOW_BASE] - 3, env) |
+          windowstart_bit(env->sregs[WINDOW_BASE] - 2, env) |
+          windowstart_bit(env->sregs[WINDOW_BASE] - 1, env))) == 0) {
+        HELPER(exception_cause)(env, pc, ALLOCA_CAUSE);
+    }
+}
-- 
2.11.0
