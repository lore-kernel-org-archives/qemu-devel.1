Received: from eggs.gnu.org ([2001:4830:134:3::10]:46373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gXP8M-0003XV-AU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gXP8I-0002Cc-61
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:26:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gXP8H-00020s-TD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:26:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7DE181E05
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:26:17 +0000 (UTC)
Received: from natto.ory.fergeau.eu (ovpn-117-65.ams2.redhat.com
	[10.36.117.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38DE560C69
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:26:17 +0000 (UTC)
From: Christophe Fergeau <cfergeau@redhat.com>
Date: Thu, 13 Dec 2018 12:26:12 +0100
Message-Id: <20181213112612.31242-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This commit adds a qemu_init_logging() helper which calls
g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
are handled similarly to other QEMU logs. This means they will get a
timestamp if timestamps are enabled, and they will go through the
monitor if one is configured.
This commit also adds a call to qemu_init_logging() to the binaries
installed by QEMU.

At the moment, this change will mostly impact SPICE logging if your
spice version is >=3D 0.14.1. With older spice versions, this is not goin=
g
to work as expected, but will not have any ill effect, so this call is
not conditional on the SPICE version.

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
---
Changes since v1:
- introduced a qemu_init_logging() helper, and call that in more
  binaries than just vl.c


 bsd-user/main.c             |  1 +
 include/qemu/error-report.h |  2 ++
 linux-user/main.c           |  1 +
 qemu-img.c                  |  1 +
 qemu-io.c                   |  1 +
 qemu-nbd.c                  |  1 +
 scsi/qemu-pr-helper.c       |  1 +
 util/qemu-error.c           | 33 +++++++++++++++++++++++++++++++++
 vl.c                        |  1 +
 9 files changed, 42 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 0d3156974c..96787b27ef 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -743,6 +743,7 @@ int main(int argc, char **argv)
     if (argc <=3D 1)
         usage();
=20
+    qemu_init_logging();
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 0a8d9cc9ea..2852e9df2a 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -49,6 +49,8 @@ bool error_report_once_cond(bool *printed, const char *=
fmt, ...)
 bool warn_report_once_cond(bool *printed, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
=20
+void qemu_init_logging(void);
+
 /*
  * Similar to error_report(), except it prints the message just once.
  * Return true when it prints, false otherwise.
diff --git a/linux-user/main.c b/linux-user/main.c
index 923cbb753a..de9ff462e9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -600,6 +600,7 @@ int main(int argc, char **argv, char **envp)
     int ret;
     int execfd;
=20
+    qemu_init_logging();
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_cpu_list();
     module_call_init(MODULE_INIT_QOM);
diff --git a/qemu-img.c b/qemu-img.c
index ad04f59565..9214392565 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4912,6 +4912,7 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
=20
+    qemu_init_logging();
     module_call_init(MODULE_INIT_TRACE);
     error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
diff --git a/qemu-io.c b/qemu-io.c
index 6df7731af4..ad38d12e68 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -524,6 +524,7 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
=20
+    qemu_init_logging();
     module_call_init(MODULE_INIT_TRACE);
     progname =3D g_path_get_basename(argv[0]);
     qemu_init_exec_dir(argv[0]);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ca7109652e..2cac038230 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -570,6 +570,7 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
=20
+    qemu_init_logging();
     module_call_init(MODULE_INIT_TRACE);
     qcrypto_init(&error_fatal);
=20
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index e7af637232..523f8b237c 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -895,6 +895,7 @@ int main(int argc, char **argv)
=20
     signal(SIGPIPE, SIG_IGN);
=20
+    qemu_init_logging();
     module_call_init(MODULE_INIT_TRACE);
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_trace_opts);
diff --git a/util/qemu-error.c b/util/qemu-error.c
index fcbe8a1f74..db838e9f20 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -345,3 +345,36 @@ bool warn_report_once_cond(bool *printed, const char=
 *fmt, ...)
     va_end(ap);
     return true;
 }
+
+static void qemu_log_func(const gchar *log_domain,
+                          GLogLevelFlags log_level,
+                          const gchar *message,
+                          gpointer user_data)
+{
+    switch (log_level & G_LOG_LEVEL_MASK) {
+    case G_LOG_LEVEL_DEBUG:
+        break;
+    case G_LOG_LEVEL_INFO:
+        /* Fall through */
+    case G_LOG_LEVEL_MESSAGE:
+        info_report("%s", message);
+        break;
+    case G_LOG_LEVEL_WARNING:
+        /* Fall through */
+    case G_LOG_LEVEL_CRITICAL:
+        warn_report("%s", message);
+        break;
+    case G_LOG_LEVEL_ERROR:
+        error_report("%s", message);
+        break;
+    }
+}
+
+/*
+ * Init QEMU logging subsystem. This sets up glib logging so libraries u=
sing it
+ * also print their logs through {info,warn,error}_report.
+ */
+void qemu_init_logging(void)
+{
+    g_log_set_default_handler(qemu_log_func, NULL);
+}
diff --git a/vl.c b/vl.c
index a5ae5f23d2..d986fd93ab 100644
--- a/vl.c
+++ b/vl.c
@@ -3015,6 +3015,7 @@ int main(int argc, char **argv, char **envp)
     QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
         =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
=20
+    qemu_init_logging();
     module_call_init(MODULE_INIT_TRACE);
=20
     qemu_init_cpu_list();
--=20
2.19.2
