Received: from eggs.gnu.org ([2001:4830:134:3::10]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aS-0007Dw-QO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aR-0005KP-AQ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38aR-0005JN-1C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 154BA81F07
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:27 +0200
Message-Id: <20170425220451.6028-18-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 17/41] migration: Create savevm.h for functions
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
index 0d496d3..503b51f 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -77,53 +77,6 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
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
index 94cdb89..ff268bd 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -16,6 +16,7 @@
 #include "qemu-file-channel.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "migration/savevm.h"
 #include "migration/colo.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
diff --git a/migration/migration.c b/migration/migration.c
index 4668236..367b039 100644
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
index 019e031..0b02755 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "savevm.h"
 #include "postcopy-ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index a6bc1f9..483eda1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -38,6 +38,7 @@
 #include "migration/migration.h"
 #include "migration/snapshot.h"
 #include "qemu-file-channel.h"
+#include "savevm.h"
 #include "postcopy-ram.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
@@ -64,6 +65,26 @@ const unsigned int postcopy_ram_discard_version = 0;
 
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
index 0000000..f4c4bc9
--- /dev/null
+++ b/migration/savevm.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU save vm functions
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
