Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF8DC4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960DE2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLLxusxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960DE2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnI1-00070L-LR
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCs-0007o4-Cs
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCq-0001Ql-8P
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id b79so3165742wmb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DYHqy58UJZR46wXpvs59hJagcJIqgUuvxLRDNUapKkI=;
 b=PLLxusxhPFqPGcofHMPBU7+IrVX7cQrLqgbuFwawPTVl20xOtV1nU3phv+B+iZ4AHa
 g6keJCPtstcNtkR9uvaZR6JJFaC+CjknldAUPdPCKsKEqqQdWg7LQ/K64hl5HabyR+I2
 XSZC8zZAAoQbmjDZS9YNLV94KZuLi3xRHX0VLG/Fck6PAhVxCTdnu5nWkj+h3JthSgFt
 /DM5h3kfoW2vgHw+PVqreYUPDkb5qTvo2xXHv7fcmFtCsNdZ/1Wv5+Bqip7AwK31O8Vt
 TwzJnYZQXcWYdG2MOygKPCTZz2aVxUEYC/IWxxydBRUNyRiC7pnfkoDkJoL/Yb8CwfVz
 LUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DYHqy58UJZR46wXpvs59hJagcJIqgUuvxLRDNUapKkI=;
 b=qauUn9YTiIZ29QaG9zlffh9DQEymYDQXh5lXJbjJFnEZ25SE5F+2XKDoMFo8rMA9nj
 xDN5TmbEdmn34c8yJaUK7AsBM53xX2llnqHlkHZK+dN5oRblrprgpBexm+QcWYSd2367
 WmYPk7EfKLGqkt69lD2h3lNQKV2aQe/s0HQJ7izseufxSUulVJGItfgjbjlKh/yyV+ra
 3ktswvQkZZaC1WZI2limO8TXtCW/fLvVCNIkGe7K67n7giE3rJgPDVK3q8TlwAIsxQQP
 RZvKGjs2hx1WVVraK758DwyUbLDDqaRcd0bea2AOE6Lzd6EzjIo6/dhSH6+6eko7kqsq
 jrkw==
X-Gm-Message-State: AOAM533VbynN63xu/oKej6wX15RxLYT7HHBqItYw0pRsPHEVxrwZduBg
 sK83FWepZM5jL+TvZWzI6MeaYw==
X-Google-Smtp-Source: ABdhPJzzqmM6H2FagwjjJuJz8oyzXp/4kjhdAn5abuNmGND89rNn/daHMZEIYFS4dnMv23kcecepaA==
X-Received: by 2002:a1c:4455:: with SMTP id r82mr2957959wma.60.1601038326726; 
 Fri, 25 Sep 2020 05:52:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m12sm2708543wml.38.2020.09.25.05.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 173971FF98;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 09/19] tools/vhost-user-rpmb: add a --verbose/debug flags
 for logging
Date: Fri, 25 Sep 2020 13:51:37 +0100
Message-Id: <20200925125147.26943-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This gives us two levels of informational output when tracing what the
daemon is doing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 269c86cbb633..1be0d4b8a567 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -6,6 +6,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#define G_LOG_DOMAIN "vhost-user-rpmb"
+#define G_LOG_USE_STRUCTURED 1
+
 #include <glib.h>
 #include <gio/gio.h>
 #include <gio/gunixsocketaddress.h>
@@ -25,12 +28,16 @@
 static gchar *socket_path;
 static gint socket_fd = -1;
 static gboolean print_cap;
+static gboolean verbose;
+static gboolean debug;
 
 static GOptionEntry options[] =
 {
     { "socket-path", 0, 0, G_OPTION_ARG_FILENAME, &socket_path, "Location of vhost-user Unix domain socket, incompatible with --fd", "PATH" },
     { "fd", 0, 0, G_OPTION_ARG_INT, &socket_fd, "Specify the file-descriptor of the backend, incompatible with --socket-path", "FD" },
     { "print-capabilities", 0, 0, G_OPTION_ARG_NONE, &print_cap, "Output to stdout the backend capabilities in JSON format and exit", NULL},
+    { "verbose", 'v', 0, G_OPTION_ARG_NONE, &verbose, "Be more verbose in output", NULL},
+    { "debug", 0, 0, G_OPTION_ARG_NONE, &debug, "Include debug output", NULL},
     { NULL }
 };
 
@@ -84,6 +91,7 @@ static void vrpmb_panic(VuDev *dev, const char *msg)
 
 static uint64_t vrpmb_get_features(VuDev *dev)
 {
+    g_info("%s: replying", __func__);
     return 0;
 }
 
@@ -209,6 +217,17 @@ int main (int argc, char *argv[])
         exit(EXIT_FAILURE);
     }
 
+    if (verbose || debug) {
+        g_log_set_handler(NULL, G_LOG_LEVEL_MASK, g_log_default_handler, NULL);
+        if (debug) {
+            g_setenv("G_MESSAGES_DEBUG", "all", true);
+        }
+    } else {
+        g_log_set_handler(NULL,
+                          G_LOG_LEVEL_WARNING | G_LOG_LEVEL_CRITICAL | G_LOG_LEVEL_ERROR,
+                          g_log_default_handler, NULL);
+    }
+
     /*
      * Now create a vhost-user socket that we will receive messages
      * on. Once we have our handler set up we can enter the glib main
-- 
2.20.1


