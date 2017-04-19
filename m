Received: from eggs.gnu.org ([2001:4830:134:3::10]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wie-0004mv-Gh
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wid-0007Nz-L9
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wid-0007Nd-FX
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 637797D0F7
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:18 +0200
Message-Id: <20170419205923.8808-55-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 54/59] migration: Remove MigrationState
 parameter from migration_is_idle()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Only user don't have a MigrationState handly.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h | 2 +-
 migration/migration.c         | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index b84ec3d..ba1a16c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -234,7 +234,7 @@ void remove_migration_state_change_notifier(Notifier *notify);
 MigrationState *migrate_init(const MigrationParams *params);
 bool migration_is_blocked(Error **errp);
 bool migration_in_setup(MigrationState *);
-bool migration_is_idle(MigrationState *s);
+bool migration_is_idle(void);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* True if outgoing migration has entered postcopy phase */
diff --git a/migration/migration.c b/migration/migration.c
index 156daf9..a92d7f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1075,11 +1075,9 @@ bool migration_in_postcopy_after_devices(MigrationState *s)
     return migration_in_postcopy() && s->postcopy_after_devices;
 }
 
-bool migration_is_idle(MigrationState *s)
+bool migration_is_idle(void)
 {
-    if (!s) {
-        s = migrate_get_current();
-    }
+    MigrationState *s = migrate_get_current();
 
     switch (s->state) {
     case MIGRATION_STATUS_NONE:
@@ -1144,7 +1142,7 @@ int migrate_add_blocker(Error *reason, Error **errp)
         return -EACCES;
     }
 
-    if (migration_is_idle(NULL)) {
+    if (migration_is_idle()) {
         migration_blockers = g_slist_prepend(migration_blockers, reason);
         return 0;
     }
-- 
2.9.3
