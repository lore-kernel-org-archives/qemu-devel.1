Received: from eggs.gnu.org ([2001:4830:134:3::10]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b4-0007mM-W6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b0-00066p-QN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38b0-00065R-Gy
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 819DE8047A
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:06:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:45 +0200
Message-Id: <20170425220451.6028-36-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 35/41] migration: create global_state.c
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

It don't belong anywhere else, just the global state where everybody
can stick other things.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/i386/pc_piix.c                |   1 +
 hw/ppc/spapr.c                   |   1 +
 include/migration/global_state.h |  26 +++++++
 include/migration/migration.h    |   4 --
 migration/Makefile.objs          |   2 +-
 migration/global_state.c         | 143 +++++++++++++++++++++++++++++++++++++++
 migration/migration.c            | 121 +--------------------------------
 migration/savevm.c               |   1 +
 vl.c                             |   1 +
 xen-common.c                     |   1 +
 10 files changed, 176 insertions(+), 125 deletions(-)
 create mode 100644 include/migration/global_state.h
 create mode 100644 migration/global_state.c

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa..6c72bd3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -52,6 +52,7 @@
 #include <xen/hvm/hvm_info_table.h>
 #include "hw/xen/xen_pt.h"
 #endif
+#include "migration/global_state.h"
 #include "migration/migration.h"
 #include "kvm_i386.h"
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4c4701e..f779c35 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -39,6 +39,7 @@
 #include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
 #include "migration/migration.h"
+#include "migration/global_state.h"
 #include "migration/register.h"
 #include "mmu-hash64.h"
 #include "qom/cpu.h"
diff --git a/include/migration/global_state.h b/include/migration/global_state.h
new file mode 100644
index 0000000..84a19d0
--- /dev/null
+++ b/include/migration/global_state.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU live migration
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_MIGRATION_GLOBAL_STATE_H
+#define QEMU_MIGRATION_GLOBAL_STATE_H
+
+#include "sysemu/sysemu.h"
+
+void register_global_state(void);
+void global_state_set_optional(void);
+int global_state_store(void);
+void global_state_store_running(void);
+bool global_state_received(void);
+RunState global_state_get_runstate(void);
+
+#endif
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 7bd87f8..fc31f8e 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -177,10 +177,6 @@ void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
 void savevm_skip_section_footers(void);
-void register_global_state(void);
-void global_state_set_optional(void);
 void savevm_skip_configuration(void);
-int global_state_store(void);
-void global_state_store_running(void);
 
 #endif
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 812b2ec..775e4ad 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-y += migration.o socket.o fd.o exec.o
 common-obj-y += tls.o channel.o
 common-obj-y += colo-comm.o colo.o colo-failover.o
 common-obj-y += vmstate.o vmstate-types.o page_cache.o
-common-obj-y += qemu-file.o
+common-obj-y += qemu-file.o global_state.o
 common-obj-y += qemu-file-channel.o
 common-obj-y += xbzrle.o postcopy-ram.o
 common-obj-y += qjson.o
diff --git a/migration/global_state.c b/migration/global_state.c
new file mode 100644
index 0000000..3d67ba2
--- /dev/null
+++ b/migration/global_state.c
@@ -0,0 +1,143 @@
+/*
+ * QEMU live migration global state
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/util.h"
+#include "migration/global_state.h"
+#include "migration/vmstate.h"
+#include "sysemu/sysemu.h"
+#include "trace.h"
+
+typedef struct {
+    bool optional;
+    uint32_t size;
+    uint8_t runstate[100];
+    RunState state;
+    bool received;
+} GlobalState;
+
+static GlobalState global_state;
+
+int global_state_store(void)
+{
+    if (!runstate_store((char *)global_state.runstate,
+                        sizeof(global_state.runstate))) {
+        error_report("runstate name too big: %s", global_state.runstate);
+        trace_migrate_state_too_big();
+        return -EINVAL;
+    }
+    return 0;
+}
+
+void global_state_store_running(void)
+{
+    const char *state = RunState_lookup[RUN_STATE_RUNNING];
+    strncpy((char *)global_state.runstate,
+           state, sizeof(global_state.runstate));
+}
+
+bool global_state_received(void)
+{
+    return global_state.received;
+}
+
+RunState global_state_get_runstate(void)
+{
+    return global_state.state;
+}
+
+void global_state_set_optional(void)
+{
+    global_state.optional = true;
+}
+
+static bool global_state_needed(void *opaque)
+{
+    GlobalState *s = opaque;
+    char *runstate = (char *)s->runstate;
+
+    /* If it is not optional, it is mandatory */
+
+    if (s->optional == false) {
+        return true;
+    }
+
+    /* If state is running or paused, it is not needed */
+
+    if (strcmp(runstate, "running") == 0 ||
+        strcmp(runstate, "paused") == 0) {
+        return false;
+    }
+
+    /* for any other state it is needed */
+    return true;
+}
+
+static int global_state_post_load(void *opaque, int version_id)
+{
+    GlobalState *s = opaque;
+    Error *local_err = NULL;
+    int r;
+    char *runstate = (char *)s->runstate;
+
+    s->received = true;
+    trace_migrate_global_state_post_load(runstate);
+
+    r = qapi_enum_parse(RunState_lookup, runstate, RUN_STATE__MAX,
+                                -1, &local_err);
+
+    if (r == -1) {
+        if (local_err) {
+            error_report_err(local_err);
+        }
+        return -EINVAL;
+    }
+    s->state = r;
+
+    return 0;
+}
+
+static void global_state_pre_save(void *opaque)
+{
+    GlobalState *s = opaque;
+
+    trace_migrate_global_state_pre_save((char *)s->runstate);
+    s->size = strlen((char *)s->runstate) + 1;
+}
+
+static const VMStateDescription vmstate_globalstate = {
+    .name = "globalstate",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = global_state_post_load,
+    .pre_save = global_state_pre_save,
+    .needed = global_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(size, GlobalState),
+        VMSTATE_BUFFER(runstate, GlobalState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+void register_global_state(void)
+{
+    /* We would use it independently that we receive it */
+    strcpy((char *)&global_state.runstate, "");
+    global_state.received = false;
+    vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
+}
diff --git a/migration/migration.c b/migration/migration.c
index 6e43ae3..4cda97c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -23,6 +23,7 @@
 #include "socket.h"
 #include "ram.h"
 #include "rdma.h"
+#include "migration/global_state.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
@@ -153,126 +154,6 @@ void migration_incoming_state_destroy(void)
     loadvm_free_handlers(mis);
 }
 
-
-typedef struct {
-    bool optional;
-    uint32_t size;
-    uint8_t runstate[100];
-    RunState state;
-    bool received;
-} GlobalState;
-
-static GlobalState global_state;
-
-int global_state_store(void)
-{
-    if (!runstate_store((char *)global_state.runstate,
-                        sizeof(global_state.runstate))) {
-        error_report("runstate name too big: %s", global_state.runstate);
-        trace_migrate_state_too_big();
-        return -EINVAL;
-    }
-    return 0;
-}
-
-void global_state_store_running(void)
-{
-    const char *state = RunState_lookup[RUN_STATE_RUNNING];
-    strncpy((char *)global_state.runstate,
-           state, sizeof(global_state.runstate));
-}
-
-static bool global_state_received(void)
-{
-    return global_state.received;
-}
-
-static RunState global_state_get_runstate(void)
-{
-    return global_state.state;
-}
-
-void global_state_set_optional(void)
-{
-    global_state.optional = true;
-}
-
-static bool global_state_needed(void *opaque)
-{
-    GlobalState *s = opaque;
-    char *runstate = (char *)s->runstate;
-
-    /* If it is not optional, it is mandatory */
-
-    if (s->optional == false) {
-        return true;
-    }
-
-    /* If state is running or paused, it is not needed */
-
-    if (strcmp(runstate, "running") == 0 ||
-        strcmp(runstate, "paused") == 0) {
-        return false;
-    }
-
-    /* for any other state it is needed */
-    return true;
-}
-
-static int global_state_post_load(void *opaque, int version_id)
-{
-    GlobalState *s = opaque;
-    Error *local_err = NULL;
-    int r;
-    char *runstate = (char *)s->runstate;
-
-    s->received = true;
-    trace_migrate_global_state_post_load(runstate);
-
-    r = qapi_enum_parse(RunState_lookup, runstate, RUN_STATE__MAX,
-                                -1, &local_err);
-
-    if (r == -1) {
-        if (local_err) {
-            error_report_err(local_err);
-        }
-        return -EINVAL;
-    }
-    s->state = r;
-
-    return 0;
-}
-
-static void global_state_pre_save(void *opaque)
-{
-    GlobalState *s = opaque;
-
-    trace_migrate_global_state_pre_save((char *)s->runstate);
-    s->size = strlen((char *)s->runstate) + 1;
-}
-
-static const VMStateDescription vmstate_globalstate = {
-    .name = "globalstate",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .post_load = global_state_post_load,
-    .pre_save = global_state_pre_save,
-    .needed = global_state_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT32(size, GlobalState),
-        VMSTATE_BUFFER(runstate, GlobalState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-void register_global_state(void)
-{
-    /* We would use it independently that we receive it */
-    strcpy((char *)&global_state.runstate, "");
-    global_state.received = false;
-    vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
-}
-
 static void migrate_generate_event(int new_state)
 {
     if (migrate_use_events()) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 1caf8ee..e7c05f3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -39,6 +39,7 @@
 #include "migration/snapshot.h"
 #include "migration/misc.h"
 #include "migration/register.h"
+#include "migration/global_state.h"
 #include "ram.h"
 #include "qemu-file-channel.h"
 #include "qemu-file.h"
diff --git a/vl.c b/vl.c
index 605c98f..c0796e4 100644
--- a/vl.c
+++ b/vl.c
@@ -88,6 +88,7 @@ int main(int argc, char **argv)
 #include "hw/block/block.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
+#include "migration/global_state.h"
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
 #include "audio/audio.h"
diff --git a/xen-common.c b/xen-common.c
index fd2c928..172131a 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -14,6 +14,7 @@
 #include "sysemu/char.h"
 #include "sysemu/accel.h"
 #include "migration/migration.h"
+#include "migration/global_state.h"
 
 //#define DEBUG_XEN
 
-- 
2.9.3
