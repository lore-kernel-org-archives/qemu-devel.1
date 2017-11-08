Received: from eggs.gnu.org ([2001:4830:134:3::10]:35714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJQt-0007tW-9X
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJQs-0006QC-LU
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJQs-0006Q3-Fs
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:50 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:02 +0800
Message-Id: <20171108060130.3772-5-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/32] migration: new postcopy-pause state
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
 migration/migration.c | 2 ++
 qapi/migration.json   | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index eae34d0524..dd270f8bc5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -530,6 +530,7 @@ static bool migration_is_setup_or_active(int state)
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -609,6 +610,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
diff --git a/qapi/migration.json b/qapi/migration.json
index bbc4671ded..dbcd43aa40 100644
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
-- 
2.13.6
