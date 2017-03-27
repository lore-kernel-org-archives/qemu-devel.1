Received: from eggs.gnu.org ([2001:4830:134:3::10]:53329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWx3-0001eD-Jq
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWx2-0006LQ-P8
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:53:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 27 Mar 2017 17:52:34 +0200
Message-Id: <20170327155234.10980-7-mreitz@redhat.com>
In-Reply-To: <20170327155234.10980-1-mreitz@redhat.com>
References: <20170327155234.10980-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] block/file-posix.c: Fix unused variable
 warning on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

On OpenBSD none of the ioctls probe_logical_blocksize() tries
exist, so the variable sector_size is unused. Refactor the
code to avoid this (and reduce the duplicated code).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 1490279788-12995-1-git-send-email-peter.maydell@linaro.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index beb7a4f728..0841a08785 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -220,28 +220,28 @@ static int probe_logical_blocksize(int fd, unsigned=
 int *sector_size_p)
 {
     unsigned int sector_size;
     bool success =3D false;
+    int i;
=20
     errno =3D ENOTSUP;
-
-    /* Try a few ioctls to get the right size */
+    static const unsigned long ioctl_list[] =3D {
 #ifdef BLKSSZGET
-    if (ioctl(fd, BLKSSZGET, &sector_size) >=3D 0) {
-        *sector_size_p =3D sector_size;
-        success =3D true;
-    }
+        BLKSSZGET,
 #endif
 #ifdef DKIOCGETBLOCKSIZE
-    if (ioctl(fd, DKIOCGETBLOCKSIZE, &sector_size) >=3D 0) {
-        *sector_size_p =3D sector_size;
-        success =3D true;
-    }
+        DKIOCGETBLOCKSIZE,
 #endif
 #ifdef DIOCGSECTORSIZE
-    if (ioctl(fd, DIOCGSECTORSIZE, &sector_size) >=3D 0) {
-        *sector_size_p =3D sector_size;
-        success =3D true;
-    }
+        DIOCGSECTORSIZE,
 #endif
+    };
+
+    /* Try a few ioctls to get the right size */
+    for (i =3D 0; i < (int)ARRAY_SIZE(ioctl_list); i++) {
+        if (ioctl(fd, ioctl_list[i], &sector_size) >=3D 0) {
+            *sector_size_p =3D sector_size;
+            success =3D true;
+        }
+    }
=20
     return success ? 0 : -errno;
 }
--=20
2.12.1
