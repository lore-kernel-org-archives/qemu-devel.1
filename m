Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8309206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miyvIiyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8309206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtwZ-0005eV-TS
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN8-00088T-60
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-0003HN-Rd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN4-0003D3-MZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id r1so925634wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K+n/Y9KbSccr2r/DGSz0DXS7y2h6ZtZ3F8obFCMz1Mk=;
 b=miyvIiynGwz+WCOYGSj8NCPrBieuW4m1B2oZ9XIqGsAZh7/u8EkpIxqlfsWtfyBcdW
 b7CDLmZgPFMF3nxKbohzZb6Vnu54lszi0+qnf7sw+KFPboOZjEMDmhc5Jp58DPm9L0LF
 ixKpRhKsKTpPiOl+FBvRj1uKFKbyYIuAK0Czdvd+28irBI3x2y38hDtqnsf0uqteXNnL
 afrD74r3RNK+t6r5bYS5jDn61YPRVIYqj0QC7vdI1bAEIRKAFHzZOP6gUwyGeP4jGhCL
 h4lfTWyd/N5+IM6zXDgl5jzrqNOK4sRHWUKZEbmVGaUC+5qj+/MamTYmi8Egp0hb6xyR
 IY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K+n/Y9KbSccr2r/DGSz0DXS7y2h6ZtZ3F8obFCMz1Mk=;
 b=qmDQTaIZlvEY+219Wc2ji7P2qU7L8mByEELqCpiY8pqLwkDRzk8bgsn/bK95fsdNYP
 D1w12FkcjnN83ObAAAwIqITXNCY5WM7YNto/KtYuSMIMHVLb/evAMSCj8AoiN1NCxRUn
 lPf/E3nMKdJxUZOIsmMS9Ct5a3KAAO0mXQ3SGaSf0lfaDN75Fv5pHgnxoGCQ5lwmxLZl
 tgLy5KCVqmentbPxTWFXlBbpNqixyzZ3F6xSCcMon3EbcFuUqIgRrFdSH4NQ6V5fUTrq
 D2Ev+GEjUX9qXHRnb6j4i6HsJyo+kbM8D4JTX+Cfoj1DBQ9KOEkDQIEilpCO+ZUJKFnU
 FEog==
X-Gm-Message-State: APjAAAWmk8mYNZVzS6F/t6kTNicgq/FGTyTKupKlBQB1UXmxWzUt5F5V
 bN7W/YottEZ/PNpX2Ub0kg9QlELrbNE=
X-Google-Smtp-Source: APXvYqyorLw2rXXGFlAUjwDetSVtbby6HIwFxIpWSW1E3XV+XsxCC5P8BIO+T8IlRHI/C5HnWvEhPQ==
X-Received: by 2002:a05:6000:343:: with SMTP id
 e3mr1393355wre.20.1571986006167; 
 Thu, 24 Oct 2019 23:46:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e12sm1352654wrs.49.2019.10.24.23.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B0BB1FFD0;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 57/73] vl: support -plugin option
Date: Fri, 25 Oct 2019 07:36:57 +0100
Message-Id: <20191025063713.23374-58-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
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

diff --git a/qemu-options.hx b/qemu-options.hx
index 996b6fba746..fb6df45193f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4181,6 +4181,23 @@ HXCOMM HX does not support conditional compilation of text.
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
index 4489cfb2bb6..8b1b4133e49 100644
--- a/vl.c
+++ b/vl.c
@@ -110,6 +110,7 @@ int main(int argc, char **argv)
 
 #include "trace-root.h"
 #include "trace/control.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
 
@@ -2854,6 +2855,7 @@ int main(int argc, char **argv, char **envp)
     bool list_data_dirs = false;
     char *dir, **dirs;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     os_set_line_buffering();
 
@@ -2884,6 +2886,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -3678,6 +3681,9 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
                 break;
+            case QEMU_OPTION_plugin:
+                qemu_plugin_opt_parse(optarg, &plugin_list);
+                break;
             case QEMU_OPTION_readconfig:
                 {
                     int ret = qemu_read_config_file(optarg);
@@ -3991,6 +3997,11 @@ int main(int argc, char **argv, char **envp)
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


