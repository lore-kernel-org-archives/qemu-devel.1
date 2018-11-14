Received: from eggs.gnu.org ([2001:4830:134:3::10]:37857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gN0Zk-00046s-JU
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gN0Zf-0004aw-Ce
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:11:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:22530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gN0ZX-0004Nm-6j
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:11:36 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Thu, 15 Nov 2018 03:09:12 +0800
Message-Id: <20181114190912.7242-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] migration/migration.c: Add COLO dependency
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Current COLO mode(independent disk mode) need replication module work
together. Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/migration.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b261c1e4ce..49ffb9997a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -918,6 +918,15 @@ static bool migrate_caps_check(bool *cap_list,
     }
 #endif
 
+#ifndef CONFIG_REPLICATION
+    if (cap_list[MIGRATION_CAPABILITY_X_COLO]) {
+        error_setg(errp, "QEMU compiled without replication module"
+                   " can't enable COLO");
+        error_append_hint(errp, "Please enable replication before COLO.\n");
+        return false;
+    }
+#endif
+
     if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
         if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
             /* The decompression threads asynchronously write into RAM
-- 
2.17.GIT
