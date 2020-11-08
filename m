Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E44C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04218206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04218206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbuB1-0005sZ-SW
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu34-0000tc-A4
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:24:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu32-0000GM-5Q
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:24:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id f18so769794pgi.8
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oqTRRse3ML08CbYMBMir3imYmfVxmJCy/vR5/9jdsfA=;
 b=uee72tzzBOfOSt4ecT17oG9023oMrORREMO3hjRXfisVbAHYquuODTy6F412UCP0Nc
 y/J3au5d02j/9l6AUW7b7W8ks4tP5YfmzOxuuolS6mVE1X4pm4ZQrzrvjRiVlmD1mAgG
 IoBam8MzuSGbtDTNubH4tP6mGSEOmyDnQBycjpO4ngBwsvawvevTuKNUE4SosiYptmib
 4o3Gj/DmnrCeUl0BBlg/YPWhY+7aJ5sMApqGhq1SnmKpOs8U4XxmiTl6oXP2YMGu9jDN
 1o5vh0Yg0BTKgPnhHcLZVI0Gw1CqiLhrGp10Z6dpkYRVxIR8B/FAD3lLl9OweV5vxykH
 fqAw==
X-Gm-Message-State: AOAM533VIuZmNY33nPGYrmSttnihi64hQFbb+tgKN4crQkhX0U5cVLIp
 7C8pdbumVZL162MZyf+BGza7WpNveDM=
X-Google-Smtp-Source: ABdhPJz2CwfqeamI2DkpxiOMaVyE2ZHBUiqZGfpwcmep4NXMYEmMpOVPvKocMnINVZRo3D8Ddna/LQ==
X-Received: by 2002:a17:90a:5204:: with SMTP id
 v4mr9427428pjh.188.1604877874671; 
 Sun, 08 Nov 2020 15:24:34 -0800 (PST)
Received: from localhost.localdomain ([73.93.154.215])
 by smtp.gmail.com with ESMTPSA id z3sm8275171pgl.73.2020.11.08.15.24.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:24:34 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 6/7] tcg: implement JIT for iOS and Apple Silicon
Date: Sun,  8 Nov 2020 15:24:23 -0800
Message-Id: <20201108232425.1705-7-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108232425.1705-1-j@getutm.app>
References: <20201108232425.1705-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.196;
 envelope-from=osy86github@gmail.com; helo=mail-pg1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 18:24:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joelle van Dyne <j@getutm.app>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When entitlements are available (macOS or jailbroken iOS), a hardware
feature called APRR exists on newer Apple Silicon that can cheaply mark JIT
pages as either RX or RW. Reverse engineered functions from
libsystem_pthread.dylib are implemented to handle this.

The following rules apply for JIT write protect:
  * JIT write-protect is enabled before tcg_qemu_tb_exec()
  * JIT write-protect is disabled after tcg_qemu_tb_exec() returns
  * JIT write-protect is disabled inside do_tb_phys_invalidate() but if it
    is called inside of tcg_qemu_tb_exec() then write-protect will be
    enabled again before returning.
  * JIT write-protect is disabled by cpu_loop_exit() for interrupt handling.
  * JIT write-protect is disabled everywhere else.

See https://developer.apple.com/documentation/apple_silicon/porting_just-in-time_compilers_to_apple_silicon

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/exec/exec-all.h     |  2 +
 include/tcg/tcg-apple-jit.h | 86 +++++++++++++++++++++++++++++++++++++
 include/tcg/tcg.h           |  3 ++
 accel/tcg/cpu-exec-common.c |  2 +
 accel/tcg/cpu-exec.c        |  2 +
 accel/tcg/translate-all.c   | 46 ++++++++++++++++++++
 tcg/tcg.c                   |  4 ++
 7 files changed, 145 insertions(+)
 create mode 100644 include/tcg/tcg-apple-jit.h

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index aa65103702..3829f3d470 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -549,6 +549,8 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
                                    target_ulong cs_base, uint32_t flags,
                                    uint32_t cf_mask);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
+void tb_exec_lock(void);
+void tb_exec_unlock(void);
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #if defined(CONFIG_TCG_INTERPRETER)
diff --git a/include/tcg/tcg-apple-jit.h b/include/tcg/tcg-apple-jit.h
new file mode 100644
index 0000000000..9efdb2000d
--- /dev/null
+++ b/include/tcg/tcg-apple-jit.h
@@ -0,0 +1,86 @@
+/*
+ * Apple Silicon functions for JIT handling
+ *
+ * Copyright (c) 2020 osy
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TCG_APPLE_JIT_H
+#define TCG_APPLE_JIT_H
+
+/*
+ * APRR handling
+ * Credits to: https://siguza.github.io/APRR/
+ * Reversed from /usr/lib/system/libsystem_pthread.dylib
+ */
+
+#if defined(__aarch64__) && defined(CONFIG_DARWIN)
+
+#define _COMM_PAGE_START_ADDRESS        (0x0000000FFFFFC000ULL) /* In TTBR0 */
+#define _COMM_PAGE_APRR_SUPPORT         (_COMM_PAGE_START_ADDRESS + 0x10C)
+#define _COMM_PAGE_APPR_WRITE_ENABLE    (_COMM_PAGE_START_ADDRESS + 0x110)
+#define _COMM_PAGE_APRR_WRITE_DISABLE   (_COMM_PAGE_START_ADDRESS + 0x118)
+
+static __attribute__((__always_inline__)) bool jit_write_protect_supported(void)
+{
+    /* Access shared kernel page at fixed memory location. */
+    uint8_t aprr_support = *(volatile uint8_t *)_COMM_PAGE_APRR_SUPPORT;
+    return aprr_support > 0;
+}
+
+/* write protect enable = write disable */
+static __attribute__((__always_inline__)) void jit_write_protect(int enabled)
+{
+    /* Access shared kernel page at fixed memory location. */
+    uint8_t aprr_support = *(volatile uint8_t *)_COMM_PAGE_APRR_SUPPORT;
+    if (aprr_support == 0 || aprr_support > 3) {
+        return;
+    } else if (aprr_support == 1) {
+        __asm__ __volatile__ (
+            "mov x0, %0\n"
+            "ldr x0, [x0]\n"
+            "msr S3_4_c15_c2_7, x0\n"
+            "isb sy\n"
+            :: "r" (enabled ? _COMM_PAGE_APRR_WRITE_DISABLE
+                            : _COMM_PAGE_APPR_WRITE_ENABLE)
+            : "memory", "x0"
+        );
+    } else {
+        __asm__ __volatile__ (
+            "mov x0, %0\n"
+            "ldr x0, [x0]\n"
+            "msr S3_6_c15_c1_5, x0\n"
+            "isb sy\n"
+            :: "r" (enabled ? _COMM_PAGE_APRR_WRITE_DISABLE
+                            : _COMM_PAGE_APPR_WRITE_ENABLE)
+            : "memory", "x0"
+        );
+    }
+}
+
+#else /* defined(__aarch64__) && defined(CONFIG_DARWIN) */
+
+static __attribute__((__always_inline__)) bool jit_write_protect_supported(void)
+{
+    return false;
+}
+
+static __attribute__((__always_inline__)) void jit_write_protect(int enabled)
+{
+}
+
+#endif
+
+#endif /* define TCG_APPLE_JIT_H */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 477919aeb6..b16b687d0b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -625,6 +625,9 @@ struct TCGContext {
     size_t code_gen_buffer_size;
     void *code_gen_ptr;
     void *data_gen_ptr;
+#if defined(CONFIG_DARWIN) && !defined(CONFIG_TCG_INTERPRETER)
+    bool code_gen_locked; /* on Darwin each thread tracks W^X flags */
+#endif
 
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 12c1e3e974..f1eb767b02 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -64,6 +64,8 @@ void cpu_reloading_memory_map(void)
 
 void cpu_loop_exit(CPUState *cpu)
 {
+    /* Unlock JIT write protect if applicable. */
+    tb_exec_unlock();
     /* Undo the setting in cpu_tb_exec.  */
     cpu->can_do_io = 1;
     siglongjmp(cpu->jmp_env, 1);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8df0a1782e..960e0c1f36 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -176,7 +176,9 @@ static inline TranslationBlock *cpu_tb_exec(CPUState *cpu,
     }
 #endif /* DEBUG_DISAS */
 
+    tb_exec_lock();
     ret = tcg_qemu_tb_exec(env, tb_ptr);
+    tb_exec_unlock();
     cpu->can_do_io = 1;
     /*
      * TODO: Delay swapping back to the read-write region of the TB
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 06102871e7..5773c561cb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -27,6 +27,9 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
+#if defined(CONFIG_DARWIN)
+#include "tcg/tcg-apple-jit.h"
+#endif
 #if defined(CONFIG_USER_ONLY)
 #include "qemu.h"
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
@@ -61,6 +64,9 @@
 #include "sysemu/tcg.h"
 #include "qapi/error.h"
 
+static bool tb_exec_is_locked(void);
+static void tb_exec_change(bool locked);
+
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
 /* make various TB consistency checks */
@@ -1339,6 +1345,7 @@ void tcg_exec_init(unsigned long tb_size, int splitwx)
                                splitwx, &error_fatal);
     assert(ok);
 
+    tb_exec_unlock();
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
@@ -1615,8 +1622,11 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     PageDesc *p;
     uint32_t h;
     tb_page_addr_t phys_pc;
+    bool code_gen_locked;
 
     assert_memory_lock();
+    code_gen_locked = tb_exec_is_locked();
+    tb_exec_unlock();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -1629,6 +1639,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
                      tb->trace_vcpu_dstate);
     if (!(tb->cflags & CF_NOCACHE) &&
         !qht_remove(&tb_ctx.htable, tb, h)) {
+        tb_exec_change(code_gen_locked);
         return;
     }
 
@@ -1661,6 +1672,8 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 
     qatomic_set(&tcg_ctx->tb_phys_invalidate_count,
                tcg_ctx->tb_phys_invalidate_count + 1);
+
+    tb_exec_change(code_gen_locked);
 }
 
 static void tb_phys_invalidate__locked(TranslationBlock *tb)
@@ -2899,3 +2912,36 @@ void tcg_flush_softmmu_tlb(CPUState *cs)
     tlb_flush(cs);
 #endif
 }
+
+#if defined(CONFIG_DARWIN) && !defined(CONFIG_TCG_INTERPRETER)
+static bool tb_exec_is_locked(void)
+{
+    return tcg_ctx->code_gen_locked;
+}
+
+static void tb_exec_change(bool locked)
+{
+    if (jit_write_protect_supported()) {
+        jit_write_protect(locked);
+    }
+    tcg_ctx->code_gen_locked = locked;
+}
+#else /* not needed on non-Darwin platforms */
+static bool tb_exec_is_locked(void)
+{
+    return false;
+}
+
+static void tb_exec_change(bool locked) {}
+#endif
+
+void tb_exec_lock(void)
+{
+    /* assumes sys_icache_invalidate already called */
+    tb_exec_change(true);
+}
+
+void tb_exec_unlock(void)
+{
+    tb_exec_change(false);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d3052031cb..5ed79d2724 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -809,6 +809,8 @@ static void alloc_tcg_plugin_context(TCGContext *s)
 void tcg_register_thread(void)
 {
     tcg_ctx = &tcg_init_ctx;
+
+    tb_exec_unlock();
 }
 #else
 void tcg_register_thread(void)
@@ -843,6 +845,8 @@ void tcg_register_thread(void)
     err = tcg_region_initial_alloc__locked(tcg_ctx);
     g_assert(!err);
     qemu_mutex_unlock(&region.lock);
+
+    tb_exec_unlock();
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.28.0


