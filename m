Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPX9n-0001t0-Gk
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPX9m-0002mC-IU
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:35 -0400
Received: from mail-eopbgr10138.outbound.protection.outlook.com
	([40.107.1.138]:62048
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dPX9m-0002lO-0k
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:34 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 26 Jun 2017 19:45:38 +0300
Message-Id: <1498495550-72357-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 01/13] char: move QemuOpts->ChardevBackend
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
---
 chardev/char.c | 81 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index bcfc065..f8817c5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -556,17 +556,23 @@ help_string_append(const char *name, void *opaque)
     g_string_append_printf(str, "\n%s", name);
 }
 
-Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
-                                Error **errp)
+static const char *chardev_alias_translate(const char *name)
+{
+    int i;
+    for (i = 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
+        if (g_strcmp0(chardev_alias_table[i].alias, name) == 0) {
+            return chardev_alias_table[i].typename;
+        }
+    }
+    return name;
+}
+
+static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
     const ChardevClass *cc;
-    Chardev *chr;
-    int i;
     ChardevBackend *backend = NULL;
-    const char *name = qemu_opt_get(opts, "backend");
-    const char *id = qemu_opts_id(opts);
-    char *bid = NULL;
+    const char *name = chardev_alias_translate(qemu_opt_get(opts, "backend"));
 
     if (name == NULL) {
         error_setg(errp, "chardev: \"%s\" missing backend",
@@ -574,7 +580,40 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         return NULL;
     }
 
-    if (is_help_option(name)) {
+    cc = char_get_class(name, errp);
+    if (cc == NULL) {
+        return NULL;
+    }
+
+    backend = g_new0(ChardevBackend, 1);
+    backend->type = CHARDEV_BACKEND_KIND_NULL;
+
+    if (cc->parse) {
+        cc->parse(opts, backend, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            qapi_free_ChardevBackend(backend);
+            return NULL;
+        }
+    } else {
+        ChardevCommon *ccom = g_new0(ChardevCommon, 1);
+        qemu_chr_parse_common(opts, ccom);
+        backend->u.null.data = ccom; /* Any ChardevCommon member would work */
+    }
+
+    return backend;
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
+    if (name && is_help_option(name)) {
         GString *str = g_string_new("");
 
         chardev_name_foreach(help_string_append, str);
@@ -589,38 +628,20 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         return NULL;
     }
 
-    for (i = 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
-        if (g_strcmp0(chardev_alias_table[i].alias, name) == 0) {
-            name = chardev_alias_table[i].typename;
-            break;
-        }
+    backend = qemu_chr_parse_opts(opts, errp);
+    if (backend == NULL) {
+        return NULL;
     }
 
     cc = char_get_class(name, errp);
     if (cc == NULL) {
-        return NULL;
+        goto out;
     }
 
-    backend = g_new0(ChardevBackend, 1);
-    backend->type = CHARDEV_BACKEND_KIND_NULL;
-
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         bid = g_strdup_printf("%s-base", id);
     }
 
-    chr = NULL;
-    if (cc->parse) {
-        cc->parse(opts, backend, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            goto out;
-        }
-    } else {
-        ChardevCommon *ccom = g_new0(ChardevCommon, 1);
-        qemu_chr_parse_common(opts, ccom);
-        backend->u.null.data = ccom; /* Any ChardevCommon member would work */
-    }
-
     chr = qemu_chardev_new(bid ? bid : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
                            backend, errp);
-- 
2.7.4
