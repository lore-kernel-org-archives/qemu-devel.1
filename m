Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D9ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D6920650
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idegc3E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D6920650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy8V-00045o-Ba
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvO-0007KH-9P
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvL-00064g-8N
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvK-00061v-8g
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id j11so19161580wrp.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aWosiEmfAHwfRAkWSG4KOdORJMPLEdhWkH8ZZEz3mMs=;
 b=idegc3E/yON+fcbsAWafyZpIBzED+7ij5Ab4MqeELd8RZxu6rxUCCerzhl4J6ULD9f
 cN6sKyl13dpm101o2C1PYLpnW/tdtWs0FudAeciTh3FA8Q7svD1fZJ6XnJx8sgLzKWzg
 utoo6Th0M69MixB8YN++XrEerPbahOXTx0OCxuiEQx/ipd8WPbk5TsL8qDm0YGFBSNqQ
 LIdA+8opQ9wEQ8AR4/fp3wg1D9l02VShwOClQxcYWr2v91aekfjoHK5hJumRz0gShU9M
 HRqumRMSbxSjhMlJq9v37lGdNQUQhhDf5djko2L7HiitflZkchKouSNEhKOGzHe5W0wc
 qtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aWosiEmfAHwfRAkWSG4KOdORJMPLEdhWkH8ZZEz3mMs=;
 b=CFBJfZzBTT7RB1zIPyEzh6z4ovbx/tI1ND9BDyrQ46M6ke+FMhhhUfowuLBsJ4Dutj
 Y8AnVNnIhTRxNN4JZGP/SEEPoRSEXuItkLlONB2McCWxv1ZEXW6g5tNtrB/qsK7E/H1B
 0lYSXN2hkAXFdso12SjThHihoFXH0hjyrt4DkLNKduuU12mb2/O3VHBPSdq+qO5QwIpd
 VfmOq5aNqvlclDU8QvnoFxcg1dB0M/FFyeaaWjnD5YNYOrmFjCje242Ft7Ablp4zbyJ2
 ag4IUOcVqu/N5Hxo1nR4MlL4xMahREM+hT+jiyHLsza2d7HjX4zOG8FDJAJLjk/lmmLW
 Bn5A==
X-Gm-Message-State: APjAAAVI9FYy7ywQppwQZKQIDdQ7nnwHPD9dxq9qtxwmd8Zecn82SYBn
 cMGfJ7HwWqp8w1OV93IXO6HznQ==
X-Google-Smtp-Source: APXvYqyyyg13BC2FumQQLGAwv4bY1LZ4CDvX0fYRLzZj5JQglVq0Wu/rM0NVxn4G9wkagFeWnROM3w==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr24981868wrb.222.1571050196562; 
 Mon, 14 Oct 2019 03:49:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm19605792wrs.49.2019.10.14.03.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F2D81FF87;
 Mon, 14 Oct 2019 11:49:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 09/55] plugin: add implementation of the api
Date: Mon, 14 Oct 2019 11:49:02 +0100
Message-Id: <20191014104948.4291-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[AJB: split from the core code commit]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4
   - add qemu_plugin_ram_addr_from_host
   - remove _haddr api calls
v5
   - remove stray #if 0
---
 plugins/Makefile.objs |   1 +
 plugins/api.c         | 287 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 plugins/api.c

diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
index 58940335bc..95baabf3d2 100644
--- a/plugins/Makefile.objs
+++ b/plugins/Makefile.objs
@@ -4,3 +4,4 @@
 
 obj-y += loader.o
 obj-y += core.o
+obj-y += api.o
diff --git a/plugins/api.c b/plugins/api.c
new file mode 100644
index 0000000000..3de05719a8
--- /dev/null
+++ b/plugins/api.c
@@ -0,0 +1,287 @@
+/*
+ * QEMU Plugin API
+ *
+ * This provides the API that is available to the plugins to interact
+ * with QEMU. We have to be careful not to expose internal details of
+ * how QEMU works so we abstract out things like translation and
+ * instructions to anonymous data types:
+ *
+ *  qemu_plugin_tb
+ *  qemu_plugin_insn
+ *
+ * Which can then be passed back into the API to do additional things.
+ * As such all the public functions in here are exported in
+ * qemu-plugin.h.
+ *
+ * The general life-cycle of a plugin is:
+ *
+ *  - plugin is loaded, public qemu_plugin_install called
+ *    - the install func registers callbacks for events
+ *    - usually an atexit_cb is registered to dump info at the end
+ *  - when a registered event occurs the plugin is called
+ *     - some events pass additional info
+ *     - during translation the plugin can decide to instrument any
+ *       instruction
+ *  - when QEMU exits all the registered atexit callbacks are called
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019, Linaro
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+#include "cpu.h"
+#include "sysemu/sysemu.h"
+#include "tcg/tcg.h"
+#include "trace/mem-internal.h" /* mem_info macros */
+#include "plugin.h"
+#ifndef CONFIG_USER_ONLY
+#include "hw/boards.h"
+#endif
+
+/* Uninstall and Reset handlers */
+
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+{
+    plugin_reset_uninstall(id, cb, false);
+}
+
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+{
+    plugin_reset_uninstall(id, cb, true);
+}
+
+/*
+ * Plugin Register Functions
+ *
+ * This allows the plugin to register callbacks for various events
+ * during the translation.
+ */
+
+void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
+}
+
+void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
+}
+
+void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+                                          qemu_plugin_vcpu_udata_cb_t cb,
+                                          enum qemu_plugin_cb_flags flags,
+                                          void *udata)
+{
+    plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
+                                  cb, flags, udata);
+}
+
+void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+                                              enum qemu_plugin_op op,
+                                              void *ptr, uint64_t imm)
+{
+    plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
+}
+
+void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+                                            qemu_plugin_vcpu_udata_cb_t cb,
+                                            enum qemu_plugin_cb_flags flags,
+                                            void *udata)
+{
+    plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR],
+        cb, flags, udata);
+}
+
+void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+                                                enum qemu_plugin_op op,
+                                                void *ptr, uint64_t imm)
+{
+    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
+                              0, op, ptr, imm);
+}
+
+
+
+void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+                                      qemu_plugin_vcpu_mem_cb_t cb,
+                                      enum qemu_plugin_cb_flags flags,
+                                      enum qemu_plugin_mem_rw rw,
+                                      void *udata)
+{
+    plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
+                                cb, flags, rw, udata);
+}
+
+void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+                                          enum qemu_plugin_mem_rw rw,
+                                          enum qemu_plugin_op op, void *ptr,
+                                          uint64_t imm)
+{
+    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
+        rw, op, ptr, imm);
+}
+
+void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+                                           qemu_plugin_vcpu_tb_trans_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb);
+}
+
+void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+                                          qemu_plugin_vcpu_syscall_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
+}
+
+void
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
+}
+
+/*
+ * Plugin Queries
+ *
+ * These are queries that the plugin can make to gauge information
+ * from our opaque data types. We do not want to leak internal details
+ * here just information useful to the plugin.
+ */
+
+/*
+ * Translation block information:
+ *
+ * A plugin can query the virtual address of the start of the block
+ * and the number of instructions in it. It can also get access to
+ * each translated instruction.
+ */
+
+size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
+{
+    return tb->n;
+}
+
+uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
+{
+    return tb->vaddr;
+}
+
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
+{
+    if (unlikely(idx >= tb->n)) {
+        return NULL;
+    }
+    return g_ptr_array_index(tb->insns, idx);
+}
+
+/*
+ * Instruction information
+ *
+ * These queries allow the plugin to retrieve information about each
+ * instruction being translated.
+ */
+
+const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn)
+{
+    return insn->data->data;
+}
+
+size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
+{
+    return insn->data->len;
+}
+
+uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
+{
+    return insn->vaddr;
+}
+
+void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
+{
+    return insn->haddr;
+}
+
+/*
+ * The memory queries allow the plugin to query information about a
+ * memory access.
+ */
+
+unsigned qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info)
+{
+    return info & TRACE_MEM_SZ_SHIFT_MASK;
+}
+
+bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info)
+{
+    return !!(info & TRACE_MEM_SE);
+}
+
+bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info)
+{
+    return !!(info & TRACE_MEM_BE);
+}
+
+bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
+{
+    return !!(info & TRACE_MEM_ST);
+}
+
+/*
+ * Virtual Memory queries
+ */
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    return NULL;
+}
+
+bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
+{
+    return false;
+}
+
+uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *haddr)
+{
+    return 0;
+}
+
+/*
+ * Queries to the number and potential maximum number of vCPUs there
+ * will be. This helps the plugin dimension per-vcpu arrays.
+ */
+
+#ifndef CONFIG_USER_ONLY
+static MachineState * get_ms(void)
+{
+    return MACHINE(qdev_get_machine());
+}
+#endif
+
+int qemu_plugin_n_vcpus(void)
+{
+#ifdef CONFIG_USER_ONLY
+    return -1;
+#else
+    return get_ms()->smp.cpus;
+#endif
+}
+
+int qemu_plugin_n_max_vcpus(void)
+{
+#ifdef CONFIG_USER_ONLY
+    return -1;
+#else
+    return get_ms()->smp.max_cpus;
+#endif
+}
-- 
2.20.1


