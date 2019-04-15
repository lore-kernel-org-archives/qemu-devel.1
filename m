Received: from eggs.gnu.org ([209.51.188.92]:49603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zu-0007nv-SA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zt-0004KR-VC
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:26 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG5zt-0004K5-MJ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:25 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 15 Apr 2019 20:06:18 +0200
Message-Id: <20190415180618.1450-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
References: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Gcc 9 needs some convincing that sopreprbuf really is going to fill
in iov in the call from soreadbuf, even though the failure case
shouldn't happen.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190415121740.9881-1-dgilbert@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/src/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/slirp/src/socket.c b/slirp/src/socket.c
index 4a3c935e25..bb752fdcae 100644
--- a/slirp/src/socket.c
+++ b/slirp/src/socket.c
@@ -171,6 +171,7 @@ int
 soread(struct socket *so)
 {
 	int n, nn;
+	size_t buf_len;
 	struct sbuf *sb =3D &so->so_snd;
 	struct iovec iov[2];
=20
@@ -181,7 +182,8 @@ soread(struct socket *so)
 	 * No need to check if there's enough room to read.
 	 * soread wouldn't have been called if there weren't
 	 */
-	sopreprbuf(so, iov, &n);
+	buf_len =3D sopreprbuf(so, iov, &n);
+	assert(buf_len !=3D 0);
=20
 	nn =3D recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
 	if (nn <=3D 0) {
@@ -257,6 +259,7 @@ int soreadbuf(struct socket *so, const char *buf, int=
 size)
 	 * No need to check if there's enough room to read.
 	 * soread wouldn't have been called if there weren't
 	 */
+	assert(size > 0);
 	if (sopreprbuf(so, iov, &n) < size)
         goto err;
=20
--=20
2.20.1
