Received: from eggs.gnu.org ([209.51.188.92]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gRD-0003Ey-Sh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gRD-0003vQ-5i
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:59:03 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:43802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1gRC-0003ux-VB
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:59:03 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 00:58:40 +0100
Message-Id: <20190306235850.30110-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/12] slirp: check for ioctlsocket error and
 0-length udp payload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Vic Lee <llyzs.vic@gmail.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Vic Lee <llyzs.vic@gmail.com>

Sometimes sorecvfrom() is called from slirp.c because revents =3D=3D G_IO=
_IN,
but there is 0 bytes available and recvfrom could be blocking indefinitel=
y.
This is likely due to 0-length udp payload. This also adds an error
checking for ioctlsocket.

Signed-off-by: Vic Lee <llyzs.vic@gmail.com>
Message-Id: <20190301064809.3074-1-llyzs.vic@gmail.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/socket.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 4876ea3f31..4dc5e2907d 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -529,6 +529,15 @@ sorecvfrom(struct socket *so)
           int n;
 #endif
=20
+	  if (ioctlsocket(so->s, FIONREAD, &n) !=3D 0) {
+	      DEBUG_MISC(" ioctlsocket errno =3D %d-%s\n",
+			 errno,strerror(errno));
+	      return;
+	  }
+	  if (n =3D=3D 0) {
+	      return;
+	  }
+
 	  m =3D m_get(so->slirp);
 	  if (!m) {
 	      return;
@@ -552,7 +561,6 @@ sorecvfrom(struct socket *so)
 	   */
 	  len =3D M_FREEROOM(m);
 	  /* if (so->so_fport !=3D htons(53)) { */
-	  ioctlsocket(so->s, FIONREAD, &n);
=20
 	  if (n > len) {
 	    n =3D (m->m_data - m->m_dat) + m->m_len + n + 1;
--=20
2.20.1
