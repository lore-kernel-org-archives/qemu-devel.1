Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48ACCA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C2220867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKvYPrxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C2220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtZA-00085T-Vk
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE7-0003Rq-OO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE5-0008Tf-NL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE5-0008SO-B5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id n7so762028wmc.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ki5hRzj89s13VKfj3RSaJdLQEClcEWqDIviltV7kgU=;
 b=tKvYPrxdmfKvLZxB976DebcC8c5ofepmvdmKv3EQPMHX2dOhhOPi0+mgutiDDLzBCO
 7xqiqpSH6PYNyd9UlW/KfBvupdNoWTcF704H47h6K9S7rXMG9ZFi3FXbbhSFFwH8Dres
 fPsXTloc/WDH7nxgx0rq7uZaBrWYVLjoEuNBukljGgelKc5qtSKGwpmrIh67jJZgSlXg
 TO6FxlcujMSYWoPSaR4e8tK5OyOUdHuGmM+AwXZURZ47O8LUTJEHj9S+4cPcpzX7Ggc/
 aq3tPQb9/K9SU1/JcVbEAy8B4a1AjXGBEV05xG65NbQV8DfATj6Ko6gKNftJMnK2yIub
 UH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ki5hRzj89s13VKfj3RSaJdLQEClcEWqDIviltV7kgU=;
 b=qQNCp/Rzn/RASsFI7hbigOppJqp9ffLJkFI4v9plLwKNYbIvl7gSI7OqVupZIey3Rv
 R2jIV2SuSvyB94ISOnB71emv/EGjUhMlVpz7yRNUQRKp4F3ftiA8rTGj/ITVqiXQ3aBU
 dR/JJ8gr36/tmnFU0Oaczy+dG7NeReOOcgCHyQEN2MV4ZamOfYvRs9L32DdgCIAZytWj
 dFvhtFnl+ofFA2SvS1wuQyR7mJEgOa3yhZQe7ox9nCLXqXbBkVM2uKyXfkqV6nYO0xkT
 c5Q6TbH33fev7D+uSBpAxfoL7y8gVQjeIZxnEs83iLYcMC7carJLMcow1n5BqTKYo645
 5QaA==
X-Gm-Message-State: APjAAAWr+YwMOJbrjn6L79Lm542QFaWYfPG9c1MVZVNoCnvVKMzCe+08
 hYRJOCIaIxIDPyUefTmnxEyziA==
X-Google-Smtp-Source: APXvYqwMCc4Nzf8nd0aUD/oP37U99ZatJTXFWl4aWfSUpL/Zq6eM5hWhsZlli/zgGvcO9ew10WhduQ==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr1903945wmd.176.1571985450476; 
 Thu, 24 Oct 2019 23:37:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p5sm1510130wmi.4.2019.10.24.23.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCD301FFAC;
 Fri, 25 Oct 2019 07:37:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 22/73] plugin: add user-facing API
Date: Fri, 25 Oct 2019 07:36:22 +0100
Message-Id: <20191025063713.23374-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Add the API first to ease review.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
new file mode 100644
index 00000000000..d9c1ca3b4cf
--- /dev/null
+++ b/include/qemu/qemu-plugin.h
@@ -0,0 +1,351 @@
+/*
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019, Linaro
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_PLUGIN_API_H
+#define QEMU_PLUGIN_API_H
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+/*
+ * For best performance, build the plugin with -fvisibility=hidden so that
+ * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
+ * QEMU_PLUGIN_EXPORT. For more info, see
+ *   https://gcc.gnu.org/wiki/Visibility
+ */
+#if defined _WIN32 || defined __CYGWIN__
+  #ifdef BUILDING_DLL
+    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
+  #else
+    #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
+  #endif
+  #define QEMU_PLUGIN_LOCAL
+#else
+  #if __GNUC__ >= 4
+    #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
+    #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
+  #else
+    #define QEMU_PLUGIN_EXPORT
+    #define QEMU_PLUGIN_LOCAL
+  #endif
+#endif
+
+typedef uint64_t qemu_plugin_id_t;
+
+/**
+ * qemu_plugin_install() - Install a plugin
+ * @id: this plugin's opaque ID
+ * @argc: number of arguments
+ * @argv: array of arguments (@argc elements)
+ *
+ * All plugins must export this symbol.
+ *
+ * Note: Calling qemu_plugin_uninstall() from this function is a bug. To raise
+ * an error during install, return !0.
+ *
+ * Note: @argv remains valid throughout the lifetime of the loaded plugin.
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv);
+
+/*
+ * Prototypes for the various callback styles we will be registering
+ * in the following functions.
+ */
+typedef void (*qemu_plugin_simple_cb_t)(qemu_plugin_id_t id);
+
+typedef void (*qemu_plugin_udata_cb_t)(qemu_plugin_id_t id, void *userdata);
+
+typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
+                                             unsigned int vcpu_index);
+
+typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
+                                            void *userdata);
+
+/**
+ * qemu_plugin_uninstall() - Uninstall a plugin
+ * @id: this plugin's opaque ID
+ * @cb: callback to be called once the plugin has been removed
+ *
+ * Do NOT assume that the plugin has been uninstalled once this function
+ * returns. Plugins are uninstalled asynchronously, and therefore the given
+ * plugin receives callbacks until @cb is called.
+ *
+ * Note: Calling this function from qemu_plugin_install() is a bug.
+ */
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+
+/**
+ * qemu_plugin_reset() - Reset a plugin
+ * @id: this plugin's opaque ID
+ * @cb: callback to be called once the plugin has been reset
+ *
+ * Unregisters all callbacks for the plugin given by @id.
+ *
+ * Do NOT assume that the plugin has been reset once this function returns.
+ * Plugins are reset asynchronously, and therefore the given plugin receives
+ * callbacks until @cb is called.
+ */
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU is initialized.
+ *
+ * See also: qemu_plugin_register_vcpu_exit_cb()
+ */
+void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU exits.
+ *
+ * See also: qemu_plugin_register_vcpu_init_cb()
+ */
+void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU idles.
+ */
+void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU resumes execution.
+ */
+void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_simple_cb_t cb);
+
+/*
+ * Opaque types that the plugin is given during the translation and
+ * instrumentation phase.
+ */
+struct qemu_plugin_tb;
+struct qemu_plugin_insn;
+
+enum qemu_plugin_cb_flags {
+    QEMU_PLUGIN_CB_NO_REGS, /* callback does not access the CPU's regs */
+    QEMU_PLUGIN_CB_R_REGS,  /* callback reads the CPU's regs */
+    QEMU_PLUGIN_CB_RW_REGS, /* callback reads and writes the CPU's regs */
+};
+
+enum qemu_plugin_mem_rw {
+    QEMU_PLUGIN_MEM_R = 1,
+    QEMU_PLUGIN_MEM_W,
+    QEMU_PLUGIN_MEM_RW,
+};
+
+/**
+ * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a translation occurs. The @cb
+ * function is passed an opaque qemu_plugin_type which it can query
+ * for additional information including the list of translated
+ * instructions. At this point the plugin can register further
+ * callbacks to be triggered when the block or individual instruction
+ * executes.
+ */
+typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
+                                               struct qemu_plugin_tb *tb);
+
+void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+                                           qemu_plugin_vcpu_tb_trans_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_tb_trans_exec_cb() - register execution callback
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @cb: callback function
+ * @flags: does the plugin read or write the CPU's registers?
+ * @userdata: any plugin data to pass to the @cb?
+ *
+ * The @cb function is called every time a translated unit executes.
+ */
+void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+                                          qemu_plugin_vcpu_udata_cb_t cb,
+                                          enum qemu_plugin_cb_flags flags,
+                                          void *userdata);
+
+enum qemu_plugin_op {
+    QEMU_PLUGIN_INLINE_ADD_U64,
+};
+
+/**
+ * qemu_plugin_register_vcpu_tb_trans_exec_inline() - execution inline op
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @ptr: the target memory location for the op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time a translated unit executes.
+ * Useful if you just want to increment a single counter somewhere in
+ * memory.
+ */
+void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+                                              enum qemu_plugin_op op,
+                                              void *ptr, uint64_t imm);
+
+/**
+ * qemu_plugin_register_vcpu_insn_exec_cb() - register insn execution cb
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @cb: callback function
+ * @flags: does the plugin read or write the CPU's registers?
+ * @userdata: any plugin data to pass to the @cb?
+ *
+ * The @cb function is called every time an instruction is executed
+ */
+void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+                                            qemu_plugin_vcpu_udata_cb_t cb,
+                                            enum qemu_plugin_cb_flags flags,
+                                            void *userdata);
+
+/**
+ * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline op
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @cb: callback function
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @ptr: the target memory location for the op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time an instruction executes. Useful
+ * if you just want to increment a single counter somewhere in memory.
+ */
+void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+                                                enum qemu_plugin_op op,
+                                                void *ptr, uint64_t imm);
+
+/*
+ * Helpers to query information about the instructions in a block
+ */
+size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
+
+uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
+
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
+
+const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
+
+size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
+
+uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
+void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
+
+/*
+ * Memory Instrumentation
+ *
+ * The anonymous qemu_plugin_meminfo_t and qemu_plugin_hwaddr types
+ * can be used in queries to QEMU to get more information about a
+ * given memory access.
+ */
+typedef uint32_t qemu_plugin_meminfo_t;
+struct qemu_plugin_hwaddr;
+
+/* meminfo queries */
+unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
+bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
+bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
+bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
+
+/*
+ * qemu_plugin_get_hwaddr():
+ * @vaddr: the virtual address of the memory operation
+ *
+ * For system emulation returns a qemu_plugin_hwaddr handle to query
+ * details about the actual physical address backing the virtual
+ * address. For linux-user guests it just returns NULL.
+ *
+ * This handle is *only* valid for the duration of the callback. Any
+ * information about the handle should be recovered before the
+ * callback returns.
+ */
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr);
+
+bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr);
+uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *haddr);
+
+typedef void
+(*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
+                             qemu_plugin_meminfo_t info, uint64_t vaddr,
+                             void *userdata);
+
+void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+                                      qemu_plugin_vcpu_mem_cb_t cb,
+                                      enum qemu_plugin_cb_flags flags,
+                                      enum qemu_plugin_mem_rw rw,
+                                      void *userdata);
+
+void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+                                          enum qemu_plugin_mem_rw rw,
+                                          enum qemu_plugin_op op, void *ptr,
+                                          uint64_t imm);
+
+
+
+typedef void
+(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                 int64_t num, uint64_t a1, uint64_t a2,
+                                 uint64_t a3, uint64_t a4, uint64_t a5,
+                                 uint64_t a6, uint64_t a7, uint64_t a8);
+
+void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+                                          qemu_plugin_vcpu_syscall_cb_t cb);
+
+typedef void
+(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
+                                     int64_t num, int64_t ret);
+
+void
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
+
+
+/**
+ * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called once for each existing vCPU.
+ *
+ * See also: qemu_plugin_register_vcpu_init_cb()
+ */
+void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+                               qemu_plugin_vcpu_simple_cb_t cb);
+
+void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
+                                   qemu_plugin_simple_cb_t cb);
+
+void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
+                                    qemu_plugin_udata_cb_t cb, void *userdata);
+
+/* returns -1 in user-mode */
+int qemu_plugin_n_vcpus(void);
+
+/* returns -1 in user-mode */
+int qemu_plugin_n_max_vcpus(void);
+
+#endif /* QEMU_PLUGIN_API_H */
-- 
2.20.1


