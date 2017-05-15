Received: from eggs.gnu.org ([2001:4830:134:3::10]:35019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeO-0001Ok-Bh
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeM-0003XI-US
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:28 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:07 +0200
Message-Id: <20170515203114.9477-8-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/13] vvfat: always create . and .. entries at
 first and in that order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

readdir() doesn't always return . and .. entries at first and in that ord=
er.
This leads to not creating them at first in the directory, which raises s=
ome
errors on file system checking utilities like MS-DOS Scandisk.

Specification: "FAT: General overview of on-disk format" v1.03, page 25

Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 348cffe1c4..7da07068b8 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -721,6 +721,12 @@ static int read_directory(BDRVVVFATState* s, int map=
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
@@ -742,8 +748,11 @@ static int read_directory(BDRVVVFATState* s, int map=
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
2.11.0
