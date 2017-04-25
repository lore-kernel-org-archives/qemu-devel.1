Received: from eggs.gnu.org ([2001:4830:134:3::10]:55428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ac-0007M1-Uq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ab-0005Wx-Rm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38ab-0005W4-IR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98270C0467F1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:33 +0200
Message-Id: <20170425220451.6028-24-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 23/41] migration: Export tls.c functions in its
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Just for the functions exported from tls.c.  Notice that we can't
remove the migration/migration.h include from tls.c because it access
directly MigrationState for the tls params.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 10 ----------
 migration/channel.c           |  1 +
 migration/migration.c         |  1 -
 migration/tls.c               |  1 +
 migration/tls.h               | 27 +++++++++++++++++++++++++++
 5 files changed, 29 insertions(+), 11 deletions(-)
 create mode 100644 migration/tls.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 18ec906..08867c6 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -18,7 +18,6 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
-#include "io/channel.h"
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
@@ -179,15 +178,6 @@ void migration_fd_process_incoming(QEMUFile *f);
 
 void qemu_start_incoming_migration(const char *uri, Error **errp);
 
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
diff --git a/migration/channel.c b/migration/channel.c
index d9b51de..5a81a60 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "channel.h"
+#include "tls.h"
 #include "migration/migration.h"
 #include "qemu-file-channel.h"
 #include "trace.h"
diff --git a/migration/migration.c b/migration/migration.c
index f349a8c..175e5c9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -42,7 +42,6 @@
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "io/channel-buffer.h"
-#include "io/channel-tls.h"
 #include "colo.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
diff --git a/migration/tls.c b/migration/tls.c
index b4cb8fe..d3abd6e 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "channel.h"
 #include "migration/migration.h"
+#include "tls.h"
 #include "io/channel-tls.h"
 #include "crypto/tlscreds.h"
 #include "qemu/error-report.h"
diff --git a/migration/tls.h b/migration/tls.h
new file mode 100644
index 0000000..1d63263
--- /dev/null
+++ b/migration/tls.h
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
-- 
2.9.3
