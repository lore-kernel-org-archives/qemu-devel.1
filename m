Received: from eggs.gnu.org ([2001:4830:134:3::10]:60334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVZ-0004Nl-5F
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVU-00047W-5U
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuVT-00046v-UH
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:35 +0400
Message-Id: <20181114123643.24091-34-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 33/41] slirp: replace
 qemu_notify_event() with a callback
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

Use a "slirp socket" helper function to call the callback when
sbdrop() returns true.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h  | 1 +
 slirp/sbuf.h      | 2 +-
 slirp/socket.h    | 1 +
 net/slirp.c       | 1 +
 slirp/sbuf.c      | 6 ++++--
 slirp/socket.c    | 7 +++++++
 slirp/tcp_input.c | 6 +++---
 7 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index c7582e6516..7d04404340 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -22,6 +22,7 @@ typedef struct SlirpCb {
     void (*timer_mod)(void *timer, int64_t expire_timer);
     void (*set_nonblock)(int fd);
     void (*guest_error)(const char *msg);
+    void (*notify)(void);
 } SlirpCb;
=20
=20
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
diff --git a/slirp/socket.h b/slirp/socket.h
index 930ed95972..79b6fbd4c1 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -154,6 +154,7 @@ int soreadbuf(struct socket *so, const char *buf, int=
 size);
 void sotranslate_out(struct socket *, struct sockaddr_storage *);
 void sotranslate_in(struct socket *, struct sockaddr_storage *);
 void sotranslate_accept(struct socket *);
+void sodrop(struct socket *, int num);
=20
=20
 #endif /* SLIRP_SOCKET_H */
diff --git a/net/slirp.c b/net/slirp.c
index b36092c948..4c39878933 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -198,6 +198,7 @@ static SlirpCb slirp_cb =3D {
     .timer_mod =3D net_slirp_timer_mod,
     .set_nonblock =3D qemu_set_nonblock,
     .guest_error =3D net_slirp_guest_error,
+    .notify =3D qemu_notify_event,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
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
diff --git a/slirp/socket.c b/slirp/socket.c
index 677fd20c9d..2b1b5052c4 100644
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
index e33fb83df5..456d5829e7 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -527,7 +527,7 @@ findso:
 				    SEQ_GT(ti->ti_ack, tp->t_rtseq))
 					tcp_xmit_timer(tp, tp->t_rtt);
 				acked =3D ti->ti_ack - tp->snd_una;
-				sbdrop(&so->so_snd, acked);
+				sodrop(so, acked);
 				tp->snd_una =3D ti->ti_ack;
 				m_free(m);
=20
@@ -1140,10 +1140,10 @@ trimthenstep6:
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
2.19.1.708.g4ede3d42df
