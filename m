Received: from eggs.gnu.org ([2001:4830:134:3::10]:55417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fGCAU-0002er-4P
	for qemu-devel@nongnu.org; Tue, 08 May 2018 19:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fGCAT-0004Cx-DQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 19:37:14 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 May 2018 19:36:59 -0400
Message-Id: <20180508233659.13973-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] blockjob: expose error string via query
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

When we've reached the concluded state, we need to expose the error
state if applicable. Add the new field.

This should be sufficient for determining if a job completed
successfully or not after concluding; if we want to discriminate
based on how it failed more mechanically, we can always add an
explicit return code enumeration later.

I didn't bother to make it only show up if we are in the concluded
state; I don't think it's necessary.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c           | 2 ++
 qapi/block-core.json | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 27f957e571..4de48166b2 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -831,6 +831,8 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->status    = job->status;
     info->auto_finalize = job->auto_finalize;
     info->auto_dismiss  = job->auto_dismiss;
+    info->has_error = job->ret != 0;
+    info->error     = job->ret ? g_strdup(strerror(-job->ret)) : NULL;
     return info;
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c50517bff3..7da3bea6bc 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1172,6 +1172,9 @@
 # @auto-dismiss: Job will dismiss itself when CONCLUDED, moving to the NULL
 #                state and disappearing from the query list. (since 2.12)
 #
+# @error: Error information if the job did not complete successfully.
+#         Not set if the job completed successfully. (since 2.12.1)
+#
 # Since: 1.1
 ##
 { 'struct': 'BlockJobInfo',
@@ -1179,7 +1182,8 @@
            'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
            'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
            'status': 'BlockJobStatus',
-           'auto-finalize': 'bool', 'auto-dismiss': 'bool' } }
+           'auto-finalize': 'bool', 'auto-dismiss': 'bool',
+           '*error': 'str' } }
 
 ##
 # @query-block-jobs:
-- 
2.14.3
