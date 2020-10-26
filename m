Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C022080A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C022080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX80v-0002PH-Om
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kX7y9-0000FQ-K3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:15:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kX7y7-00085J-Hx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:15:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id o129so1169410pfb.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EXNwdRHyKDfBU/YkYTgijXr3twjv0yV9PsiwwkhXiP0=;
 b=l61kr8iqIo+Kd2fMpcLcbJEpxwDF86SC0Wx+zeDgQmC9mmfYv6SgiQP4GNsUzPjM9O
 qrHNIBm2xDxtGoMJTLHiV+kdZZA2LsyrUibCJailYjocC0gQzTJlsGAgE4E0smFnyLXM
 b5VCyMmMyHNQtBitF7+dTqXIX/b9tjr+0Mq+FiWk2CB5Qgh7uzgFZD3MWzdPvV4zVjT6
 9L47f4Iqr+gYwDxXvL7rJQtpmjVlZE2HOFe/fELQ88NwLIuxSPtKGnGgoZTtby9x/uRa
 1GvQgfEnnWvVf0khY4a4JktmaQ103W8Q8/VFcAcug2qAPZlG0ZQd588e3N2z3g4pbKiu
 0Nqw==
X-Gm-Message-State: AOAM532sk0QwxXgN7Q37vXIms8EHrQv2rVoJh4+w1dIWRhwAxz2+TMOz
 gFH76Z9uRSYGDoXH2RWd7puKDyZtYWY=
X-Google-Smtp-Source: ABdhPJxb9j5gXt51HJOO1D0O+9ahoWONYyIZSn4Fc3smqqZ4JOHEIsVsXIlYQ9/gSyO4G3JJVBMrCA==
X-Received: by 2002:a63:3e0a:: with SMTP id l10mr12898894pga.420.1603739745766; 
 Mon, 26 Oct 2020 12:15:45 -0700 (PDT)
Received: from localhost.localdomain ([73.93.153.41])
 by smtp.gmail.com with ESMTPSA id gb13sm10233191pjb.55.2020.10.26.12.15.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2020 12:15:45 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 2/4] tcg: implement mirror mapped JIT for Linux
Date: Mon, 26 Oct 2020 12:15:38 -0700
Message-Id: <20201026191540.12434-3-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026191540.12434-1-j@getutm.app>
References: <20201026191540.12434-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.194;
 envelope-from=osy86github@gmail.com; helo=mail-pf1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:25:47
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

When configured with --enable-debug-tcg on Linux, we enable JIT mirror map
which separates the JIT allocation into a RX-only address and a RW-only
address. The backing is a memfd_create() object.

This allows us to catch bugs where we unintentionally write to the JIT
region. However, the main use case will be for other platforms that require
strict W^X separation to run.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure                 | 13 ++++++++
 meson.build               |  1 +
 include/exec/exec-all.h   |  8 +++++
 include/tcg/tcg.h         | 18 ++++++++++
 accel/tcg/cpu-exec.c      |  7 +++-
 accel/tcg/translate-all.c | 69 +++++++++++++++++++++++++++++++++++----
 6 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 55e07c82dd..71bbe82ac5 100755
--- a/configure
+++ b/configure
@@ -447,6 +447,7 @@ meson=""
 ninja=""
 skip_meson=no
 gettext=""
+mirror_jit="no"
 
 bogus_os="no"
 malloc_trim="auto"
@@ -5715,6 +5716,14 @@ if test "$mingw32" = "yes" ; then
     done
 fi
 
+# Enable mirror mapping if debug_tcg on supported platform
+
+if test "$debug_tcg" = "yes"; then
+  if test "$linux" = "yes"; then
+    mirror_jit=yes
+  fi
+fi
+
 # We can only support ivshmem if we have eventfd
 if [ "$eventfd" = "yes" ]; then
   ivshmem=yes
@@ -6801,6 +6810,10 @@ if test "$safe_stack" = "yes"; then
   echo "CONFIG_SAFESTACK=y" >> $config_host_mak
 fi
 
+if test "$mirror_jit" = "yes"; then
+  echo "CONFIG_MIRROR_JIT=y" >> $config_host_mak
+fi
+
 # If we're using a separate build tree, set it up now.
 # DIRS are directories which we simply mkdir in the build tree;
 # LINKS are things to symlink back into the source tree
diff --git a/meson.build b/meson.build
index 835424999d..0a56fef146 100644
--- a/meson.build
+++ b/meson.build
@@ -2162,6 +2162,7 @@ endif
 summary_info += {'thread sanitizer':  config_host.has_key('CONFIG_TSAN')}
 summary_info += {'rng-none':          config_host.has_key('CONFIG_RNG_NONE')}
 summary_info += {'Linux keyring':     config_host.has_key('CONFIG_SECRET_KEYRING')}
+summary_info += {'mirror JIT':        config_host.has_key('CONFIG_MIRROR_JIT')}
 summary(summary_info, bool_yn: true)
 
 if not supported_cpus.contains(cpu)
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4707ac140c..921767a51b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -519,6 +519,14 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+#if defined(CONFIG_MIRROR_JIT)
+    /*
+     * Store difference to writable mirror
+     * We need this when patching the jump instructions
+     */
+    ptrdiff_t code_rw_mirror_diff;
+#endif
 };
 
 extern bool parallel_cpus;
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 79c5ff8dab..a76c259d1b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -627,6 +627,10 @@ struct TCGContext {
     size_t code_gen_buffer_size;
     void *code_gen_ptr;
     void *data_gen_ptr;
+#if defined(CONFIG_MIRROR_JIT)
+    int code_gen_buffer_fd;
+    ptrdiff_t code_rw_mirror_diff;
+#endif
 
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
@@ -677,6 +681,20 @@ struct TCGContext {
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
 };
 
+static inline void *tcg_mirror_ptr_rw(TCGContext *s, const void *rx)
+{
+#if defined(CONFIG_MIRROR_JIT)
+    return (void *)rx + s->code_rw_mirror_diff;
+#else
+    return (void *)rx;
+#endif
+}
+
+static inline tcg_insn_unit *tcg_code_ptr_rw(TCGContext *s, const void *rx)
+{
+    return (tcg_insn_unit *)tcg_mirror_ptr_rw(s, rx);
+}
+
 extern TCGContext tcg_init_ctx;
 extern __thread TCGContext *tcg_ctx;
 extern TCGv_env cpu_env;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 58aea605d8..f7eb6fcd77 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -354,7 +354,12 @@ void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr)
     if (TCG_TARGET_HAS_direct_jump) {
         uintptr_t offset = tb->jmp_target_arg[n];
         uintptr_t tc_ptr = (uintptr_t)tb->tc.ptr;
-        tb_target_set_jmp_target(tc_ptr, tc_ptr + offset, addr);
+#if defined(CONFIG_MIRROR_JIT)
+        uintptr_t wr_addr = tc_ptr + offset + tb->code_rw_mirror_diff;
+#else
+        uintptr_t wr_addr = tc_ptr + offset;
+#endif
+        tb_target_set_jmp_target(tc_ptr, tc_ptr + offset, addr, wr_addr);
     } else {
         tb->jmp_target_arg[n] = addr;
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d76097296d..bfb856ac1a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -59,6 +59,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
+#include "qemu/memfd.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -302,10 +303,12 @@ static target_long decode_sleb128(uint8_t **pp)
 
 static int encode_search(TranslationBlock *tb, uint8_t *block)
 {
-    uint8_t *highwater = tcg_ctx->code_gen_highwater;
-    uint8_t *p = block;
+    const uint8_t *highwater, *start;
+    uint8_t *p;
     int i, j, n;
 
+    highwater = tcg_mirror_ptr_rw(tcg_ctx, tcg_ctx->code_gen_highwater);
+    start = p = tcg_mirror_ptr_rw(tcg_ctx, block);
     for (i = 0, n = tb->icount; i < n; ++i) {
         target_ulong prev;
 
@@ -329,7 +332,7 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
         }
     }
 
-    return p - block;
+    return p - start;
 }
 
 /* The cpu state corresponding to 'searched_pc' is restored.
@@ -1067,12 +1070,29 @@ static inline void *alloc_code_gen_buffer(void)
 #else
 static inline void *alloc_code_gen_buffer(void)
 {
-    int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
-    int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+    int prot = PROT_READ | PROT_EXEC;
+    int flags = 0;
     size_t size = tcg_ctx->code_gen_buffer_size;
+    int fd = -1;
     void *buf;
 
-    buf = mmap(NULL, size, prot, flags, -1, 0);
+#if defined(CONFIG_MIRROR_JIT)
+#if defined(CONFIG_LINUX)
+    fd = qemu_memfd_create("tcg-jit", size, false, 0, 0, NULL);
+    if (fd < 0) {
+        return NULL;
+    }
+    tcg_ctx->code_gen_buffer_fd = fd;
+    flags |= MAP_SHARED;
+#else /* defined(CONFIG_LINUX) */
+#error "Mirror JIT unimplemented for this platform."
+#endif /* defined(CONFIG_LINUX) */
+#else /* defined(CONFIG_MIRROR_JIT) */
+    prot |= PROT_WRITE;
+    flags |= MAP_ANONYMOUS | MAP_PRIVATE;
+#endif /* defined(CONFIG_MIRROR_JIT) */
+
+    buf = mmap(NULL, size, prot, flags, fd, 0);
     if (buf == MAP_FAILED) {
         return NULL;
     }
@@ -1118,7 +1138,28 @@ static inline void *alloc_code_gen_buffer(void)
 }
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
 
-static inline void code_gen_alloc(size_t tb_size)
+#if defined(CONFIG_MIRROR_JIT)
+#if defined(CONFIG_LINUX)
+static inline void *alloc_jit_rw_mirror(void)
+{
+    int fd = tcg_ctx->code_gen_buffer_fd;
+    size_t size = tcg_ctx->code_gen_buffer_size;
+    void *buf;
+
+    assert(fd >= 0);
+    buf = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (buf == MAP_FAILED) {
+        return NULL;
+    }
+
+    return buf;
+}
+#else
+#error "Mirror JIT unimplemented for this platform."
+#endif /* CONFIG_IOS */
+#endif /* CONFIG_MIRROR_JIT */
+
+static inline void code_gen_alloc(size_t tb_size, bool mirror_jit)
 {
     tcg_ctx->code_gen_buffer_size = size_code_gen_buffer(tb_size);
     tcg_ctx->code_gen_buffer = alloc_code_gen_buffer();
@@ -1126,6 +1167,17 @@ static inline void code_gen_alloc(size_t tb_size)
         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
         exit(1);
     }
+#if defined(CONFIG_MIRROR_JIT)
+    void *mirror;
+
+    /* For platforms that need a mirror mapping for code execution */
+    mirror = alloc_jit_rw_mirror();
+    if (mirror == NULL) {
+        fprintf(stderr, "Could not remap code buffer mirror\n");
+        exit(1);
+    }
+    tcg_ctx->code_rw_mirror_diff = mirror - tcg_ctx->code_gen_buffer;
+#endif /* CONFIG_MIRROR_JIT */
 }
 
 static bool tb_cmp(const void *ap, const void *bp)
@@ -1721,6 +1773,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         cpu_loop_exit(cpu);
     }
 
+#if defined(CONFIG_MIRROR_JIT)
+    tb->code_rw_mirror_diff = tcg_ctx->code_rw_mirror_diff;
+#endif
     gen_code_buf = tcg_ctx->code_gen_ptr;
     tb->tc.ptr = gen_code_buf;
     tb->pc = pc;
-- 
2.28.0


