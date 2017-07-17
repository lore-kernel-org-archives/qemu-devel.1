Received: from eggs.gnu.org ([2001:4830:134:3::10]:45990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6Ic-0003pk-7e
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6Ib-0005MQ-9j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6Ib-0005LK-3l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13DFE4E047
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:42:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:25 +0200
Message-Id: <20170717134238.1966-5-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 04/17] migration: Add multifd capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 9 +++++++++
 migration/migration.h | 1 +
 qapi-schema.json      | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c24ad03..af2630b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1282,6 +1282,15 @@ bool migrate_use_events(void)
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
diff --git a/migration/migration.h b/migration/migration.h
index 5a18aea..9da9b4e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -172,6 +172,7 @@ bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
+bool migrate_use_multifd(void);
 
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/qapi-schema.json b/qapi-schema.json
index ab438ea..2457fb0 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -902,14 +902,14 @@
 #
 # @return-path: If enabled, migration will use the return path even
 #               for precopy. (since 2.10)
+# @x-multifd: Use more than one fd for migration (since 2.10)
 #
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path' ] }
-
+           'block', 'return-path', 'x-multifd'] }
 ##
 # @MigrationCapabilityStatus:
 #
-- 
2.9.4
