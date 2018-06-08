Received: from eggs.gnu.org ([2001:4830:134:3::10]:45109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeL-0007dM-SN
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeJ-0004J1-Pu
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:53422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fRAeJ-0004Ia-JO
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:23 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri,  8 Jun 2018 09:13:12 +0300
Message-Id: <20180608061316.4909-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
References: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] slirp: Fix spurious error report when
 sending directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

Move check to where it actually is useful, and reduce scope of 'len'
variable along the way.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 slirp/socket.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index e2a71c9b04..08fe98907d 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -340,7 +340,7 @@ sosendoob(struct socket *so)
 	struct sbuf *sb =3D &so->so_rcv;
 	char buff[2048]; /* XXX Shouldn't be sending more oob data than this */
=20
-	int n, len;
+	int n;
=20
 	DEBUG_CALL("sosendoob");
 	DEBUG_ARG("so =3D %p", so);
@@ -359,7 +359,7 @@ sosendoob(struct socket *so)
 		 * send it all
 		 */
 		uint32_t urgc =3D so->so_urgc;
-		len =3D (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
+		int len =3D (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
 		if (len > urgc) {
 			len =3D urgc;
 		}
@@ -374,13 +374,13 @@ sosendoob(struct socket *so)
 			len +=3D n;
 		}
 		n =3D slirp_send(so, buff, len, (MSG_OOB)); /* |MSG_DONTWAIT)); */
-	}
-
 #ifdef DEBUG
-	if (n !=3D len) {
-		DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
-	}
+		if (n !=3D len) {
+			DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
+		}
 #endif
+	}
+
 	if (n < 0) {
 		return n;
 	}
--=20
2.17.1
