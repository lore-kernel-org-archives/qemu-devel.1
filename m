Received: from eggs.gnu.org ([2001:4830:134:3::10]:43163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw9j-0003vC-79
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw9h-0005g6-U8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw9h-0005fM-KB
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B33564C5
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:51:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:47 +0800
Message-Id: <1497876588-947-13-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/13] migration: move skip_configuration out
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

It was in SaveState but now moved to MigrationState altogether, reverted
its meaning, then renamed to "send_configuration". Again, using
HW_COMPAT_2_3 for old PC/SPAPR machines, and accel_register_prop() for
xen_init().

Removing savevm_skip_configuration().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c        |  1 -
 hw/ppc/spapr.c           |  1 -
 hw/xen/xen-common.c      |  2 +-
 include/hw/compat.h      |  4 ++++
 include/migration/misc.h |  1 -
 migration/migration.c    |  2 ++
 migration/migration.h    |  3 +++
 migration/savevm.c       | 15 ++++-----------
 8 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b662618..537de7c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -326,7 +326,6 @@ static void pc_compat_2_3(MachineState *machine)
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
-    savevm_skip_configuration();
 }
 
 static void pc_compat_2_2(MachineState *machine)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index edbdbfd..29fac1b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3580,7 +3580,6 @@ static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
     savevm_skip_section_footers();
-    savevm_skip_configuration();
 }
 
 static void spapr_machine_2_3_class_options(MachineClass *mc)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 186808b..ac6a2b9 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -143,7 +143,7 @@ static int xen_init(MachineState *ms)
     qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
 
     accel_register_prop(accel, "migration", "store-global-state", "off");
-    savevm_skip_configuration();
+    accel_register_prop(accel, "migration", "send-configuration", "off");
     savevm_skip_section_footers();
 
     return 0;
diff --git a/include/hw/compat.h b/include/hw/compat.h
index a506a74..1a3fd94 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -183,6 +183,10 @@
         .value    = "off",\
     },{\
         .driver   = "migration",\
+        .property = "send-configuration",\
+        .value    = "off",\
+    },{\
+        .driver   = "migration",\
         .property = "store-global-state",\
         .value    = "off",\
     },
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 23e533f..35b41bc 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -42,7 +42,6 @@ int64_t self_announce_delay(int round)
 
 void dump_vmstate_json_to_file(FILE *out_fp);
 void savevm_skip_section_footers(void);
-void savevm_skip_configuration(void);
 
 /* migration/migration.c */
 void qemu_start_incoming_migration(const char *uri, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 9af5c76..f69fe28 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1985,6 +1985,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
     DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
+    DEFINE_PROP_BOOL("send-configuration", MigrationState,
+                     send_configuration, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/migration/migration.h b/migration/migration.h
index 34377dd..4d4ea0d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -142,6 +142,9 @@ struct MigrationState
 
     /* Whether the VM is only allowing for migratable devices */
     bool only_migratable;
+
+    /* Whether we send QEMU_VM_CONFIGURATION during migration */
+    bool send_configuration;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/savevm.c b/migration/savevm.c
index d8ea522..f678a8a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -287,7 +287,6 @@ typedef struct SaveStateEntry {
 typedef struct SaveState {
     QTAILQ_HEAD(, SaveStateEntry) handlers;
     int global_section_id;
-    bool skip_configuration;
     uint32_t len;
     const char *name;
     uint32_t target_page_bits;
@@ -296,15 +295,8 @@ typedef struct SaveState {
 static SaveState savevm_state = {
     .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
     .global_section_id = 0,
-    .skip_configuration = false,
 };
 
-void savevm_skip_configuration(void)
-{
-    savevm_state.skip_configuration = true;
-}
-
-
 static void configuration_pre_save(void *opaque)
 {
     SaveState *state = opaque;
@@ -970,11 +962,11 @@ void qemu_savevm_state_header(QEMUFile *f)
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
 
-    if (!savevm_state.skip_configuration || enforce_config_section()) {
+    if (migrate_get_current()->send_configuration ||
+        enforce_config_section()) {
         qemu_put_byte(f, QEMU_VM_CONFIGURATION);
         vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
     }
-
 }
 
 void qemu_savevm_state_begin(QEMUFile *f)
@@ -1984,7 +1976,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return -ENOTSUP;
     }
 
-    if (!savevm_state.skip_configuration || enforce_config_section()) {
+    if (migrate_get_current()->send_configuration ||
+        enforce_config_section()) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
             return -EINVAL;
-- 
2.7.4
