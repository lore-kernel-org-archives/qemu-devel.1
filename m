Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C44FECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458632084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVQ93vwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458632084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyEd-0002Kp-Df
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvU-0007Wc-0w
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvS-0006GR-NK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvS-0006FE-Go
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id y18so9677482wrn.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tals8a9mIFmx+icrckx2DF+DPIwwPX+blavRmLxcPdQ=;
 b=AVQ93vwkw9sJQ6r6kitpmB3sS7F0wtz+A2OzrXXZDBthuEqWmBgg4hfc1jIhlq9DWw
 eMAUjmsacGZpsNyV9ZII5wI6I5+eis2WC39Qml6Pfsi/QOpHDWsOKg/fcH9xWjHMfetA
 2ivuU7QsQmOH1FDcguRUJ3l3HX1P696BvFoaCm8jxtyB7JO1wGshkY56BrTg41juVuhE
 FhCV2xs3OYQUA8Z4glxWq+MpKCDBKZ1bOmJKmYrHZFBaJ4BNJPBflyPTKr5ocs225kz9
 3LIVILg4Vpj6sp912epegj9CSxEzy67diUHwfNoGQX6ij1nl5KjJAN86znNGJc6bYYxd
 lLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tals8a9mIFmx+icrckx2DF+DPIwwPX+blavRmLxcPdQ=;
 b=TMWSBNa00vIoSca9hUNeMW1ze0EaQifilXDhsLodJho51zUEdmxLCnELg1X3HBdKDt
 BTE1Lp8uBIoNPqHw6g2OJ1ZgkGZFzC3L2nAiyckWFafs5/SA9c92+/JkgT45hZfYSI5P
 gtMaq0xFm+4AQjCgtelv2zLN1Gdf36zfbk5ojVNYEV3jiZnZd9oioHcxj9mLrQGP1VB6
 zqCT9U8YGLXPSlaDTD8StIYKAikqdsDr7Q+qVYNtbGfxPzGivu3MW7iBak9ecGPA/+az
 gTy9B7bnGRCj7UGBK3oi7h8AYdIKmbvSSOvK9IigfET7B7+7Z60GMmFfOJW84Exg2Q54
 WJYw==
X-Gm-Message-State: APjAAAVyB+ZdNM0eSe8oRTBb/NewXuLB2RYZQ72lN+dFJQk+fTh/9Jf4
 C5ViOXZDLap/wWU8uE+uKD1aIOzSWb8=
X-Google-Smtp-Source: APXvYqwNL7ru22TDnt5d/ktsb+eBAWeEZ9zafbaP74N+/PEaqRUw/WyhYEK0zghPRpke7xiqc/0dpQ==
X-Received: by 2002:adf:ed52:: with SMTP id u18mr26668454wro.16.1571050205477; 
 Mon, 14 Oct 2019 03:50:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n7sm19335803wrt.59.2019.10.14.03.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:50:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5CA631FFC6;
 Mon, 14 Oct 2019 11:49:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 37/55] vl: support -plugin option
Date: Mon, 14 Oct 2019 11:49:30 +0100
Message-Id: <20191014104948.4291-38-alex.bennee@linaro.org>
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
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
 qemu-options.hx | 17 +++++++++++++++++
 vl.c            | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6ac5..8dcc88e5ae 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4144,6 +4144,23 @@ HXCOMM HX does not support conditional compilation of text.
 @findex -trace
 @include qemu-option-trace.texi
 ETEXI
+DEF("plugin", HAS_ARG, QEMU_OPTION_plugin,
+    "-plugin [file=]<file>[,arg=<string>]\n"
+    "                load a plugin\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -plugin file=@var{file}[,arg=@var{string}]
+@findex -plugin
+
+Load a plugin.
+
+@table @option
+@item file=@var{file}
+Load the given plugin from a shared library file.
+@item arg=@var{string}
+Argument string passed to the plugin. (Can be given multiple times.)
+@end table
+ETEXI
 
 HXCOMM Internal use
 DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
diff --git a/vl.c b/vl.c
index 002bf4919e..4bdd526029 100644
--- a/vl.c
+++ b/vl.c
@@ -110,6 +110,7 @@ int main(int argc, char **argv)
 
 #include "trace-root.h"
 #include "trace/control.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
 
@@ -2904,6 +2905,7 @@ int main(int argc, char **argv, char **envp)
     bool list_data_dirs = false;
     char *dir, **dirs;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     os_set_line_buffering();
 
@@ -2934,6 +2936,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -3717,6 +3720,9 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
                 break;
+            case QEMU_OPTION_plugin:
+                qemu_plugin_opt_parse(optarg, &plugin_list);
+                break;
             case QEMU_OPTION_readconfig:
                 {
                     int ret = qemu_read_config_file(optarg);
@@ -4030,6 +4036,11 @@ int main(int argc, char **argv, char **envp)
                                machine_class->default_machine_opts, 0);
     }
 
+    /* process plugin before CPUs are created, but once -smp has been parsed */
+    if (qemu_plugin_load_list(&plugin_list)) {
+        exit(1);
+    }
+
     qemu_opts_foreach(qemu_find_opts("device"),
                       default_driver_check, NULL, NULL);
     qemu_opts_foreach(qemu_find_opts("global"),
-- 
2.20.1


