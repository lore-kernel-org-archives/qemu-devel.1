Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920BFC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652FA20673
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652FA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXpY-00070h-Tw
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrh-0007Kv-G7
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrg-0008Rt-9o
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrc-0008Pc-8U; Thu, 10 Oct 2019 07:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 919993090FDB;
 Thu, 10 Oct 2019 11:44:10 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 356CB60BE1;
 Thu, 10 Oct 2019 11:44:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/36] block/block-copy: split block_copy_set_callbacks function
Date: Thu, 10 Oct 2019 13:42:55 +0200
Message-Id: <20191010114300.7746-32-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 10 Oct 2019 11:44:10 +0000 (UTC)
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

Split block_copy_set_callbacks out of block_copy_state_new. It's needed
for further commit: block-copy will use BdrvChildren of backup-top
filter, so it will be created from backup-top filter creation function.
But callbacks will still belong to backup job and will be set in
separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191001131409.14202-4-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block-copy.h | 13 +++++++++----
 block/backup.c             |  6 ++++--
 block/block-copy.c         | 24 +++++++++++++++---------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 962f91056a..340d856246 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -66,12 +66,17 @@ typedef struct BlockCopyState {
     void *progress_opaque;
 } BlockCopyState;
=20
-BlockCopyState *block_copy_state_new(
-        BlockDriverState *source, BlockDriverState *target,
-        int64_t cluster_size, BdrvRequestFlags write_flags,
+BlockCopyState *block_copy_state_new(BlockDriverState *source,
+                                     BlockDriverState *target,
+                                     int64_t cluster_size,
+                                     BdrvRequestFlags write_flags,
+                                     Error **errp);
+
+void block_copy_set_callbacks(
+        BlockCopyState *s,
         ProgressBytesCallbackFunc progress_bytes_callback,
         ProgressResetCallbackFunc progress_reset_callback,
-        void *progress_opaque, Error **errp);
+        void *progress_opaque);
=20
 void block_copy_state_free(BlockCopyState *s);
=20
diff --git a/block/backup.c b/block/backup.c
index b5b7939356..1057ed0a4e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -478,8 +478,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     job->bitmap_mode =3D bitmap_mode;
=20
     job->bcs =3D block_copy_state_new(bs, target, cluster_size, write_fl=
ags,
-                                    backup_progress_bytes_callback,
-                                    backup_progress_reset_callback, job,=
 errp);
+                                    errp);
     if (!job->bcs) {
         goto error;
     }
@@ -487,6 +486,9 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     job->cluster_size =3D cluster_size;
     job->len =3D len;
=20
+    block_copy_set_callbacks(job->bcs, backup_progress_bytes_callback,
+                             backup_progress_reset_callback, job);
+
     /* Required permissions are already taken by block-copy-state target=
 */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
diff --git a/block/block-copy.c b/block/block-copy.c
index 61e5ea5f46..fcb112da14 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -66,12 +66,10 @@ void block_copy_state_free(BlockCopyState *s)
     g_free(s);
 }
=20
-BlockCopyState *block_copy_state_new(
-        BlockDriverState *source, BlockDriverState *target,
-        int64_t cluster_size, BdrvRequestFlags write_flags,
-        ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
-        void *progress_opaque, Error **errp)
+BlockCopyState *block_copy_state_new(BlockDriverState *source,
+                                     BlockDriverState *target,
+                                     int64_t cluster_size,
+                                     BdrvRequestFlags write_flags, Error=
 **errp)
 {
     BlockCopyState *s;
     int ret;
@@ -95,9 +93,6 @@ BlockCopyState *block_copy_state_new(
         .cluster_size =3D cluster_size,
         .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
         .write_flags =3D write_flags,
-        .progress_bytes_callback =3D progress_bytes_callback,
-        .progress_reset_callback =3D progress_reset_callback,
-        .progress_opaque =3D progress_opaque,
     };
=20
     s->copy_range_size =3D QEMU_ALIGN_DOWN(MIN(blk_get_max_transfer(s->s=
ource),
@@ -144,6 +139,17 @@ fail:
     return NULL;
 }
=20
+void block_copy_set_callbacks(
+        BlockCopyState *s,
+        ProgressBytesCallbackFunc progress_bytes_callback,
+        ProgressResetCallbackFunc progress_reset_callback,
+        void *progress_opaque)
+{
+    s->progress_bytes_callback =3D progress_bytes_callback;
+    s->progress_reset_callback =3D progress_reset_callback;
+    s->progress_opaque =3D progress_opaque;
+}
+
 /*
  * Copy range to target with a bounce buffer and return the bytes copied=
. If
  * error occurred, return a negative error number
--=20
2.21.0


