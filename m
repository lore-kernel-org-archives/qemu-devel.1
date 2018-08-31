Received: from eggs.gnu.org ([2001:4830:134:3::10]:57965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0G-0001eQ-8N
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrus-0007A4-Nj
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:29:23 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 31 Aug 2018 18:29:06 -0400
Message-Id: <20180831222907.16257-15-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-1-jsnow@redhat.com>
References: <20180831222907.16257-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/15] qapi/block-stream: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c           |  9 +++++++++
 hmp.c                |  5 +++--
 qapi/block-core.json | 16 +++++++++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 429cdf9901..0cf8febe6c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3116,6 +3116,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
+                      bool has_auto_finalize, bool auto_finalize,
+                      bool has_auto_dismiss, bool auto_dismiss,
                       Error **errp)
 {
     BlockDriverState *bs, *iter;
@@ -3185,6 +3187,13 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     /* backing_file string overrides base bs filename */
     base_name = has_backing_file ? backing_file : base_name;
 
+    if (has_auto_finalize && !auto_finalize) {
+        job_flags |= JOB_MANUAL_FINALIZE;
+    }
+    if (has_auto_dismiss && !auto_dismiss) {
+        job_flags |= JOB_MANUAL_DISMISS;
+    }
+
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
                  job_flags, has_speed ? speed : 0, on_error, &local_err);
     if (local_err) {
diff --git a/hmp.c b/hmp.c
index 4975fa56b0..868c1a049d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1905,8 +1905,9 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     int64_t speed = qdict_get_try_int(qdict, "speed", 0);
 
     qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
-                     false, NULL, qdict_haskey(qdict, "speed"), speed,
-                     true, BLOCKDEV_ON_ERROR_REPORT, &error);
+                     false, NULL, qdict_haskey(qdict, "speed"), speed, true,
+                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
+                     &error);
 
     hmp_handle_error(mon, &error);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e785c2e9fe..f877e9e414 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2317,6 +2317,19 @@
 #            'stop' and 'enospc' can only be used if the block device
 #            supports io-status (see BlockInfo).  Since 1.3.
 #
+# @auto-finalize: When false, this job will wait in a PENDING state after it has
+#                 finished its work, waiting for @block-job-finalize before
+#                 making any block graph changes.
+#                 When true, this job will automatically
+#                 perform its abort or commit actions.
+#                 Defaults to true. (Since 3.1)
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
+#                has completely ceased all work, and awaits @block-job-dismiss.
+#                When true, this job will automatically disappear from the query
+#                list without user intervention.
+#                Defaults to true. (Since 3.1)
+#
 # Returns: Nothing on success. If @device does not exist, DeviceNotFound.
 #
 # Since: 1.1
@@ -2332,7 +2345,8 @@
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
             '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
-            '*on-error': 'BlockdevOnError' } }
+            '*on-error': 'BlockdevOnError',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
 # @block-job-set-speed:
-- 
2.14.4
