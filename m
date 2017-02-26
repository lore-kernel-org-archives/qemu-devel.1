Received: from eggs.gnu.org ([2001:4830:134:3::10]:56118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03P-0005f1-9B
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03M-00026A-7E
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:03 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:51269)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03M-00025k-0l
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:00 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Feb 2017 15:43:51 +0100
Message-Id: <20170226144353.2502-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
References: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] slirp: Check qemu_socket() return value in
 udp_listen()
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

Check the return value from qemu_socket() rather than trying to
pass it to bind() as an fd argument even if it's negative.
This wouldn't have caused any negative consequences, because
it won't be a valid fd number and the bind call will fail;
but Coverity complains (CID 1005723).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/udp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/slirp/udp.c b/slirp/udp.c
index 93d7224792..227d779022 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -335,6 +335,10 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport=
, uint32_t laddr,
 	    return NULL;
 	}
 	so->s =3D qemu_socket(AF_INET,SOCK_DGRAM,0);
+        if (so->s < 0) {
+            sofree(so);
+            return NULL;
+        }
 	so->so_expire =3D curtime + SO_EXPIRE;
 	insque(so, &slirp->udb);
=20
--=20
2.11.0
