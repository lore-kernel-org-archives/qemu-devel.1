Received: from eggs.gnu.org ([2001:4830:134:3::10]:47303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XC-0005Ce-3F
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XA-0007oy-SK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0XA-0007oZ-Jm
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:32 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B658831B305
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:48:00 +0100
Message-Id: <20170110174810.17748-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/20] char: use a feature bit for replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use a feature flag rather than a structure field for "replay".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/char.h |  3 ++-
 qemu-char.c           | 33 ++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 7d841ad879..b0b4231d4c 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -69,6 +69,8 @@ typedef enum {
     /* Whether it is possible to send/recv file descriptors
      * over the data channel */
     QEMU_CHAR_FEATURE_FD_PASS,
+    /* Whether replay or record mode is enabled */
+    QEMU_CHAR_FEATURE_REPLAY,
=20
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
index a9ef28c370..0976d94c1f 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -277,6 +277,11 @@ static int qemu_chr_fe_write_buffer(CharDriverState =
*s, const uint8_t *buf, int
     return res;
 }
=20
+static bool qemu_chr_replay(CharDriverState *chr)
+{
+    return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
+}
+
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
     CharDriverState *s =3D be->chr;
@@ -286,7 +291,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
         return 0;
     }
=20
-    if (s->replay && replay_mode =3D=3D REPLAY_MODE_PLAY) {
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
         int offset;
         replay_char_write_event_load(&ret, &offset);
         assert(offset <=3D len);
@@ -303,7 +308,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
=20
     qemu_mutex_unlock(&s->chr_write_lock);
    =20
-    if (s->replay && replay_mode =3D=3D REPLAY_MODE_RECORD) {
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(ret, ret < 0 ? 0 : ret);
     }
    =20
@@ -315,7 +320,7 @@ static int qemu_chr_write_all(CharDriverState *s, con=
st uint8_t *buf, int len)
     int offset;
     int res;
=20
-    if (s->replay && replay_mode =3D=3D REPLAY_MODE_PLAY) {
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
         replay_char_write_event_load(&res, &offset);
         assert(offset <=3D len);
         qemu_chr_fe_write_buffer(s, buf, offset, &offset);
@@ -324,7 +329,7 @@ static int qemu_chr_write_all(CharDriverState *s, con=
st uint8_t *buf, int len)
=20
     res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset);
=20
-    if (s->replay && replay_mode =3D=3D REPLAY_MODE_RECORD) {
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
     }
=20
@@ -355,7 +360,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
         return 0;
     }
=20
-    if (s->replay && replay_mode =3D=3D REPLAY_MODE_PLAY) {
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
         return replay_char_read_all_load(buf);
     }
=20
@@ -372,7 +377,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
         }
=20
         if (res < 0) {
-            if (s->replay && replay_mode =3D=3D REPLAY_MODE_RECORD) {
+            if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_REC=
ORD) {
                 replay_char_read_all_save_error(res);
             }
             return res;
@@ -385,7 +390,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
         }
     }
=20
-    if (s->replay && replay_mode =3D=3D REPLAY_MODE_RECORD) {
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_read_all_save_buf(buf, offset);
     }
     return offset;
@@ -396,7 +401,7 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void =
*arg)
     CharDriverState *s =3D be->chr;
     int res;
=20
-    if (!s || !s->driver->chr_ioctl || s->replay) {
+    if (!s || !s->driver->chr_ioctl || qemu_chr_replay(s)) {
         res =3D -ENOTSUP;
     } else {
         res =3D s->driver->chr_ioctl(s, cmd, arg);
@@ -427,7 +432,7 @@ void qemu_chr_be_write_impl(CharDriverState *s, uint8=
_t *buf, int len)
=20
 void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
 {
-    if (s->replay) {
+    if (qemu_chr_replay(s)) {
         if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
             return;
         }
@@ -442,7 +447,7 @@ int qemu_chr_fe_get_msgfd(CharBackend *be)
     CharDriverState *s =3D be->chr;
     int fd;
     int res =3D (qemu_chr_fe_get_msgfds(be, &fd, 1) =3D=3D 1) ? fd : -1;
-    if (s && s->replay) {
+    if (s && qemu_chr_replay(s)) {
         fprintf(stderr,
                 "Replay: get msgfd is not supported for serial devices y=
et\n");
         exit(1);
@@ -4247,8 +4252,10 @@ CharDriverState *qemu_chr_new(const char *label, c=
onst char *filename)
     CharDriverState *chr;
     chr =3D qemu_chr_new_noreplay(label, filename);
     if (chr) {
-        chr->replay =3D replay_mode !=3D REPLAY_MODE_NONE;
-        if (chr->replay && chr->driver->chr_ioctl) {
+        if (replay_mode !=3D REPLAY_MODE_NONE) {
+            qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
+        }
+        if (qemu_chr_replay(chr) && chr->driver->chr_ioctl) {
             fprintf(stderr,
                     "Replay: ioctl is not supported for serial devices y=
et\n");
         }
@@ -4995,7 +5002,7 @@ void qmp_chardev_remove(const char *id, Error **err=
p)
         error_setg(errp, "Chardev '%s' is busy", id);
         return;
     }
-    if (chr->replay) {
+    if (qemu_chr_replay(chr)) {
         error_setg(errp,
             "Chardev '%s' cannot be unplugged in record/replay mode", id=
);
         return;
--=20
2.11.0
