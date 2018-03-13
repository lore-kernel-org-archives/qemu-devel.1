Received: from eggs.gnu.org ([2001:4830:134:3::10]:36683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGz-0000zW-TY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGw-0008BP-RQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Mar 2018 21:03:13 +0300
Message-Id: <20180313180320.339796-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180313180320.339796-1-vsementsov@virtuozzo.com>
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v11 06/13] qapi: add dirty-bitmaps migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 qapi/migration.json   | 6 +++++-
 migration/migration.h | 1 +
 migration/migration.c | 9 +++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 7f465a1902..9d0bf82cf4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -354,12 +354,16 @@
 #
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
+# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
+#                 (since 2.12)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
+           'block', 'return-path', 'pause-before-switchover', 'x-multifd',
+           'dirty-bitmaps' ] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/migration/migration.h b/migration/migration.h
index 08c5d2ded1..da6bc37de8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -205,6 +205,7 @@ bool migrate_postcopy(void);
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
+bool migrate_dirty_bitmaps(void);
 
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
diff --git a/migration/migration.c b/migration/migration.c
index 90307f8ab5..e0aff5c814 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1565,6 +1565,15 @@ int migrate_decompress_threads(void)
     return s->parameters.decompress_threads;
 }
 
+bool migrate_dirty_bitmaps(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
+}
+
 bool migrate_use_events(void)
 {
     MigrationState *s;
-- 
2.11.1
