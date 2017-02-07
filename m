Received: from eggs.gnu.org ([2001:4830:134:3::10]:57801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L9-0000W6-M0
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L5-00079n-1A
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Feb 2017 18:05:30 +0300
Message-Id: <1486479940-163258-8-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 07/17] qapi: add dirty-bitmaps migration
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
---
 include/migration/migration.h | 1 +
 migration/migration.c         | 9 +++++++++
 qapi-schema.json              | 4 +++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3aa228c..38eba2e 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -308,6 +308,7 @@ void migrate_del_blocker(Error *reason);
 bool migrate_postcopy(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
+bool migrate_dirty_bitmaps(void);
 
 bool migrate_auto_converge(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 2fb734e..64f88ac 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1369,6 +1369,15 @@ int migrate_decompress_threads(void)
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
diff --git a/qapi-schema.json b/qapi-schema.json
index cbdffdd..5ae1d79 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -865,11 +865,13 @@
 #        side, this process is called COarse-Grain LOck Stepping (COLO) for
 #        Non-stop Service. (since 2.8)
 #
+# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps. (since 2.9)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram', 'x-colo'] }
+           'compress', 'events', 'postcopy-ram', 'x-colo', 'dirty-bitmaps'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
1.8.3.1
