Received: from eggs.gnu.org ([2001:4830:134:3::10]:52395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpj-0006IW-Ix
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpi-0004Ye-MD
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Cpi-0004Xt-H6
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C49A8050D
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:01:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:39 +0200
Message-Id: <20170417200041.2451-18-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 17/19] migration: Export rdma.c functions in
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
 include/migration/migration.h |  4 ----
 include/migration/rdma.h      | 22 ++++++++++++++++++++++
 migration/migration.c         |  1 +
 migration/rdma.c              |  1 +
 4 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 include/migration/rdma.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3e5d106..64c1ff3 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -177,10 +177,6 @@ void migration_fd_process_incoming(QEMUFile *f);
 
 uint64_t migrate_max_downtime(void);
 
-void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
-
-void rdma_start_incoming_migration(const char *host_port, Error **errp);
-
 void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s);
diff --git a/include/migration/rdma.h b/include/migration/rdma.h
new file mode 100644
index 0000000..d2cf481
--- /dev/null
+++ b/include/migration/rdma.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU migration rdma functions
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
+#ifndef QEMU_MIGRATION_RDMA_H
+#define QEMU_MIGRATION_RDMA_H
+
+void rdma_start_outgoing_migration(void *opaque, const char *host_port,
+                                   Error **errp);
+
+void rdma_start_incoming_migration(const char *host_port, Error **errp);
+
+#endif
diff --git a/migration/migration.c b/migration/migration.c
index ba01ea2..04aa9ad 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -23,6 +23,7 @@
 #include "migration/exec.h"
 #include "migration/fd.h"
 #include "migration/socket.h"
+#include "migration/rdma.h"
 #include "migration/ram.h"
 #include "migration/migration.h"
 #include "migration/qemu-file-channel.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index 3b06fe6..2b4276b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
+#include "migration/rdma.h"
 #include "migration/migration.h"
 #include "migration/ram.h"
 #include "migration/qemu-file-channel.h"
-- 
2.9.3
