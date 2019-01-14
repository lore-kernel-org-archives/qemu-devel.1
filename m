Received: from eggs.gnu.org ([209.51.188.92]:44697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix07-0006VL-VH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix06-000208-0M
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:39 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:37914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gix05-0001tT-IE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:37 -0500
Received: by mail-lf1-x12c.google.com with SMTP id a8so14858430lfk.5
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 23:49:28 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 Jan 2019 23:48:52 -0800
Message-Id: <20190114074855.16891-5-jcmvbkbc@gmail.com>
In-Reply-To: <20190114074855.16891-1-jcmvbkbc@gmail.com>
References: <20190114074855.16891-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 4/7] target/xtensa: extract debug helpers
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

Move HELPER functions related to native debugging from op_helper.c to
dbg_helper.c. No functional changes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/Makefile.objs |   1 +
 target/xtensa/dbg_helper.c  | 129 ++++++++++++++++++++++++++++++++++++++++++++
 target/xtensa/op_helper.c   |  92 -------------------------------
 3 files changed, 130 insertions(+), 92 deletions(-)
 create mode 100644 target/xtensa/dbg_helper.c

diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index b2c720b2df9b..cfd33ba1d951 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -7,6 +7,7 @@ obj-y += core-test_kc705_be.o
 obj-$(CONFIG_SOFTMMU) += monitor.o xtensa-semi.o
 obj-y += xtensa-isa.o
 obj-y += translate.o op_helper.o helper.o cpu.o
+obj-$(CONFIG_SOFTMMU) += dbg_helper.o
 obj-y += fpu_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += mmu_helper.o
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
new file mode 100644
index 000000000000..cd8fbd653a1a
--- /dev/null
+++ b/target/xtensa/dbg_helper.c
@@ -0,0 +1,129 @@
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
+#include "exec/address-spaces.h"
+
+static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
+{
+    uint32_t paddr;
+    uint32_t page_size;
+    unsigned access;
+    int ret = xtensa_get_physical_addr(env, false, vaddr, 2, 0,
+                                       &paddr, &page_size, &access);
+    if (ret == 0) {
+        tb_invalidate_phys_addr(&address_space_memory, paddr,
+                                MEMTXATTRS_UNSPECIFIED);
+    }
+}
+
+void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
+{
+    uint32_t change = v ^ env->sregs[IBREAKENABLE];
+    unsigned i;
+
+    for (i = 0; i < env->config->nibreak; ++i) {
+        if (change & (1 << i)) {
+            tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
+        }
+    }
+    env->sregs[IBREAKENABLE] = v & ((1 << env->config->nibreak) - 1);
+}
+
+void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
+{
+    if (env->sregs[IBREAKENABLE] & (1 << i) && env->sregs[IBREAKA + i] != v) {
+        tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
+        tb_invalidate_virtual_addr(env, v);
+    }
+    env->sregs[IBREAKA + i] = v;
+}
+
+static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
+        uint32_t dbreakc)
+{
+    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    uint32_t mask = dbreakc | ~DBREAKC_MASK;
+
+    if (env->cpu_watchpoint[i]) {
+        cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[i]);
+    }
+    if (dbreakc & DBREAKC_SB) {
+        flags |= BP_MEM_WRITE;
+    }
+    if (dbreakc & DBREAKC_LB) {
+        flags |= BP_MEM_READ;
+    }
+    /* contiguous mask after inversion is one less than some power of 2 */
+    if ((~mask + 1) & ~mask) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "DBREAKC mask is not contiguous: 0x%08x\n", dbreakc);
+        /* cut mask after the first zero bit */
+        mask = 0xffffffff << (32 - clo32(mask));
+    }
+    if (cpu_watchpoint_insert(cs, dbreaka & mask, ~mask + 1,
+                              flags, &env->cpu_watchpoint[i])) {
+        env->cpu_watchpoint[i] = NULL;
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Failed to set data breakpoint at 0x%08x/%d\n",
+                      dbreaka & mask, ~mask + 1);
+    }
+}
+
+void HELPER(wsr_dbreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
+{
+    uint32_t dbreakc = env->sregs[DBREAKC + i];
+
+    if ((dbreakc & DBREAKC_SB_LB) &&
+        env->sregs[DBREAKA + i] != v) {
+        set_dbreak(env, i, v, dbreakc);
+    }
+    env->sregs[DBREAKA + i] = v;
+}
+
+void HELPER(wsr_dbreakc)(CPUXtensaState *env, uint32_t i, uint32_t v)
+{
+    if ((env->sregs[DBREAKC + i] ^ v) & (DBREAKC_SB_LB | DBREAKC_MASK)) {
+        if (v & DBREAKC_SB_LB) {
+            set_dbreak(env, i, env->sregs[DBREAKA + i], v);
+        } else {
+            if (env->cpu_watchpoint[i]) {
+                CPUState *cs = CPU(xtensa_env_get_cpu(env));
+
+                cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[i]);
+                env->cpu_watchpoint[i] = NULL;
+            }
+        }
+    }
+    env->sregs[DBREAKC + i] = v;
+}
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 1d3d87012c4a..e13e686479db 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -93,19 +93,6 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                   addr);
 }
 
-static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
-{
-    uint32_t paddr;
-    uint32_t page_size;
-    unsigned access;
-    int ret = xtensa_get_physical_addr(env, false, vaddr, 2, 0,
-            &paddr, &page_size, &access);
-    if (ret == 0) {
-        tb_invalidate_phys_addr(&address_space_memory, paddr,
-                                MEMTXATTRS_UNSPECIFIED);
-    }
-}
-
 #endif
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
@@ -325,85 +312,6 @@ void HELPER(wsr_memctl)(CPUXtensaState *env, uint32_t v)
     env->sregs[MEMCTL] = v & env->config->memctl_mask;
 }
 
-void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
-{
-    uint32_t change = v ^ env->sregs[IBREAKENABLE];
-    unsigned i;
-
-    for (i = 0; i < env->config->nibreak; ++i) {
-        if (change & (1 << i)) {
-            tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
-        }
-    }
-    env->sregs[IBREAKENABLE] = v & ((1 << env->config->nibreak) - 1);
-}
-
-void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
-{
-    if (env->sregs[IBREAKENABLE] & (1 << i) && env->sregs[IBREAKA + i] != v) {
-        tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
-        tb_invalidate_virtual_addr(env, v);
-    }
-    env->sregs[IBREAKA + i] = v;
-}
-
-static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
-        uint32_t dbreakc)
-{
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-    uint32_t mask = dbreakc | ~DBREAKC_MASK;
-
-    if (env->cpu_watchpoint[i]) {
-        cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[i]);
-    }
-    if (dbreakc & DBREAKC_SB) {
-        flags |= BP_MEM_WRITE;
-    }
-    if (dbreakc & DBREAKC_LB) {
-        flags |= BP_MEM_READ;
-    }
-    /* contiguous mask after inversion is one less than some power of 2 */
-    if ((~mask + 1) & ~mask) {
-        qemu_log_mask(LOG_GUEST_ERROR, "DBREAKC mask is not contiguous: 0x%08x\n", dbreakc);
-        /* cut mask after the first zero bit */
-        mask = 0xffffffff << (32 - clo32(mask));
-    }
-    if (cpu_watchpoint_insert(cs, dbreaka & mask, ~mask + 1,
-            flags, &env->cpu_watchpoint[i])) {
-        env->cpu_watchpoint[i] = NULL;
-        qemu_log_mask(LOG_GUEST_ERROR, "Failed to set data breakpoint at 0x%08x/%d\n",
-                      dbreaka & mask, ~mask + 1);
-    }
-}
-
-void HELPER(wsr_dbreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
-{
-    uint32_t dbreakc = env->sregs[DBREAKC + i];
-
-    if ((dbreakc & DBREAKC_SB_LB) &&
-            env->sregs[DBREAKA + i] != v) {
-        set_dbreak(env, i, v, dbreakc);
-    }
-    env->sregs[DBREAKA + i] = v;
-}
-
-void HELPER(wsr_dbreakc)(CPUXtensaState *env, uint32_t i, uint32_t v)
-{
-    if ((env->sregs[DBREAKC + i] ^ v) & (DBREAKC_SB_LB | DBREAKC_MASK)) {
-        if (v & DBREAKC_SB_LB) {
-            set_dbreak(env, i, env->sregs[DBREAKA + i], v);
-        } else {
-            if (env->cpu_watchpoint[i]) {
-                CPUState *cs = CPU(xtensa_env_get_cpu(env));
-
-                cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[i]);
-                env->cpu_watchpoint[i] = NULL;
-            }
-        }
-    }
-    env->sregs[DBREAKC + i] = v;
-}
 #endif
 
 uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
-- 
2.11.0
