Received: from eggs.gnu.org ([2001:4830:134:3::10]:52209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpU-00063q-Pa
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpT-0004QS-To
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpT-0004Om-L0
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E6224E024
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:30 +0200
Message-Id: <20170417200041.2451-9-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 08/19] migration: Export tls.c functions in its
 own file
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

Just for the functions exported from tls.c.  Notice that we can't
remove the migration/migration.h include from tls.c because it access
directly MigrationState for the tls params.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  9 ---------
 include/migration/tls.h       | 27 +++++++++++++++++++++++++++
 migration/channel.c           |  1 +
 migration/migration.c         |  1 -
 migration/tls.c               |  1 +
 5 files changed, 29 insertions(+), 10 deletions(-)
 create mode 100644 include/migration/tls.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 0c6dae5..d6f2e94 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -183,15 +183,6 @@ void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 
-void migration_tls_channel_process_incoming(MigrationState *s,
-                                            QIOChannel *ioc,
-                                            Error **errp);
-
-void migration_tls_channel_connect(MigrationState *s,
-                                   QIOChannel *ioc,
-                                   const char *hostname,
-                                   Error **errp);
-
 uint64_t migrate_max_downtime(void);
 
 void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
diff --git a/include/migration/tls.h b/include/migration/tls.h
new file mode 100644
index 0000000..1d63263
--- /dev/null
+++ b/include/migration/tls.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU live migration tls functions
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
+#ifndef QEMU_MIGRATION_TLS_H
+#define QEMU_MIGRATION_TLS_H
+
+#include "io/channel.h"
+
+void migration_tls_channel_process_incoming(MigrationState *s,
+                                            QIOChannel *ioc,
+                                            Error **errp);
+
+void migration_tls_channel_connect(MigrationState *s,
+                                   QIOChannel *ioc,
+                                   const char *hostname,
+                                   Error **errp);
+#endif
diff --git a/migration/channel.c b/migration/channel.c
index 6f11a1a..10416e0 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/channel.h"
+#include "migration/tls.h"
 #include "migration/migration.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/migration/migration.c b/migration/migration.c
index 181839b..ce34be5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -42,7 +42,6 @@
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "io/channel-buffer.h"
-#include "io/channel-tls.h"
 #include "migration/colo.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
diff --git a/migration/tls.c b/migration/tls.c
index 2b28ebd..b9e1791 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "migration/channel.h"
 #include "migration/migration.h"
+#include "migration/tls.h"
 #include "io/channel-tls.h"
 #include "crypto/tlscreds.h"
 #include "qemu/error-report.h"
-- 
2.9.3
