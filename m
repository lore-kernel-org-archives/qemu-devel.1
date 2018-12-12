Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YY-0002Oj-0Y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YV-0000yr-Px
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:26:59 +0100
Message-Id: <20181212132735.16080-6-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/41] block/replication: drop extra
 synchronization
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

After commit f8d59dfb40
    "block/backup: fix fleecing scheme: use serialized writes" fleecing
(specifically reading from backup target, when backup source is in
backing chain of backup target) is safe, because all backup-job writes
to target are serialized. Therefore we don't need additional
synchronization for these reads.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/replication.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 6349d6958e..0c2989d2cb 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -218,9 +218,6 @@ static coroutine_fn int replication_co_readv(BlockDri=
verState *bs,
                                              QEMUIOVector *qiov)
 {
     BDRVReplicationState *s =3D bs->opaque;
-    BdrvChild *child =3D s->secondary_disk;
-    BlockJob *job =3D NULL;
-    CowRequest req;
     int ret;
=20
     if (s->mode =3D=3D REPLICATION_MODE_PRIMARY) {
@@ -233,28 +230,9 @@ static coroutine_fn int replication_co_readv(BlockDr=
iverState *bs,
         return ret;
     }
=20
-    if (child && child->bs) {
-        job =3D child->bs->job;
-    }
-
-    if (job) {
-        uint64_t remaining_bytes =3D remaining_sectors * BDRV_SECTOR_SIZ=
E;
-
-        backup_wait_for_overlapping_requests(child->bs->job,
-                                             sector_num * BDRV_SECTOR_SI=
ZE,
-                                             remaining_bytes);
-        backup_cow_request_begin(&req, child->bs->job,
-                                 sector_num * BDRV_SECTOR_SIZE,
-                                 remaining_bytes);
-        ret =3D bdrv_co_preadv(bs->file, sector_num * BDRV_SECTOR_SIZE,
-                             remaining_bytes, qiov, 0);
-        backup_cow_request_end(&req);
-        goto out;
-    }
-
     ret =3D bdrv_co_preadv(bs->file, sector_num * BDRV_SECTOR_SIZE,
                          remaining_sectors * BDRV_SECTOR_SIZE, qiov, 0);
-out:
+
     return replication_return_value(s, ret);
 }
=20
--=20
2.19.2
