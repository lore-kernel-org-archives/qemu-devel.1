Received: from eggs.gnu.org ([2001:4830:134:3::10]:40610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQCoI-0005PW-KB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQCoH-0002uH-O2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:19:42 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  5 Jun 2018 10:19:32 -0400
Message-Id: <20180605141933.30169-2-jcody@redhat.com>
In-Reply-To: <20180605141933.30169-1-jcody@redhat.com>
References: <20180605141933.30169-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] sheepdog: cleanup repeated expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

From: Paolo Bonzini <pbonzini@redhat.com>

The expression "SD_INODE_SIZE - sizeof(inode.data_vdi_id)" already has a =
macro
defined for the same value (though with a nicer definition using offsetof=
).
Replace it.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180523160721.14018-2-pbonzini@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 2a5bc0a59a..cfc0e28aa5 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2335,7 +2335,7 @@ static int sd_truncate(BlockDriverState *bs, int64_=
t offset,
     }
=20
     /* we don't need to update entire object */
-    datalen =3D SD_INODE_SIZE - sizeof(s->inode.data_vdi_id);
+    datalen =3D SD_INODE_HEADER_SIZE;
     s->inode.vdi_size =3D offset;
     ret =3D write_object(fd, s->bs, (char *)&s->inode,
                        vid_to_vdi_oid(s->inode.vdi_id), s->inode.nr_copi=
es,
@@ -2703,7 +2703,7 @@ static int sd_snapshot_create(BlockDriverState *bs,=
 QEMUSnapshotInfo *sn_info)
      */
     strncpy(s->inode.tag, sn_info->name, sizeof(s->inode.tag));
     /* we don't need to update entire object */
-    datalen =3D SD_INODE_SIZE - sizeof(s->inode.data_vdi_id);
+    datalen =3D SD_INODE_HEADER_SIZE;
     inode =3D g_malloc(datalen);
=20
     /* refresh inode. */
@@ -2989,7 +2989,7 @@ static int sd_snapshot_list(BlockDriverState *bs, Q=
EMUSnapshotInfo **psn_tab)
         /* we don't need to read entire object */
         ret =3D read_object(fd, s->bs, (char *)&inode,
                           vid_to_vdi_oid(vid),
-                          0, SD_INODE_SIZE - sizeof(inode.data_vdi_id), =
0,
+                          0, SD_INODE_HEADER_SIZE, 0,
                           s->cache_flags);
=20
         if (ret) {
--=20
2.13.6
