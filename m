Received: from eggs.gnu.org ([2001:4830:134:3::10]:43200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw9q-0003zn-Vt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw9n-0005kO-RH
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw9n-0005k1-Hi
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FDC64E334
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:51:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:48 +0800
Message-Id: <1497876588-947-14-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/13] migration: move skip_section_footers
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

Move it into MigrationState, revert its meaning and renaming it to
send_section_footer, with a property bound to it. Same trick is played
like previous patches.

Removing savevm_skip_section_footers().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c        |  1 -
 hw/ppc/spapr.c           |  1 -
 hw/xen/xen-common.c      |  2 +-
 include/hw/compat.h      |  4 ++++
 include/migration/misc.h |  1 -
 migration/migration.c    |  2 ++
 migration/migration.h    |  2 ++
 migration/savevm.c       | 11 ++---------
 8 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 537de7c..04e2b2e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -322,7 +322,6 @@ static void x86_cpu_change_kvm_default(const char *prop,
 static void pc_compat_2_3(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    savevm_skip_section_footers();
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 29fac1b..7c40fdf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3579,7 +3579,6 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
 static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
-    savevm_skip_section_footers();
 }
 
 static void spapr_machine_2_3_class_options(MachineClass *mc)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index ac6a2b9..069458c 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -144,7 +144,7 @@ static int xen_init(MachineState *ms)
 
     accel_register_prop(accel, "migration", "store-global-state", "off");
     accel_register_prop(accel, "migration", "send-configuration", "off");
-    savevm_skip_section_footers();
+    accel_register_prop(accel, "migration", "send-section-footer", "off");
 
     return 0;
 }
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 1a3fd94..08f3600 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -187,6 +187,10 @@
         .value    = "off",\
     },{\
         .driver   = "migration",\
+        .property = "send-section-footer",\
+        .value    = "off",\
+    },{\
+        .driver   = "migration",\
         .property = "store-global-state",\
         .value    = "off",\
     },
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 35b41bc..114f032 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -41,7 +41,6 @@ int64_t self_announce_delay(int round)
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
-void savevm_skip_section_footers(void);
 
 /* migration/migration.c */
 void qemu_start_incoming_migration(const char *uri, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index f69fe28..c06c7ff 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1987,6 +1987,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
     DEFINE_PROP_BOOL("send-configuration", MigrationState,
                      send_configuration, true),
+    DEFINE_PROP_BOOL("send-section-footer", MigrationState,
+                     send_section_footer, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/migration/migration.h b/migration/migration.h
index 4d4ea0d..994b017 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -145,6 +145,8 @@ struct MigrationState
 
     /* Whether we send QEMU_VM_CONFIGURATION during migration */
     bool send_configuration;
+    /* Whether we send section footer during migration */
+    bool send_section_footer;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/savevm.c b/migration/savevm.c
index f678a8a..df22f90 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -62,8 +62,6 @@
 
 const unsigned int postcopy_ram_discard_version = 0;
 
-static bool skip_section_footers;
-
 /* Subcommands for QEMU_VM_COMMAND */
 enum qemu_vm_cmd {
     MIG_CMD_INVALID = 0,   /* Must be 0 */
@@ -761,11 +759,6 @@ static void vmstate_save(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
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
@@ -793,7 +786,7 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
  */
 static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 {
-    if (!skip_section_footers) {
+    if (migrate_get_current()->send_section_footer) {
         qemu_put_byte(f, QEMU_VM_SECTION_FOOTER);
         qemu_put_be32(f, se->section_id);
     }
@@ -1791,7 +1784,7 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
     uint8_t read_mark;
     uint32_t read_section_id;
 
-    if (skip_section_footers) {
+    if (!migrate_get_current()->send_section_footer) {
         /* No footer to check */
         return true;
     }
-- 
2.7.4
