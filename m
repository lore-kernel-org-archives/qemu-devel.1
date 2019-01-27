Received: from eggs.gnu.org ([209.51.188.92]:52623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCE-0001Qg-VB
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCB-0007S5-NR
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:54 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007PG-AA
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:09 +0100
Message-Id: <20190127120526.15457-15-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/31] slirp: replace qemu_notify_event() with a
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Introduce a SlirpCb callback to kick the main io-thread.

Add an intermediary sodrop() function that will call SlirpCb.notify
callback when sbdrop() returns true.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c       | 1 +
 slirp/libslirp.h  | 2 ++
 slirp/sbuf.c      | 6 ++++--
 slirp/sbuf.h      | 2 +-
 slirp/socket.c    | 7 +++++++
 slirp/socket.h    | 1 +
 slirp/tcp_input.c | 6 +++---
 7 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 78ba96b63f..7b4f9f5c5e 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -205,6 +205,7 @@ static const SlirpCb slirp_cb =3D {
     .timer_mod =3D net_slirp_timer_mod,
     .register_poll_fd =3D net_slirp_register_poll_fd,
     .unregister_poll_fd =3D net_slirp_unregister_poll_fd,
+    .notify =3D qemu_notify_event,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 8ce69f0be3..679a25422b 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -31,6 +31,8 @@ typedef struct SlirpCb {
     void (*register_poll_fd)(int fd);
     /* Unregister a fd */
     void (*unregister_poll_fd)(int fd);
+    /* Kick the io-thread, to signal that new events may be processed */
+    void (*notify)(void);
 } SlirpCb;
=20
=20
diff --git a/slirp/sbuf.c b/slirp/sbuf.c
index 912f235f65..17f28e97a6 100644
--- a/slirp/sbuf.c
+++ b/slirp/sbuf.c
@@ -17,7 +17,7 @@ sbfree(struct sbuf *sb)
 	free(sb->sb_data);
 }
=20
-void
+bool
 sbdrop(struct sbuf *sb, int num)
 {
     int limit =3D sb->sb_datalen / 2;
@@ -34,8 +34,10 @@ sbdrop(struct sbuf *sb, int num)
 		sb->sb_rptr -=3D sb->sb_datalen;
=20
     if (sb->sb_cc < limit && sb->sb_cc + num >=3D limit) {
-        qemu_notify_event();
+        return true;
     }
+
+    return false;
 }
=20
 void
diff --git a/slirp/sbuf.h b/slirp/sbuf.h
index 644c201341..1cb9a42834 100644
--- a/slirp/sbuf.h
+++ b/slirp/sbuf.h
@@ -21,7 +21,7 @@ struct sbuf {
 };
=20
 void sbfree(struct sbuf *);
-void sbdrop(struct sbuf *, int);
+bool sbdrop(struct sbuf *, int);
 void sbreserve(struct sbuf *, int);
 void sbappend(struct socket *, struct mbuf *);
 void sbcopy(struct sbuf *, int, int, char *);
diff --git a/slirp/socket.c b/slirp/socket.c
index 5805d30f3d..2e8dc22fb6 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -928,3 +928,10 @@ void sotranslate_accept(struct socket *so)
         break;
     }
 }
+
+void sodrop(struct socket *s, int num)
+{
+    if (sbdrop(&s->so_snd, num)) {
+        s->slirp->cb->notify();
+    }
+}
diff --git a/slirp/socket.h b/slirp/socket.h
index fc35ca5f72..1c1c8b5871 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -156,6 +156,7 @@ int soreadbuf(struct socket *so, const char *buf, int=
 size);
 void sotranslate_out(struct socket *, struct sockaddr_storage *);
 void sotranslate_in(struct socket *, struct sockaddr_storage *);
 void sotranslate_accept(struct socket *);
+void sodrop(struct socket *, int num);
=20
=20
 #endif /* SLIRP_SOCKET_H */
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index de5b74a52b..7c1fe18fec 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -506,7 +506,7 @@ findso:
 				    SEQ_GT(ti->ti_ack, tp->t_rtseq))
 					tcp_xmit_timer(tp, tp->t_rtt);
 				acked =3D ti->ti_ack - tp->snd_una;
-				sbdrop(&so->so_snd, acked);
+				sodrop(so, acked);
 				tp->snd_una =3D ti->ti_ack;
 				m_free(m);
=20
@@ -1118,10 +1118,10 @@ trimthenstep6:
 		}
 		if (acked > so->so_snd.sb_cc) {
 			tp->snd_wnd -=3D so->so_snd.sb_cc;
-			sbdrop(&so->so_snd, (int )so->so_snd.sb_cc);
+			sodrop(so, (int)so->so_snd.sb_cc);
 			ourfinisacked =3D 1;
 		} else {
-			sbdrop(&so->so_snd, acked);
+			sodrop(so, acked);
 			tp->snd_wnd -=3D acked;
 			ourfinisacked =3D 0;
 		}
--=20
2.20.1
