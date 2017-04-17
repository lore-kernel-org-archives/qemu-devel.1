Received: from eggs.gnu.org ([2001:4830:134:3::10]:52072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpP-0005yK-J0
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpN-0004MU-Co
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpN-0004Lk-3o
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04AA34E35B
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:25 +0200
Message-Id: <20170417200041.2451-4-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/19] migration: Split migration/channel.c for
 channel operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/channel.h   | 25 ++++++++++++++++
 include/migration/migration.h |  7 -----
 migration/Makefile.objs       |  2 +-
 migration/channel.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
 migration/exec.c              |  1 +
 migration/fd.c                |  1 +
 migration/migration.c         | 50 -------------------------------
 migration/socket.c            |  1 +
 migration/tls.c               |  1 +
 9 files changed, 99 insertions(+), 58 deletions(-)
 create mode 100644 include/migration/channel.h
 create mode 100644 migration/channel.c

diff --git a/include/migration/channel.h b/include/migration/channel.h
new file mode 100644
index 0000000..618acb7
--- /dev/null
+++ b/include/migration/channel.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU live migration channel functions
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
+#ifndef QEMU_MIGRATION_CHANNEL_H
+#define QEMU_MIGRATION_CHANNEL_H
+
+#include "io/channel.h"
+
+void migration_channel_process_incoming(MigrationState *s,
+                                        QIOChannel *ioc);
+
+void migration_channel_connect(MigrationState *s,
+                               QIOChannel *ioc,
+                               const char *hostname);
+#endif
diff --git a/include/migration/migration.h b/include/migration/migration.h
index fabfb32..3f54a7c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -183,17 +183,10 @@ void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 
-void migration_channel_process_incoming(MigrationState *s,
-                                        QIOChannel *ioc);
-
 void migration_tls_channel_process_incoming(MigrationState *s,
                                             QIOChannel *ioc,
                                             Error **errp);
 
-void migration_channel_connect(MigrationState *s,
-                               QIOChannel *ioc,
-                               const char *hostname);
-
 void migration_tls_channel_connect(MigrationState *s,
                                    QIOChannel *ioc,
                                    const char *hostname,
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 480dd49..c83ca92 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-y += migration.o socket.o fd.o exec.o
-common-obj-y += tls.o
+common-obj-y += tls.o channel.o
 common-obj-y += colo-comm.o colo.o colo-failover.o
 common-obj-y += vmstate.o
 common-obj-y += qemu-file.o
diff --git a/migration/channel.c b/migration/channel.c
new file mode 100644
index 0000000..c66c6db
--- /dev/null
+++ b/migration/channel.c
@@ -0,0 +1,69 @@
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
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "migration/channel.h"
+#include "migration/migration.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "io/channel-tls.h"
+
+void migration_channel_process_incoming(MigrationState *s,
+                                        QIOChannel *ioc)
+{
+    trace_migration_set_incoming_channel(
+        ioc, object_get_typename(OBJECT(ioc)));
+
+    if (s->parameters.tls_creds &&
+        *s->parameters.tls_creds &&
+        !object_dynamic_cast(OBJECT(ioc),
+                             TYPE_QIO_CHANNEL_TLS)) {
+        Error *local_err = NULL;
+        migration_tls_channel_process_incoming(s, ioc, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    } else {
+        QEMUFile *f = qemu_fopen_channel_input(ioc);
+        migration_fd_process_incoming(f);
+    }
+}
+
+
+void migration_channel_connect(MigrationState *s,
+                               QIOChannel *ioc,
+                               const char *hostname)
+{
+    trace_migration_set_outgoing_channel(
+        ioc, object_get_typename(OBJECT(ioc)), hostname);
+
+    if (s->parameters.tls_creds &&
+        *s->parameters.tls_creds &&
+        !object_dynamic_cast(OBJECT(ioc),
+                             TYPE_QIO_CHANNEL_TLS)) {
+        Error *local_err = NULL;
+        migration_tls_channel_connect(s, ioc, hostname, &local_err);
+        if (local_err) {
+            migrate_fd_error(s, local_err);
+            error_free(local_err);
+        }
+    } else {
+        QEMUFile *f = qemu_fopen_channel_output(ioc);
+
+        s->to_dst_file = f;
+
+        migrate_fd_connect(s);
+    }
+}
diff --git a/migration/exec.c b/migration/exec.c
index 9157721..7d13fc3 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "migration/channel.h"
 #include "migration/migration.h"
 #include "io/channel-command.h"
 #include "trace.h"
diff --git a/migration/fd.c b/migration/fd.c
index 58cb51a..f9c230e 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "migration/channel.h"
 #include "migration/migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
diff --git a/migration/migration.c b/migration/migration.c
index d3fe93d..17d22eb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -463,56 +463,6 @@ void migration_fd_process_incoming(QEMUFile *f)
     qemu_coroutine_enter(co);
 }
 
-
-void migration_channel_process_incoming(MigrationState *s,
-                                        QIOChannel *ioc)
-{
-    trace_migration_set_incoming_channel(
-        ioc, object_get_typename(OBJECT(ioc)));
-
-    if (s->parameters.tls_creds &&
-        *s->parameters.tls_creds &&
-        !object_dynamic_cast(OBJECT(ioc),
-                             TYPE_QIO_CHANNEL_TLS)) {
-        Error *local_err = NULL;
-        migration_tls_channel_process_incoming(s, ioc, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-    } else {
-        QEMUFile *f = qemu_fopen_channel_input(ioc);
-        migration_fd_process_incoming(f);
-    }
-}
-
-
-void migration_channel_connect(MigrationState *s,
-                               QIOChannel *ioc,
-                               const char *hostname)
-{
-    trace_migration_set_outgoing_channel(
-        ioc, object_get_typename(OBJECT(ioc)), hostname);
-
-    if (s->parameters.tls_creds &&
-        *s->parameters.tls_creds &&
-        !object_dynamic_cast(OBJECT(ioc),
-                             TYPE_QIO_CHANNEL_TLS)) {
-        Error *local_err = NULL;
-        migration_tls_channel_connect(s, ioc, hostname, &local_err);
-        if (local_err) {
-            migrate_fd_error(s, local_err);
-            error_free(local_err);
-        }
-    } else {
-        QEMUFile *f = qemu_fopen_channel_output(ioc);
-
-        s->to_dst_file = f;
-
-        migrate_fd_connect(s);
-    }
-}
-
-
 /*
  * Send a message on the return channel back to the source
  * of the migration.
diff --git a/migration/socket.c b/migration/socket.c
index dc88812..7171635 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -19,6 +19,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "migration/channel.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "io/channel-socket.h"
diff --git a/migration/tls.c b/migration/tls.c
index a33ecb7..4ee3349 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "migration/channel.h"
 #include "migration/migration.h"
 #include "io/channel-tls.h"
 #include "crypto/tlscreds.h"
-- 
2.9.3
