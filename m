Received: from eggs.gnu.org ([2001:4830:134:3::10]:33676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r6-0005D0-36
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r4-00049K-Sa
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:20 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r4-00048T-JN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:18 -0500
Received: by mail-wj0-x241.google.com with SMTP id ip10so5994494wjb.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:34 +0100
Message-Id: <1485524749-118532-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/41] char: use a static array for backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Number and kinds of backends is known at compile-time, use a fixed-sized
static array to simplify iterations & lookups.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-char.c | 68 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 51558a7..464c69d 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -4101,21 +4101,20 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
     }
 }
 
-static GSList *backends;
+static const CharDriver *backends[CHARDEV_BACKEND_KIND__MAX];
 
 void register_char_driver(const CharDriver *driver)
 {
-    /* casting away const */
-    backends = g_slist_append(backends, (void *)driver);
+    backends[driver->kind] = driver;
 }
 
 CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
                                         Error **errp)
 {
     Error *local_err = NULL;
-    CharDriver *cd;
+    const CharDriver *cd = NULL;
     CharDriverState *chr;
-    GSList *i;
+    int i;
     ChardevReturn *ret = NULL;
     ChardevBackend *backend;
     const char *name = qemu_opt_get(opts, "backend");
@@ -4130,11 +4129,13 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
 
     if (is_help_option(name)) {
         fprintf(stderr, "Available chardev backend types:\n");
-        for (i = backends; i; i = i->next) {
-            cd = i->data;
-            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind]);
-            if (cd->alias) {
-                fprintf(stderr, "%s\n", cd->alias);
+        for (i = 0; i < ARRAY_SIZE(backends); i++) {
+            cd = backends[i];
+            if (cd) {
+                fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind]);
+                if (cd->alias) {
+                    fprintf(stderr, "%s\n", cd->alias);
+                }
             }
         }
         exit(0);
@@ -4145,15 +4146,17 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
         goto err;
     }
 
-    for (i = backends; i; i = i->next) {
-        cd = i->data;
-
+    for (i = 0; i < ARRAY_SIZE(backends); i++) {
+        cd = backends[i];
+        if (!cd) {
+            continue;
+        }
         if (g_strcmp0(ChardevBackendKind_lookup[cd->kind], name) == 0 ||
             g_strcmp0(cd->alias, name) == 0) {
             break;
         }
     }
-    if (i == NULL) {
+    if (i == ARRAY_SIZE(backends)) {
         error_setg(errp, "chardev: backend \"%s\" not found", name);
         goto err;
     }
@@ -4370,11 +4373,15 @@ qmp_prepend_backend(ChardevBackendInfoList *list, const char *name)
 ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
 {
     ChardevBackendInfoList *backend_list = NULL;
-    CharDriver *c;
-    GSList *i;
+    const CharDriver *c;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(backends); i++) {
+        c = backends[i];
+        if (!c) {
+            continue;
+        }
 
-    for (i = backends; i; i = i->next) {
-        c = i->data;
         backend_list = qmp_prepend_backend(backend_list,
                                            ChardevBackendKind_lookup[c->kind]);
         if (c->alias) {
@@ -4835,9 +4842,8 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
 {
     ChardevReturn *ret = g_new0(ChardevReturn, 1);
     CharDriverState *chr = NULL;
+    const CharDriver *cd;
     Error *local_err = NULL;
-    GSList *i;
-    CharDriver *cd;
     bool be_opened = true;
 
     chr = qemu_chr_find(id);
@@ -4846,22 +4852,16 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
         goto out_error;
     }
 
-    for (i = backends; i; i = i->next) {
-        cd = i->data;
-
-        if (cd->kind == backend->type) {
-            chr = cd->create(id, backend, ret, &be_opened, &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
-                goto out_error;
-            }
-            break;
-        }
+    cd = (int)backend->type >= 0 && backend->type < ARRAY_SIZE(backends) ?
+        backends[backend->type] : NULL;
+    if (cd == NULL) {
+        error_setg(errp, "chardev backend not available");
+        goto out_error;
     }
 
-    if (chr == NULL) {
-        assert(!i);
-        error_setg(errp, "chardev backend not available");
+    chr = cd->create(id, backend, ret, &be_opened, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         goto out_error;
     }
 
-- 
1.8.3.1
