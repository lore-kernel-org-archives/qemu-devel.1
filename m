Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A1C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3CB206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3CB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXk2-0005n6-I8
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrg-0007JD-F0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWre-0008R8-GR
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrX-0008OM-4W; Thu, 10 Oct 2019 07:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65A4969089;
 Thu, 10 Oct 2019 11:44:06 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D17875C223;
 Thu, 10 Oct 2019 11:44:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 29/36] block/backup: move in-flight requests handling from
 backup to block-copy
Date: Thu, 10 Oct 2019 13:42:53 +0200
Message-Id: <20191010114300.7746-30-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 10 Oct 2019 11:44:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move synchronization mechanism to block-copy, to be able to use one
block-copy instance from backup job and backup-top filter in parallel.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191001131409.14202-2-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block-copy.h |  8 ++++++
 block/backup.c             | 52 --------------------------------------
 block/block-copy.c         | 43 +++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 54f90d0c9a..962f91056a 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -17,6 +17,13 @@
=20
 #include "block/block.h"
=20
+typedef struct BlockCopyInFlightReq {
+    int64_t start_byte;
+    int64_t end_byte;
+    QLIST_ENTRY(BlockCopyInFlightReq) list;
+    CoQueue wait_queue; /* coroutines blocked on this request */
+} BlockCopyInFlightReq;
+
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef void (*ProgressResetCallbackFunc)(void *opaque);
 typedef struct BlockCopyState {
@@ -27,6 +34,7 @@ typedef struct BlockCopyState {
     bool use_copy_range;
     int64_t copy_range_size;
     uint64_t len;
+    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
=20
     BdrvRequestFlags write_flags;
=20
diff --git a/block/backup.c b/block/backup.c
index 4613b8c88d..d918836f1d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -29,13 +29,6 @@
=20
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
=20
-typedef struct CowRequest {
-    int64_t start_byte;
-    int64_t end_byte;
-    QLIST_ENTRY(CowRequest) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} CowRequest;
-
 typedef struct BackupBlockJob {
     BlockJob common;
     BlockDriverState *source_bs;
@@ -51,50 +44,12 @@ typedef struct BackupBlockJob {
     uint64_t bytes_read;
     int64_t cluster_size;
     NotifierWithReturn before_write;
-    QLIST_HEAD(, CowRequest) inflight_reqs;
=20
     BlockCopyState *bcs;
 } BackupBlockJob;
=20
 static const BlockJobDriver backup_job_driver;
=20
-/* See if in-flight requests overlap and wait for them to complete */
-static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *j=
ob,
-                                                       int64_t start,
-                                                       int64_t end)
-{
-    CowRequest *req;
-    bool retry;
-
-    do {
-        retry =3D false;
-        QLIST_FOREACH(req, &job->inflight_reqs, list) {
-            if (end > req->start_byte && start < req->end_byte) {
-                qemu_co_queue_wait(&req->wait_queue, NULL);
-                retry =3D true;
-                break;
-            }
-        }
-    } while (retry);
-}
-
-/* Keep track of an in-flight request */
-static void cow_request_begin(CowRequest *req, BackupBlockJob *job,
-                              int64_t start, int64_t end)
-{
-    req->start_byte =3D start;
-    req->end_byte =3D end;
-    qemu_co_queue_init(&req->wait_queue);
-    QLIST_INSERT_HEAD(&job->inflight_reqs, req, list);
-}
-
-/* Forget about a completed request */
-static void cow_request_end(CowRequest *req)
-{
-    QLIST_REMOVE(req, list);
-    qemu_co_queue_restart_all(&req->wait_queue);
-}
-
 static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
 {
     BackupBlockJob *s =3D opaque;
@@ -116,7 +71,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *=
job,
                                       bool *error_is_read,
                                       bool is_write_notifier)
 {
-    CowRequest cow_request;
     int ret =3D 0;
     int64_t start, end; /* bytes */
=20
@@ -127,14 +81,9 @@ static int coroutine_fn backup_do_cow(BackupBlockJob =
*job,
=20
     trace_backup_do_cow_enter(job, start, offset, bytes);
=20
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
-
     ret =3D block_copy(job->bcs, start, end - start, error_is_read,
                      is_write_notifier);
=20
-    cow_request_end(&cow_request);
-
     trace_backup_do_cow_return(job, offset, bytes, ret);
=20
     qemu_co_rwlock_unlock(&job->flush_rwlock);
@@ -316,7 +265,6 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
     int ret =3D 0;
=20
-    QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
=20
     backup_init_copy_bitmap(s);
diff --git a/block/block-copy.c b/block/block-copy.c
index 3fc9152853..61e5ea5f46 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -19,6 +19,41 @@
 #include "block/block-copy.h"
 #include "sysemu/block-backend.h"
=20
+static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s=
,
+                                                       int64_t start,
+                                                       int64_t end)
+{
+    BlockCopyInFlightReq *req;
+    bool waited;
+
+    do {
+        waited =3D false;
+        QLIST_FOREACH(req, &s->inflight_reqs, list) {
+            if (end > req->start_byte && start < req->end_byte) {
+                qemu_co_queue_wait(&req->wait_queue, NULL);
+                waited =3D true;
+                break;
+            }
+        }
+    } while (waited);
+}
+
+static void block_copy_inflight_req_begin(BlockCopyState *s,
+                                          BlockCopyInFlightReq *req,
+                                          int64_t start, int64_t end)
+{
+    req->start_byte =3D start;
+    req->end_byte =3D end;
+    qemu_co_queue_init(&req->wait_queue);
+    QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
+}
+
+static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightRe=
q *req)
+{
+    QLIST_REMOVE(req, list);
+    qemu_co_queue_restart_all(&req->wait_queue);
+}
+
 void block_copy_state_free(BlockCopyState *s)
 {
     if (!s) {
@@ -79,6 +114,8 @@ BlockCopyState *block_copy_state_new(
     s->use_copy_range =3D
         !(write_flags & BDRV_REQ_WRITE_COMPRESSED) && s->copy_range_size=
 > 0;
=20
+    QLIST_INIT(&s->inflight_reqs);
+
     /*
      * We just allow aio context change on our block backends. block_cop=
y() user
      * (now it's only backup) is responsible for source and target being=
 in same
@@ -266,6 +303,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
     int64_t end =3D bytes + start; /* bytes */
     void *bounce_buffer =3D NULL;
     int64_t status_bytes;
+    BlockCopyInFlightReq req;
=20
     /*
      * block_copy() user is responsible for keeping source and target in=
 same
@@ -276,6 +314,9 @@ int coroutine_fn block_copy(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end, s->cluster_size));
=20
+    block_copy_wait_inflight_reqs(s, start, bytes);
+    block_copy_inflight_req_begin(s, &req, start, end);
+
     while (start < end) {
         int64_t dirty_end;
=20
@@ -329,5 +370,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
         qemu_vfree(bounce_buffer);
     }
=20
+    block_copy_inflight_req_end(&req);
+
     return ret;
 }
--=20
2.21.0


