Received: from eggs.gnu.org ([2001:4830:134:3::10]:58400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBlZ-0006of-HF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBlT-000651-My
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIBlT-00064m-Er
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83ADC80460
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:31:06 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Jun 2017 18:30:40 +0800
Message-Id: <1496745042-2379-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1496745042-2379-1-git-send-email-peterx@redhat.com>
References: <1496745042-2379-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] migration: move only_migratable to
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
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

One less global variable, and it does only matter with migration.

We keep the old "--only-migratable" option, but also now we support:

  -global migration.only-migratable=true

Currently still keep the old interface.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/migration.h | 3 +++
 include/sysemu/sysemu.h       | 1 -
 migration/migration.c         | 3 ++-
 migration/savevm.c            | 2 +-
 vl.c                          | 9 +++++++--
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 8aa1ea6..e7d8e32 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -168,6 +168,9 @@ struct MigrationState
      * during migration.
      */
     bool store_global_state;
+
+    /* Whether the VM is only allowing for migratable devices */
+    bool only_migratable;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
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
index 0653f49..3492365 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1120,7 +1120,7 @@ static GSList *migration_blockers;
 
 int migrate_add_blocker(Error *reason, Error **errp)
 {
-    if (only_migratable) {
+    if (migrate_get_current()->only_migratable) {
         error_propagate(errp, error_copy(reason));
         error_prepend(errp, "disallowing migration blocker "
                           "(--only_migratable) for: ");
@@ -2111,6 +2111,7 @@ void migrate_fd_connect(MigrationState *s)
 static Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
+    DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 9c320f5..f073027 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2321,7 +2321,7 @@ void vmstate_register_ram_global(MemoryRegion *mr)
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     /* check needed if --only-migratable is specified */
-    if (!only_migratable) {
+    if (!migrate_get_current()->only_migratable) {
         return true;
     }
 
diff --git a/vl.c b/vl.c
index be4dcf2..e842eef 100644
--- a/vl.c
+++ b/vl.c
@@ -188,7 +188,6 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
-int only_migratable; /* turn it off unless user states otherwise */
 
 int icount_align_option;
 
@@ -3937,7 +3936,13 @@ int main(int argc, char **argv, char **envp)
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
+                migrate_get_current()->only_migratable = true;
                 break;
             case QEMU_OPTION_nodefaults:
                 has_defaults = 0;
-- 
2.7.4
