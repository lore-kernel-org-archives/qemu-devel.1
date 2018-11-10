Received: from eggs.gnu.org ([2001:4830:134:3::10]:45792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU97-0006rS-GE
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTxH-0000Ra-CN
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLTxH-0000Gm-0x
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:43 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 10 Nov 2018 15:09:24 +0100
Message-Id: <20181110140925.22457-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
References: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] slirp: Remove code that handles socreate()
 failure
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

Now that socreate() can never fail, we can remove the code
that was trying to handle that situation.

In particular this removes code in tcp_connect() that
provoked Coverity to complain (CID 1005724): in
 closesocket(accept(inso->s, (struct sockaddr *)&addr, &addrlen));
if the accept() call fails then we pass closesocket() -1
instead of a valid file descriptor.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip_icmp.c   | 2 +-
 slirp/slirp.c     | 3 ---
 slirp/socket.c    | 3 ---
 slirp/tcp_input.c | 3 +--
 slirp/tcp_subr.c  | 5 -----
 slirp/udp.c       | 6 ------
 slirp/udp6.c      | 3 ---
 7 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index da100d1f55..9210eef3f3 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -160,7 +160,7 @@ icmp_input(struct mbuf *m, int hlen)
     } else {
       struct socket *so;
       struct sockaddr_storage addr;
-      if ((so =3D socreate(slirp)) =3D=3D NULL) goto freeit;
+      so =3D socreate(slirp);
       if (icmp_send(so, m, hlen) =3D=3D 0) {
         return;
       }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 3c3c03b22f..322edf51eb 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1477,9 +1477,6 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
ue, int version_id)
         int ret;
         struct socket *so =3D socreate(slirp);
=20
-        if (!so)
-            return -ENOMEM;
-
         ret =3D vmstate_load_state(f, &vmstate_slirp_socket, so, version=
_id);
=20
         if (ret < 0)
diff --git a/slirp/socket.c b/slirp/socket.c
index 35a9a14565..c01d8696af 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -713,9 +713,6 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
 	DEBUG_ARG("flags =3D %x", flags);
=20
 	so =3D socreate(slirp);
-	if (!so) {
-	  return NULL;
-	}
=20
 	/* Don't tcp_attach... we don't need so_snd nor so_rcv */
 	if ((so->so_tcpcb =3D tcp_newtcpcb(so)) =3D=3D NULL) {
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 4f79c95fdb..d073ef9525 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -429,8 +429,7 @@ findso:
 	  if ((tiflags & (TH_SYN|TH_FIN|TH_RST|TH_URG|TH_ACK)) !=3D TH_SYN)
 	    goto dropwithreset;
=20
-	  if ((so =3D socreate(slirp)) =3D=3D NULL)
-	    goto dropwithreset;
+          so =3D socreate(slirp);
 	  if (tcp_attach(so) < 0) {
             g_free(so); /* Not sofree (if it failed, it's not insqued) *=
/
             goto dropwithreset;
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 0270c89ae3..fa61349cbb 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -469,11 +469,6 @@ void tcp_connect(struct socket *inso)
         so =3D inso;
     } else {
         so =3D socreate(slirp);
-        if (so =3D=3D NULL) {
-            /* If it failed, get rid of the pending connection */
-            closesocket(accept(inso->s, (struct sockaddr *)&addr, &addrl=
en));
-            return;
-        }
         if (tcp_attach(so) < 0) {
             g_free(so); /* NOT sofree */
             return;
diff --git a/slirp/udp.c b/slirp/udp.c
index e5bf065bf2..c47870a61b 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -171,9 +171,6 @@ udp_input(register struct mbuf *m, int iphlen)
 	   * create one
 	   */
 	  so =3D socreate(slirp);
-	  if (!so) {
-	      goto bad;
-	  }
 	  if (udp_attach(so, AF_INET) =3D=3D -1) {
 	    DEBUG_MISC((dfd," udp_attach errno =3D %d-%s\n",
 			errno,strerror(errno)));
@@ -331,9 +328,6 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
 	socklen_t addrlen =3D sizeof(struct sockaddr_in);
=20
 	so =3D socreate(slirp);
-	if (!so) {
-	    return NULL;
-	}
 	so->s =3D qemu_socket(AF_INET,SOCK_DGRAM,0);
         if (so->s < 0) {
             sofree(so);
diff --git a/slirp/udp6.c b/slirp/udp6.c
index 7c4a6b003a..986010f0d3 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -91,9 +91,6 @@ void udp6_input(struct mbuf *m)
     if (so =3D=3D NULL) {
         /* If there's no socket for this packet, create one. */
         so =3D socreate(slirp);
-        if (!so) {
-            goto bad;
-        }
         if (udp_attach(so, AF_INET6) =3D=3D -1) {
             DEBUG_MISC((dfd, " udp6_attach errno =3D %d-%s\n",
                         errno, strerror(errno)));
--=20
2.19.1
