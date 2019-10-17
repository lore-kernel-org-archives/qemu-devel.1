Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C96ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDFD2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXd4lAa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDFD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL641-0007PT-E1
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5do-0008Bo-G2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dk-0005US-A4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dj-0005U2-UY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id p4so2307396wrm.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X4ubSfXf9LMCz4CmM78ihd0dpybaxxssEegRSSDgJVw=;
 b=EXd4lAa8fVHbwnSIaDxjase+KRLULdExAr8RvgVJ4tC09h2eYsXcUmFkv7nkenxRoA
 BbADLrZnSI61qoJWrZ8ciehzufNMt/C1MjqsTL5cCUSiZSOem/9bZHyUBOoey5S3w5E1
 jOgXBWleYrKM9zM0Z9mdr9ExmPR7j2xFXhSZXjDkS2Ar1VXamoVK5ayu4sMdonWWJdw+
 0+Eh2r/41gJFMjGRNYSIrQjoGMAYtUwS3TFADrM99k+M4hRgNa4w5dy7ha6HUqqVZ4Ht
 taESuk2uEj16rztHHH6JmZZEbEZgJNOHTPr/TqQGxoR5bhjM6m8LQymLyhJdtR54023p
 iQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X4ubSfXf9LMCz4CmM78ihd0dpybaxxssEegRSSDgJVw=;
 b=lMg3aeDkNhYsCUkb29gJA/ZOHWfkEZNS9b6crQIcgKDrqFZgN5ISeXtFysj9wwvy3A
 /+ejULA1xdpRQudUbh/wIBRe6LJr94sQuGlGtzrI305CI4VIBlW86v2YdZtz+5AFCUwf
 x0ijv/f9XFMKJ5z8g7sLy+pFQUg4GYf8XTqB0NAgZiJrEode2xKhQY1xg7E6phdu0cLn
 vnJ7FoWZQCjzKAuS9BGGtvvzRmlen1JM2zT8aVex7PoEKIsGP9Y0DkrHx8OkkSbz22jf
 5lbIdglSmsH8D0u6N4IwGHhoc12HEK0bB07oXr2uGs8GZGCPANjQjl6k6U+SEpVZTfAG
 1xtA==
X-Gm-Message-State: APjAAAVEbNSvz+NzJ9fAb1EFaDeeVdEcMPbRb/t+3HJdn4+HbDkCnvH4
 Cn5GY68RqYaTh2B18nsILAhqFA==
X-Google-Smtp-Source: APXvYqxztXa7Z+FNP6k8o8ttSCwKToG2Y0lVGWnKGZhwV0TCQhBeJn/2H5SzRyxl+TGCrLmeQp7FtA==
X-Received: by 2002:a5d:4010:: with SMTP id n16mr2963591wrp.152.1571318186130; 
 Thu, 17 Oct 2019 06:16:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm1945052wmb.33.2019.10.17.06.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 222361FF8C;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 13/54] plugin-gen: add module for TCG-related code
Date: Thu, 17 Oct 2019 14:15:34 +0100
Message-Id: <20191017131615.19660-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

We first inject empty instrumentation from translator_loop.
After translation, we go through the plugins to see what
they want to register for, filling in the empty instrumentation.
If if turns out that some instrumentation remains unused, we
remove it.

This approach supports the following features:

- Inlining TCG code for simple operations. Note that we do not
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

- Instrumentation of memory accesses performed from helpers.
  See the corresponding comment, as well as a later patch.

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: add alloc_tcg_plugin_context, use glib, rm hwaddr]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - introduce alloc_tcg_plugin_context
  - allocate GPtrArray for tracking insns
v4
  - remove hwaddr variants of callbacks
  - pass full 32bit meminfo
  - remove now unused code
  - move plugin_gen_from into .c file
v5
  - fix offsets when storing mem callbacks.
  - remove #if 0 code no longer needed
---
 accel/tcg/Makefile.objs     |   1 +
 accel/tcg/plugin-gen.c      | 932 ++++++++++++++++++++++++++++++++++++
 accel/tcg/plugin-helpers.h  |   5 +
 include/exec/helper-gen.h   |   1 +
 include/exec/helper-proto.h |   1 +
 include/exec/helper-tcg.h   |   1 +
 include/exec/plugin-gen.h   |  57 +++
 tcg/tcg-op.h                |  11 +
 tcg/tcg-opc.h               |   3 +
 tcg/tcg.c                   |  22 +
 tcg/tcg.h                   |  20 +
 11 files changed, 1054 insertions(+)
 create mode 100644 accel/tcg/plugin-gen.c
 create mode 100644 accel/tcg/plugin-helpers.h
 create mode 100644 include/exec/plugin-gen.h

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..a92f2c454b 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -6,3 +6,4 @@ obj-y += translator.o
 
 obj-$(CONFIG_USER_ONLY) += user-exec.o
 obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
+obj-$(CONFIG_PLUGIN) += plugin-gen.o
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
new file mode 100644
index 0000000000..51580d51a0
--- /dev/null
+++ b/accel/tcg/plugin-gen.c
@@ -0,0 +1,932 @@
+/*
+ * plugin-gen.c - TCG-related bits of plugin infrastructure
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * We support instrumentation at an instruction granularity. That is,
+ * if a plugin wants to instrument the memory accesses performed by a
+ * particular instruction, it can just do that instead of instrumenting
+ * all memory accesses. Thus, in order to do this we first have to
+ * translate a TB, so that plugins can decide what/where to instrument.
+ *
+ * Injecting the desired instrumentation could be done with a second
+ * translation pass that combined the instrumentation requests, but that
+ * would be ugly and inefficient since we would decode the guest code twice.
+ * Instead, during TB translation we add "empty" instrumentation calls for all
+ * possible instrumentation events, and then once we collect the instrumentation
+ * requests from plugins, we either "fill in" those empty events or remove them
+ * if they have no requests.
+ *
+ * When "filling in" an event we first copy the empty callback's TCG ops. This
+ * might seem unnecessary, but it is done to support an arbitrary number
+ * of callbacks per event. Take for example a regular instruction callback.
+ * We first generate a callback to an empty helper function. Then, if two
+ * plugins register one callback each for this instruction, we make two copies
+ * of the TCG ops generated for the empty callback, substituting the function
+ * pointer that points to the empty helper function with the plugins' desired
+ * callback functions. After that we remove the empty callback's ops.
+ *
+ * Note that the location in TCGOp.args[] of the pointer to a helper function
+ * varies across different guest and host architectures. Instead of duplicating
+ * the logic that figures this out, we rely on the fact that the empty
+ * callbacks point to empty functions that are unique pointers in the program.
+ * Thus, to find the right location we just have to look for a match in
+ * TCGOp.args[]. This is the main reason why we first copy an empty callback's
+ * TCG ops and then fill them in; regardless of whether we have one or many
+ * callbacks for that event, the logic to add all of them is the same.
+ *
+ * When generating more than one callback per event, we make a small
+ * optimization to avoid generating redundant operations. For instance, for the
+ * second and all subsequent callbacks of an event, we do not need to reload the
+ * CPU's index into a TCG temp, since the first callback did it already.
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "trace/mem.h"
+#include "exec/exec-all.h"
+#include "exec/plugin-gen.h"
+#include "exec/translator.h"
+
+#ifdef CONFIG_SOFTMMU
+# define CONFIG_SOFTMMU_GATE 1
+#else
+# define CONFIG_SOFTMMU_GATE 0
+#endif
+
+/*
+ * plugin_cb_start TCG op args[]:
+ * 0: enum plugin_gen_from
+ * 1: enum plugin_gen_cb
+ * 2: set to 1 for mem callback that is a write, 0 otherwise.
+ */
+
+enum plugin_gen_from {
+    PLUGIN_GEN_FROM_TB,
+    PLUGIN_GEN_FROM_INSN,
+    PLUGIN_GEN_FROM_MEM,
+    PLUGIN_GEN_AFTER_INSN,
+    PLUGIN_GEN_N_FROMS,
+};
+
+enum plugin_gen_cb {
+    PLUGIN_GEN_CB_UDATA,
+    PLUGIN_GEN_CB_INLINE,
+    PLUGIN_GEN_CB_MEM,
+    PLUGIN_GEN_ENABLE_MEM_HELPER,
+    PLUGIN_GEN_DISABLE_MEM_HELPER,
+    PLUGIN_GEN_N_CBS,
+};
+
+/*
+ * These helpers are stubs that get dynamically switched out for calls
+ * direct to the plugin if they are subscribed to.
+ */
+void HELPER(plugin_vcpu_udata_cb)(uint32_t cpu_index, void *udata)
+{ }
+
+void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
+                                qemu_plugin_meminfo_t info, uint64_t vaddr,
+                                void *userdata)
+{ }
+
+static void do_gen_mem_cb(TCGv vaddr, uint32_t info)
+{
+    TCGv_i32 cpu_index = tcg_temp_new_i32();
+    TCGv_i32 meminfo = tcg_const_i32(info);
+    TCGv_i64 vaddr64 = tcg_temp_new_i64();
+    TCGv_ptr udata = tcg_const_ptr(NULL);
+
+    tcg_gen_ld_i32(cpu_index, cpu_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_extu_tl_i64(vaddr64, vaddr);
+
+    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, vaddr64, udata);
+
+    tcg_temp_free_ptr(udata);
+    tcg_temp_free_i64(vaddr64);
+    tcg_temp_free_i32(meminfo);
+    tcg_temp_free_i32(cpu_index);
+}
+
+static void gen_empty_udata_cb(void)
+{
+    TCGv_i32 cpu_index = tcg_temp_new_i32();
+    TCGv_ptr udata = tcg_const_ptr(NULL); /* will be overwritten later */
+
+    tcg_gen_ld_i32(cpu_index, cpu_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
+
+    tcg_temp_free_ptr(udata);
+    tcg_temp_free_i32(cpu_index);
+}
+
+/*
+ * For now we only support addi_i64.
+ * When we support more ops, we can generate one empty inline cb for each.
+ */
+static void gen_empty_inline_cb(void)
+{
+    TCGv_i64 val = tcg_temp_new_i64();
+    TCGv_ptr ptr = tcg_const_ptr(NULL); /* overwritten later */
+
+    tcg_gen_ld_i64(val, ptr, 0);
+    /* pass an immediate != 0 so that it doesn't get optimized away */
+    tcg_gen_addi_i64(val, val, 0xdeadface);
+    tcg_gen_st_i64(val, ptr, 0);
+    tcg_temp_free_ptr(ptr);
+    tcg_temp_free_i64(val);
+}
+
+static void gen_empty_mem_cb(TCGv addr, uint32_t info)
+{
+    do_gen_mem_cb(addr, info);
+}
+
+/*
+ * Share the same function for enable/disable. When enabling, the NULL
+ * pointer will be overwritten later.
+ */
+static void gen_empty_mem_helper(void)
+{
+    TCGv_ptr ptr;
+
+    ptr = tcg_const_ptr(NULL);
+    tcg_gen_st_ptr(ptr, cpu_env, offsetof(CPUState, plugin_mem_cbs) -
+                                 offsetof(ArchCPU, env));
+    tcg_temp_free_ptr(ptr);
+}
+
+static inline
+void gen_plugin_cb_start(enum plugin_gen_from from,
+                         enum plugin_gen_cb type, unsigned wr)
+{
+    TCGOp *op;
+
+    tcg_gen_plugin_cb_start(from, type, wr);
+    op = tcg_last_op();
+    QSIMPLEQ_INSERT_TAIL(&tcg_ctx->plugin_ops, op, plugin_link);
+}
+
+static void gen_wrapped(enum plugin_gen_from from,
+                        enum plugin_gen_cb type, void (*func)(void))
+{
+    gen_plugin_cb_start(from, type, 0);
+    func();
+    tcg_gen_plugin_cb_end();
+}
+
+static inline void plugin_gen_empty_callback(enum plugin_gen_from from)
+{
+    switch (from) {
+    case PLUGIN_GEN_AFTER_INSN:
+        gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
+                    gen_empty_mem_helper);
+        break;
+    case PLUGIN_GEN_FROM_INSN:
+        /*
+         * Note: plugin_gen_inject() relies on ENABLE_MEM_HELPER being
+         * the first callback of an instruction
+         */
+        gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
+                    gen_empty_mem_helper);
+        /* fall through */
+    case PLUGIN_GEN_FROM_TB:
+        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
+        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+union mem_gen_fn {
+    void (*mem_fn)(TCGv, uint32_t);
+    void (*inline_fn)(void);
+};
+
+static void gen_mem_wrapped(enum plugin_gen_cb type,
+                            const union mem_gen_fn *f, TCGv addr,
+                            uint32_t info, bool is_mem)
+{
+    int wr = !!(info & TRACE_MEM_ST);
+
+    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, type, wr);
+    if (is_mem) {
+        f->mem_fn(addr, info);
+    } else {
+        f->inline_fn();
+    }
+    tcg_gen_plugin_cb_end();
+}
+
+void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
+{
+    union mem_gen_fn fn;
+
+    fn.mem_fn = gen_empty_mem_cb;
+    gen_mem_wrapped(PLUGIN_GEN_CB_MEM, &fn, addr, info, true);
+
+    fn.inline_fn = gen_empty_inline_cb;
+    gen_mem_wrapped(PLUGIN_GEN_CB_INLINE, &fn, 0, info, false);
+}
+
+static TCGOp *find_op(TCGOp *op, TCGOpcode opc)
+{
+    while (op) {
+        if (op->opc == opc) {
+            return op;
+        }
+        op = QTAILQ_NEXT(op, link);
+    }
+    return NULL;
+}
+
+static TCGOp *rm_ops_range(TCGOp *begin, TCGOp *end)
+{
+    TCGOp *ret = QTAILQ_NEXT(end, link);
+
+    QTAILQ_REMOVE_SEVERAL(&tcg_ctx->ops, begin, end, link);
+    return ret;
+}
+
+/* remove all ops until (and including) plugin_cb_end */
+static TCGOp *rm_ops(TCGOp *op)
+{
+    TCGOp *end_op = find_op(op, INDEX_op_plugin_cb_end);
+
+    tcg_debug_assert(end_op);
+    return rm_ops_range(op, end_op);
+}
+
+static TCGOp *copy_op_nocheck(TCGOp **begin_op, TCGOp *op)
+{
+    *begin_op = QTAILQ_NEXT(*begin_op, link);
+    tcg_debug_assert(*begin_op);
+    op = tcg_op_insert_after(tcg_ctx, op, (*begin_op)->opc);
+    memcpy(op->args, (*begin_op)->args, sizeof(op->args));
+    return op;
+}
+
+static TCGOp *copy_op(TCGOp **begin_op, TCGOp *op, TCGOpcode opc)
+{
+    op = copy_op_nocheck(begin_op, op);
+    tcg_debug_assert((*begin_op)->opc == opc);
+    return op;
+}
+
+static TCGOp *copy_extu_i32_i64(TCGOp **begin_op, TCGOp *op)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* mov_i32 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        /* movi_i32 */
+        op = copy_op(begin_op, op, INDEX_op_movi_i32);
+    } else {
+        /* extu_i32_i64 */
+        op = copy_op(begin_op, op, INDEX_op_extu_i32_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* 2x mov_i32 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+    } else {
+        /* mov_i64 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_movi_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* 2x movi_i32 */
+        op = copy_op(begin_op, op, INDEX_op_movi_i32);
+        op->args[1] = v;
+
+        op = copy_op(begin_op, op, INDEX_op_movi_i32);
+        op->args[1] = v >> 32;
+    } else {
+        /* movi_i64 */
+        op = copy_op(begin_op, op, INDEX_op_movi_i64);
+        op->args[1] = v;
+    }
+    return op;
+}
+
+static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        /* movi_i32 */
+        op = copy_op(begin_op, op, INDEX_op_movi_i32);
+        op->args[1] = (uintptr_t)ptr;
+    } else {
+        /* movi_i64 */
+        op = copy_movi_i64(begin_op, op, (uint64_t)(uintptr_t)ptr);
+    }
+    return op;
+}
+
+static TCGOp *copy_const_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
+{
+    return copy_movi_i64(begin_op, op, v);
+}
+
+static TCGOp *copy_extu_tl_i64(TCGOp **begin_op, TCGOp *op)
+{
+    if (TARGET_LONG_BITS == 32) {
+        /* extu_i32_i64 */
+        op = copy_extu_i32_i64(begin_op, op);
+    } else {
+        /* mov_i64 */
+        op = copy_mov_i64(begin_op, op);
+    }
+    return op;
+}
+
+static TCGOp *copy_ld_i64(TCGOp **begin_op, TCGOp *op)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* 2x ld_i32 */
+        op = copy_op(begin_op, op, INDEX_op_ld_i32);
+        op = copy_op(begin_op, op, INDEX_op_ld_i32);
+    } else {
+        /* ld_i64 */
+        op = copy_op(begin_op, op, INDEX_op_ld_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_st_i64(TCGOp **begin_op, TCGOp *op)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* 2x st_i32 */
+        op = copy_op(begin_op, op, INDEX_op_st_i32);
+        op = copy_op(begin_op, op, INDEX_op_st_i32);
+    } else {
+        /* st_i64 */
+        op = copy_op(begin_op, op, INDEX_op_st_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* all 32-bit backends must implement add2_i32 */
+        g_assert(TCG_TARGET_HAS_add2_i32);
+        op = copy_op(begin_op, op, INDEX_op_add2_i32);
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_add_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        /* st_i32 */
+        op = copy_op(begin_op, op, INDEX_op_st_i32);
+    } else {
+        /* st_i64 */
+        op = copy_st_i64(begin_op, op);
+    }
+    return op;
+}
+
+static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *empty_func,
+                        void *func, unsigned tcg_flags, int *cb_idx)
+{
+    /* copy all ops until the call */
+    do {
+        op = copy_op_nocheck(begin_op, op);
+    } while (op->opc != INDEX_op_call);
+
+    /* fill in the op call */
+    op->param1 = (*begin_op)->param1;
+    op->param2 = (*begin_op)->param2;
+    tcg_debug_assert(op->life == 0);
+    if (*cb_idx == -1) {
+        int i;
+
+        /*
+         * Instead of working out the position of the callback in args[], just
+         * look for @empty_func, since it should be a unique pointer.
+         */
+        for (i = 0; i < MAX_OPC_PARAM_ARGS; i++) {
+            if ((uintptr_t)(*begin_op)->args[i] == (uintptr_t)empty_func) {
+                *cb_idx = i;
+                break;
+            }
+        }
+        tcg_debug_assert(i < MAX_OPC_PARAM_ARGS);
+    }
+    op->args[*cb_idx] = (uintptr_t)func;
+    op->args[*cb_idx + 1] = tcg_flags;
+
+    return op;
+}
+
+static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
+                              TCGOp *begin_op, TCGOp *op, int *cb_idx)
+{
+    /* const_ptr */
+    op = copy_const_ptr(&begin_op, op, cb->userp);
+
+    /* copy the ld_i32, but note that we only have to copy it once */
+    begin_op = QTAILQ_NEXT(begin_op, link);
+    tcg_debug_assert(begin_op && begin_op->opc == INDEX_op_ld_i32);
+    if (*cb_idx == -1) {
+        op = tcg_op_insert_after(tcg_ctx, op, INDEX_op_ld_i32);
+        memcpy(op->args, begin_op->args, sizeof(op->args));
+    }
+
+    /* call */
+    op = copy_call(&begin_op, op, HELPER(plugin_vcpu_udata_cb),
+                   cb->f.vcpu_udata, cb->tcg_flags, cb_idx);
+
+    return op;
+}
+
+static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
+                               TCGOp *begin_op, TCGOp *op,
+                               int *unused)
+{
+    /* const_ptr */
+    op = copy_const_ptr(&begin_op, op, cb->userp);
+
+    /* ld_i64 */
+    op = copy_ld_i64(&begin_op, op);
+
+    /* const_i64 */
+    op = copy_const_i64(&begin_op, op, cb->inline_insn.imm);
+
+    /* add_i64 */
+    op = copy_add_i64(&begin_op, op);
+
+    /* st_i64 */
+    op = copy_st_i64(&begin_op, op);
+
+    return op;
+}
+
+static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
+                            TCGOp *begin_op, TCGOp *op, int *cb_idx)
+{
+    enum plugin_gen_cb type = begin_op->args[1];
+
+    tcg_debug_assert(type == PLUGIN_GEN_CB_MEM);
+
+    /* const_i32 == movi_i32 ("info", so it remains as is) */
+    op = copy_op(&begin_op, op, INDEX_op_movi_i32);
+
+    /* const_ptr */
+    op = copy_const_ptr(&begin_op, op, cb->userp);
+
+    /* copy the ld_i32, but note that we only have to copy it once */
+    begin_op = QTAILQ_NEXT(begin_op, link);
+    tcg_debug_assert(begin_op && begin_op->opc == INDEX_op_ld_i32);
+    if (*cb_idx == -1) {
+        op = tcg_op_insert_after(tcg_ctx, op, INDEX_op_ld_i32);
+        memcpy(op->args, begin_op->args, sizeof(op->args));
+    }
+
+    /* extu_tl_i64 */
+    op = copy_extu_tl_i64(&begin_op, op);
+
+    if (type == PLUGIN_GEN_CB_MEM) {
+        /* call */
+        op = copy_call(&begin_op, op, HELPER(plugin_vcpu_mem_cb),
+                       cb->f.vcpu_udata, cb->tcg_flags, cb_idx);
+    }
+
+    return op;
+}
+
+typedef TCGOp *(*inject_fn)(const struct qemu_plugin_dyn_cb *cb,
+                            TCGOp *begin_op, TCGOp *op, int *intp);
+typedef bool (*op_ok_fn)(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb);
+
+static bool op_ok(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb)
+{
+    return true;
+}
+
+static bool op_rw(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb)
+{
+    int w;
+
+    w = op->args[2];
+    return !!(cb->rw & (w + 1));
+}
+
+static inline
+void inject_cb_type(const GArray *cbs, TCGOp *begin_op, inject_fn inject,
+                    op_ok_fn ok)
+{
+    TCGOp *end_op;
+    TCGOp *op;
+    int cb_idx = -1;
+    int i;
+
+    if (!cbs || cbs->len == 0) {
+        rm_ops(begin_op);
+        return;
+    }
+
+    end_op = find_op(begin_op, INDEX_op_plugin_cb_end);
+    tcg_debug_assert(end_op);
+
+    op = end_op;
+    for (i = 0; i < cbs->len; i++) {
+        struct qemu_plugin_dyn_cb *cb =
+            &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+
+        if (!ok(begin_op, cb)) {
+            continue;
+        }
+        op = inject(cb, begin_op, op, &cb_idx);
+    }
+    rm_ops_range(begin_op, end_op);
+}
+
+static void
+inject_udata_cb(const GArray *cbs, TCGOp *begin_op)
+{
+    inject_cb_type(cbs, begin_op, append_udata_cb, op_ok);
+}
+
+static void
+inject_inline_cb(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
+{
+    inject_cb_type(cbs, begin_op, append_inline_cb, ok);
+}
+
+static void
+inject_mem_cb(const GArray *cbs, TCGOp *begin_op)
+{
+    inject_cb_type(cbs, begin_op, append_mem_cb, op_rw);
+}
+
+/* we could change the ops in place, but we can reuse more code by copying */
+static void inject_mem_helper(TCGOp *begin_op, GArray *arr)
+{
+    TCGOp *orig_op = begin_op;
+    TCGOp *end_op;
+    TCGOp *op;
+
+    end_op = find_op(begin_op, INDEX_op_plugin_cb_end);
+    tcg_debug_assert(end_op);
+
+    /* const ptr */
+    op = copy_const_ptr(&begin_op, end_op, arr);
+
+    /* st_ptr */
+    op = copy_st_ptr(&begin_op, op);
+
+    rm_ops_range(orig_op, end_op);
+}
+
+/*
+ * Tracking memory accesses performed from helpers requires extra work.
+ * If an instruction is emulated with helpers, we do two things:
+ * (1) copy the CB descriptors, and keep track of it so that they can be
+ * freed later on, and (2) point CPUState.plugin_mem_cbs to the descriptors, so
+ * that we can read them at run-time (i.e. when the helper executes).
+ * This run-time access is performed from qemu_plugin_vcpu_mem_cb.
+ *
+ * Note that plugin_gen_disable_mem_helpers undoes (2). Since it
+ * is possible that the code we generate after the instruction is
+ * dead, we also add checks before generating tb_exit etc.
+ */
+static void inject_mem_enable_helper(struct qemu_plugin_insn *plugin_insn,
+                                     TCGOp *begin_op)
+{
+    GArray *cbs[2];
+    GArray *arr;
+    size_t n_cbs, i;
+
+    cbs[0] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
+    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
+
+    n_cbs = 0;
+    for (i = 0; i < ARRAY_SIZE(cbs); i++) {
+        n_cbs += cbs[i]->len;
+    }
+
+    plugin_insn->mem_helper = plugin_insn->calls_helpers && n_cbs;
+    if (likely(!plugin_insn->mem_helper)) {
+        rm_ops(begin_op);
+        return;
+    }
+
+    arr = g_array_sized_new(false, false,
+                            sizeof(struct qemu_plugin_dyn_cb), n_cbs);
+
+    for (i = 0; i < ARRAY_SIZE(cbs); i++) {
+        g_array_append_vals(arr, cbs[i]->data, cbs[i]->len);
+    }
+
+    qemu_plugin_add_dyn_cb_arr(arr);
+    inject_mem_helper(begin_op, arr);
+}
+
+static void inject_mem_disable_helper(struct qemu_plugin_insn *plugin_insn,
+                                      TCGOp *begin_op)
+{
+    if (likely(!plugin_insn->mem_helper)) {
+        rm_ops(begin_op);
+        return;
+    }
+    inject_mem_helper(begin_op, NULL);
+}
+
+/* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
+void plugin_gen_disable_mem_helpers(void)
+{
+    TCGv_ptr ptr;
+
+    if (likely(tcg_ctx->plugin_insn == NULL ||
+               !tcg_ctx->plugin_insn->mem_helper)) {
+        return;
+    }
+    ptr = tcg_const_ptr(NULL);
+    tcg_gen_st_ptr(ptr, cpu_env, offsetof(CPUState, plugin_mem_cbs) -
+                                 offsetof(ArchCPU, env));
+    tcg_temp_free_ptr(ptr);
+    tcg_ctx->plugin_insn->mem_helper = false;
+}
+
+static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
+                                TCGOp *begin_op)
+{
+    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR], begin_op);
+}
+
+static void plugin_gen_tb_inline(const struct qemu_plugin_tb *ptb,
+                                 TCGOp *begin_op)
+{
+    inject_inline_cb(ptb->cbs[PLUGIN_CB_INLINE], begin_op, op_ok);
+}
+
+static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
+                                  TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+
+    inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], begin_op);
+}
+
+static void plugin_gen_insn_inline(const struct qemu_plugin_tb *ptb,
+                                   TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_inline_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
+                     begin_op, op_ok);
+}
+
+static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
+                                   TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_mem_cb(insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR], begin_op);
+}
+
+static void plugin_gen_mem_inline(const struct qemu_plugin_tb *ptb,
+                                  TCGOp *begin_op, int insn_idx)
+{
+    const GArray *cbs;
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+
+    cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
+    inject_inline_cb(cbs, begin_op, op_rw);
+}
+
+static void plugin_gen_enable_mem_helper(const struct qemu_plugin_tb *ptb,
+                                         TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_mem_enable_helper(insn, begin_op);
+}
+
+static void plugin_gen_disable_mem_helper(const struct qemu_plugin_tb *ptb,
+                                          TCGOp *begin_op, int insn_idx)
+{
+    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
+    inject_mem_disable_helper(insn, begin_op);
+}
+
+static void plugin_inject_cb(const struct qemu_plugin_tb *ptb, TCGOp *begin_op,
+                             int insn_idx)
+{
+    enum plugin_gen_from from = begin_op->args[0];
+    enum plugin_gen_cb type = begin_op->args[1];
+
+    switch (from) {
+    case PLUGIN_GEN_FROM_TB:
+        switch (type) {
+        case PLUGIN_GEN_CB_UDATA:
+            plugin_gen_tb_udata(ptb, begin_op);
+            return;
+        case PLUGIN_GEN_CB_INLINE:
+            plugin_gen_tb_inline(ptb, begin_op);
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    case PLUGIN_GEN_FROM_INSN:
+        switch (type) {
+        case PLUGIN_GEN_CB_UDATA:
+            plugin_gen_insn_udata(ptb, begin_op, insn_idx);
+            return;
+        case PLUGIN_GEN_CB_INLINE:
+            plugin_gen_insn_inline(ptb, begin_op, insn_idx);
+            return;
+        case PLUGIN_GEN_ENABLE_MEM_HELPER:
+            plugin_gen_enable_mem_helper(ptb, begin_op, insn_idx);
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    case PLUGIN_GEN_FROM_MEM:
+        switch (type) {
+        case PLUGIN_GEN_CB_MEM:
+            plugin_gen_mem_regular(ptb, begin_op, insn_idx);
+            return;
+        case PLUGIN_GEN_CB_INLINE:
+            plugin_gen_mem_inline(ptb, begin_op, insn_idx);
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    case PLUGIN_GEN_AFTER_INSN:
+        switch (type) {
+        case PLUGIN_GEN_DISABLE_MEM_HELPER:
+            plugin_gen_disable_mem_helper(ptb, begin_op, insn_idx);
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/* #define DEBUG_PLUGIN_GEN_OPS */
+static void pr_ops(void)
+{
+#ifdef DEBUG_PLUGIN_GEN_OPS
+    TCGOp *op;
+    int i = 0;
+
+    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
+        const char *name = "";
+        const char *type = "";
+
+        if (op->opc == INDEX_op_plugin_cb_start) {
+            switch (op->args[0]) {
+            case PLUGIN_GEN_FROM_TB:
+                name = "tb";
+                break;
+            case PLUGIN_GEN_FROM_INSN:
+                name = "insn";
+                break;
+            case PLUGIN_GEN_FROM_MEM:
+                name = "mem";
+                break;
+            case PLUGIN_GEN_AFTER_INSN:
+                name = "after insn";
+                break;
+            default:
+                break;
+            }
+            switch (op->args[1]) {
+            case PLUGIN_GEN_CB_UDATA:
+                type = "udata";
+                break;
+            case PLUGIN_GEN_CB_INLINE:
+                type = "inline";
+                break;
+            case PLUGIN_GEN_CB_MEM:
+                type = "mem";
+                break;
+            case PLUGIN_GEN_ENABLE_MEM_HELPER:
+                type = "enable mem helper";
+                break;
+            case PLUGIN_GEN_DISABLE_MEM_HELPER:
+                type = "disable mem helper";
+                break;
+            default:
+                break;
+            }
+        }
+        printf("op[%2i]: %s %s %s\n", i, tcg_op_defs[op->opc].name, name, type);
+        i++;
+    }
+#endif
+}
+
+static void plugin_gen_inject(const struct qemu_plugin_tb *plugin_tb)
+{
+    TCGOp *op;
+    int insn_idx;
+
+    pr_ops();
+    insn_idx = -1;
+    QSIMPLEQ_FOREACH(op, &tcg_ctx->plugin_ops, plugin_link) {
+        enum plugin_gen_from from = op->args[0];
+        enum plugin_gen_cb type = op->args[1];
+
+        tcg_debug_assert(op->opc == INDEX_op_plugin_cb_start);
+        /* ENABLE_MEM_HELPER is the first callback of an instruction */
+        if (from == PLUGIN_GEN_FROM_INSN &&
+            type == PLUGIN_GEN_ENABLE_MEM_HELPER) {
+            insn_idx++;
+        }
+        plugin_inject_cb(plugin_tb, op, insn_idx);
+    }
+    pr_ops();
+}
+
+bool plugin_gen_tb_start(CPUState *cpu, const TranslationBlock *tb)
+{
+    struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
+    bool ret = false;
+
+    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_mask)) {
+        ret = true;
+
+        QSIMPLEQ_INIT(&tcg_ctx->plugin_ops);
+        ptb->vaddr = tb->pc;
+        ptb->vaddr2 = -1;
+        get_page_addr_code_hostp(cpu->env_ptr, tb->pc, &ptb->haddr1);
+        ptb->haddr2 = NULL;
+
+        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
+    }
+    return ret;
+}
+
+void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
+{
+    struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
+    struct qemu_plugin_insn *pinsn;
+
+    pinsn = qemu_plugin_tb_insn_get(ptb);
+    tcg_ctx->plugin_insn = pinsn;
+    pinsn->vaddr = db->pc_next;
+    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
+
+    /*
+     * Detect page crossing to get the new host address.
+     * Note that we skip this when haddr1 == NULL, e.g. when we're
+     * fetching instructions from a region not backed by RAM.
+     */
+    if (likely(ptb->haddr1 != NULL && ptb->vaddr2 == -1) &&
+        unlikely((db->pc_next & TARGET_PAGE_MASK) !=
+                 (db->pc_first & TARGET_PAGE_MASK))) {
+        get_page_addr_code_hostp(cpu->env_ptr, db->pc_next,
+                                 &ptb->haddr2);
+        ptb->vaddr2 = db->pc_next;
+    }
+    if (likely(ptb->vaddr2 == -1)) {
+        pinsn->haddr = ptb->haddr1 + pinsn->vaddr - ptb->vaddr;
+    } else {
+        pinsn->haddr = ptb->haddr2 + pinsn->vaddr - ptb->vaddr2;
+    }
+}
+
+void plugin_gen_insn_end(void)
+{
+    plugin_gen_empty_callback(PLUGIN_GEN_AFTER_INSN);
+}
+
+void plugin_gen_tb_end(CPUState *cpu)
+{
+    struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
+    int i;
+
+    /* collect instrumentation requests */
+    qemu_plugin_tb_trans_cb(cpu, ptb);
+
+    /* inject the instrumentation at the appropriate places */
+    plugin_gen_inject(ptb);
+
+    /* clean up */
+    for (i = 0; i < PLUGIN_N_CB_SUBTYPES; i++) {
+        if (ptb->cbs[i]) {
+            g_array_set_size(ptb->cbs[i], 0);
+        }
+    }
+    ptb->n = 0;
+    tcg_ctx->plugin_insn = NULL;
+}
diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
new file mode 100644
index 0000000000..1916ee7920
--- /dev/null
+++ b/accel/tcg/plugin-helpers.h
@@ -0,0 +1,5 @@
+#ifdef CONFIG_PLUGIN
+/* Note: no TCG flags because those are overwritten later */
+DEF_HELPER_2(plugin_vcpu_udata_cb, void, i32, ptr)
+DEF_HELPER_4(plugin_vcpu_mem_cb, void, i32, i32, i64, ptr)
+#endif
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 22381a1708..236ff40524 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -70,6 +70,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 #include "trace/generated-helpers.h"
 #include "trace/generated-helpers-wrappers.h"
 #include "tcg-runtime.h"
+#include "plugin-helpers.h"
 
 #undef DEF_HELPER_FLAGS_0
 #undef DEF_HELPER_FLAGS_1
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 74943edb13..1c4ba9bc78 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -33,6 +33,7 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
+#include "plugin-helpers.h"
 
 #undef DEF_HELPER_FLAGS_0
 #undef DEF_HELPER_FLAGS_1
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index 268e0f804b..573c2ce2e9 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -55,6 +55,7 @@
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
+#include "plugin-helpers.h"
 
 #undef str
 #undef DEF_HELPER_FLAGS_0
diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
new file mode 100644
index 0000000000..de519883b1
--- /dev/null
+++ b/include/exec/plugin-gen.h
@@ -0,0 +1,57 @@
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
+struct DisasContextBase;
+
+#ifdef CONFIG_PLUGIN
+
+bool plugin_gen_tb_start(CPUState *cpu, const TranslationBlock *tb);
+void plugin_gen_tb_end(CPUState *cpu);
+void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
+void plugin_gen_insn_end(void);
+
+void plugin_gen_disable_mem_helpers(void);
+void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info);
+
+#else /* !CONFIG_PLUGIN */
+
+static inline
+bool plugin_gen_tb_start(CPUState *cpu, const TranslationBlock *tb)
+{
+    return false;
+}
+
+static inline
+void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db)
+{ }
+
+static inline void plugin_gen_insn_end(void)
+{ }
+
+static inline void plugin_gen_tb_end(CPUState *cpu)
+{ }
+
+static inline void plugin_gen_disable_mem_helpers(void)
+{ }
+
+static inline void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
+{ }
+
+#endif /* CONFIG_PLUGIN */
+
+#endif /* QEMU_PLUGIN_GEN_H */
+
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 7c778f96f3..4af272daa5 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -833,6 +833,17 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
+static inline void tcg_gen_plugin_cb_start(unsigned from, unsigned type,
+                                           unsigned wr)
+{
+    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
+}
+
+static inline void tcg_gen_plugin_cb_end(void)
+{
+    tcg_emit_op(INDEX_op_plugin_cb_end);
+}
+
 #if TARGET_LONG_BITS == 32
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_reg_new tcg_global_reg_new_i32
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 242d608e6d..9288a04946 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -198,6 +198,9 @@ DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_ptr, 0, 1, 0,
     TCG_OPF_BB_EXIT | TCG_OPF_BB_END | IMPL(TCG_TARGET_HAS_goto_ptr))
 
+DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
+DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
+
 DEF(qemu_ld_i32, 1, TLADDR_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_i32, 0, TLADDR_ARGS + 1, 1,
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 16b2d0e0ec..5475d49ed1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -736,6 +736,15 @@ void tcg_region_init(void)
 #endif
 }
 
+static void alloc_tcg_plugin_context(TCGContext *s)
+{
+#ifdef CONFIG_PLUGIN
+    s->plugin_tb = g_new0(struct qemu_plugin_tb, 1);
+    s->plugin_tb->insns =
+        g_ptr_array_new_with_free_func(qemu_plugin_insn_cleanup_fn);
+#endif
+}
+
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -780,6 +789,10 @@ void tcg_register_thread(void)
     g_assert(n < ms->smp.max_cpus);
     atomic_set(&tcg_ctxs[n], s);
 
+    if (n > 0) {
+        alloc_tcg_plugin_context(s);
+    }
+
     tcg_ctx = s;
     qemu_mutex_lock(&region.lock);
     err = tcg_region_initial_alloc__locked(tcg_ctx);
@@ -976,6 +989,8 @@ void tcg_context_init(TCGContext *s)
         indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
     }
 
+    alloc_tcg_plugin_context(s);
+
     tcg_ctx = s;
     /*
      * In user-mode we simply share the init context among threads, since we
@@ -1681,6 +1696,13 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
     flags = info->flags;
     sizemask = info->sizemask;
 
+#ifdef CONFIG_PLUGIN
+    /* detect non-plugin helpers */
+    if (tcg_ctx->plugin_insn && unlikely(strncmp(info->name, "plugin_", 7))) {
+        tcg_ctx->plugin_insn->calls_helpers = true;
+    }
+#endif
+
 #if defined(__sparc__) && !defined(__arch64__) \
     && !defined(CONFIG_TCG_INTERPRETER)
     /* We have 64-bit values in one register, but need to pass as two
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a37181c899..d234b4c9a5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -538,6 +538,9 @@ typedef struct TCGOp {
 
     /* Next and previous opcodes.  */
     QTAILQ_ENTRY(TCGOp) link;
+#ifdef CONFIG_PLUGIN
+    QSIMPLEQ_ENTRY(TCGOp) plugin_link;
+#endif
 
     /* Arguments for the opcode.  */
     TCGArg args[MAX_OPC_PARAM];
@@ -639,6 +642,23 @@ struct TCGContext {
 
     TCGLabel *exitreq_label;
 
+#ifdef CONFIG_PLUGIN
+    /*
+     * We keep one plugin_tb struct per TCGContext. Note that on every TB
+     * translation we clear but do not free its contents; this way we
+     * avoid a lot of malloc/free churn, since after a few TB's it's
+     * unlikely that we'll need to allocate either more instructions or more
+     * space for instructions (for variable-instruction-length ISAs).
+     */
+    struct qemu_plugin_tb *plugin_tb;
+
+    /* descriptor of the instruction being translated */
+    struct qemu_plugin_insn *plugin_insn;
+
+    /* list to quickly access the injected ops */
+    QSIMPLEQ_HEAD(, TCGOp) plugin_ops;
+#endif
+
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
-- 
2.20.1


