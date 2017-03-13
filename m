Received: from eggs.gnu.org ([2001:4830:134:3::10]:56431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLC-0004IH-RP
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLC-0005ry-2u
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLB-0005rW-TR
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:46 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A2A23A76A8
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:23 +0100
Message-Id: <20170313124434.1043-6-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/16] migration: Add multifd capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h | 1 +
 migration/migration.c         | 9 +++++++++
 qapi-schema.json              | 6 ++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5720c88..d48934b 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -323,6 +323,7 @@ bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
+bool migrate_use_multifd(void);
 
 int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
                          uint8_t *dst, int dlen);
diff --git a/migration/migration.c b/migration/migration.c
index 3dab684..0e5b0bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1409,6 +1409,15 @@ bool migrate_use_events(void)
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
diff --git a/qapi-schema.json b/qapi-schema.json
index 32b4a4b..d21934b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -868,12 +868,14 @@
 # @release-ram: if enabled, qemu will free the migrated ram pages on the source
 #        during postcopy-ram migration. (since 2.9)
 #
+# @x-multifd: Use more than one fd for migration (since 2.9)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
-
+           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
+           'x-multifd'] }
 ##
 # @MigrationCapabilityStatus:
 #
-- 
2.9.3
