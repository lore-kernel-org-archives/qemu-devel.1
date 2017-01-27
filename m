Received: from eggs.gnu.org ([2001:4830:134:3::10]:33739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rB-0005Is-V3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r9-0004CV-Ib
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:26 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r9-0004C3-9Q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:23 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so58441302wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:38 +0100
Message-Id: <1485524749-118532-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/41] char: use a feature bit for replay
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

Use a feature flag rather than a structure field for "replay".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/char.h |  3 ++-
 qemu-char.c           | 33 ++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 7d841ad..b0b4231 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -69,6 +69,8 @@ typedef enum {
     /* Whether it is possible to send/recv file descriptors
      * over the data channel */
     QEMU_CHAR_FEATURE_FD_PASS,
+    /* Whether replay or record mode is enabled */
+    QEMU_CHAR_FEATURE_REPLAY,
 
     QEMU_CHAR_FEATURE_LAST,
 } CharDriverFeature;
@@ -97,7 +99,6 @@ struct CharDriverState {
     int logfd;
     int be_open;
     guint fd_in_tag;
-    bool replay;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
     QTAILQ_ENTRY(CharDriverState) next;
 };
diff --git a/qemu-char.c b/qemu-char.c
index a7afb59..5d04d82 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -277,6 +277,11 @@ static int qemu_chr_fe_write_buffer(CharDriverState *s, const uint8_t *buf, int
     return res;
 }
 
+static bool qemu_chr_replay(CharDriverState *chr)
+{
+    return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
+}
+
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
     CharDriverState *s = be->chr;
@@ -286,7 +291,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
         return 0;
     }
 
-    if (s->replay && replay_mode == REPLAY_MODE_PLAY) {
+    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_PLAY) {
         int offset;
         replay_char_write_event_load(&ret, &offset);
         assert(offset <= len);
@@ -303,7 +308,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 
     qemu_mutex_unlock(&s->chr_write_lock);
     
-    if (s->replay && replay_mode == REPLAY_MODE_RECORD) {
+    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
         replay_char_write_event_save(ret, ret < 0 ? 0 : ret);
     }
     
@@ -315,7 +320,7 @@ static int qemu_chr_write_all(CharDriverState *s, const uint8_t *buf, int len)
     int offset;
     int res;
 
-    if (s->replay && replay_mode == REPLAY_MODE_PLAY) {
+    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_PLAY) {
         replay_char_write_event_load(&res, &offset);
         assert(offset <= len);
         qemu_chr_fe_write_buffer(s, buf, offset, &offset);
@@ -324,7 +329,7 @@ static int qemu_chr_write_all(CharDriverState *s, const uint8_t *buf, int len)
 
     res = qemu_chr_fe_write_buffer(s, buf, len, &offset);
 
-    if (s->replay && replay_mode == REPLAY_MODE_RECORD) {
+    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
     }
 
@@ -355,7 +360,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
         return 0;
     }
 
-    if (s->replay && replay_mode == REPLAY_MODE_PLAY) {
+    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_PLAY) {
         return replay_char_read_all_load(buf);
     }
 
@@ -372,7 +377,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
         }
 
         if (res < 0) {
-            if (s->replay && replay_mode == REPLAY_MODE_RECORD) {
+            if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
                 replay_char_read_all_save_error(res);
             }
             return res;
@@ -385,7 +390,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
         }
     }
 
-    if (s->replay && replay_mode == REPLAY_MODE_RECORD) {
+    if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
         replay_char_read_all_save_buf(buf, offset);
     }
     return offset;
@@ -396,7 +401,7 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
     CharDriverState *s = be->chr;
     int res;
 
-    if (!s || !s->driver->chr_ioctl || s->replay) {
+    if (!s || !s->driver->chr_ioctl || qemu_chr_replay(s)) {
         res = -ENOTSUP;
     } else {
         res = s->driver->chr_ioctl(s, cmd, arg);
@@ -427,7 +432,7 @@ void qemu_chr_be_write_impl(CharDriverState *s, uint8_t *buf, int len)
 
 void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
 {
-    if (s->replay) {
+    if (qemu_chr_replay(s)) {
         if (replay_mode == REPLAY_MODE_PLAY) {
             return;
         }
@@ -442,7 +447,7 @@ int qemu_chr_fe_get_msgfd(CharBackend *be)
     CharDriverState *s = be->chr;
     int fd;
     int res = (qemu_chr_fe_get_msgfds(be, &fd, 1) == 1) ? fd : -1;
-    if (s && s->replay) {
+    if (s && qemu_chr_replay(s)) {
         fprintf(stderr,
                 "Replay: get msgfd is not supported for serial devices yet\n");
         exit(1);
@@ -4249,8 +4254,10 @@ CharDriverState *qemu_chr_new(const char *label, const char *filename)
     CharDriverState *chr;
     chr = qemu_chr_new_noreplay(label, filename);
     if (chr) {
-        chr->replay = replay_mode != REPLAY_MODE_NONE;
-        if (chr->replay && chr->driver->chr_ioctl) {
+        if (replay_mode != REPLAY_MODE_NONE) {
+            qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
+        }
+        if (qemu_chr_replay(chr) && chr->driver->chr_ioctl) {
             fprintf(stderr,
                     "Replay: ioctl is not supported for serial devices yet\n");
         }
@@ -4997,7 +5004,7 @@ void qmp_chardev_remove(const char *id, Error **errp)
         error_setg(errp, "Chardev '%s' is busy", id);
         return;
     }
-    if (chr->replay) {
+    if (qemu_chr_replay(chr)) {
         error_setg(errp,
             "Chardev '%s' cannot be unplugged in record/replay mode", id);
         return;
-- 
1.8.3.1
