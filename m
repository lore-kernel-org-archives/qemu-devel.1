Received: from eggs.gnu.org ([2001:4830:134:3::10]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dX3e8-0002Li-Eu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dX3e5-0007n1-Qf
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:53:00 -0400
Received: from mail-eopbgr50115.outbound.protection.outlook.com
	([40.107.5.115]:36552
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dX3e4-0007kn-VP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:52:57 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 17 Jul 2017 13:52:35 +0300
Message-Id: <1500288755-76809-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] char: don't exit on hmp 'chardev-add help'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

qemu_chr_new_from_opts() is used from both vl.c and hmp,
and it is quite confusing to see qemu suddenly exit after receiving a help
option in hmp.

Create a separate function for printing help and let different callers
react accordingly.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 include/chardev/char.h |  9 +++++++++
 chardev/char.c         | 27 +++++++++++++++++++--------
 vl.c                   |  4 ++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 1604ea9..461962b 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -59,6 +59,15 @@ struct Chardev {
 };
 
 /**
+ * @qemu_chr_help:
+ *
+ * Print available chardevice backends if 'asked for help' in @opts
+ *
+ * Returns: true if there was a help option
+ */
+bool qemu_chr_help(QemuOpts *opts);
+
+/**
  * @qemu_chr_new_from_opts:
  *
  * Create a new character backend from a QemuOpts list.
diff --git a/chardev/char.c b/chardev/char.c
index c34b44a..19833fe 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -604,14 +604,9 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
     return backend;
 }
 
-Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
+bool qemu_chr_help(QemuOpts *opts)
 {
-    const ChardevClass *cc;
-    Chardev *chr = NULL;
-    ChardevBackend *backend = NULL;
-    const char *name = chardev_alias_translate(qemu_opt_get(opts, "backend"));
-    const char *id = qemu_opts_id(opts);
-    char *bid = NULL;
+    const char *name = qemu_opt_get(opts, "backend");
 
     if (name && is_help_option(name)) {
         GString *str = g_string_new("");
@@ -620,7 +615,23 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
 
         error_report("Available chardev backend types: %s", str->str);
         g_string_free(str, true);
-        exit(0);
+        return true;
+    }
+
+    return false;
+}
+
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
+{
+    const ChardevClass *cc;
+    Chardev *chr = NULL;
+    ChardevBackend *backend = NULL;
+    const char *name = chardev_alias_translate(qemu_opt_get(opts, "backend"));
+    const char *id = qemu_opts_id(opts);
+    char *bid = NULL;
+
+    if (qemu_chr_help(opts)) {
+        return NULL;
     }
 
     if (id == NULL) {
diff --git a/vl.c b/vl.c
index fb6b2ef..7cad539 100644
--- a/vl.c
+++ b/vl.c
@@ -2344,6 +2344,10 @@ static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
 
+    if (qemu_chr_help(opts)) {
+        exit(0);
+    }
+
     qemu_chr_new_from_opts(opts, &local_err);
     if (local_err) {
         error_report_err(local_err);
-- 
2.7.4
