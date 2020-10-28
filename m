Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD31DC55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D7F2242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D7F2242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXbqM-0006Ev-D7
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnw-0003pn-1c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:16 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:50829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnt-0006ia-L5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:15 -0400
Received: by mail-pj1-f54.google.com with SMTP id p21so1830977pju.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DT49rni35hFVEyMORzS9ppHUHIUpQbYd1D7RYdXKZaU=;
 b=nKxq1nXd/HVYMC4WsqLvi1Q0q4k9mm2loJqWf/UPeJyVvyBG+YwzouOAwzZU0vf6p8
 n1ShfG5TzI1eaadMf3hLwCAfToYO4hsc+yRvPDH4sMtERNCShyz4lWc8qUb1pdQjjtL/
 gV+ocikmm3UfqnGaawG7LE0uRZEj4xK7QAXHn4qY6Usq0qFm/gJpbyQJdzlrrLQZpVI7
 YaxxP+YuTaJ+vppFULOvDnwhZ6+p8muW+zGqNrdvxoe8fEEK1gzisYad2yOfww/JuxB2
 3rfd2XibLEtI34ldy8ttLsg0uQt49MqH4d6D1Whctg3CPCRn/sP97+pkuOf1VJ2+etN6
 Bi7A==
X-Gm-Message-State: AOAM531En3BmIpBI5lvd/9cgdjTHJW9L+RjvDnFCyzssBgxwxbStyD32
 WJq2SLXt8+hALh9ZQpbpn0YYvsEXydA=
X-Google-Smtp-Source: ABdhPJwAMN4uB7a77ySNws+RYpmTGD40J0zjoQ+lYMcsw7KhvcdB0Q4yZ8lYRTCrOQRiYi/0NoYHuQ==
X-Received: by 2002:a17:90a:3804:: with SMTP id
 w4mr4858485pjb.171.1603854431721; 
 Tue, 27 Oct 2020 20:07:11 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.93])
 by smtp.gmail.com with ESMTPSA id n6sm3407219pjj.34.2020.10.27.20.07.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 20:07:11 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] tcg: implement JIT for iOS and Apple Silicon
Date: Tue, 27 Oct 2020 20:07:00 -0700
Message-Id: <20201028030701.14086-7-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028030701.14086-1-j@getutm.app>
References: <20201028030701.14086-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.54; envelope-from=osy86github@gmail.com;
 helo=mail-pj1-f54.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 23:07:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On iOS, we cannot allocate RWX pages without special entitlements. As a
workaround, we can allocate a RX region and then mirror map it to a separate
RX region. Then we can write to one region and execute from the other one.

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

Reference:
https://developer.apple.com/documentation/apple_silicon/porting_just-in-time_compilers_to_apple_silicon
Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 docs/devel/index.rst        |   1 +
 docs/devel/ios.rst          |  39 +++++++++++++
 configure                   |   1 +
 include/exec/exec-all.h     |   2 +
 include/tcg/tcg-apple-jit.h | 106 ++++++++++++++++++++++++++++++++++++
 include/tcg/tcg.h           |   3 +
 accel/tcg/cpu-exec-common.c |   2 +
 accel/tcg/cpu-exec.c        |   2 +
 accel/tcg/translate-all.c   |  87 ++++++++++++++++++++++++++++-
 tcg/tcg.c                   |   4 ++
 10 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/ios.rst
 create mode 100644 include/tcg/tcg-apple-jit.h

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 77baae5c77..a46740929f 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -34,3 +34,4 @@ Contents:
    clocks
    qom
    block-coroutine-wrapper
+   ios
diff --git a/docs/devel/ios.rst b/docs/devel/ios.rst
new file mode 100644
index 0000000000..3cfa588e72
--- /dev/null
+++ b/docs/devel/ios.rst
@@ -0,0 +1,39 @@
+===========
+iOS Support
+===========
+
+To run qemu on the iOS platform, some modifications were required. Most of the
+modifications are conditioned on the ``CONFIG_IOS`` and configuration variable.
+
+Build support
+-------------
+
+For the code to compile, certain changes in the block driver and the slirp
+driver had to be made. There is no ``system()`` call, so code requiring it had
+to be disabled.
+
+``ucontext`` support is broken on iOS. The implementation from ``libucontext``
+is used instead.
+
+Because ``fork()`` is not allowed on iOS apps, the option to build qemu and the
+utilities as shared libraries is added. Note that because qemu does not perform
+resource cleanup in most cases (open files, allocated memory, etc), it is
+advisable that the user implements a proxy layer for syscalls so resources can
+be kept track by the app that uses qemu as a shared library.
+
+JIT support
+-----------
+
+On iOS, allocating RWX pages require special entitlements not usually granted to
+apps. However, it is possible to use `bulletproof JIT`_ with a development
+certificate. This means that we need to allocate one chunk of memory with RX
+permissions and then mirror map the same memory with RW permissions. We generate
+code to the mirror mapping and execute the original mapping.
+
+With ``CONFIG_MIRROR_JIT`` defined, we store inside the TCG context the
+difference between the two mappings. Then, we make sure that any writes to JIT
+memory is done to the pointer + the difference (in order to get a pointer to the
+mirror mapped space). Additionally, we make sure to flush the data cache before
+we invalidate the instruction cache so the changes are seen in both mappings.
+
+.. _bulletproof JIT: https://www.blackhat.com/docs/us-16/materials/us-16-Krstic.pdf
diff --git a/configure b/configure
index 0fef867a9c..a250fe7e8e 100755
--- a/configure
+++ b/configure
@@ -797,6 +797,7 @@ iOS)
   bsd="yes"
   darwin="yes"
   ios="yes"
+  mirror_jit="yes"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 921767a51b..7823a75a30 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -557,6 +557,8 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
                                    target_ulong cs_base, uint32_t flags,
                                    uint32_t cf_mask);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
+void tb_exec_lock(void);
+void tb_exec_unlock(void);
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #if defined(CONFIG_TCG_INTERPRETER)
diff --git a/include/tcg/tcg-apple-jit.h b/include/tcg/tcg-apple-jit.h
new file mode 100644
index 0000000000..703a53da4a
--- /dev/null
+++ b/include/tcg/tcg-apple-jit.h
@@ -0,0 +1,106 @@
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
+ * Mirror mapping JIT region for older SoCs ("bulletproof JIT")
+ */
+
+#if defined(CONFIG_DARWIN)
+#include <mach/mach.h>
+extern kern_return_t mach_vm_remap(vm_map_t target_task,
+                                   mach_vm_address_t *target_address,
+                                   mach_vm_size_t size,
+                                   mach_vm_offset_t mask,
+                                   int flags,
+                                   vm_map_t src_task,
+                                   mach_vm_address_t src_address,
+                                   boolean_t copy,
+                                   vm_prot_t *cur_protection,
+                                   vm_prot_t *max_protection,
+                                   vm_inherit_t inheritance
+                                  );
+#endif
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
index a76c259d1b..8a210542bc 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -631,6 +631,9 @@ struct TCGContext {
     int code_gen_buffer_fd;
     ptrdiff_t code_rw_mirror_diff;
 #endif
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
index f7eb6fcd77..f720fbd358 100644
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
index 2144433024..ad41d2c817 100644
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
 #include "qemu/memfd.h"
 
+static bool tb_exec_is_locked(void);
+static void tb_exec_change(bool locked);
+
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
 /* make various TB consistency checks */
@@ -1093,6 +1099,12 @@ static inline void *alloc_code_gen_buffer(bool mirror_jit)
         prot |= PROT_WRITE;
         flags |= MAP_ANONYMOUS | MAP_PRIVATE;
     }
+#elif defined(CONFIG_DARWIN) /* both iOS and macOS (Apple Silicon) applicable */
+    if (!mirror_jit) {
+        prot |= PROT_WRITE;
+        flags |= MAP_JIT;
+    }
+    flags |= MAP_ANONYMOUS | MAP_PRIVATE;
 #else /* defined(CONFIG_LINUX) */
 #error "Mirror JIT unimplemented for this platform."
 #endif /* defined(CONFIG_LINUX) */
@@ -1164,9 +1176,42 @@ static inline void *alloc_jit_rw_mirror(void)
 
     return buf;
 }
+#elif defined(CONFIG_DARWIN)
+static inline void *alloc_jit_rw_mirror(void)
+{
+    void *base = tcg_ctx->code_gen_buffer;
+    size_t size = tcg_ctx->code_gen_buffer_size;
+    kern_return_t ret;
+    mach_vm_address_t mirror;
+    vm_prot_t cur_prot, max_prot;
+
+    mirror = 0;
+    ret = mach_vm_remap(mach_task_self(),
+                        &mirror,
+                        size,
+                        0,
+                        VM_FLAGS_ANYWHERE | VM_FLAGS_RANDOM_ADDR,
+                        mach_task_self(),
+                        (mach_vm_address_t)base,
+                        false,
+                        &cur_prot,
+                        &max_prot,
+                        VM_INHERIT_NONE
+                       );
+    if (ret != KERN_SUCCESS) {
+        return NULL;
+    }
+
+    if (mprotect((void *)mirror, size, PROT_READ | PROT_WRITE) != 0) {
+        munmap((void *)mirror, size);
+        return NULL;
+    }
+
+    return (void *)mirror;
+}
 #else
 #error "Mirror JIT unimplemented for this platform."
-#endif /* CONFIG_IOS */
+#endif /* CONFIG_DARWIN */
 #endif /* CONFIG_MIRROR_JIT */
 
 static inline void code_gen_alloc(size_t tb_size, bool mirror_jit)
@@ -1230,6 +1275,7 @@ void tcg_exec_init(unsigned long tb_size, bool mirror_jit)
     page_init();
     tb_htable_init();
     code_gen_alloc(tb_size, mirror_jit);
+    tb_exec_unlock();
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
@@ -1506,8 +1552,11 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     PageDesc *p;
     uint32_t h;
     tb_page_addr_t phys_pc;
+    bool code_gen_locked;
 
     assert_memory_lock();
+    code_gen_locked = tb_exec_is_locked();
+    tb_exec_unlock();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -1520,6 +1569,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
                      tb->trace_vcpu_dstate);
     if (!(tb->cflags & CF_NOCACHE) &&
         !qht_remove(&tb_ctx.htable, tb, h)) {
+        tb_exec_change(code_gen_locked);
         return;
     }
 
@@ -1552,6 +1602,8 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 
     qatomic_set(&tcg_ctx->tb_phys_invalidate_count,
                tcg_ctx->tb_phys_invalidate_count + 1);
+
+    tb_exec_change(code_gen_locked);
 }
 
 static void tb_phys_invalidate__locked(TranslationBlock *tb)
@@ -2792,3 +2844,36 @@ void tcg_flush_softmmu_tlb(CPUState *cs)
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
index 085bc73063..ef64c0d3b1 100644
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
2.28.0


