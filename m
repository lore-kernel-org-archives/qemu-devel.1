Received: from eggs.gnu.org ([2001:4830:134:3::10]:45308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU9C-0006GG-2U
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTxG-0000Qw-JE
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLTxG-0000Fp-87
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:42 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 10 Nov 2018 15:09:22 +0100
Message-Id: <20181110140925.22457-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
References: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] slirp: Don't pass possibly -1 fd to send()
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

Coverity complains (CID 1005726) that we might pass -1 as the fd
argument to send() in slirp_send(), because we previously checked for
"so->s =3D=3D -1 && so->extra".  The case of "so->s =3D=3D -1 but so->ext=
ra
NULL" should not in theory happen, but it is hard to guarantee
because various places in the code do so->s =3D qemu_socket(...) and so
will end up with so->s =3D=3D -1 on failure, and not all the paths which
call that always throw away the socket in that case (eg
tcp_fconnect()).  So just check specifically for the condition and
fail slirp_send().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 51de41fc02..3c3c03b22f 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1091,6 +1091,17 @@ ssize_t slirp_send(struct socket *so, const void *=
buf, size_t len, int flags)
         return len;
     }
=20
+    if (so->s =3D=3D -1) {
+        /*
+         * This should in theory not happen but it is hard to be
+         * sure because some code paths will end up with so->s =3D=3D -1
+         * on a failure but don't dispose of the struct socket.
+         * Check specifically, so we don't pass -1 to send().
+         */
+        errno =3D EBADF;
+        return -1;
+    }
+
     return send(so->s, buf, len, flags);
 }
=20
--=20
2.19.1
