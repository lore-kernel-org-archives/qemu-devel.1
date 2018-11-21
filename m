Received: from eggs.gnu.org ([2001:4830:134:3::10]:51825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPahR-0006qj-8A
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPahP-0005h4-GN
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPahP-0005CB-45
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:19 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:43 +0400
Message-Id: <20181121220647.18844-27-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 26/30] slirp: add a
 set_nonblock() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qemu_set_nonblock() does some event registration with the main loop on
win32, let's have a callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 2 ++
 net/slirp.c      | 1 +
 slirp/misc.c     | 2 +-
 slirp/tcp_subr.c | 4 ++--
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 3e75dadfa3..e79a2d2b11 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -27,6 +27,8 @@ typedef struct SlirpCb {
     void (*timer_free)(void *timer);
     /* Modify a timer to expire at @expire_time */
     void (*timer_mod)(void *timer, int64_t expire_time);
+    /* Put a fd in nonblocking mode and register it for future polling *=
/
+    void (*set_nonblock)(int fd);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index f7cdf8398b..a31193a25a 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -193,6 +193,7 @@ static const SlirpCb slirp_cb =3D {
     .timer_new =3D net_slirp_timer_new,
     .timer_free =3D net_slirp_timer_free,
     .timer_mod =3D net_slirp_timer_mod,
+    .set_nonblock =3D qemu_set_nonblock,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/misc.c b/slirp/misc.c
index f9b2c64541..7789cefefa 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -172,7 +172,7 @@ fork_exec(struct socket *so, const char *ex)
     socket_set_fast_reuse(so->s);
     opt =3D 1;
     qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
-    qemu_set_nonblock(so->s);
+    so->slirp->cb->set_nonblock(so->s);
     return 1;
 }
 #endif
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 5dcf979c3c..3b15148187 100644
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
2.20.0.rc1
