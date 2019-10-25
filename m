Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5ADCA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC61206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/uo3G+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC61206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtsj-0001QO-Nf
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN8-00089g-U9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN7-0003IV-KF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN6-0003Cm-Jf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id g7so778259wmk.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iCdf3P82phD9cLVEW6A0PP5pJmmTk2IWDOwxH2phJBw=;
 b=P/uo3G+xBuax0OH+AqwxRCHg2F6MbPdJClHZ68Q34hwsPmTMKFpQHZMe3gnPWLIZVv
 84l4Pgwh0HrepgBrI4AgC+7I6vupapCGWDeTi3AS6azb97RVLEVBmmud5AsBXIn95CAy
 1YTd30xobH9CPRYcwZudGLeBhMtzA7ZEIUSquvGdtXn6QdV2iz2sqZjSYeWBuOv/OkUk
 XfJ2N7PjyAXER01NmDgW9WRrmLZEo0If73AqXSpOv9CuM+UZ+l+sS5B1u6u46Ti1dFCD
 q14Ek2AkBg3nYvmrMsz42ffBQbW8RAlXWUGDhBKBtkDKjl9+IaEb7PTHkbseK5FJ6+3T
 TOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iCdf3P82phD9cLVEW6A0PP5pJmmTk2IWDOwxH2phJBw=;
 b=IaxRdgLbmubY/yRavAkTyexwomsnsuIn9L/+9YvUPzKkvPkUPlXKSlMI4AHDfrC5gv
 T0YU3seLnLvzWbuuxTBEB0dvqrPoxSn5wU46RXHcV2aNYAwPIbKufITtn0M01gCDgPtY
 Q/T6zTltNLfmW8nH3fNqZBaaQmgoLkUsJkGuV/T/6019n1vbZ2sM4CPF/2yC2jPhcOl7
 ls2Ko5WmuKho3B1ZmyYSwiKiAbRhWe+XGYnvUDNrm71yMUmWdFn5pNlKWNNumj1s1opk
 DNcTitEJZ0W34C3tr0rVmuGgKfeoTMBq3J1eSqyjGONb+ZMxaSUyDzCtVW0vxo94w1mR
 lx7A==
X-Gm-Message-State: APjAAAXuPolUzgIN3CyKa/GKt5p46ERFeODQXlfpsU8gWLELk9TIMSmL
 Uh9uCLicc/phAuGTfbaeTM74uQ==
X-Google-Smtp-Source: APXvYqzmPuamY/Patr40gK7zP2OiJQL61ww/Qy41NqRt/T0jAUZOk4UYLWF3wCELfFhn+OVYqKLXiQ==
X-Received: by 2002:a05:600c:2943:: with SMTP id
 n3mr1804990wmd.11.1571986005504; 
 Thu, 24 Oct 2019 23:46:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w22sm1170795wmc.16.2019.10.24.23.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31ACC1FF91;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 58/73] linux-user: support -plugin option
Date: Fri, 25 Oct 2019 07:36:58 +0100
Message-Id: <20191025063713.23374-59-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, "Emilio G . Cota" <cota@braap.org>,
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

diff --git a/linux-user/main.c b/linux-user/main.c
index 560d053f724..6ff7851e86f 100644
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


