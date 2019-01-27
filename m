Received: from eggs.gnu.org ([209.51.188.92]:52642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCF-0001RS-Ge
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCC-0007TE-55
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:55 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007Pf-LF
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:52 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:08 +0100
Message-Id: <20190127120526.15457-14-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/31] slirp: add unregister_poll_fd() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add a counter-part to register_poll_fd() for completeness.

(so far, register_poll_fd() is called only on struct socket fd)

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c      | 6 ++++++
 slirp/ip_icmp.c  | 1 +
 slirp/libslirp.h | 2 ++
 slirp/slirp.c    | 3 ++-
 slirp/tcp_subr.c | 2 ++
 slirp/udp.c      | 1 +
 6 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index 6f756a4dcc..78ba96b63f 100644
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
index b59daa801d..19e247f773 100644
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
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 70e99139bf..8ce69f0be3 100644
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
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 12677e5da7..f0bd59fd6f 100644
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
index 8087ffc047..d8846a33b0 100644
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
index 6c3fb9a29f..3915971b50 100644
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
2.20.1
