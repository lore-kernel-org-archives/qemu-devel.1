Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC56218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC56218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8ez-0004FB-JH
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Gf-0001ne-2r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GM-00061n-2i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so6064556plp.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jq5S7DfTMucYeMtF3v3i8XupTbrbwTvgXcH0YvcLue8=;
 b=t0djxunai7uHfuWWEGuGRTnQHK/NSTV0ZAmlCkymkFB90QKlZHgUKQ6m6+wVFcgMnu
 sv+/cA3p8fEYFZShJgQ1Neupmoq8FIGw/sOORvhZCd086m5CpJDDwZARepXyMzC2GTL+
 6OFkuTjh+nuAC5BvI4iSmF62Xbspo0UgsiA7VRrRK6rCKnrbj4gm1O89765H0x4wk5PC
 yNMygRc2VrxbXxfPq0TJAZmBkNW3sW9HqWsqNrjIWbkl3lJqmkOGuRh5dZDyyEEdpm5C
 /Xt1WtT1sjJ/hqUKiwQ8ZZ7kN17GpMe58fWnBtPnABMhsENd8+IjY6dAQpV6Tg+pTk21
 eXAQ==
X-Gm-Message-State: AOAM531xaSXqC+DNPvzkxGBm1oiMXAaSR7IDqhIgF/lveSJeitHdaC9q
 RzqRnQ6PhiV9znMTrlqn8TgcGTrSjRU=
X-Google-Smtp-Source: ABdhPJwN2gtfkGFrH9T9aHyT7uUvFnAICHRx3gJ9YXHNZ2wwz1TfjktlW19IOcvnl8opxGqX5EHTAA==
X-Received: by 2002:a17:902:6ac1:b029:d3:b4c9:e92f with SMTP id
 i1-20020a1709026ac1b02900d3b4c9e92fmr24641978plt.38.1602545392485; 
 Mon, 12 Oct 2020 16:29:52 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:52 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] tcg: mirror mapping RWX pages for iOS optional
Date: Mon, 12 Oct 2020 16:29:37 -0700
Message-Id: <20201012232939.48481-9-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012232939.48481-1-j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.194; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:53
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Joelle van Dyne <j@getutm.app>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

This allows jailbroken devices with entitlements to switch the option off.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 accel/tcg/tcg-all.c       | 27 +++++++++++++++++-
 accel/tcg/translate-all.c | 60 +++++++++++++++++++++++++--------------
 bsd-user/main.c           |  2 +-
 include/sysemu/tcg.h      |  2 +-
 linux-user/main.c         |  2 +-
 qemu-options.hx           | 11 +++++++
 6 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index fa1208158f..5845744396 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -39,6 +39,7 @@ struct TCGState {
 
     bool mttcg_enabled;
     unsigned long tb_size;
+    bool mirror_rwx;
 };
 typedef struct TCGState TCGState;
 
@@ -94,6 +95,7 @@ static void tcg_accel_instance_init(Object *obj)
     TCGState *s = TCG_STATE(obj);
 
     s->mttcg_enabled = default_mttcg_enabled();
+    s->mirror_rwx = false;
 }
 
 bool mttcg_enabled;
@@ -102,7 +104,7 @@ static int tcg_init(MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_accel());
 
-    tcg_exec_init(s->tb_size * 1024 * 1024);
+    tcg_exec_init(s->tb_size * 1024 * 1024, s->mirror_rwx);
     mttcg_enabled = s->mttcg_enabled;
     cpus_register_accel(&tcg_cpus);
 
@@ -168,6 +170,22 @@ static void tcg_set_tb_size(Object *obj, Visitor *v,
     s->tb_size = value;
 }
 
+#ifdef CONFIG_IOS_JIT
+static bool tcg_get_mirror_rwx(Object *obj, Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    return s->mirror_rwx;
+}
+
+static void tcg_set_mirror_rwx(Object *obj, bool value, Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    s->mirror_rwx = value;
+}
+#endif
+
 static void tcg_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -185,6 +203,13 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "tb-size",
         "TCG translation block cache size");
 
+#ifdef CONFIG_IOS_JIT
+    object_class_property_add_bool(oc, "mirror-rwx",
+        tcg_get_mirror_rwx, tcg_set_mirror_rwx);
+    object_class_property_set_description(oc, "mirror-rwx",
+        "mirror map executable pages for TCG on iOS");
+#endif
+
 }
 
 static const TypeInfo tcg_accel_type = {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 76d8dc3d7b..de9b7d9ab6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1043,12 +1043,15 @@ static inline void *split_cross_256mb(void *buf1, size_t size1)
 static uint8_t static_code_gen_buffer[DEFAULT_CODE_GEN_BUFFER_SIZE]
     __attribute__((aligned(CODE_GEN_ALIGN)));
 
-static inline void *alloc_code_gen_buffer(void)
+static inline void *alloc_code_gen_buffer(bool no_rwx_pages)
 {
     void *buf = static_code_gen_buffer;
     void *end = static_code_gen_buffer + sizeof(static_code_gen_buffer);
     size_t size;
 
+    /* not applicable */
+    assert(!no_rwx_pages);
+
     /* page-align the beginning and end of the buffer */
     buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
     end = QEMU_ALIGN_PTR_DOWN(end, qemu_real_host_page_size);
@@ -1077,24 +1080,32 @@ static inline void *alloc_code_gen_buffer(void)
     return buf;
 }
 #elif defined(_WIN32)
-static inline void *alloc_code_gen_buffer(void)
+static inline void *alloc_code_gen_buffer(bool no_rwx_pages)
 {
     size_t size = tcg_ctx->code_gen_buffer_size;
+    assert(!no_rwx_pages); /* not applicable */
     return VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
                         PAGE_EXECUTE_READWRITE);
 }
 #else
-static inline void *alloc_code_gen_buffer(void)
+static inline void *alloc_code_gen_buffer(bool no_rwx_pages)
 {
-#if defined(CONFIG_IOS_JIT)
     int prot = PROT_READ | PROT_EXEC;
-#else
-    int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
-#endif
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     size_t size = tcg_ctx->code_gen_buffer_size;
     void *buf;
 
+#if defined(CONFIG_DARWIN) /* both iOS and macOS (Apple Silicon) applicable */
+    if (!no_rwx_pages) {
+        prot |= PROT_WRITE;
+        flags |= MAP_JIT;
+    }
+#else
+    /* not applicable */
+    assert(!no_rwx_pages);
+    prot |= PROT_WRITE;
+#endif
+
     buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         return NULL;
@@ -1174,10 +1185,10 @@ static inline void *alloc_jit_rw_mirror(void *base, size_t size)
 }
 #endif /* CONFIG_IOS_JIT */
 
-static inline void code_gen_alloc(size_t tb_size)
+static inline void code_gen_alloc(size_t tb_size, bool mirror_rwx)
 {
     tcg_ctx->code_gen_buffer_size = size_code_gen_buffer(tb_size);
-    tcg_ctx->code_gen_buffer = alloc_code_gen_buffer();
+    tcg_ctx->code_gen_buffer = alloc_code_gen_buffer(mirror_rwx);
     if (tcg_ctx->code_gen_buffer == NULL) {
         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
         exit(1);
@@ -1185,13 +1196,18 @@ static inline void code_gen_alloc(size_t tb_size)
 #if defined(CONFIG_IOS_JIT)
     void *mirror;
 
-    /* For iOS JIT we need a mirror mapping for code execution */
-    mirror = alloc_jit_rw_mirror(tcg_ctx->code_gen_buffer,
-                                 tcg_ctx->code_gen_buffer_size
-                                );
-    if (mirror == NULL) {
-        fprintf(stderr, "Could not remap code buffer mirror\n");
-        exit(1);
+    if (mirror_rwx) {
+        /* For iOS JIT we need a mirror mapping for code execution */
+        mirror = alloc_jit_rw_mirror(tcg_ctx->code_gen_buffer,
+                                     tcg_ctx->code_gen_buffer_size
+                                    );
+        if (mirror == NULL) {
+            fprintf(stderr, "Could not remap code buffer mirror\n");
+            exit(1);
+        }
+    } else {
+        /* If we have JIT entitlements */
+        mirror = tcg_ctx->code_gen_buffer;
     }
     tcg_ctx->code_rw_mirror_diff = mirror - tcg_ctx->code_gen_buffer;
 #endif /* CONFIG_IOS_JIT */
@@ -1218,16 +1234,18 @@ static void tb_htable_init(void)
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
 }
 
-/* Must be called before using the QEMU cpus. 'tb_size' is the size
-   (in bytes) allocated to the translation buffer. Zero means default
-   size. */
-void tcg_exec_init(unsigned long tb_size)
+/*
+ * Must be called before using the QEMU cpus. 'tb_size' is the size
+ * (in bytes) allocated to the translation buffer. Zero means default
+ * size. mirror_rwx only applicable on iOS.
+ */
+void tcg_exec_init(unsigned long tb_size, bool mirror_rwx)
 {
     tcg_allowed = true;
     cpu_gen_init();
     page_init();
     tb_htable_init();
-    code_gen_alloc(tb_size);
+    code_gen_alloc(tb_size, mirror_rwx);
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index ac40d79bfa..ffd4888a26 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -910,7 +910,7 @@ int main(int argc, char **argv)
     }
 
     /* init tcg before creating CPUs and to get qemu_host_page_size */
-    tcg_exec_init(0);
+    tcg_exec_init(0, false);
 
     cpu_type = parse_cpu_option(cpu_model);
     cpu = cpu_create(cpu_type);
diff --git a/include/sysemu/tcg.h b/include/sysemu/tcg.h
index d9d3ca8559..569f90b11d 100644
--- a/include/sysemu/tcg.h
+++ b/include/sysemu/tcg.h
@@ -8,7 +8,7 @@
 #ifndef SYSEMU_TCG_H
 #define SYSEMU_TCG_H
 
-void tcg_exec_init(unsigned long tb_size);
+void tcg_exec_init(unsigned long tb_size, bool mirror_rwx);
 #ifdef CONFIG_TCG
 extern bool tcg_allowed;
 #define tcg_enabled() (tcg_allowed)
diff --git a/linux-user/main.c b/linux-user/main.c
index 75c9785157..3856b2611d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -705,7 +705,7 @@ int main(int argc, char **argv, char **envp)
     cpu_type = parse_cpu_option(cpu_model);
 
     /* init tcg before creating CPUs and to get qemu_host_page_size */
-    tcg_exec_init(0);
+    tcg_exec_init(0, false);
 
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
diff --git a/qemu-options.hx b/qemu-options.hx
index 1da52a269c..deb39d56f5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -123,6 +123,9 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
+#ifdef CONFIG_IOS_JIT
+    "                mirror-rwx=on|off (mirror map executable pages for TCG on iOS)\n"
+#endif
     "                tb-size=n (TCG translation block cache size)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 SRST
@@ -148,6 +151,14 @@ SRST
     ``kvm-shadow-mem=size``
         Defines the size of the KVM shadow MMU.
 
+#ifdef CONFIG_IOS_JIT
+
+    ``mirror-rwx=on|off``
+        Only applicable to TCG running on iOS hosts. When enabled, TB code
+        is written to a mirror mapped address separate from the address that is
+        executed. By default, this is disabled.
+#endif
+
     ``tb-size=n``
         Controls the size (in MiB) of the TCG translation block cache.
 
-- 
2.24.3 (Apple Git-128)


