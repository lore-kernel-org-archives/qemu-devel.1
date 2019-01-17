Received: from eggs.gnu.org ([209.51.188.92]:57327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66S-0005cl-Nj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66P-0004i2-0X
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66O-0004fg-O7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:52 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:41 +0400
Message-Id: <20190117114359.5164-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/27] slirp: replace qemu_set_nonblock()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Replace qemu_set_nonblock() with slirp_set_nonblock()

qemu_set_nonblock() does some event registration with the main
loop. Add a new callback register_poll_fd() for that reason.

Always build the fd-register stub, to avoid #if WIN32.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h    |  2 ++
 slirp/util.h        |  1 +
 net/slirp.c         |  6 ++++++
 slirp/misc.c        |  3 ++-
 slirp/tcp_subr.c    |  6 ++++--
 slirp/util.c        | 12 ++++++++++++
 stubs/Makefile.objs |  2 +-
 7 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 3e75dadfa31..70e99139bf6 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -27,6 +27,8 @@ typedef struct SlirpCb {
     void (*timer_free)(void *timer);
     /* Modify a timer to expire at @expire_time */
     void (*timer_mod)(void *timer, int64_t expire_time);
+    /* Register a fd for future polling */
+    void (*register_poll_fd)(int fd);
 } SlirpCb;
=20
=20
diff --git a/slirp/util.h b/slirp/util.h
index 050ca7f1a3f..782ae8ef0ee 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -66,6 +66,7 @@ int inet_aton(const char *cp, struct in_addr *ia);
 #endif
=20
 int slirp_socket(int domain, int type, int protocol);
+void slirp_set_nonblock(int fd);
=20
 static inline int slirp_socket_set_nodelay(int fd)
 {
diff --git a/net/slirp.c b/net/slirp.c
index c24a779425b..6f756a4dccc 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -186,6 +186,11 @@ static void net_slirp_timer_mod(void *timer, int64_t=
 expire_timer)
     timer_mod(timer, expire_timer);
 }
=20
+static void net_slirp_register_poll_fd(int fd)
+{
+    qemu_fd_register(fd);
+}
+
 static const SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
     .guest_error =3D net_slirp_guest_error,
@@ -193,6 +198,7 @@ static const SlirpCb slirp_cb =3D {
     .timer_new =3D net_slirp_timer_new,
     .timer_free =3D net_slirp_timer_free,
     .timer_mod =3D net_slirp_timer_mod,
+    .register_poll_fd =3D net_slirp_register_poll_fd,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/misc.c b/slirp/misc.c
index 32ec02a5251..4ee20a10e44 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -163,7 +163,8 @@ fork_exec(struct socket *so, const char *ex)
     slirp_socket_set_fast_reuse(so->s);
     opt =3D 1;
     slirp_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int))=
;
-    qemu_set_nonblock(so->s);
+    slirp_set_nonblock(so->s);
+    so->slirp->cb->register_poll_fd(so->s);
     return 1;
 }
=20
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 3567f320ff0..8087ffc047f 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -412,7 +412,8 @@ int tcp_fconnect(struct socket *so, unsigned short af=
)
     int opt, s=3Dso->s;
     struct sockaddr_storage addr;
=20
-    qemu_set_nonblock(s);
+    slirp_set_nonblock(s);
+    so->slirp->cb->register_poll_fd(so->s);
     slirp_socket_set_fast_reuse(s);
     opt =3D 1;
     slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
@@ -484,7 +485,8 @@ void tcp_connect(struct socket *inso)
         tcp_close(sototcpcb(so)); /* This will sofree() as well */
         return;
     }
-    qemu_set_nonblock(s);
+    slirp_set_nonblock(s);
+    so->slirp->cb->register_poll_fd(so->s);
     slirp_socket_set_fast_reuse(s);
     opt =3D 1;
     slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
diff --git a/slirp/util.c b/slirp/util.c
index b1a36b27bc5..499c5cea46f 100644
--- a/slirp/util.c
+++ b/slirp/util.c
@@ -43,6 +43,18 @@ int inet_aton(const char *cp, struct in_addr *ia)
 }
 #endif
=20
+void slirp_set_nonblock(int fd)
+{
+#ifndef _WIN32
+    int f;
+    f =3D fcntl(fd, F_GETFL);
+    fcntl(fd, F_SETFL, f | O_NONBLOCK);
+#else
+    unsigned long opt =3D 1;
+    ioctlsocket(fd, FIONBIO, &opt);
+#endif
+}
+
 static void slirp_set_cloexec(int fd)
 {
 #ifndef _WIN32
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5dd0aeeec69..cda0efa4e86 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -33,7 +33,7 @@ stub-obj-y +=3D trace-control.o
 stub-obj-y +=3D uuid.o
 stub-obj-y +=3D vm-stop.o
 stub-obj-y +=3D vmstate.o
-stub-obj-$(CONFIG_WIN32) +=3D fd-register.o
+stub-obj-y +=3D fd-register.o
 stub-obj-y +=3D qmp_memory_device.o
 stub-obj-y +=3D target-monitor-defs.o
 stub-obj-y +=3D target-get-monitor-def.o
--=20
2.20.1.98.gecbdaf0899
