Received: from eggs.gnu.org ([2001:4830:134:3::10]:35898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMui8-0006Tt-Bj
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMui6-00075H-Hf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:56:00 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 14 Nov 2018 13:55:46 +0100
Message-Id: <20181114125546.4319-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vvfat: Fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, Liam.Merwick@oracle.com, qemu-devel@nongnu.org

Don't leak 'cluster' in the mapping =3D=3D NULL case. Found by Coverity
(CID 1055918).

Fixes: 8d9401c2791ee2d2805b741b1ee3006041edcd3e
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 1de5de1db4..b7b61ea8b7 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2510,7 +2510,7 @@ static int commit_one_file(BDRVVVFATState* s,
     uint32_t first_cluster =3D c;
     mapping_t* mapping =3D find_mapping_for_cluster(s, c);
     uint32_t size =3D filesize_of_direntry(direntry);
-    char* cluster =3D g_malloc(s->cluster_size);
+    char *cluster;
     uint32_t i;
     int fd =3D 0;
=20
@@ -2528,17 +2528,17 @@ static int commit_one_file(BDRVVVFATState* s,
     if (fd < 0) {
         fprintf(stderr, "Could not open %s... (%s, %d)\n", mapping->path=
,
                 strerror(errno), errno);
-        g_free(cluster);
         return fd;
     }
     if (offset > 0) {
         if (lseek(fd, offset, SEEK_SET) !=3D offset) {
             qemu_close(fd);
-            g_free(cluster);
             return -3;
         }
     }
=20
+    cluster =3D g_malloc(s->cluster_size);
+
     while (offset < size) {
         uint32_t c1;
         int rest_size =3D (size - offset > s->cluster_size ?
--=20
2.19.1
