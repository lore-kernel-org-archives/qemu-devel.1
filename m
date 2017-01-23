Received: from eggs.gnu.org ([2001:4830:134:3::10]:33729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE7-00029E-3H
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE6-0002yt-9J
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmE6-0002x4-3f
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:34 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A8B42E604C
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:09 +0100
Message-Id: <1485207141-1941-6-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/17] migration: Add multifd capability
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
 qapi-schema.json              | 5 +++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index a184509..19245d6 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -297,6 +297,7 @@ bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);

 bool migrate_auto_converge(void);
+bool migrate_use_multifd(void);

 int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
                          uint8_t *dst, int dlen);
diff --git a/migration/migration.c b/migration/migration.c
index 77d7b84..1669e41 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1319,6 +1319,15 @@ bool migrate_use_events(void)
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
index ddc8783..d34632e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -865,12 +865,13 @@
 #        side, this process is called COarse-Grain LOck Stepping (COLO) for
 #        Non-stop Service. (since 2.8)
 #
+# @x-multifd: Use more than one fd for migration (since 2.9)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram', 'x-colo'] }
-
+           'compress', 'events', 'postcopy-ram', 'x-colo', 'x-multifd'] }
 ##
 # @MigrationCapabilityStatus:
 #
-- 
2.9.3
