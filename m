Received: from eggs.gnu.org ([2001:4830:134:3::10]:50262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cbqbN-0004tw-SA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cbqbK-0003Fl-44
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:41 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:32982 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cbqbJ-0003F9-5R
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:37 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu,  9 Feb 2017 18:25:33 +0300
Message-Id: <1486653934-14805-2-git-send-email-den@openvz.org>
In-Reply-To: <1486653934-14805-1-git-send-email-den@openvz.org>
References: <1486653934-14805-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

This patch adds a possibility to change a char device without a frontend
removal.

Ideally, it would have to happen transparently to a frontend, i.e. fronte=
nd
would continue its regular operation. However, backends are not stateles
and are set up by the frontends via qemu_chr_fe_<> functions, and it's no=
t
(generally) possible to replay that setup entirely in a backend code, as
different chardevs respond to the setup calls differently, so do frontend=
s
work differently basing on those setup responses. Moreover, some frontend
can generally get and save the backend pointer (qemu_chr_fe_get_driver())=
,
and it will become invalid after backend change.

So, a frontend which would like to support chardev hotswap has to registe=
r
a "backend change" handler, and redo its backend setup there.

Write path can be used by multiple threads and thus protected with
chr_write_lock. So hotswap also has to be protected so write functions
won't access a backend being replaced.

3. Hotswap function can be called from e.g. a read handler of a monitor
socket. This can cause troubles so it's safer to defer execution to
a bottom-half. (however, it means we cannot return some of the errors
synchronously - but most of them we can)

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
---
 chardev/char.c        | 161 ++++++++++++++++++++++++++++++++++++++++++++=
+++---
 hmp.c                 |  14 +++++
 include/sysemu/char.h |  25 ++++++++
 3 files changed, 191 insertions(+), 9 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index abd525f..ec52b52 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -136,12 +136,16 @@ static bool qemu_chr_replay(Chardev *chr)
=20
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
-    Chardev *s =3D be->chr;
+    Chardev *s;
     ChardevClass *cc;
     int ret;
=20
+    qemu_mutex_lock(&be->chr_lock);
+    s =3D be->chr;
+
     if (!s) {
-        return 0;
+        ret =3D 0;
+        goto end;
     }
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
@@ -149,7 +153,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
         replay_char_write_event_load(&ret, &offset);
         assert(offset <=3D len);
         qemu_chr_fe_write_buffer(s, buf, offset, &offset);
-        return ret;
+        goto end;
     }
=20
     cc =3D CHARDEV_GET_CLASS(s);
@@ -165,7 +169,9 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(ret, ret < 0 ? 0 : ret);
     }
-   =20
+
+end:
+    qemu_mutex_unlock(&be->chr_lock);
     return ret;
 }
=20
@@ -195,13 +201,16 @@ int qemu_chr_write_all(Chardev *s, const uint8_t *b=
uf, int len)
=20
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
 {
-    Chardev *s =3D be->chr;
+    Chardev *s;
+    int ret;
=20
-    if (!s) {
-        return 0;
-    }
+    qemu_mutex_lock(&be->chr_lock);
+
+    s =3D be->chr;
+    ret =3D s ? qemu_chr_write_all(s, buf, len) : 0;
=20
-    return qemu_chr_write_all(s, buf, len);
+    qemu_mutex_unlock(&be->chr_lock);
+    return ret;
 }
=20
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
@@ -505,6 +514,10 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Er=
ror **errp)
=20
     b->fe_open =3D false;
     b->tag =3D tag;
+
+    if (!b->chr) {
+        qemu_mutex_init(&b->chr_lock);
+    }
     b->chr =3D s;
     return true;
=20
@@ -537,9 +550,22 @@ void qemu_chr_fe_deinit(CharBackend *b)
             d->backends[b->tag] =3D NULL;
         }
         b->chr =3D NULL;
+        qemu_mutex_destroy(&b->chr_lock);
+        if (b->hotswap_bh) {
+            qemu_bh_delete(b->hotswap_bh);
+        }
     }
 }
=20
+void qemu_chr_fe_set_be_change_handler(CharBackend *b,
+                                       BackendChangeHandler *be_change)
+{
+    if (!b->chr) {
+        return;
+    }
+    b->chr_be_change =3D be_change;
+}
+
 void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
                               IOReadHandler *fd_read,
@@ -875,6 +901,123 @@ help_string_append(const char *name, void *opaque)
     g_string_append_printf(str, "\n%s", name);
 }
=20
+#define CHARDEV_CHANGE_PREFIX "tmp-chardev-xchg-"
+
+static void qemu_chr_change_bh(void *opaque)
+{
+    char *id =3D opaque;
+    char *tmpid =3D g_strdup_printf(CHARDEV_CHANGE_PREFIX "%s", id);
+    Chardev *chr =3D qemu_chr_find(id);
+    Chardev *chr_new =3D qemu_chr_find(tmpid);
+    CharBackend *be =3D chr->be;
+    bool closed_sent =3D false;
+
+    if (be) {
+        if (chr->be_open && !chr_new->be_open) {
+            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+            closed_sent =3D true;
+        }
+
+        qemu_mutex_lock(&be->chr_lock);
+        qemu_chr_fe_init(be, chr_new, &error_abort);
+
+        if (be->chr_be_change(be->opaque) < 0) {
+            fprintf(stderr, "Chardev '%s' change failed", id);
+            qemu_chr_fe_init(be, chr, &error_abort);
+            qemu_mutex_unlock(&be->chr_lock);
+            if (closed_sent) {
+                qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+            }
+            qemu_chr_delete(chr_new);
+            g_free(id);
+            g_free(tmpid);
+            return;
+        }
+        qemu_mutex_unlock(&be->chr_lock);
+
+        chr->be =3D NULL;
+    }
+
+    qemu_chr_delete(chr);
+    g_free(chr_new->label);
+    chr_new->label =3D id;
+    g_free(tmpid);
+}
+
+void qemu_chr_change(QemuOpts *opts, Error **errp)
+{
+    const char *be_name =3D qemu_opt_get(opts, "backend");
+    const char *id =3D qemu_opts_id(opts);
+    char *tmpid;
+    Chardev *chr, *chr_new;
+    const ChardevClass *cc;
+    int i;
+
+    if (!id) {
+        error_setg(errp, "chardev: no id specified");
+        return;
+    }
+
+    chr =3D qemu_chr_find(id);
+    if (!chr) {
+        error_setg(errp, "Chardev '%s' does not exist", id);
+        return;
+    }
+
+    if (!be_name) {
+        error_setg(errp, "chardev: '%s' missing backend", id);
+        return;
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
+        if (g_strcmp0(chardev_alias_table[i].alias, be_name) =3D=3D 0) {
+            be_name =3D chardev_alias_table[i].typename;
+            break;
+        }
+    }
+
+    cc =3D char_get_class(be_name, errp);
+    if (!cc) {
+        return;
+    }
+
+    if (chr->be && !chr->be->chr_be_change) {
+        error_setg(errp, "Chardev user does not support chardev hotswap"=
);
+        return;
+    }
+
+    if (qemu_chr_replay(chr)) {
+        error_setg(errp,
+            "Chardev '%s' cannot be changed in record/replay mode", id);
+        return;
+    }
+
+    if (CHARDEV_IS_MUX(chr)) {
+        error_setg(errp, "Mux device hotswap not supported yet");
+        return;
+    }
+
+    tmpid =3D g_strdup_printf(CHARDEV_CHANGE_PREFIX "%s", id);
+    qemu_opts_set_id(opts, tmpid);
+    chr_new =3D qemu_chr_new_from_opts(opts, errp);
+    qemu_opts_set_id(opts, (char *)id);
+    g_free(tmpid);
+
+    if (!chr_new) {
+        return;
+    }
+
+    if (chr->be) {
+        if (chr->be->hotswap_bh) {
+            qemu_bh_delete(chr->be->hotswap_bh);
+        }
+        chr->be->hotswap_bh =3D qemu_bh_new(qemu_chr_change_bh, g_strdup=
(id));
+        qemu_bh_schedule(chr->be->hotswap_bh);
+    } else {
+        qemu_chr_change_bh(g_strdup(id));
+    }
+}
+
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
                                 Error **errp)
 {
diff --git a/hmp.c b/hmp.c
index 2bc4f06..70252df 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1522,6 +1522,20 @@ void hmp_change(Monitor *mon, const QDict *qdict)
             }
         }
         qmp_change("vnc", target, !!arg, arg, &err);
+    } else if (strcmp(device, "chardev") =3D=3D 0) {
+        QemuOpts *opts;
+
+        if (arg =3D=3D NULL) {
+            arg =3D "";
+        }
+        opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"), arg,=
 true);
+        if (opts =3D=3D NULL) {
+            error_setg(&err, "Parsing chardev args failed");
+        } else {
+            qemu_opts_set_id(opts, g_strdup(target));
+            qemu_chr_change(opts, &err);
+            qemu_opts_del(opts);
+        }
     } else {
         if (read_only) {
             read_only_mode =3D
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 450881d..3e99953 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -56,6 +56,7 @@ struct ParallelIOArg {
 #define CHR_TIOCM_RTS	0x004
=20
 typedef void IOEventHandler(void *opaque, int event);
+typedef int BackendChangeHandler(void *opaque);
=20
 typedef enum {
     /* Whether the chardev peer is able to close and
@@ -79,9 +80,12 @@ typedef struct CharBackend {
     IOEventHandler *chr_event;
     IOCanReadHandler *chr_can_read;
     IOReadHandler *chr_read;
+    BackendChangeHandler *chr_be_change;
     void *opaque;
     int tag;
     int fe_open;
+    QemuMutex chr_lock;
+    QEMUBH *hotswap_bh;
 } CharBackend;
=20
 struct Chardev {
@@ -132,6 +136,14 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCo=
mmon *backend);
  */
 Chardev *qemu_chr_new(const char *label, const char *filename);
=20
+/**
+ * @qemu_chr_change:
+ *
+ * Change an existing character backend
+ *
+ * @opts the new backend options
+ */
+void qemu_chr_change(QemuOpts *opts, Error **errp);
=20
 /**
  * @qemu_chr_fe_disconnect:
@@ -419,6 +431,19 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               bool set_open);
=20
 /**
+ * @qemu_chr_fe_set_be_change_handler:
+ * @be_change: backend change callback
+ *
+ * Set the front end handler for the backend hotswap.
+ * If the handler is not set or set to NULL, no backend hotswap will
+ * be performed.
+ *
+ * Without associated Chardev, nothing is changed.
+ */
+void qemu_chr_fe_set_be_change_handler(CharBackend *b,
+                                       BackendChangeHandler *be_change);
+
+/**
  * @qemu_chr_fe_take_focus:
  *
  * Take the focus (if the front end is muxed).
--=20
2.7.4
