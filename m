Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3C5C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE79E24680
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="CV4/9eKB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="wROTDxCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE79E24680
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXt8x-00019S-Dp
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 17:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kXt6M-0000SO-3N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 17:35:26 -0400
Received: from home.keithp.com ([63.227.221.253]:48064 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kXt6I-0001KS-Th
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 17:35:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 393FF3F2DDB5;
 Wed, 28 Oct 2020 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603920920; bh=Cc20zA94dsjlJ56GyP6sBhSgPpNZNEKP68oxX4EMpNk=;
 h=From:To:Cc:Subject:Date:From;
 b=CV4/9eKB+Msd2jpZqN8b6z4JxopVEwrlgzxqz6ZlrBIvwCzxs7yhSLAynb/QgEpa1
 su0X4tqCCHK9DmA/p8uHspHoXNzlNxoF+5DLjQ3bL8Qcaq6VjTF4lvVUxBRZxTciP5
 2MSN7+01dEvVCH8HggNhpLnfC4Qums4AZgxlJ96C4cgwpdCXqhEoUNt/VJFZCGa873
 ELILyTU2iTLNJeJmoujHt0w8zLIjr763cZrxpU+feBsNdibffVspDkSw12hGuXaDJ7
 Se9KCJnW0DNe5WDgN8Dlq+HNT0BKPZBosvXgiyU/gABnKGIwOttcVQtVxC6kbtNtj9
 AvWOZbnWy3I3Q==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id tOwmd0NJ75hH; Wed, 28 Oct 2020 14:35:15 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 0E2513F2DDB2;
 Wed, 28 Oct 2020 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603920915; bh=Cc20zA94dsjlJ56GyP6sBhSgPpNZNEKP68oxX4EMpNk=;
 h=From:To:Cc:Subject:Date:From;
 b=wROTDxCnplkESpbfKkD6OSp7TdAH3fI/ennXJmMJUZ0xdfW10TZ0W97QlDjarKTq3
 g+VXzQc+lgCKFCrQVk8TUfXPSWFSRVtwIZU2oJEmEst43Rztih0HVZuLTPfW69MP3R
 Mi4YYcmTmZFHDBBM9ediLDPFWiYgDEBnceSUgaJyi3P+GmfznXw4IBAPh1S0gWc7nT
 SDKIASTyX1ZEeoXeJxihp3l+OkA318eEgWwqxlOsTIr42CwCWhvmjtgO1+KoVa4jKX
 o3j1SW6vveJZZDkYstH/f6tnkGVHmRQqRMnA2C+zhXF7TEq6R09iMvbprOQKoZH7O6
 WSG+4n+oiyuxw==
Received: by keithp.com (Postfix, from userid 1000)
 id C66081582210; Wed, 28 Oct 2020 14:35:14 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Packard <keithp@keithp.com>
Subject: [PATCH] semihosting: Merge semihosting console init functions to fix
 READC
Date: Wed, 28 Oct 2020 14:35:12 -0700
Message-Id: <20201028213512.3002352-1-keithp@keithp.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 17:35:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Keith Packard <keithp@keithp.com>
From: Keith Packard via <qemu-devel@nongnu.org>

Commit 619985e937 (semihosting: defer connect_chardevs a little more
to use serialx) moved the call to qemu_semihosting_connect_chardevs
until after all of the serial devices were initialized to make
semihosting console configuration easier.

This change broke semihosting console input as the call to
qemu_semihosting_console_init was now made *before*
qemu_semihosting_connect_chardevs, which it requires.

To fix that, and to make sure it doesn't happen in the future, I've
merged these two functions together into
qemu_semihosting_console_init, which finds the Chardev and then wires
up console input.

These were split when semihosting READC was added to control the
priority of semihosting input compared with other users of a
multiplexed console. With connect_chardevs now occuring much later in
qemu initialization, the semihosting console input will have the same
priority as it did before the referenced commit was applied.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/semihosting/config.c           | 21 ++---------
 hw/semihosting/console.c          | 58 ++++++++++++++++++-------------
 include/hw/semihosting/semihost.h |  4 +--
 softmmu/vl.c                      |  5 +--
 4 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/hw/semihosting/config.c b/hw/semihosting/config.c
index 9807f10cb0..1bf3125f0c 100644
--- a/hw/semihosting/config.c
+++ b/hw/semihosting/config.c
@@ -51,14 +51,13 @@ QemuOptsList qemu_semihosting_config_opts = {
 typedef struct SemihostingConfig {
     bool enabled;
     SemihostingTarget target;
-    Chardev *chardev;
+    const char *chardev;
     const char **argv;
     int argc;
     const char *cmdline; /* concatenated argv */
 } SemihostingConfig;
 
 static SemihostingConfig semihosting;
-static const char *semihost_chardev;
 
 bool semihosting_enabled(void)
 {
@@ -122,7 +121,7 @@ void semihosting_arg_fallback(const char *file, const char *cmd)
     }
 }
 
-Chardev *semihosting_get_chardev(void)
+const char *semihosting_get_chardev(void)
 {
     return semihosting.chardev;
 }
@@ -145,7 +144,7 @@ int qemu_semihosting_config_options(const char *optarg)
                                                 true);
         const char *target = qemu_opt_get(opts, "target");
         /* setup of chardev is deferred until they are initialised */
-        semihost_chardev = qemu_opt_get(opts, "chardev");
+        semihosting.chardev = qemu_opt_get(opts, "chardev");
         if (target != NULL) {
             if (strcmp("native", target) == 0) {
                 semihosting.target = SEMIHOSTING_TARGET_NATIVE;
@@ -171,17 +170,3 @@ int qemu_semihosting_config_options(const char *optarg)
 
     return 0;
 }
-
-void qemu_semihosting_connect_chardevs(void)
-{
-    /* We had to defer this until chardevs were created */
-    if (semihost_chardev) {
-        Chardev *chr = qemu_chr_find(semihost_chardev);
-        if (chr == NULL) {
-            error_report("semihosting chardev '%s' not found",
-                         semihost_chardev);
-            exit(1);
-        }
-        semihosting.chardev = chr;
-    }
-}
diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 9b4fee9260..345f21b8e5 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -29,11 +29,23 @@
 #include "qapi/error.h"
 #include "qemu/fifo8.h"
 
+#define FIFO_SIZE   1024
+
+/* Access to this structure is protected by the BQL */
+typedef struct SemihostingConsole {
+    CharBackend         backend;
+    GSList              *sleeping_cpus;
+    bool                got;
+    Fifo8               fifo;
+    Chardev             *chardev;
+} SemihostingConsole;
+
+static SemihostingConsole console;
+
 int qemu_semihosting_log_out(const char *s, int len)
 {
-    Chardev *chardev = semihosting_get_chardev();
-    if (chardev) {
-        return qemu_chr_write_all(chardev, (uint8_t *) s, len);
+    if (console.chardev) {
+        return qemu_chr_write_all(console.chardev, (uint8_t *) s, len);
     } else {
         return write(STDERR_FILENO, s, len);
     }
@@ -107,17 +119,6 @@ void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
     }
 }
 
-#define FIFO_SIZE   1024
-
-/* Access to this structure is protected by the BQL */
-typedef struct SemihostingConsole {
-    CharBackend         backend;
-    GSList              *sleeping_cpus;
-    bool                got;
-    Fifo8               fifo;
-} SemihostingConsole;
-
-static SemihostingConsole console;
 
 static int console_can_read(void *opaque)
 {
@@ -166,15 +167,24 @@ target_ulong qemu_semihosting_console_inc(CPUArchState *env)
 
 void qemu_semihosting_console_init(void)
 {
-    Chardev *chr = semihosting_get_chardev();
-
-    if  (chr) {
-        fifo8_create(&console.fifo, FIFO_SIZE);
-        qemu_chr_fe_init(&console.backend, chr, &error_abort);
-        qemu_chr_fe_set_handlers(&console.backend,
-                                 console_can_read,
-                                 console_read,
-                                 NULL, NULL, &console,
-                                 NULL, true);
+    const char *chardev = semihosting_get_chardev();
+
+    if (chardev == NULL) {
+        return;
     }
+
+    console.chardev = qemu_chr_find(chardev);
+
+    if (console.chardev == NULL) {
+        error_report("semihosting chardev '%s' not found", chardev);
+        exit(1);
+    }
+
+    fifo8_create(&console.fifo, FIFO_SIZE);
+    qemu_chr_fe_init(&console.backend, console.chardev, &error_abort);
+    qemu_chr_fe_set_handlers(&console.backend,
+                             console_can_read,
+                             console_read,
+                             NULL, NULL, &console,
+                             NULL, true);
 }
diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/semihost.h
index b8ce5117ae..bbde8bd807 100644
--- a/include/hw/semihosting/semihost.h
+++ b/include/hw/semihosting/semihost.h
@@ -52,7 +52,7 @@ static inline const char *semihosting_get_cmdline(void)
     return NULL;
 }
 
-static inline Chardev *semihosting_get_chardev(void)
+static inline const char *semihosting_get_chardev(void)
 {
     return NULL;
 }
@@ -66,7 +66,7 @@ const char *semihosting_get_arg(int i);
 int semihosting_get_argc(void);
 const char *semihosting_get_cmdline(void);
 void semihosting_arg_fallback(const char *file, const char *cmd);
-Chardev *semihosting_get_chardev(void);
+const char *semihosting_get_chardev(void);
 /* for vl.c hooks */
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *opt);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 7c1c6d37ef..b2bad58575 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4284,9 +4284,6 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
 
-    /* connect semihosting console input if requested */
-    qemu_semihosting_console_init();
-
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
     if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
@@ -4295,7 +4292,7 @@ void qemu_init(int argc, char **argv, char **envp)
         exit(1);
 
     /* now chardevs have been created we may have semihosting to connect */
-    qemu_semihosting_connect_chardevs();
+    qemu_semihosting_console_init();
 
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
-- 
2.28.0


