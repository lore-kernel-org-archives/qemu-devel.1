Received: from eggs.gnu.org ([2001:4830:134:3::10]:58580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PEV-0007wL-Rr
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PEU-0005YI-VO
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PEU-0005Wo-N5
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:26 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:28:59 +0400
Message-Id: <20181005122910.11745-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 01/12] qdev-monitor: print help to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qdev_device_help() is used from command line "-device help", or from
HMP "device_add". If used from command line, print help to stdout
(it is only printed on explicit demand).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/monitor/monitor.h |  3 +++
 monitor.c                 | 16 +++++++++++++---
 qdev-monitor.c            | 32 +++++++++++++++++++-------------
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 2ef5e04b37..6fd2c53b09 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -47,4 +47,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_=
fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int monitor_fdset_dup_fd_find(int dup_fd);
=20
+void monitor_vfprintf(FILE *stream,
+                      const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+
 #endif /* MONITOR_H */
diff --git a/monitor.c b/monitor.c
index c4677b502b..b9258a7438 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4493,19 +4493,29 @@ static void monitor_readline_flush(void *opaque)
 }
=20
 /*
- * Print to current monitor if we have one, else to stderr.
+ * Print to current monitor if we have one, else to stream.
  * TODO should return int, so callers can calculate width, but that
  * requires surgery to monitor_vprintf().  Left for another day.
  */
-void error_vprintf(const char *fmt, va_list ap)
+void monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
     if (cur_mon && !monitor_cur_is_qmp()) {
         monitor_vprintf(cur_mon, fmt, ap);
     } else {
-        vfprintf(stderr, fmt, ap);
+        vfprintf(stream, fmt, ap);
     }
 }
=20
+/*
+ * Print to current monitor if we have one, else to stderr.
+ * TODO should return int, so callers can calculate width, but that
+ * requires surgery to monitor_vprintf().  Left for another day.
+ */
+void error_vprintf(const char *fmt, va_list ap)
+{
+    monitor_vfprintf(stderr, fmt, ap);
+}
+
 void error_vprintf_unless_qmp(const char *fmt, va_list ap)
 {
     if (cur_mon && !monitor_cur_is_qmp()) {
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 61e0300991..802c18a74e 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -104,22 +104,31 @@ static bool qdev_class_has_alias(DeviceClass *dc)
     return (qdev_class_get_alias(dc) !=3D NULL);
 }
=20
+static void out_printf(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    monitor_vfprintf(stdout, fmt, ap);
+    va_end(ap);
+}
+
 static void qdev_print_devinfo(DeviceClass *dc)
 {
-    error_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)))=
;
+    out_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
     if (dc->bus_type) {
-        error_printf(", bus %s", dc->bus_type);
+        out_printf(", bus %s", dc->bus_type);
     }
     if (qdev_class_has_alias(dc)) {
-        error_printf(", alias \"%s\"", qdev_class_get_alias(dc));
+        out_printf(", alias \"%s\"", qdev_class_get_alias(dc));
     }
     if (dc->desc) {
-        error_printf(", desc \"%s\"", dc->desc);
+        out_printf(", desc \"%s\"", dc->desc);
     }
     if (!dc->user_creatable) {
-        error_printf(", no-user");
+        out_printf(", no-user");
     }
-    error_printf("\n");
+    out_printf("\n");
 }
=20
 static void qdev_print_devinfos(bool show_no_user)
@@ -155,8 +164,7 @@ static void qdev_print_devinfos(bool show_no_user)
                 continue;
             }
             if (!cat_printed) {
-                error_printf("%s%s devices:\n", i ? "\n" : "",
-                             cat_name[i]);
+                out_printf("%s%s devices:\n", i ? "\n" : "", cat_name[i]=
);
                 cat_printed =3D true;
             }
             qdev_print_devinfo(dc);
@@ -278,13 +286,11 @@ int qdev_device_help(QemuOpts *opts)
     }
=20
     for (prop =3D prop_list; prop; prop =3D prop->next) {
-        error_printf("%s.%s=3D%s", driver,
-                     prop->value->name,
-                     prop->value->type);
+        out_printf("%s.%s=3D%s", driver, prop->value->name, prop->value-=
>type);
         if (prop->value->has_description) {
-            error_printf(" (%s)\n", prop->value->description);
+            out_printf(" (%s)\n", prop->value->description);
         } else {
-            error_printf("\n");
+            out_printf("\n");
         }
     }
=20
--=20
2.19.0.271.gfe8321ec05
