Received: from eggs.gnu.org ([2001:4830:134:3::10]:58427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBld-0006r8-HJ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBlc-00067D-H6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIBlc-000673-9U
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57FA24E4D0
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:31:15 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Jun 2017 18:30:42 +0800
Message-Id: <1496745042-2379-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1496745042-2379-1-git-send-email-peterx@redhat.com>
References: <1496745042-2379-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] migration: move skip_section_footers
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

Move it into MigrationState, with a property binded to it.

Same trick played with HW_COMPAT_2_3.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c             | 1 -
 hw/ppc/spapr.c                | 1 -
 include/hw/compat.h           | 4 ++++
 include/migration/migration.h | 2 ++
 migration/migration.c         | 2 ++
 migration/savevm.c            | 8 +++-----
 6 files changed, 11 insertions(+), 7 deletions(-)

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
index 2d8c9f5..6bdaa97 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -174,6 +174,8 @@ struct MigrationState
 
     /* Whether we skip QEMU_VM_CONFIGURATION for migration */
     bool skip_configuration;
+    /* Whether we skip section footer */
+    bool skip_section_footer;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/migration.c b/migration/migration.c
index 5d93d06..e0e0970 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2114,6 +2114,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
     DEFINE_PROP_BOOL("skip-configuration", MigrationState,
                      skip_configuration, false),
+    DEFINE_PROP_BOOL("skip-section-footer", MigrationState,
+                     skip_section_footer, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/migration/savevm.c b/migration/savevm.c
index e7c18a4..9f56d03 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -65,8 +65,6 @@
 
 const unsigned int postcopy_ram_discard_version = 0;
 
-static bool skip_section_footers;
-
 /* Subcommands for QEMU_VM_COMMAND */
 enum qemu_vm_cmd {
     MIG_CMD_INVALID = 0,   /* Must be 0 */
@@ -787,7 +785,7 @@ static void vmstate_save(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
 
 void savevm_skip_section_footers(void)
 {
-    skip_section_footers = true;
+    migrate_get_current()->skip_section_footer = true;
 }
 
 /*
@@ -817,7 +815,7 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
  */
 static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 {
-    if (!skip_section_footers) {
+    if (!migrate_get_current()->skip_section_footer) {
         qemu_put_byte(f, QEMU_VM_SECTION_FOOTER);
         qemu_put_be32(f, se->section_id);
     }
@@ -1815,7 +1813,7 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
     uint8_t read_mark;
     uint32_t read_section_id;
 
-    if (skip_section_footers) {
+    if (migrate_get_current()->skip_section_footer) {
         /* No footer to check */
         return true;
     }
-- 
2.7.4
