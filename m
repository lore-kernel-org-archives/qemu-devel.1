Received: from eggs.gnu.org ([2001:4830:134:3::10]:45460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dues7-0003TR-38
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dues1-0001NE-Ci
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dues0-0001Mh-WC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:53 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Sep 2017 12:46:39 +0200
Message-Id: <20170920104639.2335-17-quintela@redhat.com>
In-Reply-To: <20170920104639.2335-1-quintela@redhat.com>
References: <20170920104639.2335-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 16/16] migration: introduce postcopy-blocktime
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

From: Alexey Perevalov <a.perevalov@samsung.com>

Right now it could be used on destination side to
enable vCPU blocktime calculation for postcopy live migration.
vCPU blocktime - it's time since vCPU thread was put into
interruptible sleep, till memory page was copied and thread awake.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 9 +++++++++
 migration/migration.h | 1 +
 qapi/migration.json   | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index b9056ccbac..4ceded5a79 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1462,6 +1462,15 @@ bool migrate_zero_blocks(void)
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
index 641290f51b..b84946f69e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -191,6 +191,7 @@ int migrate_compress_level(void);
 int migrate_compress_threads(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
+bool migrate_postcopy_blocktime(void);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_shut(MigrationIncomingState *mis,
diff --git a/qapi/migration.json b/qapi/migration.json
index f8b365e3f5..0f2af26a19 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -343,12 +343,15 @@
 #
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
+# @postcopy-blocktime: Calculate downtime for postcopy live migration
+#                     (since 2.11)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path', 'x-multifd' ] }
+           'block', 'return-path', 'x-multifd', 'postcopy-blocktime' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.13.5
