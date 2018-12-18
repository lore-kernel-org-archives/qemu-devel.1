Received: from eggs.gnu.org ([2001:4830:134:3::10]:40234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00082D-Uu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQF-0004GJ-Kr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:10 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQD-0004A2-9P
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:07 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:56 +0100
Message-Id: <20181218230442.27887-19-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/64] slirp: remove the disabled
 readv()/writev() code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The soread() function may be used on datagram sockets, and would
provide different behaviour if HAVE_READV was set, on empty datagrams.
This looks like a minor optimization, that never has been a strong
goal for slirp.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp_config.h |  3 ---
 slirp/socket.c       | 15 ---------------
 2 files changed, 18 deletions(-)

diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index f0cc1c781b..3ce64e088e 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -29,9 +29,6 @@
 /* Define if the machine is big endian */
 //#undef HOST_WORDS_BIGENDIAN
=20
-/* Define if you have readv */
-#undef HAVE_READV
-
 /* Define if iovec needs to be declared */
 #undef DECLARE_IOVEC
 #ifdef _WIN32
diff --git a/slirp/socket.c b/slirp/socket.c
index 041ec5061a..7012c7c07d 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -187,12 +187,7 @@ soread(struct socket *so)
 	 */
 	sopreprbuf(so, iov, &n);
=20
-#ifdef HAVE_READV
-	nn =3D readv(so->s, (struct iovec *)iov, n);
-	DEBUG_MISC((dfd, " ... read nn =3D %d bytes\n", nn));
-#else
 	nn =3D qemu_recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
-#endif
 	if (nn <=3D 0) {
 		if (nn < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN))
 			return 0;
@@ -226,7 +221,6 @@ soread(struct socket *so)
 		}
 	}
=20
-#ifndef HAVE_READV
 	/*
 	 * If there was no error, try and read the second time round
 	 * We read again if n =3D 2 (ie, there's another part of the buffer)
@@ -244,7 +238,6 @@ soread(struct socket *so)
         }
=20
 	DEBUG_MISC((dfd, " ... read nn =3D %d bytes\n", nn));
-#endif
=20
 	/* Update fields */
 	sb->sb_cc +=3D nn;
@@ -452,13 +445,7 @@ sowrite(struct socket *so)
 	}
 	/* Check if there's urgent data to send, and if so, send it */
=20
-#ifdef HAVE_READV
-	nn =3D writev(so->s, (const struct iovec *)iov, n);
-
-	DEBUG_MISC((dfd, "  ... wrote nn =3D %d bytes\n", nn));
-#else
 	nn =3D slirp_send(so, iov[0].iov_base, iov[0].iov_len,0);
-#endif
 	/* This should never happen, but people tell me it does *shrug* */
 	if (nn < 0 && (errno =3D=3D EAGAIN || errno =3D=3D EINTR))
 		return 0;
@@ -467,7 +454,6 @@ sowrite(struct socket *so)
 		goto err_disconnected;
 	}
=20
-#ifndef HAVE_READV
 	if (n =3D=3D 2 && nn =3D=3D iov[0].iov_len) {
             int ret;
             ret =3D slirp_send(so, iov[1].iov_base, iov[1].iov_len,0);
@@ -475,7 +461,6 @@ sowrite(struct socket *so)
                 nn +=3D ret;
         }
         DEBUG_MISC((dfd, "  ... wrote nn =3D %d bytes\n", nn));
-#endif
=20
 	/* Update sbuf */
 	sb->sb_cc -=3D nn;
--=20
2.19.2
