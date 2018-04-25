Received: from eggs.gnu.org ([2001:4830:134:3::10]:45236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQde-0003ZW-8Z
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdb-0002zF-6F
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdb-0002yo-1a
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:35 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:11 +0100
Message-Id: <20180425200326.72337-2-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 01/16] migration: introduce postcopy-blocktime
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: Alexey Perevalov <a.perevalov@samsung.com>

Right now it could be used on destination side to
enable vCPU blocktime calculation for postcopy live migration.
vCPU blocktime - it's time since vCPU thread was put into
interruptible sleep, till memory page was copied and thread awake.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1521742647-25550-2-git-send-email-a.perevalov@samsung.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 9 +++++++++
 migration/migration.h | 1 +
 qapi/migration.json   | 6 +++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 52a5092add..bf2e8db9c7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1541,6 +1541,15 @@ bool migrate_zero_blocks(void)
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
diff --git a/migration/migration.h b/migration/migration.h
index 8d2f320c48..46a50bc789 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -230,6 +230,7 @@ int migrate_compress_level(void);
 int migrate_compress_threads(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
+bool migrate_postcopy_blocktime(void);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_shut(MigrationIncomingState *mis,
diff --git a/qapi/migration.json b/qapi/migration.json
index 9d0bf82cf4..24bfc190ba 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -354,16 +354,20 @@
 #
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
+#
 # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
 #                 (since 2.12)
 #
+# @postcopy-blocktime: Calculate downtime for postcopy live migration
+#                     (since 2.13)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
            'block', 'return-path', 'pause-before-switchover', 'x-multifd',
-           'dirty-bitmaps' ] }
+           'dirty-bitmaps', 'postcopy-blocktime' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.17.0
