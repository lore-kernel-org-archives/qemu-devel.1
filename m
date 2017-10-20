Received: from eggs.gnu.org ([2001:4830:134:3::10]:50767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5TFm-0005eI-Rr
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5TFl-00049v-MS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e5TFl-00049c-DV
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:05 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 20 Oct 2017 10:05:51 +0100
Message-Id: <20171020090556.18631-3-dgilbert@redhat.com>
In-Reply-To: <20171020090556.18631-1-dgilbert@redhat.com>
References: <20171020090556.18631-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/7] migration: Add 'pre-switchover' and
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

Add two statuses for use when the 'pause-before-switchover'
capability is enabled.

'pre-switchover' is the state that we wait in for management
to allow us to continue.
'device' is the state we enter while serialising the devices
after management gives us the OK.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 ++++++
 qapi/migration.json   | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index fba3342368..86ae0292f0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -526,6 +526,8 @@ static bool migration_is_setup_or_active(int state)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_SETUP:
+    case MIGRATION_STATUS_PRE_SWITCHOVER:
+    case MIGRATION_STATUS_DEVICE:
         return true;
 
     default:
@@ -600,6 +602,8 @@ MigrationInfo *qmp_query_migrate(Error **errp)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_PRE_SWITCHOVER:
+    case MIGRATION_STATUS_DEVICE:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
@@ -1183,6 +1187,8 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_COLO:
+    case MIGRATION_STATUS_PRE_SWITCHOVER:
+    case MIGRATION_STATUS_DEVICE:
         return false;
     case MIGRATION_STATUS__MAX:
         g_assert_not_reached();
diff --git a/qapi/migration.json b/qapi/migration.json
index 4960231ba2..b56f95db64 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -96,12 +96,18 @@
 # @colo: VM is in the process of fault tolerance, VM can not get into this
 #        state unless colo capability is enabled for migration. (since 2.8)
 #
+# @pre-switchover: Paused before device serialisation. (since 2.11)
+#
+# @device: During device serialisation when pause-before-switchover is enabled
+#        (since 2.11)
+#
 # Since: 2.3
 #
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'completed', 'failed', 'colo' ] }
+            'active', 'postcopy-active', 'completed', 'failed', 'colo',
+            'pre-switchover', 'device' ] }
 
 ##
 # @MigrationInfo:
-- 
2.13.6
