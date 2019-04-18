Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DE5C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED45A214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED45A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHE2o-0006at-7c
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:54:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0S-000561-UQ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0R-0005AK-5Y
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0Q-00059I-S9
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE0BEC04B94F
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 85E85600C5;
	Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 02B861132BD3; Thu, 18 Apr 2019 22:51:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:01 +0200
Message-Id: <20190418205135.6686-3-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 02/36] log: Make glib logging go through
 QEMU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Christophe Fergeau <cfergeau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418205101.3gUUURzRQKbx-W-HFLvyiCu1-gPT_FuNyCVePotwGAo@z>

From: Christophe Fergeau <cfergeau@redhat.com>

This commit adds a error_init() helper which calls
g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
are handled similarly to other QEMU logs. This means they will get a
timestamp if timestamps are enabled, and they will go through the
HMP monitor if one is configured.

This commit also adds a call to error_init() to the binaries
installed by QEMU. Since error_init() also calls error_set_progname(),
this means that *-linux-user, *-bsd-user and qemu-pr-helper messages
output with error_report, info_report, ... will slightly change: they
will be prefixed by the binary name.

glib debug messages are enabled through G_MESSAGES_DEBUG similarly to
the glib default log handler.

At the moment, this change will mostly impact SPICE logging if your
spice version is >= 0.14.1. With older spice versions, this is not going
to work as expected, but will not have any ill effect, so this call is
not conditional on the SPICE version.

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190131164614.19209-3-cfergeau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 bsd-user/main.c             |  2 ++
 include/qemu/error-report.h |  3 +-
 linux-user/main.c           |  2 ++
 qemu-img.c                  |  2 +-
 qemu-io.c                   |  2 +-
 qemu-nbd.c                  |  2 +-
 scsi/qemu-pr-helper.c       |  1 +
 util/qemu-error.c           | 55 ++++++++++++++++++++++++++++++++++++-
 vl.c                        |  2 +-
 9 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 0d3156974c..8fd8ae4127 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qemu.h"
 #include "qemu/config-file.h"
+#include "qemu/error-report.h"
 #include "qemu/path.h"
 #include "qemu/help_option.h"
 #include "cpu.h"
@@ -743,6 +744,7 @@ int main(int argc, char **argv)
     if (argc <= 1)
         usage();
 
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 0a8d9cc9ea..ce43c02314 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -34,7 +34,6 @@ void error_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-void error_set_progname(const char *argv0);
 
 void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void warn_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
@@ -49,6 +48,8 @@ bool error_report_once_cond(bool *printed, const char *fmt, ...)
 bool warn_report_once_cond(bool *printed, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
+void error_init(const char *argv0);
+
 /*
  * Similar to error_report(), except it prints the message just once.
  * Return true when it prints, false otherwise.
diff --git a/linux-user/main.c b/linux-user/main.c
index a0aba9cb1e..f9efe9ff6e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -27,6 +27,7 @@
 #include "qemu/path.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
@@ -600,6 +601,7 @@ int main(int argc, char **argv, char **envp)
     int ret;
     int execfd;
 
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
diff --git a/qemu-img.c b/qemu-img.c
index aa6f81f1ea..8c7b2437f0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4923,8 +4923,8 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
 
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
-    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
     if (qemu_init_main_loop(&local_error)) {
diff --git a/qemu-io.c b/qemu-io.c
index 2c52ac0ade..8d5d5911cb 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -522,8 +522,8 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
 
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
-    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
     qcrypto_init(&error_fatal);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 941ba729c2..dca9e72cee 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -690,8 +690,8 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
 
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
-    error_set_progname(argv[0]);
     qcrypto_init(&error_fatal);
 
     module_call_init(MODULE_INIT_QOM);
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index e7af637232..2541fbbd1b 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -895,6 +895,7 @@ int main(int argc, char **argv)
 
     signal(SIGPIPE, SIG_IGN);
 
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_trace_opts);
diff --git a/util/qemu-error.c b/util/qemu-error.c
index fcbe8a1f74..d08139d9ac 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -142,7 +142,7 @@ static const char *progname;
 /*
  * Set the program name for error_print_loc().
  */
-void error_set_progname(const char *argv0)
+static void error_set_progname(const char *argv0)
 {
     const char *p = strrchr(argv0, '/');
     progname = p ? p + 1 : argv0;
@@ -345,3 +345,56 @@ bool warn_report_once_cond(bool *printed, const char *fmt, ...)
     va_end(ap);
     return true;
 }
+
+static char *qemu_glog_domains;
+
+static void qemu_log_func(const gchar *log_domain,
+                          GLogLevelFlags log_level,
+                          const gchar *message,
+                          gpointer user_data)
+{
+    switch (log_level & G_LOG_LEVEL_MASK) {
+    case G_LOG_LEVEL_DEBUG:
+    case G_LOG_LEVEL_INFO:
+        /*
+         * Use same G_MESSAGES_DEBUG logic as glib to enable/disable debug
+         * messages
+         */
+        if (qemu_glog_domains == NULL) {
+            break;
+        }
+        if (strcmp(qemu_glog_domains, "all") != 0 &&
+          (log_domain == NULL || !strstr(qemu_glog_domains, log_domain))) {
+            break;
+        }
+        /* Fall through */
+    case G_LOG_LEVEL_MESSAGE:
+        info_report("%s%s%s",
+                    log_domain ?: "", log_domain ? ": " : "", message);
+
+        break;
+    case G_LOG_LEVEL_WARNING:
+        warn_report("%s%s%s",
+                    log_domain ?: "", log_domain ? ": " : "", message);
+        break;
+    case G_LOG_LEVEL_CRITICAL:
+    case G_LOG_LEVEL_ERROR:
+        error_report("%s%s%s",
+                     log_domain ?: "", log_domain ? ": " : "", message);
+        break;
+    }
+}
+
+void error_init(const char *argv0)
+{
+    /* Set the program name for error_print_loc(). */
+    error_set_progname(argv0);
+
+    /*
+     * This sets up glib logging so libraries using it also print their logs
+     * through error_report(), warn_report(), info_report().
+     */
+    g_log_set_default_handler(qemu_log_func, NULL);
+    g_warn_if_fail(qemu_glog_domains == NULL);
+    qemu_glog_domains = g_strdup(g_getenv("G_MESSAGES_DEBUG"));
+}
diff --git a/vl.c b/vl.c
index c696ad2a13..9877972d97 100644
--- a/vl.c
+++ b/vl.c
@@ -3022,6 +3022,7 @@ int main(int argc, char **argv, char **envp)
     char *dir, **dirs;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
 
     qemu_init_cpu_list();
@@ -3030,7 +3031,6 @@ int main(int argc, char **argv, char **envp)
     qemu_mutex_lock_iothread();
 
     atexit(qemu_run_exit_notifiers);
-    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.17.2


