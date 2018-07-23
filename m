Received: from eggs.gnu.org ([2001:4830:134:3::10]:42793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKK-0003Y5-KO
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKH-0005As-DX
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:04 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:17 -0500
Message-Id: <20180723201748.25573-69-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 68/99] blockjob: expose error string via query
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: John Snow <jsnow@redhat.com>

When we've reached the concluded state, we need to expose the error
state if applicable. Add the new field.

This should be sufficient for determining if a job completed
successfully or not after concluding; if we want to discriminate
based on how it failed more mechanically, we can always add an
explicit return code enumeration later.

I didn't bother to make it only show up if we are in the concluded
state; I don't think it's necessary.

Cc: qemu-stable@nongnu.org
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ab9ba614556ac5b0f8d96b99e0dba19f1e28d6c2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.17.1
