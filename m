Received: from eggs.gnu.org ([209.51.188.92]:34708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB6k-0004Bd-Uo
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB6h-0001Cc-Qd
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:24 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB6h-0001AJ-HG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:23 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:52:11 +0100
Message-Id: <20190114225306.21569-11-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/65] slirp: replace the poor-man string split
 with g_strsplit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Use the glib function for the work, fix a potential crash on >256 words.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index ce323ef92e..4840187750 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -88,11 +88,8 @@ fork_exec(struct socket *so, const char *ex)
 	socklen_t addrlen =3D sizeof(addr);
         socklen_t csaddrlen =3D sizeof(csaddr);
 	int opt;
-	const char *argv[256];
-	/* don't want to clobber the original */
-	char *bptr;
-	const char *curarg;
-	int c, i, ret;
+	char **argv;
+	int ret;
 	pid_t pid;
=20
 	DEBUG_CALL("fork_exec");
@@ -156,19 +153,7 @@ fork_exec(struct socket *so, const char *ex)
 		for (s =3D getdtablesize() - 1; s >=3D 3; s--)
 		   close(s);
=20
-		i =3D 0;
-		bptr =3D g_strdup(ex); /* No need to free() this */
-        do {
-			/* Change the string into argv[] */
-			curarg =3D bptr;
-			while (*bptr !=3D ' ' && *bptr !=3D (char)0)
-			   bptr++;
-			c =3D *bptr;
-			*bptr++ =3D (char)0;
-			argv[i++] =3D g_strdup(curarg);
-        } while (c);
-
-                argv[i] =3D NULL;
+                argv =3D g_strsplit(ex, " ", -1);
 		execvp(argv[0], (char **)argv);
=20
 		/* Ooops, failed, let's tell the user why */
--=20
2.20.1
