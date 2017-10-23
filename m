Received: from eggs.gnu.org ([2001:4830:134:3::10]:35701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fH6-0005Y1-Pl
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fH4-0008LU-28
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fH3-0008KV-Sz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A8A480472
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:45 +0200
Message-Id: <20171023160800.20540-7-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 06/21] migration: Add 'pause-before-switchover'
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When 'pause-before-switchover' is enabled, the outgoing migration
will pause before invalidating the block devices and serializing
the device state.
At this point the management layer gets the chance to clean up any
device jobs or other device users before the migration completes.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 10 ++++++++++
 migration/migration.h |  1 +
 qapi/migration.json   |  5 ++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3feffb5e26..c041ec7aed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1511,6 +1511,16 @@ bool migrate_use_multifd(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
 }
 
+bool migrate_pause_before_switchover(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[
+        MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER];
+}
+
 int migrate_multifd_channels(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index b83cceadc4..969866303e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -177,6 +177,7 @@ bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
+bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
 int migrate_multifd_page_count(void);
 
diff --git a/qapi/migration.json b/qapi/migration.json
index f8b365e3f5..4960231ba2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -341,6 +341,9 @@
 # @return-path: If enabled, migration will use the return path even
 #               for precopy. (since 2.10)
 #
+# @pause-before-switchover: Pause outgoing migration before serialising device
+#          state and before disabling block IO (since 2.11)
+#
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
 # Since: 1.2
@@ -348,7 +351,7 @@
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path', 'x-multifd' ] }
+           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.13.6
