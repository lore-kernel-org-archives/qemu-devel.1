Received: from eggs.gnu.org ([209.51.188.92]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5u-00009q-H4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5t-0008Bg-Gg
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:12 +0100
Message-Id: <20190308125823.32535-23-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/33] qcow2: Return error for snapshot
 operation with data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Internal snapshots and an external data file are incompatible because
snapshots require refcounting and non-linear mapping. Return an error
for all of the snapshot operations if an external data file is in use.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-snapshot.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 5ae3407f68..a6ffae89a6 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -353,6 +353,10 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMU=
SnapshotInfo *sn_info)
         return -EFBIG;
     }
=20
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
+
     memset(sn, 0, sizeof(*sn));
=20
     /* Generate an ID */
@@ -466,6 +470,10 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const =
char *snapshot_id)
     int ret;
     uint64_t *sn_l1_table =3D NULL;
=20
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
+
     /* Search the snapshot */
     snapshot_index =3D find_snapshot_by_id_or_name(bs, snapshot_id);
     if (snapshot_index < 0) {
@@ -599,6 +607,10 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
     QCowSnapshot sn;
     int snapshot_index, ret;
=20
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
+
     /* Search the snapshot */
     snapshot_index =3D find_snapshot_by_id_and_name(bs, snapshot_id, nam=
e);
     if (snapshot_index < 0) {
@@ -670,6 +682,9 @@ int qcow2_snapshot_list(BlockDriverState *bs, QEMUSna=
pshotInfo **psn_tab)
     QCowSnapshot *sn;
     int i;
=20
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
     if (!s->nb_snapshots) {
         *psn_tab =3D NULL;
         return s->nb_snapshots;
--=20
2.20.1
