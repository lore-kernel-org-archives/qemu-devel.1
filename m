Received: from eggs.gnu.org ([2001:4830:134:3::10]:40613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQCoI-0005Pf-RY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQCoH-0002uQ-TH
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:19:42 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  5 Jun 2018 10:19:33 -0400
Message-Id: <20180605141933.30169-3-jcody@redhat.com>
In-Reply-To: <20180605141933.30169-1-jcody@redhat.com>
References: <20180605141933.30169-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] sheepdog: remove huge BSS object
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

block/sheepdog.o has a 4M static variable that is 90% of QEMU's whole .bs=
s
section.  Replace it with a heap-allocated block, and make it smaller too
since only the inode header is actually being used.

bss size goes down from 4464280 to 269976.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180523160721.14018-3-pbonzini@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index cfc0e28aa5..7b98725af7 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2938,13 +2938,14 @@ static int sd_snapshot_list(BlockDriverState *bs,=
 QEMUSnapshotInfo **psn_tab)
     QEMUSnapshotInfo *sn_tab =3D NULL;
     unsigned wlen, rlen;
     int found =3D 0;
-    static SheepdogInode inode;
+    SheepdogInode *inode;
     unsigned long *vdi_inuse;
     unsigned int start_nr;
     uint64_t hval;
     uint32_t vid;
=20
     vdi_inuse =3D g_malloc(max);
+    inode =3D g_malloc(SD_INODE_HEADER_SIZE);
=20
     fd =3D connect_to_sdog(s, &local_err);
     if (fd < 0) {
@@ -2987,7 +2988,7 @@ static int sd_snapshot_list(BlockDriverState *bs, Q=
EMUSnapshotInfo **psn_tab)
         }
=20
         /* we don't need to read entire object */
-        ret =3D read_object(fd, s->bs, (char *)&inode,
+        ret =3D read_object(fd, s->bs, (char *)inode,
                           vid_to_vdi_oid(vid),
                           0, SD_INODE_HEADER_SIZE, 0,
                           s->cache_flags);
@@ -2996,17 +2997,17 @@ static int sd_snapshot_list(BlockDriverState *bs,=
 QEMUSnapshotInfo **psn_tab)
             continue;
         }
=20
-        if (!strcmp(inode.name, s->name) && is_snapshot(&inode)) {
-            sn_tab[found].date_sec =3D inode.snap_ctime >> 32;
-            sn_tab[found].date_nsec =3D inode.snap_ctime & 0xffffffff;
-            sn_tab[found].vm_state_size =3D inode.vm_state_size;
-            sn_tab[found].vm_clock_nsec =3D inode.vm_clock_nsec;
+        if (!strcmp(inode->name, s->name) && is_snapshot(inode)) {
+            sn_tab[found].date_sec =3D inode->snap_ctime >> 32;
+            sn_tab[found].date_nsec =3D inode->snap_ctime & 0xffffffff;
+            sn_tab[found].vm_state_size =3D inode->vm_state_size;
+            sn_tab[found].vm_clock_nsec =3D inode->vm_clock_nsec;
=20
             snprintf(sn_tab[found].id_str, sizeof(sn_tab[found].id_str),
-                     "%" PRIu32, inode.snap_id);
+                     "%" PRIu32, inode->snap_id);
             pstrcpy(sn_tab[found].name,
-                    MIN(sizeof(sn_tab[found].name), sizeof(inode.tag)),
-                    inode.tag);
+                    MIN(sizeof(sn_tab[found].name), sizeof(inode->tag)),
+                    inode->tag);
             found++;
         }
     }
@@ -3016,6 +3017,7 @@ out:
     *psn_tab =3D sn_tab;
=20
     g_free(vdi_inuse);
+    g_free(inode);
=20
     if (ret < 0) {
         return ret;
--=20
2.13.6
