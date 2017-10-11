Received: from eggs.gnu.org ([2001:4830:134:3::10]:55986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2MRy-0005Fq-GB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2MRt-0004ox-IK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e2MRt-0004oX-Bq
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:45 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 11 Oct 2017 20:13:11 +0100
Message-Id: <20171011191317.24157-2-dgilbert@redhat.com>
In-Reply-To: <20171011191317.24157-1-dgilbert@redhat.com>
References: <20171011191317.24157-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] migration: Add 'pause-before-device'
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When 'pause-before-device' is enabled, the outgoing migration
will pause after completing any outstanding IOs but before serialising
the device state.   At this point the management layer gets the
chance to clean up any device jobs or other device users before
the migration completes.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 9 +++++++++
 migration/migration.h | 1 +
 qapi/migration.json   | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 98429dc843..df8f8c9f14 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1521,6 +1521,15 @@ bool migrate_use_multifd(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
 }
 
+bool migrate_pause_before_device(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_PAUSE_BEFORE_DEVICE];
+}
+
 int migrate_multifd_channels(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index b83cceadc4..37feea5453 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -177,6 +177,7 @@ bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
+bool migrate_pause_before_device(void);
 int migrate_multifd_channels(void);
 int migrate_multifd_page_count(void);
 
diff --git a/qapi/migration.json b/qapi/migration.json
index f8b365e3f5..420b56f194 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -341,6 +341,9 @@
 # @return-path: If enabled, migration will use the return path even
 #               for precopy. (since 2.10)
 #
+# @pause-before-device: Pause outgoing migration before serialising device
+#          state but after finalising any IO. (since 2.11)
+#
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
 # Since: 1.2
@@ -348,7 +351,7 @@
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path', 'x-multifd' ] }
+           'block', 'return-path', 'pause-before-device', 'x-multifd' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.13.6
