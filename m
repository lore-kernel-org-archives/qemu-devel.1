Received: from eggs.gnu.org ([2001:4830:134:3::10]:33740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rB-0005It-V3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r8-0004C7-Py
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:26 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r8-0004Bn-Gu
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:22 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so58624368wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:37 +0100
Message-Id: <1485524749-118532-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/41] char: introduce generic
 qemu_chr_get_kind()
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

This allows to remove the "is_mux" field from CharDriverState.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/char.h | 15 +++++++++++++--
 monitor.c             |  2 +-
 qemu-char.c           | 21 ++++++++++-----------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 2dd0564..7d841ad 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -96,7 +96,6 @@ struct CharDriverState {
     char *filename;
     int logfd;
     int be_open;
-    int is_mux;
     guint fd_in_tag;
     bool replay;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
@@ -455,7 +454,19 @@ void qemu_chr_be_generic_open(CharDriverState *s);
 void qemu_chr_fe_accept_input(CharBackend *be);
 int qemu_chr_add_client(CharDriverState *s, int fd);
 CharDriverState *qemu_chr_find(const char *name);
-bool chr_is_ringbuf(const CharDriverState *chr);
+
+/**
+ * @qemu_chr_get_kind:
+ *
+ * Returns the kind of char backend, or -1 if unspecified.
+ */
+ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr);
+
+static inline bool qemu_chr_is_ringbuf(const CharDriverState *chr)
+{
+    return qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_RINGBUF ||
+        qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_MEMORY;
+}
 
 bool qemu_chr_has_feature(CharDriverState *chr,
                           CharDriverFeature feature);
diff --git a/monitor.c b/monitor.c
index 6ac4e95..24add02 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3196,7 +3196,7 @@ static void ringbuf_completion(ReadLineState *rs, const char *str)
 
         if (!strncmp(chr_info->label, str, len)) {
             CharDriverState *chr = qemu_chr_find(chr_info->label);
-            if (chr && chr_is_ringbuf(chr)) {
+            if (chr && qemu_chr_is_ringbuf(chr)) {
                 readline_add_completion(rs, chr_info->label);
             }
         }
diff --git a/qemu-char.c b/qemu-char.c
index 4719ad6..a7afb59 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -781,7 +781,7 @@ static void muxes_realize_done(Notifier *notifier, void *unused)
     CharDriverState *chr;
 
     QTAILQ_FOREACH(chr, &chardevs, next) {
-        if (chr->is_mux) {
+        if (qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_MUX) {
             MuxDriver *d = chr->opaque;
             int i;
 
@@ -888,7 +888,6 @@ static CharDriverState *qemu_chr_open_mux(const CharDriver *driver,
      * set of muxes
      */
     *be_opened = muxes_realized;
-    chr->is_mux = 1;
     if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
         qemu_chr_free(chr);
         return NULL;
@@ -906,7 +905,7 @@ bool qemu_chr_fe_init(CharBackend *b, CharDriverState *s, Error **errp)
 {
     int tag = 0;
 
-    if (s->is_mux) {
+    if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
         MuxDriver *d = s->opaque;
 
         if (d->mux_cnt >= MAX_MUX) {
@@ -933,7 +932,7 @@ unavailable:
 
 static bool qemu_chr_is_busy(CharDriverState *s)
 {
-    if (s->is_mux) {
+    if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
         MuxDriver *d = s->opaque;
         return d->mux_cnt >= 0;
     } else {
@@ -950,7 +949,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
         if (b->chr->be == b) {
             b->chr->be = NULL;
         }
-        if (b->chr->is_mux) {
+        if (qemu_chr_get_kind(b->chr) == CHARDEV_BACKEND_KIND_MUX) {
             MuxDriver *d = b->chr->opaque;
             d->backends[b->tag] = NULL;
         }
@@ -1001,7 +1000,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         }
     }
 
-    if (s->is_mux) {
+    if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
         mux_chr_set_handlers(s, context);
     }
 }
@@ -1012,7 +1011,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
         return;
     }
 
-    if (b->chr->is_mux) {
+    if (qemu_chr_get_kind(b->chr) == CHARDEV_BACKEND_KIND_MUX) {
         mux_set_focus(b->chr, b->tag);
     }
 }
@@ -3559,9 +3558,9 @@ fail:
     return NULL;
 }
 
-bool chr_is_ringbuf(const CharDriverState *chr)
+ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr)
 {
-    return chr->driver->chr_write == ringbuf_chr_write;
+    return chr->driver->kind;
 }
 
 void qmp_ringbuf_write(const char *device, const char *data,
@@ -3579,7 +3578,7 @@ void qmp_ringbuf_write(const char *device, const char *data,
         return;
     }
 
-    if (!chr_is_ringbuf(chr)) {
+    if (!qemu_chr_is_ringbuf(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return;
     }
@@ -3623,7 +3622,7 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
         return NULL;
     }
 
-    if (!chr_is_ringbuf(chr)) {
+    if (!qemu_chr_is_ringbuf(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return NULL;
     }
-- 
1.8.3.1
