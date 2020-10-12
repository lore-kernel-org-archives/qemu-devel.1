Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F8DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DDF20575
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DDF20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8ri-0000gC-JT
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Gh-0001oS-7C
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:15 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:35906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GN-000621-EB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:14 -0400
Received: by mail-pl1-f170.google.com with SMTP id w21so6828165plq.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g46hQzXfYsVfDOAEjWsJ5/ziWAju7INePcqlbhhfRHU=;
 b=UJrBO1lI1xsC/fi7/iFDV177e0e7Upu6gbI8a8oh31ObD39tV16at0WD4e+YEC7DUy
 bmBdjF2UNNzRJuF/bghqBzuXFfkpA1BCAWFZRhHxjEvxVzX3zHJSABMav+sGwi5RgZ5F
 nWU5Vl83b0pmt//1JTtNwMUC4mnMwi/EGX2ypewp5IkiYqqf/KJWtGeSwyue7SYahyhI
 VwbzdbtBqQtL4mtpaLG45YRkMKlSwmexeRXcFFCmMcD+Izhbg4ELiEueeNb/VVWiShQI
 oeLCIp8VExPiAEq+k2S/wO/KzGKIZtfLUklE46aw/+SiTcTqdOrjPonVedBaSMJA7205
 R4Eg==
X-Gm-Message-State: AOAM533fHFmJdBjWniL4gGTwIip8ZMJtyeIkBjUCV/uq22qzvdOn1DYR
 ATlsfFbeEqFRpGf6A6uaSYaIGcH22bU=
X-Google-Smtp-Source: ABdhPJwA4IABniys11eyN6yvhiuOU/Z0ACncgHjY2JIiUAwS0aQ8T6yyXjCBejilCXI8a4c3eytDjQ==
X-Received: by 2002:a17:902:7441:b029:d3:eaa4:8f35 with SMTP id
 e1-20020a1709027441b02900d3eaa48f35mr26156674plt.74.1602545393736; 
 Mon, 12 Oct 2020 16:29:53 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:53 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] tcg: support JIT on Apple Silicon
Date: Mon, 12 Oct 2020 16:29:38 -0700
Message-Id: <20201012232939.48481-10-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012232939.48481-1-j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.170; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f170.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2020 20:56:29 -0400
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

From: osy <osy86@users.noreply.github.com>

https://developer.apple.com/documentation/apple_silicon/porting_just-in-time_compilers_to_apple_silicon

For < iOS 14, reverse engineered functions from libsystem_pthread.dylib is
implemented to handle APRR supported SoCs.

The following rules apply for JIT write protect:
  * JIT write-protect is enabled before tcg_qemu_tb_exec()
  * JIT write-protect is disabled after tcg_qemu_tb_exec() returns
  * JIT write-protect is disabled inside do_tb_phys_invalidate() but if it
    is called inside of tcg_qemu_tb_exec() then write-protect will be
    enabled again before returning.
  * JIT write-protect is disabled by cpu_loop_exit() for interrupt handling.
  * JIT write-protect is disabled everywhere else.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 accel/tcg/cpu-exec-common.c |  2 +
 accel/tcg/cpu-exec.c        |  2 +
 accel/tcg/translate-all.c   | 51 ++++++++++++++++++++++
 configure                   | 20 +++++++++
 include/exec/exec-all.h     |  2 +
 include/tcg/tcg-apple-jit.h | 85 +++++++++++++++++++++++++++++++++++++
 include/tcg/tcg.h           |  3 ++
 tcg/tcg.c                   |  4 ++
 8 files changed, 169 insertions(+)
 create mode 100644 include/tcg/tcg-apple-jit.h

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
index 821aefdea2..d00d17f3c6 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -175,7 +175,9 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
     }
 #endif /* DEBUG_DISAS */
 
+    tb_exec_lock();
     ret = tcg_qemu_tb_exec(env, tb_ptr);
+    tb_exec_unlock();
     cpu->can_do_io = 1;
     last_tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
     tb_exit = ret & TB_EXIT_MASK;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index de9b7d9ab6..98daabbfc0 100644
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
@@ -76,6 +79,9 @@ extern kern_return_t mach_vm_remap(vm_map_t target_task,
                                   );
 #endif
 
+static bool tb_exec_is_locked(void);
+static void tb_exec_change(bool locked);
+
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
 /* make various TB consistency checks */
@@ -1246,6 +1252,7 @@ void tcg_exec_init(unsigned long tb_size, bool mirror_rwx)
     page_init();
     tb_htable_init();
     code_gen_alloc(tb_size, mirror_rwx);
+    tb_exec_unlock();
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
@@ -1522,8 +1529,11 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     PageDesc *p;
     uint32_t h;
     tb_page_addr_t phys_pc;
+    bool code_gen_locked;
 
     assert_memory_lock();
+    code_gen_locked = tb_exec_is_locked();
+    tb_exec_unlock();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -1536,6 +1546,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
                      tb->trace_vcpu_dstate);
     if (!(tb->cflags & CF_NOCACHE) &&
         !qht_remove(&tb_ctx.htable, tb, h)) {
+        tb_exec_change(code_gen_locked);
         return;
     }
 
@@ -1568,6 +1579,8 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 
     qatomic_set(&tcg_ctx->tb_phys_invalidate_count,
                tcg_ctx->tb_phys_invalidate_count + 1);
+
+    tb_exec_change(code_gen_locked);
 }
 
 static void tb_phys_invalidate__locked(TranslationBlock *tb)
@@ -2808,3 +2821,41 @@ void tcg_flush_softmmu_tlb(CPUState *cs)
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
+#if defined(HAVE_PTHREAD_JIT_PROTECT)
+    if (__builtin_available(macOS 11, iOS 14, watchOS 7, tvOS 14, *)) {
+        pthread_jit_write_protect_np(locked);
+    } else
+#endif
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
diff --git a/configure b/configure
index c5a6584683..4c8cb63670 100755
--- a/configure
+++ b/configure
@@ -5874,6 +5874,22 @@ but not implemented on your system"
     fi
 fi
 
+##########################################
+# check for Apple Silicon JIT function
+
+if [ "$darwin" = "yes" ] ; then
+  cat > $TMPC << EOF
+#include <pthread.h>
+int main() { pthread_jit_write_protect_np(0); return 0; }
+EOF
+  if ! compile_prog ""; then
+    have_pthread_jit_protect='no'
+  else
+    have_pthread_jit_protect='yes'
+  fi
+fi
+
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -6994,6 +7010,10 @@ if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
 fi
 
+if test "$have_pthread_jit_protect" = "yes" ; then
+  echo "HAVE_PTHREAD_JIT_PROTECT=y" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote ${source_path}/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2db155a772..253af30a2e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -521,6 +521,8 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
                                    target_ulong cs_base, uint32_t flags,
                                    uint32_t cf_mask);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
+void tb_exec_lock(void);
+void tb_exec_unlock(void);
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #if defined(CONFIG_TCG_INTERPRETER)
diff --git a/include/tcg/tcg-apple-jit.h b/include/tcg/tcg-apple-jit.h
new file mode 100644
index 0000000000..1e70bf3afe
--- /dev/null
+++ b/include/tcg/tcg-apple-jit.h
@@ -0,0 +1,85 @@
+/*
+ * Apple Silicon APRR functions for JIT handling
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
+/*
+ * Credits to: https://siguza.github.io/APRR/
+ * Reversed from /usr/lib/system/libsystem_pthread.dylib
+ */
+
+#ifndef TCG_APPLE_JIT_H
+#define TCG_APPLE_JIT_H
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
index 40d1a7a85e..fbe00af4e1 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -630,6 +630,9 @@ struct TCGContext {
 #if defined(CONFIG_IOS_JIT)
     ptrdiff_t code_rw_mirror_diff;
 #endif
+#if defined(CONFIG_DARWIN) && !defined(CONFIG_TCG_INTERPRETER)
+    bool code_gen_locked; /* on Darwin each thread tracks W^X flags */
+#endif
 
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ef203a34a6..244a0a43bf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -781,6 +781,8 @@ static void alloc_tcg_plugin_context(TCGContext *s)
 void tcg_register_thread(void)
 {
     tcg_ctx = &tcg_init_ctx;
+
+    tb_exec_unlock();
 }
 #else
 void tcg_register_thread(void)
@@ -815,6 +817,8 @@ void tcg_register_thread(void)
     err = tcg_region_initial_alloc__locked(tcg_ctx);
     g_assert(!err);
     qemu_mutex_unlock(&region.lock);
+
+    tb_exec_unlock();
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.24.3 (Apple Git-128)


