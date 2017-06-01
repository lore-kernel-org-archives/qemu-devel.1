Received: from eggs.gnu.org ([2001:4830:134:3::10]:38469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVhL-0004eM-Jy
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVhK-00053T-7R
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGVhJ-00053C-Uf
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 003CFC0587CA
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 19:23:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 21:23:22 +0200
Message-Id: <20170601192327.29712-11-quintela@redhat.com>
In-Reply-To: <20170601192327.29712-1-quintela@redhat.com>
References: <20170601192327.29712-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] migration: Export socket.c functions in
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |  8 --------
 migration/migration.c         |  1 +
 migration/socket.c            |  1 +
 migration/socket.h            | 28 ++++++++++++++++++++++++++++
 4 files changed, 30 insertions(+), 8 deletions(-)
 create mode 100644 migration/socket.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index d249c13..9d311ed 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -163,14 +163,6 @@ void migration_tls_channel_connect(MigrationState *s,
 
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
index ec93f7a..e6e36fa 100644
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
index 3f8ffc9..85bfdcc 100644
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
index 0000000..6b91e9d
--- /dev/null
+++ b/migration/socket.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU live migration via socket
+ *
+ * Copyright Red Hat, Inc. 2009-2016
+ *
+ * Authors:
+ *  Chris Lalancette <clalance@redhat.com>
+ *  Daniel P. Berrange <berrange@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
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
2.9.4
