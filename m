Received: from eggs.gnu.org ([2001:4830:134:3::10]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dQ-0000G2-CO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dP-0000m2-Hm
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dP-0000lO-Bf
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50EC67E9CB
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:47:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:44 +0100
Message-Id: <20170323204544.12015-52-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 51/51] migration: Remove MigrationState
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
---
 include/migration/migration.h | 2 +-
 migration/migration.c         | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 39a8e7e..6f7221f 100644
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
index fc19ba7..ba1d094 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1067,11 +1067,9 @@ bool migration_in_postcopy_after_devices(MigrationState *s)
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
@@ -1136,7 +1134,7 @@ int migrate_add_blocker(Error *reason, Error **errp)
         return -EACCES;
     }
 
-    if (migration_is_idle(NULL)) {
+    if (migration_is_idle()) {
         migration_blockers = g_slist_prepend(migration_blockers, reason);
         return 0;
     }
-- 
2.9.3
