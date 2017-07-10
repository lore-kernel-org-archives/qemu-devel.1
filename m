Received: from eggs.gnu.org ([2001:4830:134:3::10]:35567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCv-0004oN-Uo
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCt-0008GT-CE
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUcCt-0008GA-5r
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 235F915D9
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:10:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Jul 2017 18:10:32 +0100
Message-Id: <20170710171040.21021-2-dgilbert@redhat.com>
In-Reply-To: <20170710171040.21021-1-dgilbert@redhat.com>
References: <20170710171040.21021-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] migration: fix handling for
 --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

MigrateState object is not ready at that time, so we'll get an
assertion. Use qemu_global_option() instead.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Fixes: 3df663e ("migration: move only_migratable to MigrationState")
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1499242883-2184-2-git-send-email-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/migration.c    | 5 -----
 vl.c                     | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 22551216bb..c079b7771b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -53,7 +53,6 @@ bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
-void migration_only_migratable_set(void);
 void migration_global_dump(Monitor *mon);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 51ccd1a4c5..dbdc121838 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -128,11 +128,6 @@ MigrationState *migrate_get_current(void)
     return current_migration;
 }
 
-void migration_only_migratable_set(void)
-{
-    migrate_get_current()->only_migratable = true;
-}
-
 MigrationIncomingState *migration_incoming_get_current(void)
 {
     static bool once;
diff --git a/vl.c b/vl.c
index d17c863409..7a015eccc6 100644
--- a/vl.c
+++ b/vl.c
@@ -3962,7 +3962,7 @@ int main(int argc, char **argv, char **envp)
                  *
                  * "-global migration.only-migratable=true"
                  */
-                migration_only_migratable_set();
+                qemu_global_option("migration.only-migratable=true");
                 break;
             case QEMU_OPTION_nodefaults:
                 has_defaults = 0;
-- 
2.13.0
