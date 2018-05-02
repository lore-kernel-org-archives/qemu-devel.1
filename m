Received: from eggs.gnu.org ([2001:4830:134:3::10]:34703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIl-0006Dw-Lm
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIk-0002hj-Oe
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:47:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpIk-0002hG-Hw
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:47:58 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:18 +0800
Message-Id: <20180502104740.12123-3-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 02/24] migration: new postcopy-pause state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Introducing a new state "postcopy-paused", which can be used when the
postcopy migration is paused. It is targeted for postcopy network
failure recovery.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json   | 5 ++++-
 migration/migration.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index f3974c6807..97891aec89 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -89,6 +89,8 @@
 #
 # @postcopy-active: like active, but now in postcopy mode. (since 2.5)
 #
+# @postcopy-paused: during postcopy but paused. (since 2.12)
+#
 # @completed: migration is finished.
 #
 # @failed: some error occurred during migration process.
@@ -106,7 +108,8 @@
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'completed', 'failed', 'colo',
+            'active', 'postcopy-active', 'postcopy-paused',
+            'completed', 'failed', 'colo',
             'pre-switchover', 'device' ] }
 
 ##
diff --git a/migration/migration.c b/migration/migration.c
index 0bdb28e144..57ff1010e5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -569,6 +569,7 @@ static bool migration_is_setup_or_active(int state)
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -649,6 +650,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
-- 
2.14.3
