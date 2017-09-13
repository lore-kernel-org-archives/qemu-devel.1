Received: from eggs.gnu.org ([2001:4830:134:3::10]:42113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5PA-0006K5-Gq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5P6-0006eE-LY
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds5P6-0006c3-GD
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DB6F4ACC7
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:00:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 13 Sep 2017 12:59:40 +0200
Message-Id: <20170913105953.13760-8-quintela@redhat.com>
In-Reply-To: <20170913105953.13760-1-quintela@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 07/20] migration: Add multifd capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

--

Use new DEFINE_PROP
---
 migration/migration.c | 10 ++++++++++
 migration/migration.h |  1 +
 qapi/migration.json   |  4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index b15f0ba876..ef5ce6c55d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1458,6 +1458,15 @@ bool migrate_use_events(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
 
+bool migrate_use_multifd(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -2236,6 +2245,7 @@ static Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
     DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
+    DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_X_MULTIFD),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/migration/migration.h b/migration/migration.h
index 7ddb0cdc1a..023b14aa08 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -179,6 +179,7 @@ bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
+bool migrate_use_multifd(void);
 
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index ee2b3b8733..ec4a88a43a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -341,12 +341,14 @@
 # @return-path: If enabled, migration will use the return path even
 #               for precopy. (since 2.10)
 #
+# @x-multifd: Use more than one fd for migration (since 2.11)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path' ] }
+           'block', 'return-path', 'x-multifd' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.13.5
