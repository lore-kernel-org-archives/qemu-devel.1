Received: from eggs.gnu.org ([2001:4830:134:3::10]:33295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvW-0002aM-Lb
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvV-0007eH-Lu
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJAvV-0007dV-Ci
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FE988553E
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 03:49:32 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 11:49:02 +0800
Message-Id: <1496980142-8986-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1496980142-8986-1-git-send-email-peterx@redhat.com>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] migration: move skip_section_footers
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

Move it into MigrationState, with a property binded to it. Same trick is
played like previous patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c             |  1 -
 hw/ppc/spapr.c                |  1 -
 hw/xen/xen-common.c           |  2 +-
 include/hw/compat.h           |  4 ++++
 include/migration/migration.h |  3 ++-
 migration/migration.c         |  2 ++
 migration/savevm.c            | 11 ++---------
 7 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 529018d..1be23e2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -313,7 +313,6 @@ static void pc_init1(MachineState *machine,
 static void pc_compat_2_3(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    savevm_skip_section_footers();
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 227b03b..944f829 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3592,7 +3592,6 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
 static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
-    savevm_skip_section_footers();
 }
 
 static void spapr_machine_2_3_class_options(MachineClass *mc)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index a80034f..e8f08bb 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -146,7 +146,7 @@ static int xen_init(MachineState *ms)
      */
     register_compat_prop("migration", "store-global-state", "off");
     register_compat_prop("migration", "skip-configuration", "on");
-    savevm_skip_section_footers();
+    register_compat_prop("migration", "skip-section-footer", "on");
 
     return 0;
 }
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 4ed2ae7..ef5fbc7 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -183,6 +183,10 @@
         .value    = "on",\
     },{\
         .driver   = "migration",\
+        .property = "skip-section-footer",\
+        .value    = "on",\
+    },{\
+        .driver   = "migration",\
         .property = "store-global-state",\
         .value    = "off",\
     },
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5f6861c..dc35567 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -174,6 +174,8 @@ struct MigrationState
 
     /* Whether we skip QEMU_VM_CONFIGURATION for migration */
     bool skip_configuration;
+    /* Whether we skip section footer */
+    bool skip_section_footer;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -250,7 +252,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                              ram_addr_t offset, size_t size,
                              uint64_t *bytes_sent);
 
-void savevm_skip_section_footers(void);
 void register_global_state(void);
 int global_state_store(void);
 void global_state_store_running(void);
diff --git a/migration/migration.c b/migration/migration.c
index a4ab83d..9f90f7b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2107,6 +2107,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
     DEFINE_PROP_BOOL("skip-configuration", MigrationState,
                      skip_configuration, false),
+    DEFINE_PROP_BOOL("skip-section-footer", MigrationState,
+                     skip_section_footer, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 222af4c..06d6986 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -65,8 +65,6 @@
 
 const unsigned int postcopy_ram_discard_version = 0;
 
-static bool skip_section_footers;
-
 /* Subcommands for QEMU_VM_COMMAND */
 enum qemu_vm_cmd {
     MIG_CMD_INVALID = 0,   /* Must be 0 */
@@ -780,11 +778,6 @@ static void vmstate_save(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
     vmstate_save_state(f, se->vmsd, se->opaque, vmdesc);
 }
 
-void savevm_skip_section_footers(void)
-{
-    skip_section_footers = true;
-}
-
 /*
  * Write the header for device section (QEMU_VM_SECTION START/END/PART/FULL)
  */
@@ -812,7 +805,7 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
  */
 static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 {
-    if (!skip_section_footers) {
+    if (!migrate_get_current()->skip_section_footer) {
         qemu_put_byte(f, QEMU_VM_SECTION_FOOTER);
         qemu_put_be32(f, se->section_id);
     }
@@ -1810,7 +1803,7 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
     uint8_t read_mark;
     uint32_t read_section_id;
 
-    if (skip_section_footers) {
+    if (migrate_get_current()->skip_section_footer) {
         /* No footer to check */
         return true;
     }
-- 
2.7.4
