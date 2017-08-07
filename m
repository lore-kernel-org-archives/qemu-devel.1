Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJA-0007Ss-VX
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIv-0003zd-Ej
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:48 +0200
Message-Id: <1502117160-24655-45-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 44/56] blockjob: Lift speed sign conversion
 out of blockdev_mirror_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

blockdev_mirror_common() takes int64_t speed.  The underlying BlockJob
abstraction takes uint64_t.  blockdev_mirror_common() converts from
int64_t to uint64_t, rejecting negative speed.

Lift this check and conversion out of blockdev_mirror_common() into
its callers.  I'm going to lift it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 06f87e3..13df88b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3419,7 +3419,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    bool has_replaces, const char *replaces,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
-                                   bool has_speed, int64_t speed,
+                                   bool has_speed, uint64_t speed,
                                    bool has_granularity, uint64_t granularity,
                                    bool has_buf_size, int64_t buf_size,
                                    bool has_on_source_error,
@@ -3454,11 +3454,6 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         filter_node_name = NULL;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
     if (granularity != 0 && (granularity < 512 || granularity > 1048576 * 64)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
                    "a value in range [512B, 64MB]");
@@ -3508,6 +3503,12 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
+    if (arg->speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3667,6 +3668,12 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
         return;
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
-- 
2.7.5
