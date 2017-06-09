Received: from eggs.gnu.org ([2001:4830:134:3::10]:33262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvN-0002Yz-Pf
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvK-0007Wo-N6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJAvK-0007Wh-AC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C1B781236
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 03:49:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 11:48:59 +0800
Message-Id: <1496980142-8986-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1496980142-8986-1-git-send-email-peterx@redhat.com>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] migration: move global_state.optional
 out
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

Put it into MigrationState then we can use the properties to specify
whether to enable storing global state.

Removing global_state_set_optional() since now we can use HW_COMPAT_2_3
for x86/power in general, and the register_compat_prop() for xen_init().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c             |  1 -
 hw/ppc/spapr.c                |  1 -
 hw/xen/xen-common.c           |  8 +++++++-
 include/hw/compat.h           |  4 ++++
 include/migration/migration.h |  7 ++++++-
 migration/migration.c         | 24 ++++++++++++++++--------
 6 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2234bd0..c83cec5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -317,7 +317,6 @@ static void pc_compat_2_3(MachineState *machine)
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
-    global_state_set_optional();
     savevm_skip_configuration();
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab3aab1..3e78bb9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3593,7 +3593,6 @@ static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
     savevm_skip_section_footers();
-    global_state_set_optional();
     savevm_skip_configuration();
 }
 
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 0bed577..8240d50 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -138,7 +138,13 @@ static int xen_init(MachineState *ms)
     }
     qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
 
-    global_state_set_optional();
+    /*
+     * TODO: make sure global MigrationState has not yet been created
+     * (otherwise the compat trick won't work). For now we are in
+     * configure_accelerator() so we are mostly good. Better to
+     * confirm that in the future.
+     */
+    register_compat_prop("migration", "store-global-state", "off");
     savevm_skip_configuration();
     savevm_skip_section_footers();
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 400c64b..5b5c8de 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -177,6 +177,10 @@
         .driver   = TYPE_PCI_DEVICE,\
         .property = "x-pcie-lnksta-dllla",\
         .value    = "off",\
+    },{\
+        .driver   = "migration",\
+        .property = "store-global-state",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_2 \
diff --git a/include/migration/migration.h b/include/migration/migration.h
index bd0186c..d3ec719 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -162,6 +162,12 @@ struct MigrationState
     /* Do we have to clean up -b/-i from old migrate parameters */
     /* This feature is deprecated and will be removed */
     bool must_remove_block_options;
+
+    /*
+     * Global switch on whether we need to store the global state
+     * during migration.
+     */
+    bool store_global_state;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -240,7 +246,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
 
 void savevm_skip_section_footers(void);
 void register_global_state(void);
-void global_state_set_optional(void);
 void savevm_skip_configuration(void);
 int global_state_store(void);
 void global_state_store_running(void);
diff --git a/migration/migration.c b/migration/migration.c
index 98b77e2..79d886c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -138,13 +138,13 @@ void migration_incoming_state_destroy(void)
 
 
 typedef struct {
-    bool optional;
     uint32_t size;
     uint8_t runstate[100];
     RunState state;
     bool received;
 } GlobalState;
 
+/* This is only used if MigrationState.store_global_state is set. */
 static GlobalState global_state;
 
 int global_state_store(void)
@@ -175,19 +175,13 @@ static RunState global_state_get_runstate(void)
     return global_state.state;
 }
 
-void global_state_set_optional(void)
-{
-    global_state.optional = true;
-}
-
 static bool global_state_needed(void *opaque)
 {
     GlobalState *s = opaque;
     char *runstate = (char *)s->runstate;
 
     /* If it is not optional, it is mandatory */
-
-    if (s->optional == false) {
+    if (migrate_get_current()->store_global_state) {
         return true;
     }
 
@@ -2107,6 +2101,19 @@ void migrate_fd_connect(MigrationState *s)
     s->migration_thread_running = true;
 }
 
+static Property migration_properties[] = {
+    DEFINE_PROP_BOOL("store-global-state", MigrationState,
+                     store_global_state, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void migration_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = migration_properties;
+}
+
 static void migration_instance_init(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
@@ -2131,6 +2138,7 @@ static void migration_instance_init(Object *obj)
 static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
     .parent = TYPE_DEVICE,
+    .class_init = migration_class_init,
     .class_size = sizeof(MigrationClass),
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
-- 
2.7.4
