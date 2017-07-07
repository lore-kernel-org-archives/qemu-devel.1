Received: from eggs.gnu.org ([2001:4830:134:3::10]:41387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWky-0004kC-9j
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkw-0007g6-T9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:26 +0200
Message-Id: <1499447335-6125-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 011/100] vvfat: always create . and .. entries
 at first and in that order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

readdir() doesn't always return . and .. entries at first and in that ord=
er.
This leads to not creating them at first in the directory, which raises s=
ome
errors on file system checking utilities like MS-DOS Scandisk.

Specification: "FAT: General overview of on-disk format" v1.03, page 25

Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 676cacb..0c6d0f4 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -727,6 +727,12 @@ static int read_directory(BDRVVVFATState* s, int map=
ping_index)
     i =3D mapping->info.dir.first_dir_index =3D
             first_cluster =3D=3D 0 ? 0 : s->directory.next;
=20
+    if (first_cluster !=3D 0) {
+        /* create the top entries of a subdirectory */
+        (void)create_short_and_long_name(s, i, ".", 1);
+        (void)create_short_and_long_name(s, i, "..", 1);
+    }
+
     /* actually read the directory, and allocate the mappings */
     while((entry=3Dreaddir(dir))) {
         unsigned int length=3Dstrlen(dirname)+2+strlen(entry->d_name);
@@ -748,8 +754,11 @@ static int read_directory(BDRVVVFATState* s, int map=
ping_index)
         }
=20
         /* create directory entry for this file */
-        direntry=3Dcreate_short_and_long_name(s, i, entry->d_name,
-                is_dot || is_dotdot);
+        if (!is_dot && !is_dotdot) {
+            direntry =3D create_short_and_long_name(s, i, entry->d_name,=
 0);
+        } else {
+            direntry =3D array_get(&(s->directory), is_dot ? i : i + 1);
+        }
         direntry->attributes=3D(S_ISDIR(st.st_mode)?0x10:0x20);
         direntry->reserved[0]=3Ddirentry->reserved[1]=3D0;
         direntry->ctime=3Dfat_datetime(st.st_ctime,1);
--=20
1.8.3.1
