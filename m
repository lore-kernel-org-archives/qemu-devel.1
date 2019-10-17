Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D57ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D6020854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fd259wrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D6020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL74k-0001ud-6k
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wD-00061s-4V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wB-0004Tb-3F
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5w9-0004S2-5n
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id m18so2582864wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j9VLj7yufnPKaz6aaA2SbuwWsfLmWj3MLD1Awwtmne8=;
 b=Fd259wrHctY9DyUwxxGiqpFZD90FvvM4HkUoSRPzNqIJYMxfFJHxhtV+BvjnRKbUff
 VHJp1fYBxYD9cKEmzyZ35yiDHQ/8kncKyj4C24KTZOIAIeRwt9QL41hqB2HCgkWJZS2S
 IaUb3K1GFyG0ORtfcDOhy4GzNraq1RAq9PeFwnARrlA3uqCk/Nw8f+qbdork+1FBIaMD
 NMlFmMTKffTzFKg/1JlCx8mCUwm4Ymtiuphcj3tB/THYh2eXVrTzAyBXXigoLWnGh4wG
 mALJbUXo2NGSds4XTBbN7fPN6ENxpAr7eEaJWk+d5gUE41JjV/adU6ODRLzsLHmqSYOG
 3RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j9VLj7yufnPKaz6aaA2SbuwWsfLmWj3MLD1Awwtmne8=;
 b=DFu7u00ZDd3bNqi1pTp2udYuez0ahxQrrNX5OSyaZ6zIEO9XD8knLz3aKLof09IBZR
 HUYYG59KMrKifQuP7WqthSeOhWjDalIkKIO3VRF03xRp5ofBAHZKhm0ash8Aa04sIeHW
 8bTEy6iIn3qRFCTpcb+/bfeUcIZcUaAwrgdH514h+jmbyNB5DuZaSn/FtBauHA9o6yUI
 gR9Y7vtnAswpjJSUN64dw43ycjSv4oFEqh2QiRv6ClkBQ8gs3f9iadFX9JoIUeGASjCt
 THsH8k0A1+g68zWL9DaVrdlUnJz508j/RRkJrZnahhhjbnbq2HRnmpeGb14paJm8Nk/i
 siqQ==
X-Gm-Message-State: APjAAAWbQ2Q2rUp/z7lkUmivQkhK8+4nJV2E/TKpltHvI0LvgzaWyltZ
 wL8InJicvwemz5zoaIBvZKgXsA==
X-Google-Smtp-Source: APXvYqyaLeqhv0v4mWfZNRMWact38EOjS0cBvWS91gSOHqmGEVEd3kA8S9tuxJGhLbL/1tdjYJMDSQ==
X-Received: by 2002:a1c:9990:: with SMTP id b138mr3040374wme.176.1571319327845; 
 Thu, 17 Oct 2019 06:35:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm3094463wrn.48.2019.10.17.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD5DA1FFC0;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 41/54] linux-user: support -plugin option
Date: Thu, 17 Oct 2019 14:16:02 +0100
Message-Id: <20191017131615.19660-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


