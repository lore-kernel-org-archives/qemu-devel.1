Received: from eggs.gnu.org ([209.51.188.92]:53379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCU9e-0004ms-P1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCU9d-0001c2-JA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:05:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCU8d-0008EJ-MU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:05:24 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  5 Apr 2019 19:46:48 +0100
Message-Id: <20190405184648.17029-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Gcc 9 needs some convincing that sopreprbuf really is going to fill
in iov in the call from soreadbuf, even though the failure case
shouldn't happen; so swing the check around initialising the fields.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 slirp/src/socket.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/slirp/src/socket.c b/slirp/src/socket.c
index 4a3c935e25..4a2222a95f 100644
--- a/slirp/src/socket.c
+++ b/slirp/src/socket.c
@@ -113,12 +113,14 @@ size_t sopreprbuf(struct socket *so, struct iovec *=
iov, int *np)
 	DEBUG_CALL("sopreprbuf");
 	DEBUG_ARG("so =3D %p", so);
=20
-	if (len <=3D 0)
-		return 0;
-
 	iov[0].iov_base =3D sb->sb_wptr;
+        iov[0].iov_len =3D 0;
         iov[1].iov_base =3D NULL;
         iov[1].iov_len =3D 0;
+
+	if (len <=3D 0)
+		return 0;
+
 	if (sb->sb_wptr < sb->sb_rptr) {
 		iov[0].iov_len =3D sb->sb_rptr - sb->sb_wptr;
 		/* Should never succeed, but... */
--=20
2.21.0
