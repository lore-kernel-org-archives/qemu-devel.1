Received: from eggs.gnu.org ([2001:4830:134:3::10]:54177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xer-0002Ie-QC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xer-0000ji-1e
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xeq-0000jJ-Rr
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC3F68AE6E
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:27 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:27:03 +0800
Message-Id: <20170421122710.15373-8-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] mirror: Make errp the last parameter of
 mirror_start_job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 164438f..0c1a56c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1112,10 +1112,11 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              BlockdevOnError on_target_error,
                              bool unmap,
                              BlockCompletionFunc *cb,
-                             void *opaque, Error **errp,
+                             void *opaque,
                              const BlockJobDriver *driver,
                              bool is_none_mode, BlockDriverState *base,
-                             bool auto_complete, const char *filter_node_name)
+                             bool auto_complete, const char *filter_node_name,
+                             Error **errp)
 {
     MirrorBlockJob *s;
     BlockDriverState *mirror_top_bs;
@@ -1280,9 +1281,9 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
     base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
     mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target, replaces,
                      speed, granularity, buf_size, backing_mode,
-                     on_source_error, on_target_error, unmap, NULL, NULL, errp,
+                     on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name);
+                     filter_node_name, errp);
 }
 
 void commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -1303,9 +1304,9 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN,
-                     on_error, on_error, true, cb, opaque, &local_err,
+                     on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
-                     filter_node_name);
+                     filter_node_name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error_restore_flags;
-- 
2.9.3
