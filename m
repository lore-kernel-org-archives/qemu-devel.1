Received: from eggs.gnu.org ([209.51.188.92]:57391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66e-0005p9-Al
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66c-0004tj-8X
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66a-0004lo-8C
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:42 +0400
Message-Id: <20190117114359.5164-11-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/27] slirp: add unregister_poll_fd() callback
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

Add a counter-part to register_poll_fd() for completeness.

(so far, register_poll_fd() is called only on struct socket fd)

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 2 ++
 net/slirp.c      | 6 ++++++
 slirp/ip_icmp.c  | 1 +
 slirp/slirp.c    | 3 ++-
 slirp/tcp_subr.c | 2 ++
 slirp/udp.c      | 1 +
 6 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 70e99139bf6..8ce69f0be39 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -29,6 +29,8 @@ typedef struct SlirpCb {
     void (*timer_mod)(void *timer, int64_t expire_time);
     /* Register a fd for future polling */
     void (*register_poll_fd)(int fd);
+    /* Unregister a fd */
+    void (*unregister_poll_fd)(int fd);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index 6f756a4dccc..78ba96b63f7 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -191,6 +191,11 @@ static void net_slirp_register_poll_fd(int fd)
     qemu_fd_register(fd);
 }
=20
+static void net_slirp_unregister_poll_fd(int fd)
+{
+    /* no qemu_fd_unregister */
+}
+
 static const SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
     .guest_error =3D net_slirp_guest_error,
@@ -199,6 +204,7 @@ static const SlirpCb slirp_cb =3D {
     .timer_free =3D net_slirp_timer_free,
     .timer_mod =3D net_slirp_timer_mod,
     .register_poll_fd =3D net_slirp_register_poll_fd,
+    .unregister_poll_fd =3D net_slirp_unregister_poll_fd,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index b59daa801d1..19e247f773e 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -114,6 +114,7 @@ static int icmp_send(struct socket *so, struct mbuf *=
m, int hlen)
=20
 void icmp_detach(struct socket *so)
 {
+    so->slirp->cb->unregister_poll_fd(so->s);
     slirp_closesocket(so->s);
     sofree(so);
 }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index dd72829017f..fdf26d5e626 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1015,7 +1015,8 @@ int slirp_remove_hostfwd(Slirp *slirp, int is_udp, =
struct in_addr host_addr,
             getsockname(so->s, (struct sockaddr *)&addr, &addr_len) =3D=3D=
 0 &&
             addr.sin_addr.s_addr =3D=3D host_addr.s_addr &&
             addr.sin_port =3D=3D port) {
-            close(so->s);
+            so->slirp->cb->unregister_poll_fd(so->s);
+            slirp_closesocket(so->s);
             sofree(so);
             return 0;
         }
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 8087ffc047f..d8846a33b0c 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -337,6 +337,7 @@ tcp_close(struct tcpcb *tp)
 	/* clobber input socket cache if we're closing the cached connection */
 	if (so =3D=3D slirp->tcp_last_so)
 		slirp->tcp_last_so =3D &slirp->tcb;
+	so->slirp->cb->unregister_poll_fd(so->s);
 	slirp_closesocket(so->s);
 	sbfree(&so->so_rcv);
 	sbfree(&so->so_snd);
@@ -498,6 +499,7 @@ void tcp_connect(struct socket *inso)
     /* Close the accept() socket, set right state */
     if (inso->so_state & SS_FACCEPTONCE) {
         /* If we only accept once, close the accept() socket */
+        so->slirp->cb->unregister_poll_fd(so->s);
         slirp_closesocket(so->s);
=20
         /* Don't select it yet, even though we have an FD */
diff --git a/slirp/udp.c b/slirp/udp.c
index 6c3fb9a29ff..3915971b506 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -292,6 +292,7 @@ udp_attach(struct socket *so, unsigned short af)
 void
 udp_detach(struct socket *so)
 {
+	so->slirp->cb->unregister_poll_fd(so->s);
 	slirp_closesocket(so->s);
 	sofree(so);
 }
--=20
2.20.1.98.gecbdaf0899
