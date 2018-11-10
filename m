Received: from eggs.gnu.org ([2001:4830:134:3::10]:36770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbe-0004wV-Nb
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbd-0001a8-TM
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLTbd-0001Y0-NH
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:21 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 17:45:46 +0400
Message-Id: <20181110134548.14741-12-marcandre.lureau@redhat.com>
In-Reply-To: <20181110134548.14741-1-marcandre.lureau@redhat.com>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 11/13] slirp: replace the poor-man
 string split with g_strsplit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use the glib function for the work, fix a potential crash on >256 words.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/misc.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index d9804f2a6d..dedc9bf6c3 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -130,11 +130,8 @@ err:
 int
 fork_exec(struct socket *so, const char *ex)
 {
-	const char *argv[256];
-	/* don't want to clobber the original */
-	char *bptr;
-	const char *curarg;
-	int opt, c, i, sp[2];
+	char **argv;
+	int opt, c, sp[2];
 	pid_t pid;
=20
 	DEBUG_CALL("fork_exec");
@@ -161,19 +158,7 @@ fork_exec(struct socket *so, const char *ex)
 		for (c =3D getdtablesize() - 1; c >=3D 3; c--)
 		   close(c);
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
+        argv =3D g_strsplit(ex, " ", -1);
 		execvp(argv[0], (char **)argv);
=20
 		/* Ooops, failed, let's tell the user why */
--=20
2.19.1.708.g4ede3d42df
