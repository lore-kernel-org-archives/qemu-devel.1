Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAABBECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D662089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMdfdwj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D662089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5ud-00039f-Um
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dg-00080w-AA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5de-0005Nk-0Q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dd-0005La-Od
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so2319014wrj.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jxSf2lbuW5KJiixqzN79rCXNmB+////wViO7YEre93M=;
 b=iMdfdwj8gkyW/+HononaJbEEZ844boMUIfSaBU0o+Hs6IpV/1Qw5AQtjb+RHxL2Mwp
 6JUpKc2d49MaO3iG2DZ2FbWmyfZr5AoiTinDEe3Dh/NzdynaO8rs5RtbZs3dLni9Vrzl
 GTKHGKAl31nHY4NtzKK6qQmmC4hfVQyYbE5MHfY071NC8F3TQ61qRX7/au4BWG0iXMTR
 6GA5uRPXgHi3gFrASmpSRf/EEApTR4tYi/MixBbVeUAGXv++mShBd8G+/5GUs4w+Fy6m
 JfQluUT8CWgeXpX2xlP6ojx/xzdlndYQRi2doEMpTxhbQJ0jnv/7IOcanQE2Iu9Wfn0M
 eUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jxSf2lbuW5KJiixqzN79rCXNmB+////wViO7YEre93M=;
 b=AiKNsuNoNoKcwNw9oa2y0xccJQVoOJ+BUHN+O24YDrKbvipmFoza5VNqcYZxau7wFP
 WklAxH6C0llMpVLh+O3ABm5DZC8jxSrvcPJx+jsXJ+D5tl/RHHBXRrU/jGZieJVfZ/WQ
 BP43LG2PCuWW0XViDGH/2ZG1qgnBi93QC98wPxLZeUwiwUFpjDi9JLZQPUYwyOnHTXAT
 IAcfGAcBhGluPboZYUUhHadV3rZfyY/VmDBUyhUlfK1QmArsxXcxrKip69ZdRz9akMVE
 tFvRpw8IfDwHxVdaIBA6DtnrtETr06AiNCmyhlV/lP/FjHAWPYXhZowZdiUh1QKvEmPJ
 SG9Q==
X-Gm-Message-State: APjAAAVsA7RbOTtHsSETSKeG8/i1sho9EKqL184IAizchLRCyT9vSwM5
 pSDlR5IWjf/JTgyFV2S4h8hBB1BjzMQ=
X-Google-Smtp-Source: APXvYqx75Ou8WK0mqFKGZj89hO0bRIrbe6f6jAeBvpodlAnHTYq1UUvoyvppfXkoJ8dde1dCxPyNLA==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr2925736wrt.36.1571318180439;
 Thu, 17 Oct 2019 06:16:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g17sm2158196wrq.58.2019.10.17.06.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A9EA1FF93;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 06/54] plugin: add user-facing API
Date: Thu, 17 Oct 2019 14:15:27 +0100
Message-Id: <20191017131615.19660-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: "Emilio G. Cota" <cota@braap.org>

Add the API first to ease review.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - merge in changes to plugin install/reset/uninstall
  - split api file
v4
  - s/is/it/
  - more docstrings
  - remove qemu_plugin_register_vcpu_mem_haddr_cb and related bits
  - add qemu_plugin_get_hwaddr and related bits
  - drop vcpu_index from tb_trans_cb_t
---
 include/qemu/qemu-plugin.h | 351 +++++++++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)
 create mode 100644 include/qemu/qemu-plugin.h

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
new file mode 100644
index 0000000000..d9c1ca3b4c
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


