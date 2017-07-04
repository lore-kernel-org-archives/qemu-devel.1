Received: from eggs.gnu.org ([2001:4830:134:3::10]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwr-0008Ku-6L
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwq-0000av-9q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:26 +0200
Message-Id: <20170704220346.29244-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/35] backup: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/block/block_backup.h | 4 ++--
 block/backup.c               | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/block/block_backup.h b/include/block/block_backup.h
index 8a759477a3..415cf8519d 100644
--- a/include/block/block_backup.h
+++ b/include/block/block_backup.h
@@ -27,12 +27,12 @@ typedef struct CowRequest {
     CoQueue wait_queue; /* coroutines blocked on this request */
 } CowRequest;
=20
-void backup_wait_for_overlapping_requests(BlockJob *job, int64_t sector_=
num,
+void coroutine_fn backup_wait_for_overlapping_requests(BlockJob *job, in=
t64_t sector_num,
                                           int nb_sectors);
 void backup_cow_request_begin(CowRequest *req, BlockJob *job,
                               int64_t sector_num,
                               int nb_sectors);
-void backup_cow_request_end(CowRequest *req);
+void coroutine_fn backup_cow_request_end(CowRequest *req);
=20
 void backup_do_checkpoint(BlockJob *job, Error **errp);
=20
diff --git a/block/backup.c b/block/backup.c
index 5387fbd84e..58ddd80b3f 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -84,7 +84,8 @@ static void cow_request_begin(CowRequest *req, BackupBl=
ockJob *job,
 }
=20
 /* Forget about a completed request */
-static void cow_request_end(CowRequest *req)
+static void coroutine_fn
+cow_request_end(CowRequest *req)
 {
     QLIST_REMOVE(req, list);
     qemu_co_queue_restart_all(&req->wait_queue);
@@ -275,7 +276,8 @@ void backup_do_checkpoint(BlockJob *job, Error **errp=
)
     bitmap_zero(backup_job->done_bitmap, len);
 }
=20
-void backup_wait_for_overlapping_requests(BlockJob *job, int64_t sector_=
num,
+void coroutine_fn
+backup_wait_for_overlapping_requests(BlockJob *job, int64_t sector_num,
                                           int nb_sectors)
 {
     BackupBlockJob *backup_job =3D container_of(job, BackupBlockJob, com=
mon);
@@ -304,7 +306,8 @@ void backup_cow_request_begin(CowRequest *req, BlockJ=
ob *job,
     cow_request_begin(req, backup_job, start, end);
 }
=20
-void backup_cow_request_end(CowRequest *req)
+void coroutine_fn
+backup_cow_request_end(CowRequest *req)
 {
     cow_request_end(req);
 }
--=20
2.13.1.395.gf7b71de06
