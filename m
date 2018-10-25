Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKl-0006hz-6y
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKH-00007P-Ar
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKF-0008Qf-Rg
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:26 -0400
Message-Id: <20181025172057.20414-18-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 17/48] plugin-gen: add TCG code generation helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Here we implement several features:

- Inlining TCG code for simple operations. Crucially, we do not
  export TCG ops to plugins. Instead, we give them a C API to
  insert inlined ops. So far we only support adding an immediate
  to a u64, e.g. to count events.

- "Direct" callbacks. These are callbacks that do not go via
  a helper. Instead, the helper is defined at run-time, so that
  the plugin code is directly called from TCG. This makes direct
  callbacks as efficient as possible; they are therefore used
  for very frequent events, e.g. memory callbacks.

- Passing the host address to memory callbacks. Most of this
  is implemented in a later patch though.

- Instrumentation of memory accesses performed from helpers. See comment.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/plugin-gen.h |  51 +++++++++
 accel/tcg/plugin-gen.c    | 230 ++++++++++++++++++++++++++++++++++++++
 accel/tcg/Makefile.objs   |   1 +
 3 files changed, 282 insertions(+)
 create mode 100644 include/exec/plugin-gen.h
 create mode 100644 accel/tcg/plugin-gen.c

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
new file mode 100644
index 0000000000..46a167527e
--- /dev/null
+++ b/include/exec/plugin-gen.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * plugin-gen.h - TCG-dependent definitions for generating plugin code
+ *
+ * This header should be included only from plugin.c and C files that emit
+ * TCG code.
+ */
+#ifndef QEMU_PLUGIN_GEN_H
+#define QEMU_PLUGIN_GEN_H
+
+#include "qemu/plugin.h"
+#include "tcg/tcg.h"
+
+#ifdef CONFIG_PLUGINS
+
+void qemu_plugin_gen_vcpu_mem_callbacks(struct qemu_plugin_dyn_cb_arr *arr,
+                                        TCGv vaddr, uint8_t info);
+
+void qemu_plugin_gen_vcpu_udata_callbacks(struct qemu_plugin_dyn_cb_arr *arr);
+
+void qemu_plugin_gen_disable_mem_helpers(void);
+
+void
+qemu_plugin_gen_enable_mem_helpers(const struct qemu_plugin_dyn_cb_arr *orig);
+
+#else /* !CONFIG_PLUGINS */
+
+static inline void
+qemu_plugin_gen_vcpu_mem_callbacks(struct qemu_plugin_dyn_cb_arr *arr,
+                                   TCGv vaddr, uint8_t info)
+{ }
+
+static inline void
+qemu_plugin_gen_vcpu_udata_callbacks(struct qemu_plugin_dyn_cb_arr *arr)
+{ }
+
+static inline void qemu_plugin_gen_disable_mem_helpers(void)
+{ }
+
+static inline void
+qemu_plugin_gen_enable_mem_helpers(const struct qemu_plugin_dyn_cb_arr *orig)
+{ }
+
+#endif /* CONFIG_PLUGINS */
+
+#endif /* QEMU_PLUGIN_GEN_H */
+
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
new file mode 100644
index 0000000000..75f182be37
--- /dev/null
+++ b/accel/tcg/plugin-gen.c
@@ -0,0 +1,230 @@
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "exec/exec-all.h"
+#include "exec/plugin-gen.h"
+
+static void gen_inline_op(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_i64 val = tcg_temp_new_i64();
+    TCGv_ptr ptr = tcg_const_ptr(cb->userp);
+
+    tcg_gen_ld_i64(val, ptr, 0);
+    switch (cb->inline_insn.op) {
+    case QEMU_PLUGIN_INLINE_ADD_U64:
+        tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_gen_st_i64(val, ptr, 0);
+
+    tcg_temp_free_ptr(ptr);
+    tcg_temp_free_i64(val);
+}
+
+static void gen_helper_mem_cb(const char *name, unsigned flags,
+                              qemu_plugin_vcpu_mem_cb_t cb, TCGv_i32 cpu_index,
+                              TCGv_i32 meminfo, TCGv_i64 vaddr, TCGv_ptr udata)
+{
+    TCGHelperInfo info = {
+        .func = cb,
+        .name = name,
+        .flags = flags,
+        .sizemask = dh_sizemask(void, 0) |
+                    dh_sizemask(i32, 1) |
+                    dh_sizemask(i32, 2) |
+                    dh_sizemask(i64, 3) |
+                    dh_sizemask(ptr, 4),
+
+    };
+    TCGTemp *args[] = {
+        tcgv_i32_temp(cpu_index),
+        tcgv_i32_temp(meminfo),
+        tcgv_i64_temp(vaddr),
+        tcgv_ptr_temp(udata),
+    };
+
+    tcg_gen_runtime_helper(&info, NULL, ARRAY_SIZE(args), args);
+}
+
+static void gen_helper_mem_haddr_cb(const char *name, unsigned flags,
+                                    qemu_plugin_vcpu_mem_haddr_cb_t cb,
+                                    TCGv_i32 cpu_index, TCGv_i32 meminfo,
+                                    TCGv_i64 vaddr, TCGv_ptr haddr,
+                                    TCGv_ptr udata)
+{
+    TCGHelperInfo info = {
+        .func = cb,
+        .name = name,
+        .flags = flags,
+        .sizemask = dh_sizemask(void, 0) |
+                    dh_sizemask(i32, 1) |
+                    dh_sizemask(i32, 2) |
+                    dh_sizemask(i64, 3) |
+                    dh_sizemask(ptr, 4) |
+                    dh_sizemask(ptr, 5),
+
+    };
+    TCGTemp *args[] = {
+        tcgv_i32_temp(cpu_index),
+        tcgv_i32_temp(meminfo),
+        tcgv_i64_temp(vaddr),
+        tcgv_ptr_temp(haddr),
+        tcgv_ptr_temp(udata),
+    };
+
+    tcg_gen_runtime_helper(&info, NULL, ARRAY_SIZE(args), args);
+}
+
+static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb, TCGv vaddr, uint8_t info)
+{
+    TCGv_i32 cpu_index = tcg_temp_new_i32();
+    TCGv_i32 meminfo = tcg_const_i32(info);
+    TCGv_i64 vaddr64 = tcg_temp_new_i64();
+    TCGv_ptr udata = tcg_const_ptr(cb->userp);
+    TCGv_ptr haddr;
+
+    tcg_gen_ld_i32(cpu_index, cpu_env,
+                   -ENV_OFFSET + offsetof(CPUState, cpu_index));
+    tcg_gen_extu_tl_i64(vaddr64, vaddr);
+
+    if (cb->mem.haddr) {
+#ifdef CONFIG_SOFTMMU
+        haddr = tcg_temp_new_ptr();
+        tcg_gen_ld_ptr(haddr, cpu_env, offsetof(CPUArchState, hostaddr));
+#else
+        haddr = tcg_const_ptr(NULL);
+#endif
+        gen_helper_mem_haddr_cb("helper_plugin_vcpu_mem_haddr_cb",
+                                cb->tcg_flags, cb->f.vcpu_mem_haddr,
+                                cpu_index, meminfo, vaddr64, haddr, udata);
+        tcg_temp_free_ptr(haddr);
+    } else {
+        gen_helper_mem_cb("helper_plugin_vcpu_mem_cb", cb->tcg_flags,
+                          cb->f.vcpu_mem, cpu_index, meminfo, vaddr64,
+                          udata);
+    }
+
+    tcg_temp_free_ptr(udata);
+    tcg_temp_free_i64(vaddr64);
+    tcg_temp_free_i32(meminfo);
+    tcg_temp_free_i32(cpu_index);
+}
+
+void qemu_plugin_gen_vcpu_mem_callbacks(struct qemu_plugin_dyn_cb_arr *arr,
+                                        TCGv vaddr, uint8_t info)
+{
+    size_t i;
+
+    for (i = 0; i < arr->n; i++) {
+        struct qemu_plugin_dyn_cb *cb = &arr->data[i];
+
+        switch (cb->type) {
+        case QEMU_PLUGIN_DYN_CB_TYPE_REGULAR:
+            gen_mem_cb(cb, vaddr, info);
+            break;
+        case QEMU_PLUGIN_DYN_CB_TYPE_INLINE:
+            gen_inline_op(cb);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+static void gen_helper_vcpu_udata_cb(const char *name, unsigned flags,
+                                     qemu_plugin_vcpu_udata_cb_t cb,
+                                     TCGv_i32 cpu_index, TCGv_ptr udata)
+{
+    TCGHelperInfo info = {
+        .func = cb,
+        .name = name,
+        .flags = flags,
+        .sizemask = dh_sizemask(void, 0) |
+                    dh_sizemask(i32, 1) |
+                    dh_sizemask(ptr, 2),
+    };
+    TCGTemp *args[] = {
+        tcgv_i32_temp(cpu_index),
+        tcgv_ptr_temp(udata),
+    };
+
+    tcg_gen_runtime_helper(&info, NULL, ARRAY_SIZE(args), args);
+}
+
+static void gen_vcpu_udata_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_i32 cpu_index = tcg_temp_new_i32();
+    TCGv_ptr udata = tcg_const_ptr(cb->userp);
+
+    tcg_gen_ld_i32(cpu_index, cpu_env,
+                   -ENV_OFFSET + offsetof(CPUState, cpu_index));
+
+    gen_helper_vcpu_udata_cb("helper_plugin_vcpu_udata_cb", cb->tcg_flags,
+                             cb->f.vcpu_udata, cpu_index, udata);
+
+    tcg_temp_free_ptr(udata);
+    tcg_temp_free_i32(cpu_index);
+}
+
+void qemu_plugin_gen_vcpu_udata_callbacks(struct qemu_plugin_dyn_cb_arr *arr)
+{
+    size_t i;
+
+    for (i = 0; i < arr->n; i++) {
+        struct qemu_plugin_dyn_cb *cb = &arr->data[i];
+
+        switch (cb->type) {
+        case QEMU_PLUGIN_DYN_CB_TYPE_REGULAR:
+            gen_vcpu_udata_cb(cb);
+            break;
+        case QEMU_PLUGIN_DYN_CB_TYPE_INLINE:
+            gen_inline_op(cb);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+/*
+ * Tracking memory accesses performed from helpers requires extra work.
+ * If an instruction is emulated with helpers, struct qemu_plugin_insn's
+ * .calls_helpers is set. If so, this function is called. Here we do two
+ * things: (1) copy the CB descriptor, and keep track of it so that it can be
+ * freed later on, and (2) point CPUState.plugin_mem_cbs to the descriptor, so
+ * that we can read it at run-time (i.e. when the helper executes).
+ * This run-time access is performed from qemu_plugin_vcpu_mem_cb.
+ *
+ * Note that qemu_plugin_gen_disable_mem_helpers undoes (2).
+ */
+void
+qemu_plugin_gen_enable_mem_helpers(const struct qemu_plugin_dyn_cb_arr *orig)
+{
+    struct qemu_plugin_dyn_cb_arr *arr;
+    TCGv_ptr ptr;
+
+    arr = g_new(struct qemu_plugin_dyn_cb_arr, 1);
+    arr->capacity = orig->n;
+    arr->n = orig->n;
+    arr->data = g_new(struct qemu_plugin_dyn_cb, arr->n);
+    memcpy(arr->data, orig->data, sizeof(*arr->data) * arr->n);
+    qemu_plugin_add_dyn_cb_arr(arr);
+
+    ptr = tcg_const_ptr(arr);
+    tcg_gen_st_ptr(ptr, cpu_env, -ENV_OFFSET + offsetof(CPUState,
+                                                        plugin_mem_cbs));
+    tcg_temp_free_ptr(ptr);
+}
+
+/* Called once we're done instrumenting an instruction that calls helpers */
+void qemu_plugin_gen_disable_mem_helpers(void)
+{
+    TCGv_ptr ptr = tcg_const_ptr(NULL);
+
+    tcg_gen_st_ptr(ptr, cpu_env, -ENV_OFFSET + offsetof(CPUState,
+                                                        plugin_mem_cbs));
+    tcg_temp_free_ptr(ptr);
+}
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..4f617e4fe5 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -6,3 +6,4 @@ obj-y += translator.o
 
 obj-$(CONFIG_USER_ONLY) += user-exec.o
 obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
+obj-$(CONFIG_PLUGINS) += plugin-gen.o
-- 
2.17.1
