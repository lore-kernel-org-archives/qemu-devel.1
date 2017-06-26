Received: from eggs.gnu.org ([2001:4830:134:3::10]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXA3-00024j-NM
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXA0-0002tU-HI
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:51 -0400
Received: from mail-eopbgr50109.outbound.protection.outlook.com
	([40.107.5.109]:28420
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dPXA0-0002sp-22
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:48 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 26 Jun 2017 19:45:40 +0300
Message-Id: <1498495550-72357-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 03/13] char: chardevice hotswap
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

This patch adds a possibility to change a char device without a frontend
removal.

1. Ideally, it would have to happen transparently to a frontend, i.e.
frontend would continue its regular operation.
However, backends are not stateless and are set up by the frontends
via qemu_chr_fe_<> functions, and it's not (generally) possible to replay
that setup entirely in a backend code, as different chardevs respond
to the setup calls differently, so do frontends work differently basing
on those setup responses.
Moreover, some frontend can generally get and save the backend pointer
(qemu_chr_fe_get_driver()), and it will become invalid after backend change.

So, a frontend which would like to support chardev hotswap has to register
a "backend change" handler, and redo its backend setup there.

2. Write path can be used by multiple threads and thus protected with
chr_write_lock.
So hotswap also has to be protected so write functions won't access
a backend being replaced.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/chardev/char-fe.h | 17 ++++++++++
 include/chardev/char.h    |  9 +++++
 chardev/char-fe.c         | 33 +++++++++++++-----
 chardev/char.c            | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json          | 40 ++++++++++++++++++++++
 5 files changed, 176 insertions(+), 9 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 9f38060..0314870 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -10,6 +10,12 @@ typedef int BackendChangeHandler(void *opaque);
  * Chardev */
 struct CharBackend {
     Chardev *chr;
+    /* chr_lock is used to ensure thread-safety of operations with
+     * the associated Chardev.
+     * There is no guarantee otherwise, generally, that *chr won't become
+     * invalid.
+     */
+    QemuMutex chr_lock;
     IOEventHandler *chr_event;
     IOCanReadHandler *chr_can_read;
     IOReadHandler *chr_read;
@@ -42,6 +48,17 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
 void qemu_chr_fe_deinit(CharBackend *b, bool del);
 
 /**
+ * @qemu_chr_fe_connect:
+ *
+ * Connects the already initialized front end with a given Chardev.
+ * Call qemu_chr_fe_deinit() to remove the association and
+ * release the driver.
+ *
+ * Returns: false on error.
+ */
+bool qemu_chr_fe_connect(CharBackend *b, Chardev *s, Error **errp);
+
+/**
  * @qemu_chr_fe_get_driver:
  *
  * Returns the driver associated with a CharBackend or NULL if no
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 8a9ade4..22fd734 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -93,6 +93,15 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
 Chardev *qemu_chr_new(const char *label, const char *filename);
 
 /**
+ * @qemu_chr_change:
+ *
+ * Change an existing character backend
+ *
+ * @opts the new backend options
+ */
+void qemu_chr_change(QemuOpts *opts, Error **errp);
+
+/**
  * @qemu_chr_cleanup:
  *
  * Delete all chardevs (when leaving qemu)
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 7054863..86a878b 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -33,24 +33,28 @@
 
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
-    Chardev *s = be->chr;
+    int ret = 0;
 
-    if (!s) {
-        return 0;
+    qemu_mutex_lock(&be->chr_lock);
+    if (be->chr) {
+        ret = qemu_chr_write(be->chr, buf, len, false);
     }
+    qemu_mutex_unlock(&be->chr_lock);
 
-    return qemu_chr_write(s, buf, len, false);
+    return ret;
 }
 
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
 {
-    Chardev *s = be->chr;
+    int ret = 0;
 
-    if (!s) {
-        return 0;
+    qemu_mutex_lock(&be->chr_lock);
+    if (be->chr) {
+        ret = qemu_chr_write(be->chr, buf, len, true);
     }
+    qemu_mutex_unlock(&be->chr_lock);
 
-    return qemu_chr_write(s, buf, len, true);
+    return ret;
 }
 
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
@@ -182,7 +186,7 @@ Chardev *qemu_chr_fe_get_driver(CharBackend *be)
     return be->chr;
 }
 
-bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
+bool qemu_chr_fe_connect(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag = 0;
 
@@ -211,6 +215,16 @@ unavailable:
     return false;
 }
 
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
+{
+    if (!qemu_chr_fe_connect(b, s, errp)) {
+        return false;
+    }
+
+    qemu_mutex_init(&b->chr_lock);
+    return true;
+}
+
 void qemu_chr_fe_deinit(CharBackend *b, bool del)
 {
     assert(b);
@@ -228,6 +242,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
             object_unparent(OBJECT(b->chr));
         }
         b->chr = NULL;
+        qemu_mutex_destroy(&b->chr_lock);
     }
 }
 
diff --git a/chardev/char.c b/chardev/char.c
index f8817c5..6b2cb7b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -951,6 +951,92 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
     return ret;
 }
 
+ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
+                                  Error **errp)
+{
+    CharBackend *be;
+    const ChardevClass *cc;
+    Chardev *chr, *chr_new;
+    bool closed_sent = false;
+    ChardevReturn *ret;
+
+    chr = qemu_chr_find(id);
+    if (!chr) {
+        error_setg(errp, "Chardev '%s' does not exist", id);
+        return NULL;
+    }
+
+    if (CHARDEV_IS_MUX(chr)) {
+        error_setg(errp, "Mux device hotswap not supported yet");
+        return NULL;
+    }
+
+    if (qemu_chr_replay(chr)) {
+        error_setg(errp,
+            "Chardev '%s' cannot be changed in record/replay mode", id);
+        return NULL;
+    }
+
+    be = chr->be;
+    if (!be) {
+        /* easy case */
+        object_unparent(OBJECT(chr));
+        return qmp_chardev_add(id, backend, errp);
+    }
+
+    if (!be->chr_be_change) {
+        error_setg(errp, "Chardev user does not support chardev hotswap");
+        return NULL;
+    }
+
+    cc = char_get_class(ChardevBackendKind_lookup[backend->type], errp);
+    if (!cc) {
+        return NULL;
+    }
+
+    chr_new = qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLASS(cc)),
+                               backend, errp);
+    if (!chr_new) {
+        return NULL;
+    }
+    chr_new->label = g_strdup(id);
+
+    if (chr->be_open && !chr_new->be_open) {
+        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        closed_sent = true;
+    }
+
+    qemu_mutex_lock(&be->chr_lock);
+    chr->be = NULL;
+    qemu_chr_fe_connect(be, chr_new, &error_abort);
+
+    if (be->chr_be_change(be->opaque) < 0) {
+        error_setg(errp, "Chardev '%s' change failed", chr_new->label);
+        chr_new->be = NULL;
+        qemu_chr_fe_connect(be, chr, &error_abort);
+        qemu_mutex_unlock(&be->chr_lock);
+        if (closed_sent) {
+            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+        }
+        object_unref(OBJECT(chr_new));
+        return NULL;
+    }
+    qemu_mutex_unlock(&be->chr_lock);
+
+    object_unparent(OBJECT(chr));
+    object_property_add_child(get_chardevs_root(), chr_new->label,
+                              OBJECT(chr_new), &error_abort);
+    object_unref(OBJECT(chr_new));
+
+    ret = g_new0(ChardevReturn, 1);
+    if (CHARDEV_IS_PTY(chr_new)) {
+        ret->pty = g_strdup(chr_new->filename + 4);
+        ret->has_pty = true;
+    }
+
+    return ret;
+}
+
 void qmp_chardev_remove(const char *id, Error **errp)
 {
     Chardev *chr;
diff --git a/qapi-schema.json b/qapi-schema.json
index 4b50b65..1a39911 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5095,6 +5095,46 @@
   'returns': 'ChardevReturn' }
 
 ##
+# @chardev-change:
+#
+# Change a character device backend
+#
+# @id: the chardev's ID, must exist
+# @backend: new backend type and parameters
+#
+# Returns: ChardevReturn.
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "execute" : "chardev-change",
+#      "arguments" : { "id" : "baz",
+#                      "backend" : { "type" : "pty", "data" : {} } } }
+# <- { "return": { "pty" : "/dev/pty/42" } }
+#
+# -> {"execute" : "chardev-change",
+#     "arguments" : {
+#         "id" : "charchannel2",
+#         "backend" : {
+#             "type" : "socket",
+#             "data" : {
+#                 "addr" : {
+#                     "type" : "unix" ,
+#                     "data" : {
+#                         "path" : "/tmp/charchannel2.socket"
+#                     }
+#                  },
+#                  "server" : true,
+#                  "wait" : false }}}}
+# <- {"return": {}}
+#
+##
+{ 'command': 'chardev-change', 'data': {'id'      : 'str',
+                                        'backend' : 'ChardevBackend' },
+  'returns': 'ChardevReturn' }
+
+##
 # @chardev-remove:
 #
 # Remove a character device backend
-- 
2.7.4
