Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BFC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81065206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vf3Qhf4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81065206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrjk-0002xe-OI
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51208)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrj3-0001h3-5T
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrj2-0000qo-28
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:45:17 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrj1-0000oz-QS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:45:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id p13so70408859wru.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mjk2DnvfJD1k/p+MqNImwcO38VXfRv1NAD/8zcwI2MQ=;
 b=vf3Qhf4qL45sidOgROi8Ul9+tgpNUnxyKODPFMrd5NpW+c3Yya3bnu3xPP6Qm2Xo2z
 jYsDmCrBSX8Ehlqx3GK3X9DbewB+nZFp5Jh5xy4GbT8Ff0idt1VXCeIKp926jAohQhVB
 IBSEZXUb3E+e0Ef7KIoXlHP/3Uh6kexxfeObgcycullKID62vZGMlFq6leHxaZoIwZbN
 itHyHHnPA3kk2/yNEQcbRARG3OYAwG69XnldtFXfqmrbIBc+iljlJV8wmJwJg0ys1wV5
 UFxyxs2/C2785hrgov1RaNoXr+5gOOdzaQkOywuR994lE+aAmT6jR4GqgmXFWfQD3hSe
 vo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mjk2DnvfJD1k/p+MqNImwcO38VXfRv1NAD/8zcwI2MQ=;
 b=jIEWQuy2n3yL1jhNaLJ4G9AbzsyYspRrCa59rZTXFkwGFHGGv+QxXppWyq585Ft+ZG
 V1gImozwWnc0sKlOrCfsOLX/PEmQqmTejsSZnceFmK4yGz6/Ynz9QJ8of3OiNoPB+5fT
 KGXx02oy94TgZoEL5+ueOeTBmdHnOmRdMyI+FmXWv8G1WJWvRKkkvDff5041bDDUXo3l
 zTNrK+bzhrwgxrXXTsVHv4Z2Yksy56tBx9wXV4AHeub3wgyHXorJSeyaM/Drjminn5CW
 KfLMlzanceXSYZxWF19fNlkDiQ+za6LVWZZbHHiShIlIOmPdhbWdT/A5tQ+aNgNag09o
 bElA==
X-Gm-Message-State: APjAAAUWsTkWPUk1VnSKziXOWfXQEIkxng66IhZLc98vuALeJNajAf+/
 C1PqNN48guUYHVPv90yyBKi4940HjUE=
X-Google-Smtp-Source: APXvYqxZmJZr7PKRMxVZgJU5+u0tZYUHVe0M2VFciORbq0cG3ExDZ2sjLa+yj3wXpEzcsPQ+xO+7lw==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr129156373wro.162.1564591514200; 
 Wed, 31 Jul 2019 09:45:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z5sm49307630wmf.48.2019.07.31.09.45.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:45:13 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C49B1FFC2;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:09 +0100
Message-Id: <20190731160719.11396-45-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PATCH  v4 44/54] vl: support -plugin option
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
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
index 9621e934c0b..7b438f61734 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4131,6 +4131,23 @@ HXCOMM HX does not support conditional compilation of text.
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
index b426b321346..bb62989f776 100644
--- a/vl.c
+++ b/vl.c
@@ -109,6 +109,7 @@ int main(int argc, char **argv)
 
 #include "trace-root.h"
 #include "trace/control.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
 
@@ -2889,6 +2890,7 @@ int main(int argc, char **argv, char **envp)
     bool list_data_dirs = false;
     char *dir, **dirs;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     os_set_line_buffering();
 
@@ -2919,6 +2921,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -3697,6 +3700,9 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
                 break;
+            case QEMU_OPTION_plugin:
+                qemu_plugin_opt_parse(optarg, &plugin_list);
+                break;
             case QEMU_OPTION_readconfig:
                 {
                     int ret = qemu_read_config_file(optarg);
@@ -4010,6 +4016,11 @@ int main(int argc, char **argv, char **envp)
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


