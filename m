Received: from eggs.gnu.org ([2001:4830:134:3::10]:40689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR9-0000LI-6B
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR7-000502-TW
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:02 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR7-0004PR-I1
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:01 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:18 +0100
Message-Id: <20181218230442.27887-41-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/64] slirp: remove dead TCP_ACK_HACK code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Untouched since original introduction in 2004.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tcp_input.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 5b5355dd99..b67ec24075 100644
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
2.19.2
