Received: from eggs.gnu.org ([2001:4830:134:3::10]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yb-0002RD-Kk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ya-00013p-E7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:00 +0100
Message-Id: <20181212132735.16080-7-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/41] block/backup: drop unused synchronization
 interface
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_backup.h | 13 ------------
 block/backup.c               | 38 +++++++-----------------------------
 2 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/include/block/block_backup.h b/include/block/block_backup.h
index 994a3bd2ec..157596c296 100644
--- a/include/block/block_backup.h
+++ b/include/block/block_backup.h
@@ -20,19 +20,6 @@
=20
 #include "block/block_int.h"
=20
-typedef struct CowRequest {
-    int64_t start_byte;
-    int64_t end_byte;
-    QLIST_ENTRY(CowRequest) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} CowRequest;
-
-void backup_wait_for_overlapping_requests(BlockJob *job, int64_t offset,
-                                          uint64_t bytes);
-void backup_cow_request_begin(CowRequest *req, BlockJob *job,
-                              int64_t offset, uint64_t bytes);
-void backup_cow_request_end(CowRequest *req);
-
 void backup_do_checkpoint(BlockJob *job, Error **errp);
=20
 #endif
diff --git a/block/backup.c b/block/backup.c
index 4d084f6ca6..b829b251eb 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -28,6 +28,13 @@
=20
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
=20
+typedef struct CowRequest {
+    int64_t start_byte;
+    int64_t end_byte;
+    QLIST_ENTRY(CowRequest) list;
+    CoQueue wait_queue; /* coroutines blocked on this request */
+} CowRequest;
+
 typedef struct BackupBlockJob {
     BlockJob common;
     BlockBackend *target;
@@ -322,37 +329,6 @@ void backup_do_checkpoint(BlockJob *job, Error **err=
p)
     hbitmap_set(backup_job->copy_bitmap, 0, len);
 }
=20
-void backup_wait_for_overlapping_requests(BlockJob *job, int64_t offset,
-                                          uint64_t bytes)
-{
-    BackupBlockJob *backup_job =3D container_of(job, BackupBlockJob, com=
mon);
-    int64_t start, end;
-
-    assert(block_job_driver(job) =3D=3D &backup_job_driver);
-
-    start =3D QEMU_ALIGN_DOWN(offset, backup_job->cluster_size);
-    end =3D QEMU_ALIGN_UP(offset + bytes, backup_job->cluster_size);
-    wait_for_overlapping_requests(backup_job, start, end);
-}
-
-void backup_cow_request_begin(CowRequest *req, BlockJob *job,
-                              int64_t offset, uint64_t bytes)
-{
-    BackupBlockJob *backup_job =3D container_of(job, BackupBlockJob, com=
mon);
-    int64_t start, end;
-
-    assert(block_job_driver(job) =3D=3D &backup_job_driver);
-
-    start =3D QEMU_ALIGN_DOWN(offset, backup_job->cluster_size);
-    end =3D QEMU_ALIGN_UP(offset + bytes, backup_job->cluster_size);
-    cow_request_begin(req, backup_job, start, end);
-}
-
-void backup_cow_request_end(CowRequest *req)
-{
-    cow_request_end(req);
-}
-
 static void backup_drain(BlockJob *job)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common);
--=20
2.19.2
