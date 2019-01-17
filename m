Received: from eggs.gnu.org ([209.51.188.92]:57392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66e-0005pA-Av
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66a-0004sO-95
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66Y-0004pa-9m
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:43 +0400
Message-Id: <20190117114359.5164-12-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/27] slirp: replace qemu_notify_event() with
 a callback
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

Introduce a SlirpCb callback to kick the main io-thread.

Add an intermediary sodrop() function that will call SlirpCb.notify
callback when sbdrop() returns true.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h  | 2 ++
 slirp/sbuf.h      | 2 +-
 slirp/socket.h    | 1 +
 net/slirp.c       | 1 +
 slirp/sbuf.c      | 6 ++++--
 slirp/socket.c    | 7 +++++++
 slirp/tcp_input.c | 6 +++---
 7 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 8ce69f0be39..679a25422b9 100644
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
diff --git a/slirp/sbuf.h b/slirp/sbuf.h
index 644c2013413..1cb9a428341 100644
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
diff --git a/slirp/socket.h b/slirp/socket.h
index fc35ca5f72a..1c1c8b5871c 100644
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
diff --git a/net/slirp.c b/net/slirp.c
index 78ba96b63f7..7b4f9f5c5ee 100644
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
diff --git a/slirp/sbuf.c b/slirp/sbuf.c
index 912f235f652..17f28e97a63 100644
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
diff --git a/slirp/socket.c b/slirp/socket.c
index 5805d30f3d8..2e8dc22fb62 100644
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
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index de5b74a52b1..7c1fe18fec1 100644
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
2.20.1.98.gecbdaf0899
