Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3B22053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfnvLKwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3B22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvFt-0006Ob-8I
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEn-0004hc-LN
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEk-0007l5-W9
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so29511966wma.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qcFVIBqUp0EMIHK5cdTZ6uX+aE01YOYGri1QnnvF5Gw=;
 b=HfnvLKwkkm0n9VXzBjxEaM5yQwmxPDHgFHqw0O5k6Qdm1UvqIxv5UHOnekGJVts2W2
 uV1uFKVT7AmyyJqsCmEaXHip2MRLc1V3eFJ+yFD8gJmbaE8gI7uFliSDsIbmCY88Xs1c
 p+WhKv/ekYOqkjiD29NIzefkbaTkLwP8ZgBM6d1k4+hNB4b9yFqOO1cydyAMCL3U9y0r
 C4EWqAufC/+OnZ38osa2Z6beUoBO4qmiISHoFY+wt9aPsrZg9SQYJMdJCdLUACzhaNb1
 U57JhRYvEbL+LlKl9vwTsk7UQgI3060cN2fJ9MUdx29Khqlz6fF+7V+8YLRc7on0qYJ7
 08ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qcFVIBqUp0EMIHK5cdTZ6uX+aE01YOYGri1QnnvF5Gw=;
 b=jc782DDnacAdh4B9ZNf0sqp5u8eECg+dONs6Sqc4niSiTSQkGnH1SqkKILUoqpKeJT
 4B2xFJcfDdQo3I5R5NlajYZCLbGkDebnqtRFDLQUyEocrElb3yb0X0T0aoP2E2BowJ0o
 3CRWrzg1lChUULo0Hb2ZAYrAMOoCzrW+Iwj1SgxClz29pQe0vTIKKRbYk06Jru0KW8Q5
 a+5p31cdLhrz5qg73oNM9ws8puEwn+36B5wobiIj6VWUtGAIsvBXzAM0fIevzBNF09il
 6s6Jp/dGeIQP8ws6MqWNMkVoBIqjIXU890jD5mWcOrOORYsbFjAejxgiMblzf2pQ4iSw
 gkzg==
X-Gm-Message-State: AGi0PuberkuzHpVuwTpaFbkozMszXypB4UtotniRdq+JghuQitbLDU8u
 ECzu+qy4+US1DEI6soJqtVFdFQ==
X-Google-Smtp-Source: APiQypIesWLFs3N7PAZU3rtca0szHc81hl2eKtxMiby5p8BqiwMg5FaFcH3oPPV1aPjzdD/gicGKyA==
X-Received: by 2002:a05:600c:2299:: with SMTP id
 25mr23278372wmf.138.1589391125390; 
 Wed, 13 May 2020 10:32:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w9sm286251wrc.27.2020.05.13.10.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0154A1FF87;
 Wed, 13 May 2020 18:32:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/8] qemu/plugin: Trivial code movement
Date: Wed, 13 May 2020 18:31:53 +0100
Message-Id: <20200513173200.11830-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Move the qemu_plugin_event enum declaration earlier.
This will make the next commit easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200510171119.20827-2-f4bug@amsat.org>
---
 include/qemu/plugin.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 11687e8cdc3..e45f950fe36 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -13,6 +13,22 @@
 #include "qemu/queue.h"
 #include "qemu/option.h"
 
+/*
+ * Events that plugins can subscribe to.
+ */
+enum qemu_plugin_event {
+    QEMU_PLUGIN_EV_VCPU_INIT,
+    QEMU_PLUGIN_EV_VCPU_EXIT,
+    QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+    QEMU_PLUGIN_EV_VCPU_IDLE,
+    QEMU_PLUGIN_EV_VCPU_RESUME,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
+    QEMU_PLUGIN_EV_FLUSH,
+    QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
+};
+
 /*
  * Option parsing/processing.
  * Note that we can load an arbitrary number of plugins.
@@ -47,22 +63,6 @@ static inline int qemu_plugin_load_list(QemuPluginList *head)
 }
 #endif /* !CONFIG_PLUGIN */
 
-/*
- * Events that plugins can subscribe to.
- */
-enum qemu_plugin_event {
-    QEMU_PLUGIN_EV_VCPU_INIT,
-    QEMU_PLUGIN_EV_VCPU_EXIT,
-    QEMU_PLUGIN_EV_VCPU_TB_TRANS,
-    QEMU_PLUGIN_EV_VCPU_IDLE,
-    QEMU_PLUGIN_EV_VCPU_RESUME,
-    QEMU_PLUGIN_EV_VCPU_SYSCALL,
-    QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
-    QEMU_PLUGIN_EV_FLUSH,
-    QEMU_PLUGIN_EV_ATEXIT,
-    QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
-};
-
 union qemu_plugin_cb_sig {
     qemu_plugin_simple_cb_t          simple;
     qemu_plugin_udata_cb_t           udata;
-- 
2.20.1


