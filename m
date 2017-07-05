Received: from eggs.gnu.org ([2001:4830:134:3::10]:36310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZ6-0005rd-Ny
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZ5-0000Su-BM
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSfZ5-0000Sh-52
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:39 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Jul 2017 16:21:20 +0800
Message-Id: <1499242883-2184-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1499242883-2184-1-git-send-email-peterx@redhat.com>
References: <1499242883-2184-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] migration: fix handling for
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, haoqf@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

MigrateState object is not ready at that time, so we'll get an
assertion. Use qemu_global_option() instead.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Fixes: 3df663e ("migration: move only_migratable to MigrationState")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/migration.c    | 5 -----
 vl.c                     | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 2255121..c079b77 100644
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
index 51ccd1a..dbdc121 100644
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
index 36ff3f4..0c497a3 100644
--- a/vl.c
+++ b/vl.c
@@ -3958,7 +3958,7 @@ int main(int argc, char **argv, char **envp)
                  *
                  * "-global migration.only-migratable=true"
                  */
-                migration_only_migratable_set();
+                qemu_global_option("migration.only-migratable=true");
                 break;
             case QEMU_OPTION_nodefaults:
                 has_defaults = 0;
-- 
2.7.4
