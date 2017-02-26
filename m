Received: from eggs.gnu.org ([2001:4830:134:3::10]:56115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03P-0005ey-8i
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03M-00026E-7M
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:03 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:51276)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03M-00025s-17
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:00 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Feb 2017 15:43:53 +0100
Message-Id: <20170226144353.2502-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
References: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] slirp: tcp_listen(): Don't try to close()
 an fd we never opened
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

Coverity points out (CID 1005725) that an error-exit path in tcp_listen()
will try to close(s) even if the reason it got there was that the
qemu_socket() failed and s was never opened.  Not only that, this isn't e=
ven
the right function to use, because we need closesocket() to do the right
thing on Windows.  Change to using the right function and only calling it=
 if
needed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 6c18971368..86927722e1 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -713,7 +713,9 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport,=
 uint32_t laddr,
 	    (listen(s,1) < 0)) {
 		int tmperrno =3D errno; /* Don't clobber the real reason we failed */
=20
-		close(s);
+                if (s >=3D 0) {
+                    closesocket(s);
+                }
 		sofree(so);
 		/* Restore the real errno */
 #ifdef _WIN32
--=20
2.11.0
