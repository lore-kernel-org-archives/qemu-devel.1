Received: from eggs.gnu.org ([2001:4830:134:3::10]:58547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGND8-0004Xs-18
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGND7-00018T-65
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGND7-00017z-1N
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9D2EE4480
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:40 +0200
Message-Id: <20180509112406.6183-16-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 15/41] migration: new postcopy-pause state
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

From: Peter Xu <peterx@redhat.com>

Introducing a new state "postcopy-paused", which can be used when the
postcopy migration is paused. It is targeted for postcopy network
failure recovery.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-3-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 ++
 qapi/migration.json   | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 61c4ee7850..02ebd6c9d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -574,6 +574,7 @@ static bool migration_is_setup_or_active(int state)
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -654,6 +655,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
diff --git a/qapi/migration.json b/qapi/migration.json
index f3974c6807..244334e9f4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -89,6 +89,8 @@
 #
 # @postcopy-active: like active, but now in postcopy mode. (since 2.5)
 #
+# @postcopy-paused: during postcopy but paused. (since 2.13)
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
2.17.0
