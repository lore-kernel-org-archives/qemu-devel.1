Received: from eggs.gnu.org ([2001:4830:134:3::10]:58926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRV-0000gq-J0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRN-0001X6-1T
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuRH-0001SN-Ja
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:38 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:11 +0400
Message-Id: <20181114123643.24091-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 09/41] slirp: add a set_nonblock()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qemu_set_nonblock() does some event registration with the main loop on
win32, let's have a callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 1 +
 net/slirp.c      | 1 +
 slirp/misc.c     | 2 +-
 slirp/tcp_subr.c | 4 ++--
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 88185e6c33..f2e7f94ebb 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -20,6 +20,7 @@ typedef struct SlirpCb {
                       SlirpTimerCb cb, void *opaque);
     void (*timer_free)(void *timer);
     void (*timer_mod)(void *timer, int64_t expire_timer);
+    void (*set_nonblock)(int fd);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index 7b28886802..5ea8c255f6 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -190,6 +190,7 @@ static SlirpCb slirp_cb =3D {
     .timer_new =3D net_slirp_timer_new,
     .timer_free =3D net_slirp_timer_free,
     .timer_mod =3D net_slirp_timer_mod,
+    .set_nonblock =3D qemu_set_nonblock,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/misc.c b/slirp/misc.c
index 7972b9b05b..dd2b3512a8 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -174,7 +174,7 @@ fork_exec(struct socket *so, const char *ex)
     socket_set_fast_reuse(so->s);
     opt =3D 1;
     qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
-    qemu_set_nonblock(so->s);
+    so->slirp->cb->set_nonblock(so->s);
     return 1;
 }
 #endif
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 4b40850c7a..8d97f1f54e 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -412,7 +412,7 @@ int tcp_fconnect(struct socket *so, unsigned short af=
)
     int opt, s=3Dso->s;
     struct sockaddr_storage addr;
=20
-    qemu_set_nonblock(s);
+    so->slirp->cb->set_nonblock(s);
     socket_set_fast_reuse(s);
     opt =3D 1;
     qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
@@ -484,7 +484,7 @@ void tcp_connect(struct socket *inso)
         tcp_close(sototcpcb(so)); /* This will sofree() as well */
         return;
     }
-    qemu_set_nonblock(s);
+    so->slirp->cb->set_nonblock(s);
     socket_set_fast_reuse(s);
     opt =3D 1;
     qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
--=20
2.19.1.708.g4ede3d42df
