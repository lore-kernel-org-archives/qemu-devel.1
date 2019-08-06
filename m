Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D6C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EB52070C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjlrSxGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EB52070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hutfX-0002Bt-Nz
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutcn-0005vQ-II
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutcm-0002HZ-Au
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hutcm-0002H8-4j
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id s15so53950763wmj.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hun2Fzp3UC3+BE6p1OV7nB2Qd68PIPI16xM6ErbZLo8=;
 b=qjlrSxGa7ZoLF801q9Ps9e9lMQJ8ybDQeEPB0jWmHuMYGqkyfdA3nI6tVj0Kx47vKq
 XNycZK9xKmauJYC4lVhPltTUemEHIOLU1rD2y6svEccxsPg4aTPJcVIXePIDJFvlzeLc
 NYnL1J2k6fu0u3Vy3eE/hcTtDX9eOd0S8GbnEh9TOY1o/3I3xs/voZ44PHa08OBVjSty
 ib5LTNZ1bLBq2mMCib63kIZenmL3lMB+YQokA25z5UjIrnPfZKnEn6HH6b0E60cku1Gz
 KXy4Cr6j96udLBmVYHG4hurqW6kFJc9qDopMRJczj78dS+nuk3whr+pp+tibG1E110Q6
 PA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Hun2Fzp3UC3+BE6p1OV7nB2Qd68PIPI16xM6ErbZLo8=;
 b=benBLBYSGHzYPoMa1XrDDwWcowzTERvz7F8cqergRvmTkR2Q1Li/MWJfmDvVgkR/rx
 oCZIm1PhxxRbF6Kc8sguvXYR36dUmxFCBi210P6knK6V2mm+Obmcov2MfZTCQvAAespj
 /FE7epyU+3ZeoN8TtTJ2hwKCJ9XoJEHkb/h6OBxiXw8OrEv5NcYJKOOOF2uECzjDxwO5
 +yyw/9XUQYILbWIEOCHbIwa7xdyscXhKZIv1TxXCIkYjmzj3lkeQVSWHRm/ewCANTToZ
 usdQPZ7Y8z+O8ZF6j9p3HM+QhgSjeMYVqRBy7RAuMTXCylSd5CgcoVAwmWemWcaEUIrd
 oyEQ==
X-Gm-Message-State: APjAAAVxUN9e9XPAxXAbCBd33t4LVxl9e88TomBBu7d8cagJGs9lAN+Q
 scYXQ1kPwx/k1G75Xelp2kkfiavU
X-Google-Smtp-Source: APXvYqx+fxnkD/g0epwjzDOaljVdDDsih7qxXgMhnxDjkd3JxywPX6s7/NRP50N6NiAc2WcPifExKg==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr2974331wmj.94.1565075470876; 
 Tue, 06 Aug 2019 00:11:10 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id z6sm74944037wrw.2.2019.08.06.00.11.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:11:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 09:11:06 +0200
Message-Id: <1565075466-14943-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565075466-14943-1-git-send-email-pbonzini@redhat.com>
References: <1565075466-14943-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 3/3] tests: add module loading test
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This test will simply check that modules can be loaded, and no symbols
are missing.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qtest.c                |  9 +++++++
 tests/Makefile.include |  1 +
 tests/libqtest.c       |  6 +++++
 tests/libqtest.h       |  2 ++
 tests/modules-test.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+)
 create mode 100644 tests/modules-test.c

diff --git a/qtest.c b/qtest.c
index 15e27e9..40c3609 100644
--- a/qtest.c
+++ b/qtest.c
@@ -661,6 +661,15 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    } else if (strcmp(words[0], "module_load") == 0) {
+        g_assert(words[1] && words[2]);
+
+        qtest_send_prefix(chr);
+        if (module_load_one(words[1], words[2])) {
+            qtest_sendf(chr, "OK\n");
+        } else {
+            qtest_sendf(chr, "FAIL\n");
+        }
     } else if (qtest_enabled() && strcmp(words[0], "clock_set") == 0) {
         int64_t ns;
         int ret;
diff --git a/tests/Makefile.include b/tests/Makefile.include
index db750dd..17dd439 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -147,6 +147,7 @@ check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
 check-qtest-generic-y += tests/qmp-test$(EXESUF)
 check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
+check-qtest-generic-$(CONFIG_MODULES) += tests/modules-test$(EXESUF)
 
 check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
 check-qtest-generic-y += tests/cdrom-test$(EXESUF)
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3c5c3f4..e158e50 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -811,6 +811,12 @@ bool qtest_get_irq(QTestState *s, int num)
     return s->irq_level[num];
 }
 
+void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
+{
+    qtest_sendf(s, "module_load %s %s\n", prefix, libname);
+    qtest_rsp(s, 0);
+}
+
 static int64_t qtest_clock_rsp(QTestState *s)
 {
     gchar **words;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index cadf1d4..2a09102 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -262,6 +262,8 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
 
+void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
+
 /**
  * qtest_get_irq:
  * @s: #QTestState instance to operate on.
diff --git a/tests/modules-test.c b/tests/modules-test.c
new file mode 100644
index 0000000..3aef0e5
--- /dev/null
+++ b/tests/modules-test.c
@@ -0,0 +1,71 @@
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static void test_modules_load(const void *data)
+{
+    QTestState *qts;
+    const char **args = data;
+
+    qts = qtest_init(NULL);
+    qtest_module_load(qts, args[0], args[1]);
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    const char *modules[] = {
+#ifdef CONFIG_CURL
+        "block-", "curl",
+#endif
+#ifdef CONFIG_GLUSTERFS
+        "block-", "gluster",
+#endif
+#ifdef CONFIG_LIBISCSI
+        "block-", "iscsi",
+#endif
+#ifdef CONFIG_LIBNFS
+        "block-", "nfs",
+#endif
+#ifdef CONFIG_LIBSSH
+        "block-", "ssh",
+#endif
+#ifdef CONFIG_RBD
+        "block-", "rbd",
+#endif
+#ifdef CONFIG_AUDIO_ALSA
+        "audio-", "alsa",
+#endif
+#ifdef CONFIG_AUDIO_OSS
+        "audio-", "oss",
+#endif
+#ifdef CONFIG_AUDIO_PA
+        "audio-", "pa",
+#endif
+#ifdef CONFIG_AUDIO_SDL
+        "audio-", "sdl",
+#endif
+#ifdef CONFIG_CURSES
+        "ui-", "curses",
+#endif
+#if defined(CONFIG_GTK) && defined(CONFIG_VTE)
+        "ui-", "gtk",
+#endif
+#ifdef CONFIG_SDL
+        "ui-", "sdl",
+#endif
+#if defined(CONFIG_SPICE) && defined(CONFIG_GIO)
+        "ui-", "spice-app",
+#endif
+    };
+    int i;
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (i = 0; i < G_N_ELEMENTS(modules); i += 2) {
+        char *testname = g_strdup_printf("/module/load/%s", modules[i + 1]);
+        qtest_add_data_func(testname, modules + i, test_modules_load);
+        g_free(testname);
+    }
+
+    return g_test_run();
+}
-- 
1.8.3.1


