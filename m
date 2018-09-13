Received: from eggs.gnu.org ([2001:4830:134:3::10]:47065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7a-0002cR-2L
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7U-00029A-VH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:12 +0200
Message-Id: <20180913125217.23173-13-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/17] mirror: Fix potential use-after-free
 in active commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

When starting an active commit job, other callbacks can run before
mirror_start_job() calls bdrv_ref() where needed and cause the nodes to
go away. Add another pair of bdrv_ref/unref() around it to protect
against this case.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 56d9ef7474..c8657991cf 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1697,7 +1697,14 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 
     orig_base_flags = bdrv_get_flags(base);
 
+    /* bdrv_reopen() drains, which might make the BDSes go away before a
+     * reference is taken in mirror_start_job(). */
+    bdrv_ref(bs);
+    bdrv_ref(base);
+
     if (bdrv_reopen(base, bs->open_flags, errp)) {
+        bdrv_unref(bs);
+        bdrv_unref(base);
         return;
     }
 
@@ -1707,6 +1714,10 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
                      &local_err);
+
+    bdrv_unref(bs);
+    bdrv_unref(base);
+
     if (local_err) {
         error_propagate(errp, local_err);
         goto error_restore_flags;
-- 
2.13.6
