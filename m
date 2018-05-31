Received: from eggs.gnu.org ([2001:4830:134:3::10]:59619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9z-00047Q-4C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9w-0008VW-7n
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:55 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOT9w-0008Uo-1s
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:52 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:22:31 +0200
Message-Id: <20180531192237.3994-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] slirp: disable Nagle in ingoing connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

This follows 3929766fb3e4 ('slirp: disable Nagle in outgoing connections'=
):
for the same reasons, ingoing connections should have the Nagle algorithm=
 disabled.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 slirp/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/slirp/socket.c b/slirp/socket.c
index 61347d1a0c..6f18e157a5 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -754,6 +754,8 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
 		return NULL;
 	}
 	qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+	opt =3D 1;
+	qemu_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(int));
=20
 	getsockname(s,(struct sockaddr *)&addr,&addrlen);
 	so->so_ffamily =3D AF_INET;
--=20
2.17.0
