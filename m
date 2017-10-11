Received: from eggs.gnu.org ([2001:4830:134:3::10]:55997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2MRz-0005GC-3x
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2MRy-0004ql-6n
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e2MRy-0004qP-0C
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:50 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 11 Oct 2017 20:13:12 +0100
Message-Id: <20171011191317.24157-3-dgilbert@redhat.com>
In-Reply-To: <20171011191317.24157-1-dgilbert@redhat.com>
References: <20171011191317.24157-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] migration: Add 'pause-before-device' and
 'device' statuses
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

Add two statuses for use when the 'pause-before-device'
capability is enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 6 ++++++
 qapi/migration.json   | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index df8f8c9f14..e1a87c3d23 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -526,6 +526,8 @@ static bool migration_is_setup_or_active(int state)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_SETUP:
+    case MIGRATION_STATUS_PAUSE_BEFORE_DEVICE:
+    case MIGRATION_STATUS_DEVICE:
         return true;
 
     default:
@@ -600,6 +602,8 @@ MigrationInfo *qmp_query_migrate(Error **errp)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_PAUSE_BEFORE_DEVICE:
+    case MIGRATION_STATUS_DEVICE:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
@@ -1183,6 +1187,8 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_COLO:
+    case MIGRATION_STATUS_PAUSE_BEFORE_DEVICE:
+    case MIGRATION_STATUS_DEVICE:
         return false;
     case MIGRATION_STATUS__MAX:
         g_assert_not_reached();
diff --git a/qapi/migration.json b/qapi/migration.json
index 420b56f194..00f2f6cc09 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -96,12 +96,18 @@
 # @colo: VM is in the process of fault tolerance, VM can not get into this
 #        state unless colo capability is enabled for migration. (since 2.8)
 #
+# @pause-before-device: Paused before device serialisation. (since 2.11)
+#
+# @device: During device serialisation when pause-before-device is enabled
+#        (since 2.11)
+#
 # Since: 2.3
 #
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'completed', 'failed', 'colo' ] }
+            'active', 'postcopy-active', 'completed', 'failed', 'colo',
+            'pause-before-device', 'device' ] }
 
 ##
 # @MigrationInfo:
-- 
2.13.6
