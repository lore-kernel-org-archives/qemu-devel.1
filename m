Received: from eggs.gnu.org ([2001:4830:134:3::10]:58089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciINs-0004IT-HK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciINn-0006O4-Gp
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:18:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ciINn-0006N1-86
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:18:19 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 14:18:11 +0400
Message-Id: <20170227101811.22722-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] vhost-user: delay vhost_user_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
may trigger a disconnect events, calling vhost_user_stop() and clearing
all the vhost_dev strutures holding data that vhost.c functions expect
to remain valid. Delay the cleanup to keep the vhost_dev structure
valid during the vhost.c functions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/vhost-user.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++=
------
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 77b8110f8c..028bf0cf5d 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -25,6 +25,7 @@ typedef struct VhostUserState {
     guint watch;
     uint64_t acked_features;
     bool started;
+    QEMUBH *chr_closed_bh;
 } VhostUserState;
=20
 VHostNetState *vhost_user_get_vhost_net(NetClientState *nc)
@@ -190,9 +191,45 @@ static gboolean net_vhost_user_watch(GIOChannel *cha=
n, GIOCondition cond,
=20
     qemu_chr_fe_disconnect(&s->chr);
=20
+    s->watch =3D 0;
     return FALSE;
 }
=20
+static void net_vhost_user_event(void *opaque, int event);
+
+static void chr_closed_bh(void *opaque)
+{
+    const char *name =3D opaque;
+    NetClientState *ncs[MAX_QUEUE_NUM];
+    VhostUserState *s;
+    Error *err =3D NULL;
+    int queues;
+
+    queues =3D qemu_find_net_clients_except(name, ncs,
+                                          NET_CLIENT_DRIVER_NIC,
+                                          MAX_QUEUE_NUM);
+    assert(queues < MAX_QUEUE_NUM);
+
+    s =3D DO_UPCAST(VhostUserState, nc, ncs[0]);
+
+    qmp_set_link(name, false, &err);
+    vhost_user_stop(queues, ncs);
+    if (s->watch) {
+        g_source_remove(s->watch);
+    }
+    s->watch =3D 0;
+
+    qemu_bh_delete(s->chr_closed_bh);
+    s->chr_closed_bh =3D NULL;
+
+    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
+                             opaque, NULL, true);
+
+    if (err) {
+        error_report_err(err);
+    }
+}
+
 static void net_vhost_user_event(void *opaque, int event)
 {
     const char *name =3D opaque;
@@ -212,20 +249,27 @@ static void net_vhost_user_event(void *opaque, int =
event)
     trace_vhost_user_event(chr->label, event);
     switch (event) {
     case CHR_EVENT_OPENED:
-        s->watch =3D qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
-                                         net_vhost_user_watch, s);
         if (vhost_user_start(queues, ncs, &s->chr) < 0) {
             qemu_chr_fe_disconnect(&s->chr);
             return;
         }
+        s->watch =3D qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
+                                         net_vhost_user_watch, s);
         qmp_set_link(name, true, &err);
+        s->chr_closed_bh =3D qemu_bh_new(chr_closed_bh, opaque);
         s->started =3D true;
         break;
     case CHR_EVENT_CLOSED:
-        qmp_set_link(name, false, &err);
-        vhost_user_stop(queues, ncs);
-        g_source_remove(s->watch);
-        s->watch =3D 0;
+        /* a close event may happen during a read/write, but vhost
+         * code assumes the vhost_dev remains setup, so delay the
+         * stop & clear to idle.
+         * FIXME: better handle failure in vhost code, remove bh
+         */
+        if (s->chr_closed_bh) {
+            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL,
+                                     NULL, NULL, false);
+            qemu_bh_schedule(s->chr_closed_bh);
+        }
         break;
     }
=20
--=20
2.12.0.rc2.3.gc93709801
