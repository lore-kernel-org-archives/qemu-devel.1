Received: from eggs.gnu.org ([2001:4830:134:3::10]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1gAoMs-0000bT-Hy
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1gAoMn-0004Jz-JR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:44:02 -0400
Received: from [220.181.50.185] (port=59356 helo=baidu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1gAoMn-0004Fj-5O
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:43:57 -0400
From: jialina01 <jialina01@baidu.com>
Date: Fri, 12 Oct 2018 10:56:23 +0800
Message-ID: <20181012025623.38792-1-jialina01@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] migration: avoid segmentfault when take a
 snapshot of a VM which being migrated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jialina01@baidu.com, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org
Cc: chaiwen <chaiwen@baidu.com>, zhangyu <zhangyu31@baidu.com>

During an active background migraion, snapshot will trigger a
segmentfault. As snapshot clears the "current_migration" struct
and updates "to_dst_file" before it finds out that there is a
migration task, Migration accesses the null pointer in
"current_migration" struct and qemu crashes eventually.

Signed-off-by: jialina01 <jialina01@baidu.com>
Signed-off-by: chaiwen <chaiwen@baidu.com>
Signed-off-by: zhangyu <zhangyu31@baidu.com>
---
 migration/savevm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 2d10e45582..9cb97ca343 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1319,21 +1319,18 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     MigrationState *ms = migrate_get_current();
     MigrationStatus status;
 
-    migrate_init(ms);
-
-    ms->to_dst_file = f;
-
     if (migration_is_blocked(errp)) {
-        ret = -EINVAL;
-        goto done;
+        return -EINVAL;
     }
 
     if (migrate_use_block()) {
         error_setg(errp, "Block migration and snapshots are incompatible");
-        ret = -EINVAL;
-        goto done;
+        return -EINVAL;
     }
 
+    migrate_init(ms);
+    ms->to_dst_file = f;
+
     qemu_mutex_unlock_iothread();
     qemu_savevm_state_header(f);
     qemu_savevm_state_setup(f);
@@ -1355,7 +1352,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         error_setg_errno(errp, -ret, "Error while writing VM state");
     }
 
-done:
     if (ret != 0) {
         status = MIGRATION_STATUS_FAILED;
     } else {
-- 
2.13.2.windows.1
