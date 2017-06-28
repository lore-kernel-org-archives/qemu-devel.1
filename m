Received: from eggs.gnu.org ([2001:4830:134:3::10]:50278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBy-00030k-J8
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBx-0004ln-BJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBBx-0004lV-2h
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25C94C04B333
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:31:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 13:30:59 +0200
Message-Id: <20170628113106.5248-8-quintela@redhat.com>
In-Reply-To: <20170628113106.5248-1-quintela@redhat.com>
References: <20170628113106.5248-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 07/14] migration: move skip_configuration out
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

It was in SaveState but now moved to MigrationState altogether, reverted
its meaning, then renamed to "send_configuration". Again, using
HW_COMPAT_2_3 for old PC/SPAPR machines, and accel_register_prop() for
xen_init().

Removing savevm_skip_configuration().

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1498536619-14548-8-git-send-email-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/i386/pc_piix.c        |  1 -
 hw/ppc/spapr.c           |  1 -
 hw/xen/xen-common.c      |  6 +++++-
 include/hw/compat.h      |  4 ++++
 include/migration/misc.h |  1 -
 migration/migration.c    |  2 ++
 migration/migration.h    |  3 +++
 migration/savevm.c       | 15 ++++-----------
 8 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3b51297..488fc0a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -318,7 +318,6 @@ static void pc_compat_2_3(MachineState *machine)
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
-    savevm_skip_configuration();
 }
 
 static void pc_compat_2_2(MachineState *machine)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f07d40a..8429187 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3581,7 +3581,6 @@ static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
     savevm_skip_section_footers();
-    savevm_skip_configuration();
 }
 
 static void spapr_machine_2_3_class_options(MachineClass *mc)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 459e6ab..1f3688d 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -139,7 +139,6 @@ static int xen_init(MachineState *ms)
     }
     qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
 
-    savevm_skip_configuration();
     savevm_skip_section_footers();
 
     return 0;
@@ -151,6 +150,11 @@ static GlobalProperty xen_compat_props[] = {
         .property = "store-global-state",
         .value = "off",
     },
+    {
+        .driver = "migration",
+        .property = "send-configuration",
+        .value = "off",
+    },
     { /* end of list */ },
 };
 
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
index 6ac3307..f30db4d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -42,7 +42,6 @@ int64_t self_announce_delay(int round)
 
 void dump_vmstate_json_to_file(FILE *out_fp);
 void savevm_skip_section_footers(void);
-void savevm_skip_configuration(void);
 
 /* migration/migration.c */
 void migration_object_init(void);
diff --git a/migration/migration.c b/migration/migration.c
index 67f9e68..414e14d 100644
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
index 1499cd3..0a8c61f 100644
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
@@ -1995,7 +1987,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return -ENOTSUP;
     }
 
-    if (!savevm_state.skip_configuration || enforce_config_section()) {
+    if (migrate_get_current()->send_configuration ||
+        enforce_config_section()) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
             return -EINVAL;
-- 
2.9.4
