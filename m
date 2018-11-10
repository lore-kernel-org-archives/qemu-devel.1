Received: from eggs.gnu.org ([2001:4830:134:3::10]:45792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU9B-0006rS-Ui
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTxG-0000Qn-FP
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLTxG-0000F7-5s
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:42 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 10 Nov 2018 15:09:23 +0100
Message-Id: <20181110140925.22457-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
References: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] slirp: Use g_new() to allocate sockets in
 socreate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Peter Maydell <peter.maydell@linaro.org>

The slirp socreate() function can only fail if the attempt
to malloc() the struct socket fails. Switch to using
g_new() instead, which will allow us to remove the
error-handling code from its callers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/socket.c    | 14 ++++++--------
 slirp/tcp_input.c |  4 ++--
 slirp/tcp_subr.c  |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 322383a1f9..35a9a14565 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -46,17 +46,15 @@ struct socket *solookup(struct socket **last, struct =
socket *head,
 struct socket *
 socreate(Slirp *slirp)
 {
-  struct socket *so;
+    struct socket *so =3D g_new(struct socket, 1);
=20
-  so =3D (struct socket *)malloc(sizeof(struct socket));
-  if(so) {
     memset(so, 0, sizeof(struct socket));
     so->so_state =3D SS_NOFDREF;
     so->s =3D -1;
     so->slirp =3D slirp;
     so->pollfds_idx =3D -1;
-  }
-  return(so);
+
+    return so;
 }
=20
 /*
@@ -110,7 +108,7 @@ sofree(struct socket *so)
   if (so->so_tcpcb) {
       free(so->so_tcpcb);
   }
-  free(so);
+  g_free(so);
 }
=20
 size_t sopreprbuf(struct socket *so, struct iovec *iov, int *np)
@@ -721,8 +719,8 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
=20
 	/* Don't tcp_attach... we don't need so_snd nor so_rcv */
 	if ((so->so_tcpcb =3D tcp_newtcpcb(so)) =3D=3D NULL) {
-		free(so);
-		return NULL;
+            g_free(so);
+            return NULL;
 	}
 	insque(so, &slirp->tcb);
=20
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 07bcbdb2dd..4f79c95fdb 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -432,8 +432,8 @@ findso:
 	  if ((so =3D socreate(slirp)) =3D=3D NULL)
 	    goto dropwithreset;
 	  if (tcp_attach(so) < 0) {
-	    free(so); /* Not sofree (if it failed, it's not insqued) */
-	    goto dropwithreset;
+            g_free(so); /* Not sofree (if it failed, it's not insqued) *=
/
+            goto dropwithreset;
 	  }
=20
 	  sbreserve(&so->so_snd, TCP_SNDSPACE);
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 8d0f94b75f..0270c89ae3 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -475,7 +475,7 @@ void tcp_connect(struct socket *inso)
             return;
         }
         if (tcp_attach(so) < 0) {
-            free(so); /* NOT sofree */
+            g_free(so); /* NOT sofree */
             return;
         }
         so->lhost =3D inso->lhost;
--=20
2.19.1
