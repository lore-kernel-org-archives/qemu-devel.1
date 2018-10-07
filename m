Received: from eggs.gnu.org ([2001:4830:134:3::10]:54612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQp-0008VP-I3
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQo-00017w-Aj
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:31 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:54658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1g9DQn-0000xM-Q2
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:30 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun,  7 Oct 2018 20:05:18 +0200
Message-Id: <20181007180518.5212-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
References: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] slirp: Propagate host TCP RST packet to the
 guest after socket disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Gavin Grant <gavingrant@protonmail.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Gavin Grant <gavingrant@protonmail.com>

Commit 27d92ebc5ed1bb0b518d0ebc4c609182ad20a799 handled the case where th=
e TCP
connection is abruptly closed via a RST packet, by checking for the ECONN=
RESET
errno. However it does not consider the case where the connection has bee=
n
half-closed by the host (FIN/ACK), then the host socket is disconnected. =
For
example, if the host application calls close() on the socket, then the
application exits.

In this case, the socket still exists due to the file descriptor in SLIRP=
, but
it is disconnected. recv() does not indicate an error since an orderly so=
cket
close has previously occurred. The socket will then be stuck in FIN_WAIT_=
2,
until the peer sends FIN/ACK or a timeout occurs. Instead we can send a R=
ST
to the peer and transition to the CLOSED state.

Signed-off-by: Gavin Grant <gavingrant@protonmail.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/socket.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 08fe98907d..322383a1f9 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -204,12 +204,19 @@ soread(struct socket *so)
 			return 0;
 		else {
 			int err;
-			socklen_t slen =3D sizeof err;
+			socklen_t elen =3D sizeof err;
+			struct sockaddr_storage addr;
+			struct sockaddr *paddr =3D (struct sockaddr *) &addr;
+			socklen_t alen =3D sizeof addr;
=20
 			err =3D errno;
 			if (nn =3D=3D 0) {
-				getsockopt(so->s, SOL_SOCKET, SO_ERROR,
-					   &err, &slen);
+				if (getpeername(so->s, paddr, &alen) < 0) {
+					err =3D errno;
+				} else {
+					getsockopt(so->s, SOL_SOCKET, SO_ERROR,
+						&err, &elen);
+				}
 			}
=20
 			DEBUG_MISC((dfd, " --- soread() disconnected, nn =3D %d, errno =3D %d=
-%s\n", nn, errno,strerror(errno)));
--=20
2.19.0
