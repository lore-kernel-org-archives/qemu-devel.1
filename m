Received: from eggs.gnu.org ([2001:4830:134:3::10]:55347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Caa-0001U8-MM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaZ-00018D-An
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:14 +0200
Message-Id: <1493411622-5343-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/34] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Commit d35ff5e6 ('block: Ignore guest dev permissions during incoming
migration') added blk_resume_after_migration() to the precopy migration
path, but neglected to add it to the duplicated code that is used for
postcopy migration. This means that the guest device doesn't request the
necessary permissions, which ultimately led to failing assertions.

Add the missing blk_resume_after_migration() to the postcopy path.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/savevm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 03ae1bd..a00c1ab 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1622,6 +1622,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         error_report_err(local_err);
     }
 
+    /* If we get an error here, just don't restart the VM yet. */
+    blk_resume_after_migration(&local_err);
+    if (local_err) {
+        error_free(local_err);
+        local_err = NULL;
+        autostart = false;
+    }
+
     trace_loadvm_postcopy_handle_run_cpu_sync();
     cpu_synchronize_all_post_init();
 
-- 
1.8.3.1
