Received: from eggs.gnu.org ([2001:4830:134:3::10]:50307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBC0-00032W-7N
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBz-0004mk-1e
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBBy-0004mB-Ph
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD3943DBE4
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:31:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 13:31:00 +0200
Message-Id: <20170628113106.5248-9-quintela@redhat.com>
In-Reply-To: <20170628113106.5248-1-quintela@redhat.com>
References: <20170628113106.5248-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 08/14] migration: move skip_section_footers
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

Move it into MigrationState, revert its meaning and renaming it to
send_section_footer, with a property bound to it. Same trick is played
like previous patches.

Removing savevm_skip_section_footers().

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1498536619-14548-9-git-send-email-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/i386/pc_piix.c        |  1 -
 hw/ppc/spapr.c           |  1 -
 hw/xen/xen-common.c      |  8 +++++---
 include/hw/compat.h      |  4 ++++
 include/migration/misc.h |  1 -
 migration/migration.c    |  2 ++
 migration/migration.h    |  2 ++
 migration/savevm.c       | 11 ++---------
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 488fc0a..22dbef6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -314,7 +314,6 @@ static void pc_init1(MachineState *machine,
 static void pc_compat_2_3(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    savevm_skip_section_footers();
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8429187..ea44358 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3580,7 +3580,6 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
 static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
-    savevm_skip_section_footers();
 }
 
 static void spapr_machine_2_3_class_options(MachineClass *mc)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 1f3688d..632a938 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -138,9 +138,6 @@ static int xen_init(MachineState *ms)
         return -1;
     }
     qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
-
-    savevm_skip_section_footers();
-
     return 0;
 }
 
@@ -155,6 +152,11 @@ static GlobalProperty xen_compat_props[] = {
         .property = "send-configuration",
         .value = "off",
     },
+    {
+        .driver = "migration",
+        .property = "send-section-footer",
+        .value = "off",
+    },
     { /* end of list */ },
 };
 
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
index f30db4d..854c28d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -41,7 +41,6 @@ int64_t self_announce_delay(int round)
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
-void savevm_skip_section_footers(void);
 
 /* migration/migration.c */
 void migration_object_init(void);
diff --git a/migration/migration.c b/migration/migration.c
index 414e14d..96c6412 100644
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
index 0a8c61f..7b39fb9 100644
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
@@ -1802,7 +1795,7 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
     uint8_t read_mark;
     uint32_t read_section_id;
 
-    if (skip_section_footers) {
+    if (!migrate_get_current()->send_section_footer) {
         /* No footer to check */
         return true;
     }
-- 
2.9.4
