Received: from eggs.gnu.org ([2001:4830:134:3::10]:57314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d98oA-0003HJ-Rq
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d98o7-0000mD-Mr
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:30 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:49631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d98o7-0000kM-HK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPU00HFY81YWY80@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 12 May 2017 12:32:22 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 12 May 2017 14:31:39 +0300
Message-id: <1494588703-9076-6-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
References: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512113220eucas1p14c340af61c08de90fe20a16be9a3d180@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V4 5/9] migration: introduce postcopy-blocktime
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, peterx@redhat.com

Right now it could be used on destination side to
enable vCPU blocktime calculation for postcopy live migration.
vCPU blocktime - it's time since vCPU thread was put into
interruptible sleep, till memory page was copied and thread awake.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 include/migration/migration.h | 1 +
 migration/migration.c         | 9 +++++++++
 qapi-schema.json              | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index e29cb01..30108d3 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -316,6 +316,7 @@ int migrate_compress_level(void);
 int migrate_compress_threads(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
+bool migrate_postcopy_blocktime(void);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_message(MigrationIncomingState *mis,
diff --git a/migration/migration.c b/migration/migration.c
index 1cce2a1..b0af75f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1371,6 +1371,15 @@ bool migrate_zero_blocks(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_ZERO_BLOCKS];
 }
 
+bool migrate_postcopy_blocktime(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
+}
+
 bool migrate_use_compression(void)
 {
     MigrationState *s;
diff --git a/qapi-schema.json b/qapi-schema.json
index 5728b7f..df9f801 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -894,11 +894,14 @@
 # @release-ram: if enabled, qemu will free the migrated ram pages on the source
 #        during postcopy-ram migration. (since 2.9)
 #
+# @postcopy-blocktime: Calculate downtime for postcopy live migration (since 2.10)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
+           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
+           'postcopy-blocktime'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
1.8.3.1
