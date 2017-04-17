Received: from eggs.gnu.org ([2001:4830:134:3::10]:52166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpT-00061V-JS
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpS-0004Oe-IU
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpS-0004OM-9q
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 325298FCE5
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:29 +0200
Message-Id: <20170417200041.2451-8-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 07/19] migration: Export socket.c functions in
 its own file
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
 include/migration/migration.h |  8 --------
 include/migration/socket.h    | 25 +++++++++++++++++++++++++
 migration/migration.c         |  1 +
 migration/socket.c            |  1 +
 4 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 include/migration/socket.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 077b75b..0c6dae5 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -194,14 +194,6 @@ void migration_tls_channel_connect(MigrationState *s,
 
 uint64_t migrate_max_downtime(void);
 
-void tcp_start_incoming_migration(const char *host_port, Error **errp);
-
-void tcp_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
-
-void unix_start_incoming_migration(const char *path, Error **errp);
-
-void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
-
 void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp);
diff --git a/include/migration/socket.h b/include/migration/socket.h
new file mode 100644
index 0000000..800fde1
--- /dev/null
+++ b/include/migration/socket.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU live migration socket functions
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
+#ifndef QEMU_MIGRATION_SOCKET_H
+#define QEMU_MIGRATION_SOCKET_H
+void tcp_start_incoming_migration(const char *host_port, Error **errp);
+
+void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
+                                  Error **errp);
+
+void unix_start_incoming_migration(const char *path, Error **errp);
+
+void unix_start_outgoing_migration(MigrationState *s, const char *path,
+                                   Error **errp);
+#endif
diff --git a/migration/migration.c b/migration/migration.c
index a608faa..181839b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -23,6 +23,7 @@
 #include "migration/init.h"
 #include "migration/exec.h"
 #include "migration/fd.h"
+#include "migration/socket.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "sysemu/sysemu.h"
diff --git a/migration/socket.c b/migration/socket.c
index b06cde3..71a8439 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -20,6 +20,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/channel.h"
+#include "migration/socket.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "io/channel-socket.h"
-- 
2.9.3
