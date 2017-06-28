Received: from eggs.gnu.org ([2001:4830:134:3::10]:50234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBv-0002y3-LJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBr-0004gN-Tr
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBBr-0004dM-F2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5679F4E4F3
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:31:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 13:30:57 +0200
Message-Id: <20170628113106.5248-6-quintela@redhat.com>
In-Reply-To: <20170628113106.5248-1-quintela@redhat.com>
References: <20170628113106.5248-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] migration: move global_state.optional out
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

Put it into MigrationState then we can use the properties to specify
whether to enable storing global state.

Removing global_state_set_optional() since now we can use HW_COMPAT_2_3
for x86/power, and AccelClass.global_props for Xen.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1498536619-14548-6-git-send-email-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/i386/pc_piix.c                |  1 -
 hw/ppc/spapr.c                   |  1 -
 hw/xen/xen-common.c              | 11 ++++++++++-
 include/hw/compat.h              |  4 ++++
 include/migration/global_state.h |  1 -
 migration/global_state.c         |  9 ++-------
 migration/migration.c            |  7 +++++++
 migration/migration.h            |  6 ++++++
 8 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 46a2bc4..3b51297 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -318,7 +318,6 @@ static void pc_compat_2_3(MachineState *machine)
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
-    global_state_set_optional();
     savevm_skip_configuration();
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ede5167..f07d40a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3581,7 +3581,6 @@ static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
     savevm_skip_section_footers();
-    global_state_set_optional();
     savevm_skip_configuration();
 }
 
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index d3fa705..459e6ab 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -139,19 +139,28 @@ static int xen_init(MachineState *ms)
     }
     qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
 
-    global_state_set_optional();
     savevm_skip_configuration();
     savevm_skip_section_footers();
 
     return 0;
 }
 
+static GlobalProperty xen_compat_props[] = {
+    {
+        .driver = "migration",
+        .property = "store-global-state",
+        .value = "off",
+    },
+    { /* end of list */ },
+};
+
 static void xen_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "Xen";
     ac->init_machine = xen_init;
     ac->allowed = &xen_allowed;
+    ac->global_props = xen_compat_props;
 }
 
 #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 26cd585..a506a74 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -181,6 +181,10 @@
         .driver   = TYPE_PCI_DEVICE,\
         .property = "x-pcie-lnksta-dllla",\
         .value    = "off",\
+    },{\
+        .driver   = "migration",\
+        .property = "store-global-state",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_2 \
diff --git a/include/migration/global_state.h b/include/migration/global_state.h
index 90faea7..d307de8 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -16,7 +16,6 @@
 #include "sysemu/sysemu.h"
 
 void register_global_state(void);
-void global_state_set_optional(void);
 int global_state_store(void);
 void global_state_store_running(void);
 bool global_state_received(void);
diff --git a/migration/global_state.c b/migration/global_state.c
index f792cf5..dcbbcb2 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -15,12 +15,12 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/util.h"
+#include "migration.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
 typedef struct {
-    bool optional;
     uint32_t size;
     uint8_t runstate[100];
     RunState state;
@@ -57,11 +57,6 @@ RunState global_state_get_runstate(void)
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
@@ -69,7 +64,7 @@ static bool global_state_needed(void *opaque)
 
     /* If it is not optional, it is mandatory */
 
-    if (s->optional == false) {
+    if (migrate_get_current()->store_global_state) {
         return true;
     }
 
diff --git a/migration/migration.c b/migration/migration.c
index 2c25927..221b22c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1976,11 +1976,18 @@ void migrate_fd_connect(MigrationState *s)
     s->migration_thread_running = true;
 }
 
+static Property migration_properties[] = {
+    DEFINE_PROP_BOOL("store-global-state", MigrationState,
+                     store_global_state, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void migration_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->user_creatable = false;
+    dc->props = migration_properties;
 }
 
 static void migration_instance_init(Object *obj)
diff --git a/migration/migration.h b/migration/migration.h
index 3fca364..4b898e9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -133,6 +133,12 @@ struct MigrationState
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
-- 
2.9.4
