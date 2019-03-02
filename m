Received: from eggs.gnu.org ([209.51.188.92]:53008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzuLQ-0000Qt-U3
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 21:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzuLN-0003w7-61
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 21:25:42 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:47188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gzuLH-0003eC-C7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 21:25:37 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri,  1 Mar 2019 18:25:18 -0800
Message-Id: <20190302022518.18719-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: fix big/little endian conversion in
 ident protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, will@wbowling.info

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tcp_subr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index ef9d99c154..1d7e72dca7 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -660,10 +660,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
 						    tmpso->so_fport =3D=3D n1) {
 							if (getsockname(tmpso->s,
 								(struct sockaddr *)&addr, &addrlen) =3D=3D 0)
-							   n2 =3D ntohs(addr.sin_port);
+							   n2 =3D addr.sin_port;
 							break;
 						}
 					}
+					NTOHS(n1);
+					NTOHS(n2);
 					so_rcv->sb_cc =3D snprintf(so_rcv->sb_data,
 								 so_rcv->sb_datalen,
 								 "%d,%d\r\n", n1, n2);
--=20
2.20.1
