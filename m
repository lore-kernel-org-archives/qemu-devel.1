Received: from eggs.gnu.org ([2001:4830:134:3::10]:43113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw9S-0003hW-S4
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw9R-0005X9-Sx
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw9R-0005We-Jm
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 827964E040
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:51:28 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:46 +0800
Message-Id: <1497876588-947-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/13] migration: move only_migratable to
 MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

One less global variable, and it does only matter with migration.

We keep the old "--only-migratable" option, but also now we support:

  -global migration.only-migratable=true

Currently still keep the old interface.

Hmm, now vl.c has no way to access migrate_get_current(). Export a
function for it to setup only_migratable.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 2 ++
 include/sysemu/sysemu.h  | 1 -
 migration/migration.c    | 8 +++++++-
 migration/migration.h    | 3 +++
 migration/savevm.c       | 2 +-
 vl.c                     | 9 +++++++--
 6 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 65c7070..23e533f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -54,4 +54,6 @@ bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
+void migration_only_migratable_set(bool only_migratable);
+
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 9841a52..b213696 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -15,7 +15,6 @@
 /* vl.c */
 
 extern const char *bios_name;
-extern int only_migratable;
 extern const char *qemu_name;
 extern QemuUUID qemu_uuid;
 extern bool qemu_uuid_set;
diff --git a/migration/migration.c b/migration/migration.c
index 095abd8..9af5c76 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -110,6 +110,11 @@ MigrationState *migrate_get_current(void)
     return current_migration;
 }
 
+void migration_only_migratable_set(bool only_migratable)
+{
+    migrate_get_current()->only_migratable = only_migratable;
+}
+
 MigrationIncomingState *migration_incoming_get_current(void)
 {
     static bool once;
@@ -981,7 +986,7 @@ static GSList *migration_blockers;
 
 int migrate_add_blocker(Error *reason, Error **errp)
 {
-    if (only_migratable) {
+    if (migrate_get_current()->only_migratable) {
         error_propagate(errp, error_copy(reason));
         error_prepend(errp, "disallowing migration blocker "
                           "(--only_migratable) for: ");
@@ -1979,6 +1984,7 @@ void migrate_fd_connect(MigrationState *s)
 static Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
+    DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/migration/migration.h b/migration/migration.h
index 4b898e9..34377dd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -139,6 +139,9 @@ struct MigrationState
      * during migration.
      */
     bool store_global_state;
+
+    /* Whether the VM is only allowing for migratable devices */
+    bool only_migratable;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/savevm.c b/migration/savevm.c
index f32a82d..d8ea522 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2303,7 +2303,7 @@ void vmstate_register_ram_global(MemoryRegion *mr)
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     /* check needed if --only-migratable is specified */
-    if (!only_migratable) {
+    if (!migrate_get_current()->only_migratable) {
         return true;
     }
 
diff --git a/vl.c b/vl.c
index a564139..be2a918 100644
--- a/vl.c
+++ b/vl.c
@@ -188,7 +188,6 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
-int only_migratable; /* turn it off unless user states otherwise */
 
 int icount_align_option;
 
@@ -3916,7 +3915,13 @@ int main(int argc, char **argv, char **envp)
                 incoming = optarg;
                 break;
             case QEMU_OPTION_only_migratable:
-                only_migratable = 1;
+                /*
+                 * TODO: we can remove this option one day, and we
+                 * should all use:
+                 *
+                 * "-global migration.only-migratable=true"
+                 */
+                migration_only_migratable_set(true);
                 break;
             case QEMU_OPTION_nodefaults:
                 has_defaults = 0;
-- 
2.7.4
