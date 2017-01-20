Received: from eggs.gnu.org ([2001:4830:134:3::10]:43537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYi-0006hX-OX
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYh-0000Pi-In
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:28 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Jan 2017 15:23:07 +0800
Message-Id: <20170120072310.8009-14-famz@redhat.com>
In-Reply-To: <20170120072310.8009-1-famz@redhat.com>
References: <20170120072310.8009-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 13/16] tests: Disable image lock in
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, eblake@redhat.com

The COLO block replication architecture requires one disk to be shared
between primary and secondary, in the test both processes use posix file
protocol (instead of over NBD) so it is affected by image locking.
Disable the lock.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/test-replication.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index fac2da3..5bede49 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -179,7 +179,8 @@ static BlockBackend *start_primary(void)
     char *cmdline;
 
     cmdline = g_strdup_printf("driver=replication,mode=primary,node-name=xxx,"
-                              "file.driver=qcow2,file.file.filename=%s"
+                              "file.driver=qcow2,file.file.filename=%s,"
+                              "file.file.disable-lock=on"
                               , p_local_disk);
     opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
@@ -310,7 +311,9 @@ static BlockBackend *start_secondary(void)
     Error *local_err = NULL;
 
     /* add s_local_disk and forge S_LOCAL_DISK_ID */
-    cmdline = g_strdup_printf("file.filename=%s,driver=qcow2", s_local_disk);
+    cmdline = g_strdup_printf("file.filename=%s,driver=qcow2,"
+                              "file.file.disable-lock=on",
+                              s_local_disk);
     opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
 
@@ -331,8 +334,10 @@ static BlockBackend *start_secondary(void)
     /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */
     cmdline = g_strdup_printf("driver=replication,mode=secondary,top-id=%s,"
                               "file.driver=qcow2,file.file.filename=%s,"
+                              "file.file.disable-lock=on",
                               "file.backing.driver=qcow2,"
                               "file.backing.file.filename=%s,"
+                              "file.backing.file.disable-lock=on",
                               "file.backing.backing=%s"
                               , S_ID, s_active_disk, s_hidden_disk
                               , S_LOCAL_DISK_ID);
-- 
2.9.3
