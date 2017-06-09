Received: from eggs.gnu.org ([2001:4830:134:3::10]:33281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvS-0002Zn-R2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvR-0007ar-RS
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJAvR-0007Ze-Ib
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B80A3DE3D
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 03:49:28 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 11:49:01 +0800
Message-Id: <1496980142-8986-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1496980142-8986-1-git-send-email-peterx@redhat.com>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] migration: move skip_configuration out
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

It was in SaveState but now moved to MigrationState altogether. Again,
using HW_COMPAT_2_3 for old PC/SPAPR machines, and
register_compat_prop() for xen_init().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c             |  1 -
 hw/ppc/spapr.c                |  1 -
 hw/xen/xen-common.c           |  2 +-
 include/hw/compat.h           |  4 ++++
 include/migration/migration.h |  4 +++-
 migration/migration.c         |  2 ++
 migration/savevm.c            | 15 ++++-----------
 7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c83cec5..529018d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -317,7 +317,6 @@ static void pc_compat_2_3(MachineState *machine)
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
-    savevm_skip_configuration();
 }
 
 static void pc_compat_2_2(MachineState *machine)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3e78bb9..227b03b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3593,7 +3593,6 @@ static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
     savevm_skip_section_footers();
-    savevm_skip_configuration();
 }
 
 static void spapr_machine_2_3_class_options(MachineClass *mc)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 8240d50..a80034f 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -145,7 +145,7 @@ static int xen_init(MachineState *ms)
      * confirm that in the future.
      */
     register_compat_prop("migration", "store-global-state", "off");
-    savevm_skip_configuration();
+    register_compat_prop("migration", "skip-configuration", "on");
     savevm_skip_section_footers();
 
     return 0;
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 5b5c8de..4ed2ae7 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -179,6 +179,10 @@
         .value    = "off",\
     },{\
         .driver   = "migration",\
+        .property = "skip-configuration",\
+        .value    = "on",\
+    },{\
+        .driver   = "migration",\
         .property = "store-global-state",\
         .value    = "off",\
     },
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 27b07ed..5f6861c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -171,6 +171,9 @@ struct MigrationState
 
     /* Whether the VM is only allowing for migratable devices */
     bool only_migratable;
+
+    /* Whether we skip QEMU_VM_CONFIGURATION for migration */
+    bool skip_configuration;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -249,7 +252,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
 
 void savevm_skip_section_footers(void);
 void register_global_state(void);
-void savevm_skip_configuration(void);
 int global_state_store(void);
 void global_state_store_running(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index dbec586..a4ab83d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2105,6 +2105,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
     DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
+    DEFINE_PROP_BOOL("skip-configuration", MigrationState,
+                     skip_configuration, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f073027..222af4c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -290,7 +290,6 @@ typedef struct SaveStateEntry {
 typedef struct SaveState {
     QTAILQ_HEAD(, SaveStateEntry) handlers;
     int global_section_id;
-    bool skip_configuration;
     uint32_t len;
     const char *name;
     uint32_t target_page_bits;
@@ -299,15 +298,8 @@ typedef struct SaveState {
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
@@ -989,11 +981,11 @@ void qemu_savevm_state_header(QEMUFile *f)
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
 
-    if (!savevm_state.skip_configuration || enforce_config_section()) {
+    if (!migrate_get_current()->skip_configuration ||
+        enforce_config_section()) {
         qemu_put_byte(f, QEMU_VM_CONFIGURATION);
         vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
     }
-
 }
 
 void qemu_savevm_state_begin(QEMUFile *f)
@@ -2003,7 +1995,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return -ENOTSUP;
     }
 
-    if (!savevm_state.skip_configuration || enforce_config_section()) {
+    if (!migrate_get_current()->skip_configuration ||
+        enforce_config_section()) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
             return -EINVAL;
-- 
2.7.4
