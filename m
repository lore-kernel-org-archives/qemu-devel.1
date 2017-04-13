Received: from eggs.gnu.org ([2001:4830:134:3::10]:53605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyiTQ-0007cg-9f
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyiTP-0005Bd-EG
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:24:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Apr 2017 19:23:32 +0200
Message-Id: <1492104214-29994-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] migration: Call
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

Commit d35ff5e6 ('block: Ignore guest dev permissions during incoming
migration') added blk_resume_after_migration() to the precopy migration
path, but neglected to add it to the duplicated code that is used for
postcopy migration. This means that the guest device doesn't request the
necessary permissions, which ultimately led to failing assertions.

Add the missing blk_resume_after_migration() to the postcopy path.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 migration/savevm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..43fa9bf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1623,6 +1623,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
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
