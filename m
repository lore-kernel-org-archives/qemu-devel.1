Received: from eggs.gnu.org ([2001:4830:134:3::10]:45837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfJ-0004sl-Tc
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfF-0007CR-Bu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:29 -0400
Received: from mail-ve1eur01on0106.outbound.protection.outlook.com
	([104.47.1.106]:21120
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dFhfF-0007Bb-0D
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:25 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 30 May 2017 16:57:51 +0300
Message-ID: <1496152683-102751-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 01/13] char: move QemuOpts->ChardevBackend
 translation to a separate func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

parse function will be used by the following patch

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 chardev/char.c | 70 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 4e24dc3..3a0f543 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -854,17 +854,13 @@ help_string_append(const char *name, void *opaque)
     g_string_append_printf(str, "\n%s", name);
 }
 
-Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
-                                Error **errp)
+static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
     const ChardevClass *cc;
-    Chardev *chr;
     int i;
     ChardevBackend *backend = NULL;
     const char *name = qemu_opt_get(opts, "backend");
-    const char *id = qemu_opts_id(opts);
-    char *bid = NULL;
 
     if (name == NULL) {
         error_setg(errp, "chardev: \"%s\" missing backend",
@@ -872,21 +868,6 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         return NULL;
     }
 
-    if (is_help_option(name)) {
-        GString *str = g_string_new("");
-
-        chardev_name_foreach(help_string_append, str);
-
-        error_report("Available chardev backend types: %s", str->str);
-        g_string_free(str, true);
-        exit(0);
-    }
-
-    if (id == NULL) {
-        error_setg(errp, "chardev: no id specified");
-        return NULL;
-    }
-
     for (i = 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
         if (g_strcmp0(chardev_alias_table[i].alias, name) == 0) {
             name = chardev_alias_table[i].typename;
@@ -902,16 +883,12 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     backend = g_new0(ChardevBackend, 1);
     backend->type = CHARDEV_BACKEND_KIND_NULL;
 
-    if (qemu_opt_get_bool(opts, "mux", 0)) {
-        bid = g_strdup_printf("%s-base", id);
-    }
-
-    chr = NULL;
     if (cc->parse) {
         cc->parse(opts, backend, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            goto out;
+            qapi_free_ChardevBackend(backend);
+            return NULL;
         }
     } else {
         ChardevCommon *ccom = g_new0(ChardevCommon, 1);
@@ -919,6 +896,47 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         backend->u.null.data = ccom; /* Any ChardevCommon member would work */
     }
 
+    return backend;
+}
+
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
+{
+    const ChardevClass *cc;
+    Chardev *chr = NULL;
+    ChardevBackend *backend = NULL;
+    const char *name = qemu_opt_get(opts, "backend");
+    const char *id = qemu_opts_id(opts);
+    char *bid = NULL;
+
+    if (name && is_help_option(name)) {
+        GString *str = g_string_new("");
+
+        chardev_name_foreach(help_string_append, str);
+
+        error_report("Available chardev backend types: %s", str->str);
+        g_string_free(str, true);
+        exit(0);
+    }
+
+    if (id == NULL) {
+        error_setg(errp, "chardev: no id specified");
+        return NULL;
+    }
+
+    backend = qemu_chr_parse_opts(opts, errp);
+    if (backend == NULL) {
+        return NULL;
+    }
+
+    cc = char_get_class(name, errp);
+    if (cc == NULL) {
+        goto out;
+    }
+
+    if (qemu_opt_get_bool(opts, "mux", 0)) {
+        bid = g_strdup_printf("%s-base", id);
+    }
+
     chr = qemu_chardev_new(bid ? bid : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
                            backend, errp);
-- 
2.7.4
