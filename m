Received: from eggs.gnu.org ([2001:4830:134:3::10]:41697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1w-0006Fr-6K
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1v-0000Gc-Ai
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:19:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  2 May 2017 16:18:26 +0800
Message-Id: <20170502081832.9546-17-famz@redhat.com>
In-Reply-To: <20170502081832.9546-1-famz@redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v16 16/22] tests: Disable image lock in
 test-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The COLO block replication architecture requires one disk to be shared
between primary and secondary, in the test both processes use posix file
protocol (instead of over NBD) so it is affected by image locking.
Disable the lock.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/test-replication.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index 3016c6f..cebeb79 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -179,7 +179,8 @@ static BlockBackend *start_primary(void)
     char *cmdline;
 
     cmdline = g_strdup_printf("driver=replication,mode=primary,node-name=xxx,"
-                              "file.driver=qcow2,file.file.filename=%s"
+                              "file.driver=qcow2,file.file.filename=%s,"
+                              "file.file.locking=off"
                               , p_local_disk);
     opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
@@ -310,7 +311,9 @@ static BlockBackend *start_secondary(void)
     Error *local_err = NULL;
 
     /* add s_local_disk and forge S_LOCAL_DISK_ID */
-    cmdline = g_strdup_printf("file.filename=%s,driver=qcow2", s_local_disk);
+    cmdline = g_strdup_printf("file.filename=%s,driver=qcow2,"
+                              "file.locking=off",
+                              s_local_disk);
     opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
 
@@ -331,8 +334,10 @@ static BlockBackend *start_secondary(void)
     /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */
     cmdline = g_strdup_printf("driver=replication,mode=secondary,top-id=%s,"
                               "file.driver=qcow2,file.file.filename=%s,"
+                              "file.file.locking=off,"
                               "file.backing.driver=qcow2,"
                               "file.backing.file.filename=%s,"
+                              "file.backing.file.locking=off,"
                               "file.backing.backing=%s"
                               , S_ID, s_active_disk, s_hidden_disk
                               , S_LOCAL_DISK_ID);
-- 
2.9.3
