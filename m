Received: from eggs.gnu.org ([2001:4830:134:3::10]:57453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBd-0000jb-DP
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBc-0006uG-0x
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPBb-0006ts-JT
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 941AF80C0B
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:33 +0200
Message-Id: <20170518172543.32694-2-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/11] migration: Create savevm.h for functions
 exported from savevm.c
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

This removes last trace of migration functions from sysemu/sysemu.h.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/sysemu/sysemu.h  | 47 -----------------------------------------------
 migration/colo.c         |  1 +
 migration/migration.c    |  1 +
 migration/postcopy-ram.c |  1 +
 migration/savevm.c       | 29 +++++++++++++++++++++++++----
 migration/savevm.h       | 41 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+), 51 deletions(-)
 create mode 100644 migration/savevm.h

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ed8fe3b..73baea1 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -79,53 +79,6 @@ int load_vmstate(const char *name, Error **errp);
 
 void qemu_announce_self(void);
 
-/* Subcommands for QEMU_VM_COMMAND */
-enum qemu_vm_cmd {
-    MIG_CMD_INVALID = 0,   /* Must be 0 */
-    MIG_CMD_OPEN_RETURN_PATH,  /* Tell the dest to open the Return path */
-    MIG_CMD_PING,              /* Request a PONG on the RP */
-
-    MIG_CMD_POSTCOPY_ADVISE,       /* Prior to any page transfers, just
-                                      warn we might want to do PC */
-    MIG_CMD_POSTCOPY_LISTEN,       /* Start listening for incoming
-                                      pages as it's running. */
-    MIG_CMD_POSTCOPY_RUN,          /* Start execution */
-
-    MIG_CMD_POSTCOPY_RAM_DISCARD,  /* A list of pages to discard that
-                                      were previously sent during
-                                      precopy but are dirty. */
-    MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
-    MIG_CMD_MAX
-};
-
-#define MAX_VM_CMD_PACKAGED_SIZE (1ul << 24)
-
-bool qemu_savevm_state_blocked(Error **errp);
-void qemu_savevm_state_begin(QEMUFile *f);
-void qemu_savevm_state_header(QEMUFile *f);
-int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
-void qemu_savevm_state_cleanup(void);
-void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
-void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
-                               uint64_t *res_non_postcopiable,
-                               uint64_t *res_postcopiable);
-void qemu_savevm_command_send(QEMUFile *f, enum qemu_vm_cmd command,
-                              uint16_t len, uint8_t *data);
-void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
-void qemu_savevm_send_open_return_path(QEMUFile *f);
-int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
-void qemu_savevm_send_postcopy_advise(QEMUFile *f);
-void qemu_savevm_send_postcopy_listen(QEMUFile *f);
-void qemu_savevm_send_postcopy_run(QEMUFile *f);
-
-void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
-                                           uint16_t len,
-                                           uint64_t *start_list,
-                                           uint64_t *length_list);
-
-int qemu_loadvm_state(QEMUFile *f);
-
 extern int autostart;
 
 typedef enum {
diff --git a/migration/colo.c b/migration/colo.c
index 929b31c..8c2ade4 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -16,6 +16,7 @@
 #include "qemu-file-channel.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "savevm.h"
 #include "migration/colo.h"
 #include "migration/block.h"
 #include "io/channel-buffer.h"
diff --git a/migration/migration.c b/migration/migration.c
index ad29e53..7087d1a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -19,6 +19,7 @@
 #include "qemu/main-loop.h"
 #include "migration/blocker.h"
 #include "migration/migration.h"
+#include "savevm.h"
 #include "qemu-file-channel.h"
 #include "migration/qemu-file.h"
 #include "migration/vmstate.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a37620d..3f9ae1b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -22,6 +22,7 @@
 #include "exec/target_page.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "savevm.h"
 #include "postcopy-ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index d971e5e..d840731 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -36,6 +36,7 @@
 #include "qemu/timer.h"
 #include "migration/migration.h"
 #include "qemu-file-channel.h"
+#include "savevm.h"
 #include "postcopy-ram.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
@@ -63,6 +64,26 @@ const unsigned int postcopy_ram_discard_version = 0;
 
 static bool skip_section_footers;
 
+/* Subcommands for QEMU_VM_COMMAND */
+enum qemu_vm_cmd {
+    MIG_CMD_INVALID = 0,   /* Must be 0 */
+    MIG_CMD_OPEN_RETURN_PATH,  /* Tell the dest to open the Return path */
+    MIG_CMD_PING,              /* Request a PONG on the RP */
+
+    MIG_CMD_POSTCOPY_ADVISE,       /* Prior to any page transfers, just
+                                      warn we might want to do PC */
+    MIG_CMD_POSTCOPY_LISTEN,       /* Start listening for incoming
+                                      pages as it's running. */
+    MIG_CMD_POSTCOPY_RUN,          /* Start execution */
+
+    MIG_CMD_POSTCOPY_RAM_DISCARD,  /* A list of pages to discard that
+                                      were previously sent during
+                                      precopy but are dirty. */
+    MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
+    MIG_CMD_MAX
+};
+
+#define MAX_VM_CMD_PACKAGED_SIZE (1ul << 24)
 static struct mig_cmd_args {
     ssize_t     len; /* -1 = variable */
     const char *name;
@@ -807,10 +828,10 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
  * @len: Length of associated data
  * @data: Data associated with command.
  */
-void qemu_savevm_command_send(QEMUFile *f,
-                              enum qemu_vm_cmd command,
-                              uint16_t len,
-                              uint8_t *data)
+static void qemu_savevm_command_send(QEMUFile *f,
+                                     enum qemu_vm_cmd command,
+                                     uint16_t len,
+                                     uint8_t *data)
 {
     trace_savevm_command_send(command, len);
     qemu_put_byte(f, QEMU_VM_COMMAND);
diff --git a/migration/savevm.h b/migration/savevm.h
new file mode 100644
index 0000000..eb44877
--- /dev/null
+++ b/migration/savevm.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU save vm functions
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2009-2017 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIGRATION_SAVEVM_H
+#define MIGRATION_SAVEVM_H
+
+bool qemu_savevm_state_blocked(Error **errp);
+void qemu_savevm_state_begin(QEMUFile *f);
+void qemu_savevm_state_header(QEMUFile *f);
+int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
+void qemu_savevm_state_cleanup(void);
+void qemu_savevm_state_complete_postcopy(QEMUFile *f);
+void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
+void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
+                               uint64_t *res_non_postcopiable,
+                               uint64_t *res_postcopiable);
+void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
+void qemu_savevm_send_open_return_path(QEMUFile *f);
+int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
+void qemu_savevm_send_postcopy_advise(QEMUFile *f);
+void qemu_savevm_send_postcopy_listen(QEMUFile *f);
+void qemu_savevm_send_postcopy_run(QEMUFile *f);
+
+void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
+                                           uint16_t len,
+                                           uint64_t *start_list,
+                                           uint64_t *length_list);
+
+int qemu_loadvm_state(QEMUFile *f);
+
+#endif
-- 
2.9.3
