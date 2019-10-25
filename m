Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0DBCA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FC420867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmu3aD/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FC420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtVu-00086z-Hy
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE2-0003KL-H2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE1-0008RL-95
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE1-0008Qk-2Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id q130so761849wme.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tNTEbGMtJZXoQB4/p2TTXTubBbnqE0j7BRIuNAJ75D8=;
 b=jmu3aD/DxDoCZf3tNr7epWj855PZx5LkiKtYiQlSEGuyRMtjV5YHDvKnsf+/O8aKsC
 wiI1LL/eTZ0PlMdaXndXBNK6FkTReJXL+61UJhn1zC28sh4Ejkr2lRoMH5m3rASlcRaX
 pMD7hAcq4KX72tfVDLYl8aariv7+omEc7QzDK0wFbN1sW1tdvHKIG2otUvuayTksEkHV
 gbCOd/9UAFYHalA3s3hILbmcjBy2Wd261UwI+RFDLtHJS/lTHY7FX6DZGF5Xm3wnhJdd
 0XsE9G1FNSD3W7kH7Dj/ne5LMZrB+NBdCWNPkoHnIQSqN6/DLCKuhDxn2ZWnLJatnPlE
 zSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tNTEbGMtJZXoQB4/p2TTXTubBbnqE0j7BRIuNAJ75D8=;
 b=ulu9bKO6slWP3m6gRspPcZOIxuEGLYN2LsphtPzCmn10DoyU9MJj0oKZsSXJOfO7xL
 k6wb9F2AFd6eIGCGxz8+m1NByl+cFQW+TMk4RK4WnseYSKsRohel4msBOk0tGGSiXMiT
 zdljiIbBihAgVXx5yKYOlN0ILPmE+ftArijscy+b65cJO6fdgFh12QsxZ5kCzx+GfuFZ
 YEMQdAcv/2+8OXzTY/QSdIXYmWuwo2wAt+0zYDi0vVDphrFcxAGXcDmU3dcdSj4ulraG
 GKXsmiyuDQZ4husZL8JHAuvDI9BFPr9xhmvgHli/ZMRESDE97vl0tqWoVZODjcvOuEAh
 MLkw==
X-Gm-Message-State: APjAAAWVnHiBrZRcSz+d4UcxiM7LeFIfs4QsO+JsGGh+t/P1t5hfa5+r
 Ho+9+IELXc0EVHXKofWxyukgBBZZayg=
X-Google-Smtp-Source: APXvYqzbgKAZg3PxyPtQDEuk/Lzw6qlUsW4S0bub6K7qzz/Y8AGrP868UjxTwujF008acEixB1x+XQ==
X-Received: by 2002:a1c:7401:: with SMTP id p1mr1766700wmc.144.1571985447568; 
 Thu, 24 Oct 2019 23:37:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm971570wml.26.2019.10.24.23.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C40891FFCD;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 54/73] plugin: expand the plugin_init function to include an
 info block
Date: Fri, 25 Oct 2019 07:36:54 +0100
Message-Id: <20191025063713.23374-55-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This provides a limited amount of info to plugins about the guest
system that will allow them to make some additional decisions on
setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c213d1dd19f..784f1dfc3da 100644
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
index eaedff577c3..ce724ed5839 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -28,6 +28,10 @@
 #include "hw/core/cpu.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#ifndef CONFIG_USER_ONLY
+#include "hw/boards.h"
+#endif
+
 #include "plugin.h"
 
 /*
@@ -58,7 +62,7 @@ QemuOptsList qemu_plugin_opts = {
     },
 };
 
-typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, int, char **);
+typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, const qemu_info_t *, int, char **);
 
 extern struct qemu_plugin_state plugin;
 
@@ -145,7 +149,7 @@ static uint64_t xorshift64star(uint64_t x)
     return x * UINT64_C(2685821657736338717);
 }
 
-static int plugin_load(struct qemu_plugin_desc *desc)
+static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
 {
     qemu_plugin_install_func_t install;
     struct qemu_plugin_ctx *ctx;
@@ -193,7 +197,7 @@ static int plugin_load(struct qemu_plugin_desc *desc)
     }
     QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
     ctx->installing = true;
-    rc = install(ctx->id, desc->argc, desc->argv);
+    rc = install(ctx->id, info, desc->argc, desc->argv);
     ctx->installing = false;
     if (rc) {
         error_report("%s: qemu_plugin_install returned error code %d",
@@ -241,11 +245,22 @@ static void plugin_desc_free(struct qemu_plugin_desc *desc)
 int qemu_plugin_load_list(QemuPluginList *head)
 {
     struct qemu_plugin_desc *desc, *next;
+    g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
+
+    info->target_name = TARGET_NAME;
+#ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(qdev_get_machine());
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
-- 
2.20.1


