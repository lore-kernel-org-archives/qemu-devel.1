Received: from eggs.gnu.org ([2001:4830:134:3::10]:42267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zGW-0000U3-Fp
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zGT-0001Dz-EC
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e3zGT-0001D9-8S
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:52:41 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 16 Oct 2017 14:51:48 +0800
Message-Id: <20171016065216.18162-5-peterx@redhat.com>
In-Reply-To: <20171016065216.18162-1-peterx@redhat.com>
References: <20171016065216.18162-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/32] migration: new postcopy-pause state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Introducing a new state "postcopy-paused", which can be used when the
postcopy migration is paused. It is targeted for postcopy network
failure recovery.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 2 ++
 qapi/migration.json   | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3366bdddcc..22142c8194 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -525,6 +525,7 @@ static bool migration_is_setup_or_active(int state)
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_SETUP:
         return true;
 
@@ -600,6 +601,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
diff --git a/qapi/migration.json b/qapi/migration.json
index f8b365e3f5..d5fd937c26 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -89,6 +89,8 @@
 #
 # @postcopy-active: like active, but now in postcopy mode. (since 2.5)
 #
+# @postcopy-paused: during postcopy but paused. (since 2.11)
+#
 # @completed: migration is finished.
 #
 # @failed: some error occurred during migration process.
@@ -101,7 +103,8 @@
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'completed', 'failed', 'colo' ] }
+            'active', 'postcopy-active', 'postcopy-paused',
+            'completed', 'failed', 'colo' ] }
 
 ##
 # @MigrationInfo:
-- 
2.13.5
