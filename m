Received: from eggs.gnu.org ([2001:4830:134:3::10]:54096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth7-0004kv-7E
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth3-0001Kq-OD
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:47 -0400
Message-Id: <20180807043349.27196-20-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 19/21] qapi/block-commit: expose new job
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
 blockdev.c           | 8 ++++++++
 qapi/block-core.json | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index c2e6402a66..8efc47e178 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3314,6 +3314,8 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
                       bool has_filter_node_name, const char *filter_node_name,
+                      bool has_auto_finalize, bool auto_finalize,
+                      bool has_auto_dismiss, bool auto_dismiss,
                       Error **errp)
 {
     BlockDriverState *bs;
@@ -3333,6 +3335,12 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     if (!has_filter_node_name) {
         filter_node_name = NULL;
     }
+    if (has_auto_finalize && !auto_finalize) {
+        job_flags |= JOB_MANUAL_FINALIZE;
+    }
+    if (has_auto_dismiss && !auto_dismiss) {
+        job_flags |= JOB_MANUAL_DISMISS;
+    }
 
     /* Important Note:
      *  libvirt relies on the DeviceNotFound error class in order to probe for
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b9084a394..4ee58cfb28 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1518,7 +1518,8 @@
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str', '*top': 'str',
             '*backing-file': 'str', '*speed': 'int',
-            '*filter-node-name': 'str' } }
+            '*filter-node-name': 'str',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
 # @drive-backup:
-- 
2.14.4
