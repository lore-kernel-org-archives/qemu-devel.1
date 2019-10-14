Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB32ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382BC206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImaDVd7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382BC206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyme-0001Ik-RO
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC8-00081p-WB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC7-0007eJ-0w
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyC6-0007dM-Q4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id v8so19217095wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3DpqzaOrNntDkFAtLNgfVGSPKEwLzzpzG6mkI3f5/AE=;
 b=ImaDVd7LxXydpl7pcYiPgZ1vdyAVAgbO8Q7HnjywLiP1LCYREfdymKJKMBmr9msY+c
 sRDEuYHTtX18uefWeBvbQuD69iy9bP15FsASA+XryJLC6jkj1J6FYr5HVNOytqTcMzkQ
 5viDbwswTo2RbXye7hWN/Xuz95LEOfkETPAri+iSoxW9JNkt021K3C6uVWgHzqqUBjRu
 ySkxJXtU2CbGa4AjV74Jt+KRSRdicnT+1Rpxz8J42j87clXXX2ilDPgy0aWz2L81WjTv
 +9rxZmBX1BmgMIAm4dRAaIqi63dM3oPA/6D876ELkiH8p05Vp3/mvAWVVN/bWkAR9awR
 WAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3DpqzaOrNntDkFAtLNgfVGSPKEwLzzpzG6mkI3f5/AE=;
 b=G9ZjyZDL1NPtVeGhveG4fGKgFvFUZvFPJg+iyOYIfyFu4oPimfY9Ug7gXBhDa7dFoV
 Fj6n88nSbS/Ge9QmgOdTlnTBu3lfsJH5qkTDmBagNTjQoan6dZCoZgjzxW19QkT5zoy2
 i0/NiOuVwCaTl2b6eV5iAd5mYETibdYCZVYZnM6OiFbDln4KWHCMtC5bIZrTMF2zVAZV
 OXO9JxcCraCRtVyEZGBIz4WBzXgBi1miDkE3f5AZrAQTQ8QVCOE/SK6+NVNeunJfavEZ
 R1mfIgU0DDbSM/gSkO6UWG7vcyXJM4urlpbXMOYxcVsghzX9rWkGwy/eq2b9i+vXM0c9
 KflQ==
X-Gm-Message-State: APjAAAVxuLsWwo6YD8J+4hb5ahaBYoHru+w1R7NK60nMxOdJE8Okhw22
 wuQW0z3ocrAIgGfpNVswXHt3+g==
X-Google-Smtp-Source: APXvYqxMlONgYQY22I4g+e3D6trvZYDaQbeijXv3izPRzbL7LgRgKrfchx37nFsbPjPa+zLJGIojLw==
X-Received: by 2002:adf:ba12:: with SMTP id o18mr15204429wrg.147.1571051237648; 
 Mon, 14 Oct 2019 04:07:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h63sm31448934wmf.15.2019.10.14.04.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:07:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 741E51FFAC;
 Mon, 14 Oct 2019 11:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 51/55] plugins: expand the plugin_init function to include
 an info block
Date: Mon, 14 Oct 2019 11:49:44 +0100
Message-Id: <20191014104948.4291-52-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This provides a limited amount of info to plugins about the guest
system that will allow them to make some additional decisions on
setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h | 26 ++++++++++++++++++++++++--
 plugins/loader.c           | 22 ++++++++++++++++++----
 tests/plugin/bb.c          |  5 +++--
 tests/plugin/empty.c       |  5 +++--
 tests/plugin/hotblocks.c   |  5 +++--
 tests/plugin/hotpages.c    |  5 +++--
 tests/plugin/howvec.c      |  5 +++--
 tests/plugin/insn.c        |  5 +++--
 tests/plugin/mem.c         |  5 +++--
 9 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 8b403dd615..719d7054a1 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -38,9 +38,27 @@
 
 typedef uint64_t qemu_plugin_id_t;
 
+typedef struct {
+    /* string describing architecture */
+    const char *target_name;
+    /* is this a full system emulation? */
+    bool system_emulation;
+    union {
+        /*
+         * smp_vcpus may change if vCPUs can be hot-plugged, max_vcpus
+         * is the system-wide limit.
+         */
+        struct {
+            int smp_vcpus;
+            int max_vcpus;
+        } system;
+    };
+} qemu_info_t;
+
 /**
  * qemu_plugin_install() - Install a plugin
  * @id: this plugin's opaque ID
+ * @info: a block describing some details about the guest
  * @argc: number of arguments
  * @argv: array of arguments (@argc elements)
  *
@@ -49,10 +67,14 @@ typedef uint64_t qemu_plugin_id_t;
  * Note: Calling qemu_plugin_uninstall() from this function is a bug. To raise
  * an error during install, return !0.
  *
+ * Note: @info is only live during the call. Copy any information we
+ * want to keep.
+ *
  * Note: @argv remains valid throughout the lifetime of the loaded plugin.
  */
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv);
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv);
 
 /*
  * Prototypes for the various callback styles we will be registering
diff --git a/plugins/loader.c b/plugins/loader.c
index 5de5cff8e3..a136a71d35 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -29,6 +29,9 @@
 #include "hw/core/cpu.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#ifndef CONFIG_USER_ONLY
+#include "hw/boards.h"
+#endif
 
 #include "plugin.h"
 
@@ -60,7 +63,7 @@ QemuOptsList qemu_plugin_opts = {
     },
 };
 
-typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, int, char **);
+typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, const qemu_info_t *, int, char **);
 
 extern struct qemu_plugin_state plugin;
 
@@ -147,7 +150,7 @@ static uint64_t xorshift64star(uint64_t x)
     return x * UINT64_C(2685821657736338717);
 }
 
-static int plugin_load(struct qemu_plugin_desc *desc)
+static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
 {
     qemu_plugin_install_func_t install;
     struct qemu_plugin_ctx *ctx;
@@ -198,7 +201,7 @@ static int plugin_load(struct qemu_plugin_desc *desc)
     }
     QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
     ctx->installing = true;
-    rc = install(ctx->id, desc->argc, desc->argv);
+    rc = install(ctx->id, info, desc->argc, desc->argv);
     ctx->installing = false;
     if (rc) {
         error_report("%s: qemu_plugin_install returned error code %d",
@@ -249,11 +252,22 @@ static void plugin_desc_free(struct qemu_plugin_desc *desc)
 int qemu_plugin_load_list(QemuPluginList *head)
 {
     struct qemu_plugin_desc *desc, *next;
+    g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
+
+    info->target_name = TARGET_NAME;
+#ifndef CONFIG_USER_ONLY
+    MachineState * ms = MACHINE(qdev_get_machine());
+    info->system_emulation = true;
+    info->system.smp_vcpus = ms->smp.cpus;
+    info->system.max_vcpus = ms->smp.max_cpus;
+#else
+    info->system_emulation = false;
+#endif
 
     QTAILQ_FOREACH_SAFE(desc, head, entry, next) {
         int err;
 
-        err = plugin_load(desc);
+        err = plugin_load(desc, info);
         if (err) {
             return err;
         }
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index 93d25de363..4a6d6ca0bc 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -48,8 +48,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv)
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
 {
     if (argc && strcmp(argv[0], "inline") == 0) {
         do_inline = true;
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
index b141ddd0df..3f60f69027 100644
--- a/tests/plugin/empty.c
+++ b/tests/plugin/empty.c
@@ -21,8 +21,9 @@
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 { }
 
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv)
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
 {
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     return 0;
diff --git a/tests/plugin/hotblocks.c b/tests/plugin/hotblocks.c
index a150179a5c..57bea765b3 100644
--- a/tests/plugin/hotblocks.c
+++ b/tests/plugin/hotblocks.c
@@ -129,8 +129,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv)
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
 {
     if (argc && strcmp(argv[0], "inline") == 0) {
         do_inline = true;
diff --git a/tests/plugin/hotpages.c b/tests/plugin/hotpages.c
index 13ce8ffeb8..99bb4be07c 100644
--- a/tests/plugin/hotpages.c
+++ b/tests/plugin/hotpages.c
@@ -148,8 +148,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv)
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
 {
     int i;
 
diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index b435c6b64d..3b1d177ef3 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -264,8 +264,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv)
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
 {
     int i;
 
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 3000ab4b73..9cfa7d0e53 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -45,8 +45,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     dprintf(stdout_fd, "insns: %" PRIu64 "\n", insn_count);
 }
 
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv)
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
 {
     if (argc && !strcmp(argv[0], "inline")) {
         do_inline = true;
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index e5490f4a99..fdf4347c5e 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -64,8 +64,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
-                                           char **argv)
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
 {
     if (argc) {
         if (argc >= 3) {
-- 
2.20.1


