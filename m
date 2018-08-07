Received: from eggs.gnu.org ([2001:4830:134:3::10]:54100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth7-0004l2-8O
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth5-0001MS-EJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:49 -0400
Message-Id: <20180807043349.27196-22-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 21/21] qapi/block-stream: expose new job
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
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 9 +++++++++
 hmp.c                | 5 +++--
 qapi/block-core.json | 3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index bbb3279020..806531dc20 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3226,6 +3226,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
+                      bool has_auto_finalize, bool auto_finalize,
+                      bool has_auto_dismiss, bool auto_dismiss,
                       Error **errp)
 {
     BlockDriverState *bs, *iter;
@@ -3295,6 +3297,13 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
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
index 2aafb50e8e..e3c3ecd76f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1865,8 +1865,9 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
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
index bc53eaf2c0..9d06509d0d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2298,7 +2298,8 @@
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
