Received: from eggs.gnu.org ([209.51.188.92]:36598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gpFdB-0004hZ-GY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gpFd9-000582-SU
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gpFd9-00057c-Ki
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:55:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4B6E394D54
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 16:46:44 +0000 (UTC)
From: Christophe Fergeau <cfergeau@redhat.com>
Date: Thu, 31 Jan 2019 17:46:14 +0100
Message-Id: <20190131164614.19209-3-cfergeau@redhat.com>
In-Reply-To: <20190131164614.19209-1-cfergeau@redhat.com>
References: <20190131164614.19209-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 2/2] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
spice version is >=3D 0.14.1. With older spice versions, this is not goin=
g
to work as expected, but will not have any ill effect, so this call is
not conditional on the SPICE version.

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Changes since v6:
- expanded on the bsd-user/linux-user/qemu-pr-helper changes in the
  commit log
- fix obsolete mention of qemu_init_logging() in commit log
- improved output when 'log_domain' is NULL
- removed unneeded "fall through" comment in switch/case
- fixed multi-line comments

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
     if (argc <=3D 1)
         usage();
=20
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 0a8d9cc9ea..ce43c02314 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -34,7 +34,6 @@ void error_vprintf(const char *fmt, va_list ap) GCC_FMT=
_ATTR(1, 0);
 void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(=
1, 0);
 void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-void error_set_progname(const char *argv0);
=20
 void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void warn_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
@@ -49,6 +48,8 @@ bool error_report_once_cond(bool *printed, const char *=
fmt, ...)
 bool warn_report_once_cond(bool *printed, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
=20
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
=20
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
diff --git a/qemu-img.c b/qemu-img.c
index ad04f59565..0af9cac244 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4912,8 +4912,8 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
=20
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
-    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
=20
     if (qemu_init_main_loop(&local_error)) {
diff --git a/qemu-io.c b/qemu-io.c
index 2c52ac0ade..8d5d5911cb 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -522,8 +522,8 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
=20
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
-    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
=20
     qcrypto_init(&error_fatal);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 1f7b2a03f5..39849f1692 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -685,8 +685,8 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
=20
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
-    error_set_progname(argv[0]);
     qcrypto_init(&error_fatal);
=20
     module_call_init(MODULE_INIT_QOM);
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index e7af637232..2541fbbd1b 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -895,6 +895,7 @@ int main(int argc, char **argv)
=20
     signal(SIGPIPE, SIG_IGN);
=20
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
     const char *p =3D strrchr(argv0, '/');
     progname =3D p ? p + 1 : argv0;
@@ -345,3 +345,56 @@ bool warn_report_once_cond(bool *printed, const char=
 *fmt, ...)
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
+         * Use same G_MESSAGES_DEBUG logic as glib to enable/disable deb=
ug
+         * messages
+         */
+        if (qemu_glog_domains =3D=3D NULL) {
+            break;
+        }
+        if (strcmp(qemu_glog_domains, "all") !=3D 0 &&
+          (log_domain =3D=3D NULL || !strstr(qemu_glog_domains, log_doma=
in))) {
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
+     * This sets up glib logging so libraries using it also print their =
logs
+     * through error_report(), warn_report(), info_report().
+     */
+    g_log_set_default_handler(qemu_log_func, NULL);
+    g_warn_if_fail(qemu_glog_domains =3D=3D NULL);
+    qemu_glog_domains =3D g_strdup(g_getenv("G_MESSAGES_DEBUG"));
+}
diff --git a/vl.c b/vl.c
index 9cf0fbe0b8..3d447b84d1 100644
--- a/vl.c
+++ b/vl.c
@@ -3042,6 +3042,7 @@ int main(int argc, char **argv, char **envp)
     QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
         =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
=20
+    error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
=20
     qemu_init_cpu_list();
@@ -3050,7 +3051,6 @@ int main(int argc, char **argv, char **envp)
     qemu_mutex_lock_iothread();
=20
     atexit(qemu_run_exit_notifiers);
-    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
=20
     module_call_init(MODULE_INIT_QOM);
--=20
2.20.1
