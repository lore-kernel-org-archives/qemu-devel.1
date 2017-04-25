Received: from eggs.gnu.org ([2001:4830:134:3::10]:55407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ab-0007KJ-Aa
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aa-0005VD-6W
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38aZ-0005UG-Ts
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5973C049D5B
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:32 +0200
Message-Id: <20170425220451.6028-23-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 22/41] migration: Export socket.c functions in
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  8 --------
 migration/migration.c         |  1 +
 migration/socket.c            |  1 +
 migration/socket.h            | 25 +++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 migration/socket.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index fd7d40d..18ec906 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -190,14 +190,6 @@ void migration_tls_channel_connect(MigrationState *s,
 
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
diff --git a/migration/migration.c b/migration/migration.c
index ca5a576..f349a8c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -20,6 +20,7 @@
 #include "migration/blocker.h"
 #include "exec.h"
 #include "fd.h"
+#include "socket.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
diff --git a/migration/socket.c b/migration/socket.c
index 6ee69ed..acb3f0d 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -20,6 +20,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
+#include "socket.h"
 #include "migration/migration.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
diff --git a/migration/socket.h b/migration/socket.h
new file mode 100644
index 0000000..800fde1
--- /dev/null
+++ b/migration/socket.h
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
-- 
2.9.3
