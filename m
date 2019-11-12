Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8C720656
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGi/Yk2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8C720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXdl-0003xj-V8
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVD-0003ZW-W8
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVC-00037p-8J
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXVC-00036t-1a
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id i10so18836240wrs.7
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gqg0+V7qSEz/6ZJOKa53BGZgGZ5jVCsKocXvLtTyKDM=;
 b=cGi/Yk2CehzucHabB93Ij5kZCzQJ+6MYYNgNxLnbbXlH1Xas/XnGWoNE1xyU4B47Yu
 jQF7Flaw8Fo+yemlkVPYqChTV3FQ2ESyGiYRSjhUoQX2TUJDJItAqzkbJij2i2KBn7Or
 V5XW8EGDij7u/M56tYBlsGkUNsx3XF7mzuGUkFWlme1Z8pMPwJVQIR6KWCGWbrWAbWmT
 1jbx5pr3Y1m900INehVbJT+/cgakEEKyfyjhdKiK25kw7kY1cPGmzvyV5wLVlYNJzoDI
 A9TpjVMeEgUm6Xw7dI0btutPKNJGDsP/tiJN6wctHaXNC1QQ7Qx6yqVVct364PABxGTO
 AXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gqg0+V7qSEz/6ZJOKa53BGZgGZ5jVCsKocXvLtTyKDM=;
 b=M7CfognzxmkuaSaaDXTUbJxabheJXP1csQ1WAmjfaC3qNtI18wbJc1EwRNygA3snGr
 XzI7xdgTKu1UkvSnMIIA1jP486CF/rh54OTs2FweNBPia4UTwkHGYXIyIoYTPz9UNxI9
 u/3WgyoZQLpjh6ZemhvkX6E0X76KqMb0MhAq8MqIQGz14dyOzzeGYbZzxMc1KTEP0Tqo
 lVBP5NRFpt163fTmy9eL390sAedLmd0Fo34sktNAIjiUIQVIdP+jusPmbogJuGxVu+dl
 GyMXRehkdBkVIzVSWG/1WuQE7XgDun1mde1vaIFR5w3ky+aX9RyFKi+YArRPq6bVhgtK
 W0iQ==
X-Gm-Message-State: APjAAAUQ5/nnqnSKqbNnplCH6oB6QieqUzLX1yjQpIKLLvQxbZkW80Bh
 HK+40PokclhHMXvsOYvaFEO3Aw==
X-Google-Smtp-Source: APXvYqyLkFDqbq2jQ5vwURIek2epGpQi4W7lxvxMj1miwXOuKYGv3K/jGwnFtlR7eSIunSSIG5iglw==
X-Received: by 2002:adf:979a:: with SMTP id s26mr21423502wrb.92.1573570240901; 
 Tue, 12 Nov 2019 06:50:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l4sm3185204wme.4.2019.11.12.06.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C31801FF98;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 8/8] tcg plugins: expose an API version concept
Date: Tue, 12 Nov 2019 14:50:28 +0000
Message-Id: <20191112145028.26386-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a very simple versioning API which allows the plugin
infrastructure to check the API a plugin was built against. We also
expose a min/cur API version to the plugin via the info block in case
it wants to avoid using old deprecated APIs in the future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index a00a7deb461..5502e112c81 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -38,9 +38,28 @@
 
 typedef uint64_t qemu_plugin_id_t;
 
+/*
+ * Versioning plugins:
+ *
+ * The plugin API will pass a minimum and current API version that
+ * QEMU currently supports. The minimum API will be incremented if an
+ * API needs to be deprecated.
+ *
+ * The plugins export the API they were built against by exposing the
+ * symbol qemu_plugin_version which can be checked.
+ */
+
+extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
+
+#define QEMU_PLUGIN_VERSION 0
+
 typedef struct {
     /* string describing architecture */
     const char *target_name;
+    struct {
+        int min;
+        int cur;
+    } version;
     /* is this a full system emulation? */
     bool system_emulation;
     union {
diff --git a/plugins/loader.c b/plugins/loader.c
index ce724ed5839..15fc7e55156 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -178,6 +178,25 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
         goto err_symbol;
     }
 
+    if (!g_module_symbol(ctx->handle, "qemu_plugin_version", &sym)) {
+        error_report("TCG plugin %s does not declare API version %s",
+                     desc->path, g_module_error());
+        goto err_symbol;
+    } else {
+        int version = *(int *)sym;
+        if (version < QEMU_PLUGIN_MIN_VERSION) {
+            error_report("TCG plugin %s requires API version %d, but "
+                         "this QEMU supports only a minimum version of %d",
+                         desc->path, version, QEMU_PLUGIN_MIN_VERSION);
+            goto err_symbol;
+        } else if (version > QEMU_PLUGIN_VERSION) {
+            error_report("TCG plugin %s requires API version %d, but "
+                         "this QEMU supports only up to version %d",
+                         desc->path, version, QEMU_PLUGIN_VERSION);
+            goto err_symbol;
+        }
+    }
+
     qemu_rec_mutex_lock(&plugin.lock);
 
     /* find an unused random id with &ctx as the seed */
@@ -248,6 +267,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
 
     info->target_name = TARGET_NAME;
+    info->version.min = QEMU_PLUGIN_MIN_VERSION;
+    info->version.cur = QEMU_PLUGIN_VERSION;
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
     info->system_emulation = true;
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5482168d797..1aa29dcaddf 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -14,6 +14,8 @@
 
 #include <gmodule.h>
 
+#define QEMU_PLUGIN_MIN_VERSION 0
+
 /* global state */
 struct qemu_plugin_state {
     QTAILQ_HEAD(, qemu_plugin_ctx) ctxs;
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index 45e1de5bd68..f30bea08dcc 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -14,6 +14,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 static uint64_t bb_count;
 static uint64_t insn_count;
 static bool do_inline;
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
index 3f60f690278..8fa6bacd93d 100644
--- a/tests/plugin/empty.c
+++ b/tests/plugin/empty.c
@@ -13,6 +13,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 /*
  * Empty TB translation callback.
  * This allows us to measure the overhead of injecting and then
diff --git a/tests/plugin/hotblocks.c b/tests/plugin/hotblocks.c
index 1bd183849a1..3942a2ca544 100644
--- a/tests/plugin/hotblocks.c
+++ b/tests/plugin/hotblocks.c
@@ -15,6 +15,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 static bool do_inline;
 
 /* Plugins need to take care of their own locking */
diff --git a/tests/plugin/hotpages.c b/tests/plugin/hotpages.c
index 77df07a3ccf..ecd6c187327 100644
--- a/tests/plugin/hotpages.c
+++ b/tests/plugin/hotpages.c
@@ -18,6 +18,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 static uint64_t page_size = 4096;
diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 58fa675e348..4ca555e1239 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -20,6 +20,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 typedef enum {
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index e5fd07fb64b..0a8f5a0000e 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -14,6 +14,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 static uint64_t insn_count;
 static bool do_inline;
 
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index d9673889896..878abf09d19 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -14,6 +14,8 @@
 
 #include <qemu-plugin.h>
 
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
 static uint64_t mem_count;
 static uint64_t io_count;
 static bool do_inline;
-- 
2.20.1


