Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20F222243
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20F222243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUNpX-0005LJ-S9
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 01:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNae-00041d-W0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 01:20:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNab-0005HY-Kv
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 01:20:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id d23so4392449pll.7
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 22:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HKK8nQ2FGrit9epsZhjwH0bTT4EKpHAFg3nmNqWRDd0=;
 b=DuKEC3MLXeUt7tfNX5RaA1W5eI8x61ciSOzuSA9SgJlAWh4yB/TeKfd8PbaRWH5Yvo
 /TirzxoVmeWnImhcVcResOBSK3jm+TbMvNMpppYgxQyfyahVv9pje4C8bz0i1JL+DOzx
 WvbKeBD5zGvlg9zycDcuzyteJg107dtT2b+XDGRV0RVtawmLwlOZsUCJFBTVecs9GwPj
 9Qx2WAbkFZggMU5AlHRljkD7tG1BkJ5CObwq/m0PhavuOyTiuAUovHO0oRW6ihcH2u6U
 FYOm+DQqJW4EkHiChDyJJoWD4ufnJOfyh3ToXiHXOIdy5rsBcvhu3NsSglW+tV0oGw4s
 ep+Q==
X-Gm-Message-State: AOAM532RsLda+Uduw6Efln87p7sS2YQQxLVM7hegU9Bgpyf/q0A3Pwj0
 c1cadK7laV/Y6rr8t4WDevTwNltymK4=
X-Google-Smtp-Source: ABdhPJxlkxwPohINf9ZLHIfbvAxB/B0yTy2m3/wiykzNKheXhAMtn7kB+A/BPj0n87nvjE3bPLzQaQ==
X-Received: by 2002:a17:90a:f187:: with SMTP id
 bv7mr16258465pjb.198.1603084807961; 
 Sun, 18 Oct 2020 22:20:07 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.253])
 by smtp.gmail.com with ESMTPSA id p6sm10673904pjd.1.2020.10.18.22.20.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 22:20:07 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 7/9] tcg: mirror mapping RWX pages for iOS optional
Date: Sun, 18 Oct 2020 22:19:51 -0700
Message-Id: <20201019051953.90107-8-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019051953.90107-1-j@getutm.app>
References: <20201019051953.90107-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.195;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:20:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Joelle van Dyne <j@getutm.app>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

This allows jailbroken devices with entitlements to switch the option off.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/sysemu/tcg.h      |  2 +-
 accel/tcg/tcg-all.c       | 27 +++++++++++++++++-
 accel/tcg/translate-all.c | 60 +++++++++++++++++++++++++--------------
 bsd-user/main.c           |  2 +-
 linux-user/main.c         |  2 +-
 qemu-options.hx           | 11 +++++++
 6 files changed, 79 insertions(+), 25 deletions(-)

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
index eb1d8fbe2f..1675951b75 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1042,12 +1042,15 @@ static inline void *split_cross_256mb(void *buf1, size_t size1)
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
@@ -1076,24 +1079,32 @@ static inline void *alloc_code_gen_buffer(void)
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
@@ -1173,10 +1184,10 @@ static inline void *alloc_jit_rw_mirror(void *base, size_t size)
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
@@ -1184,13 +1195,18 @@ static inline void code_gen_alloc(size_t tb_size)
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
@@ -1217,16 +1233,18 @@ static void tb_htable_init(void)
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


