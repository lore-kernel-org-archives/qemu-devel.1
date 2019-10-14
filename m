Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802CFC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4AB207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oecO6g/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4AB207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyq2-0004In-CM
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyCA-000842-CN
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC9-0007gk-2k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyC8-0007fZ-Sr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id p14so19204004wro.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j9VLj7yufnPKaz6aaA2SbuwWsfLmWj3MLD1Awwtmne8=;
 b=oecO6g/3JdU/4TFoiyt63qfh/TjovK1lLUNBurXi88JoRRRNlCJR+waZSAZ6ypma9Y
 cIMvk/4JZciOdKM4dv9ThBtpNNltPafWLDaoH/OjkZOv8prhs71wseAL1TyDas083Qpw
 FlADygF/xNXa1g8GzCtjyOuAUwN3ezTyHiC27NhL78W6NbgItdjI8xlHpyrt4zot7y9j
 lIz9wOD7FbtjKNvxJmn8I6Y4OwQKtbDpqFSTBd7YKChZ4omA/FpG7PI2ruvxmE+mzNZk
 NWr/RStHsuBFMiwHpH+zChnZY7XFsRAa0jyFgIyvzpwtVZNKv6bHCCDm0FC261RN/c+I
 Yb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j9VLj7yufnPKaz6aaA2SbuwWsfLmWj3MLD1Awwtmne8=;
 b=HHDS2Ljt4bI3v4XCkF1OCgfDczXV4v5YieFDmqwFGhlNUaBTEHc1DXNZFePvJOPKUZ
 axBoyjvisEdQxCtLWv5jaGGzXjTiPXB3WPFXGwG8muvs1a/jCFoBmiPvDJbX89Nxn6jZ
 mQUR4N4a2iW1/Al64xRtnkwm0dd+s++IU5kNxtnvJcJky33UtktycEzcix5MzaBai8P2
 ICxlCKhRcP7+/CQhDpu2f6ze13UISMzqT6/5almVNH5rc43EAGTjYSgYgPVqh0S8LGo5
 K5gwhwEQFWuzMaQvzLIEIVdzq9AhEcpKhGVkRUJs5JBDa4olbbnR0uoY9cR+KKTdhIQ9
 APXQ==
X-Gm-Message-State: APjAAAXadql5YK3ynerJfIzbvvgM3tpNtSvCGDCjTM2Xa4fRvvgmN+7Y
 1t+w22x8H5PUcZQK3g8Fe2yeRA==
X-Google-Smtp-Source: APXvYqxwHJTVoQziLkkZn3+KLPbsvkPi4yRS63ATtZ9fu3t8gVBcS2o9AXHNuJjhiX71Y6PwmmVmPA==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr25955533wrp.69.1571051239774; 
 Mon, 14 Oct 2019 04:07:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f18sm16911737wrv.38.2019.10.14.04.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:07:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C54B1FFC7;
 Mon, 14 Oct 2019 11:49:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 38/55] linux-user: support -plugin option
Date: Mon, 14 Oct 2019 11:49:31 +0100
Message-Id: <20191014104948.4291-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: robert.foley@futurewei.com, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
[ cota: s/instrument/plugin ]
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 560d053f72..6ff7851e86 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
+#include "qemu/plugin.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
@@ -398,6 +399,15 @@ static void handle_arg_abi_call0(const char *arg)
 }
 #endif
 
+static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
+
+#ifdef CONFIG_PLUGIN
+static void handle_arg_plugin(const char *arg)
+{
+    qemu_plugin_opt_parse(arg, &plugins);
+}
+#endif
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -449,6 +459,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+#ifdef CONFIG_PLUGIN
+    {"plugin",     "QEMU_PLUGIN",      true,  handle_arg_plugin,
+     "",           "[file=]<file>[,arg=<string>]"},
+#endif
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
 #if defined(TARGET_XTENSA)
@@ -643,6 +657,7 @@ int main(int argc, char **argv, char **envp)
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
 
     optind = parse_args(argc, argv);
 
@@ -650,6 +665,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
     trace_init_file(trace_file);
+    if (qemu_plugin_load_list(&plugins)) {
+        exit(1);
+    }
 
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
-- 
2.20.1


