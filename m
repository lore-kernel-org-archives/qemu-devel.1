Received: from eggs.gnu.org ([2001:4830:134:3::10]:52930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1H-0002DG-K3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1F-0001YU-Cr
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvN1F-0001Xu-6z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E122C058EB1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 12:25:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 14:24:52 +0200
Message-Id: <20170922122505.9413-6-quintela@redhat.com>
In-Reply-To: <20170922122505.9413-1-quintela@redhat.com>
References: <20170922122505.9413-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 05/18] migration: Add multifd capability
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
index bac4a99277..958b783bcf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1449,6 +1449,15 @@ bool migrate_use_events(void)
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
@@ -2227,6 +2236,7 @@ static Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
     DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
+    DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_X_MULTIFD),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/migration/migration.h b/migration/migration.h
index 1881e4a754..b7437f16ce 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -174,6 +174,7 @@ bool migrate_postcopy_ram(void);
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
