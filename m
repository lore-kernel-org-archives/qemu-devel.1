Received: from eggs.gnu.org ([2001:4830:134:3::10]:60656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvko7-0002ic-MO
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvko7-0005aa-13
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Aug 2018 16:53:13 +0200
Message-Id: <20180831145314.14736-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180831145314.14736-1-marcandre.lureau@redhat.com>
References: <20180831145314.14736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] util: use fcntl() for qemu_write_pidfile()
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Daniel Berrang=C3=A9 suggested to use fcntl() locks rather than lockf().

'man lockf':

   On Linux, lockf() is just an interface on top of fcntl(2) locking.
   Many other systems implement lockf() in this way, but note that
   POSIX.1 leaves the relationship between lockf() and fcntl(2) locks
   unspecified.  A portable application should probably avoid mixing
   calls to these interfaces.

IOW, if its just a shim around fcntl() on many systems, it is clearer
if we just use fcntl() directly, as we then know how fcntl() locks will
behave if they're on a network filesystem like NFS.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/oslib-posix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 0e3ab9d959..fbd0dc8c57 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -95,6 +95,11 @@ bool qemu_write_pidfile(const char *path, Error **errp=
)
=20
     while (1) {
         struct stat a, b;
+        struct flock lock =3D {
+            .l_type =3D F_WRLCK,
+            .l_whence =3D SEEK_SET,
+            .l_len =3D 0,
+        };
=20
         fd =3D qemu_open(path, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
         if (fd =3D=3D -1) {
@@ -107,7 +112,7 @@ bool qemu_write_pidfile(const char *path, Error **err=
p)
             goto fail_close;
         }
=20
-        if (lockf(fd, F_TLOCK, 0) < 0) {
+        if (fcntl(fd, F_SETLK, &lock)) {
             error_setg_errno(errp, errno, "Cannot lock pid file");
             goto fail_close;
         }
--=20
2.19.0.rc1
