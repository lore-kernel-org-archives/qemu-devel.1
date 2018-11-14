Received: from eggs.gnu.org ([2001:4830:134:3::10]:60423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuW7-0004my-Fl
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuW2-0004NO-Dj
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuVz-0004L8-Hw
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:28 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:38 +0400
Message-Id: <20181114123643.24091-37-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 36/41] slirp: remove dead TCP_ACK_HACK
 code
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

Untouched since original introduction in 2004.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/tcp_input.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index de4ef92aba..0d34abf8d7 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -60,27 +60,6 @@
  * Set DELACK for segments received in order, but ack immediately
  * when segments are out of order (so fast retransmit can work).
  */
-#ifdef TCP_ACK_HACK
-#define TCP_REASS(tp, ti, m, so, flags) {\
-       if ((ti)->ti_seq =3D=3D (tp)->rcv_nxt && \
-           tcpfrag_list_empty(tp) && \
-           (tp)->t_state =3D=3D TCPS_ESTABLISHED) {\
-               if (ti->ti_flags & TH_PUSH) \
-                       tp->t_flags |=3D TF_ACKNOW; \
-               else \
-                       tp->t_flags |=3D TF_DELACK; \
-               (tp)->rcv_nxt +=3D (ti)->ti_len; \
-               flags =3D (ti)->ti_flags & TH_FIN; \
-               if (so->so_emu) { \
-		       if (tcp_emu((so),(m))) sbappend((so), (m)); \
-	       } else \
-	       	       sbappend((so), (m)); \
-	} else {\
-               (flags) =3D tcp_reass((tp), (ti), (m)); \
-               tp->t_flags |=3D TF_ACKNOW; \
-       } \
-}
-#else
 #define	TCP_REASS(tp, ti, m, so, flags) { \
 	if ((ti)->ti_seq =3D=3D (tp)->rcv_nxt && \
         tcpfrag_list_empty(tp) && \
@@ -97,7 +76,7 @@
 		tp->t_flags |=3D TF_ACKNOW; \
 	} \
 }
-#endif
+
 static void tcp_dooptions(struct tcpcb *tp, u_char *cp, int cnt,
                           struct tcpiphdr *ti);
 static void tcp_xmit_timer(register struct tcpcb *tp, int rtt);
--=20
2.19.1.708.g4ede3d42df
