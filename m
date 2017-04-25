Received: from eggs.gnu.org ([2001:4830:134:3::10]:55388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aa-0007JZ-Dq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aY-0005TJ-6b
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38aX-0005SX-WC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02E2767ECB
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:31 +0200
Message-Id: <20170425220451.6028-22-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 21/41] migration: Export fd.c functions in its
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  4 ----
 migration/fd.c                |  1 +
 migration/fd.h                | 20 ++++++++++++++++++++
 migration/migration.c         |  1 +
 4 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 migration/fd.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3786f05..fd7d40d 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -198,10 +198,6 @@ void unix_start_incoming_migration(const char *path, Error **errp);
 
 void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
 
-void fd_start_incoming_migration(const char *path, Error **errp);
-
-void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp);
-
 void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp);
diff --git a/migration/fd.c b/migration/fd.c
index ccaa806..8a04dcd 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "channel.h"
+#include "fd.h"
 #include "migration/migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
diff --git a/migration/fd.h b/migration/fd.h
new file mode 100644
index 0000000..4ec3298
--- /dev/null
+++ b/migration/fd.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU live migration fd functions
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
+#ifndef QEMU_MIGRATION_FD_H
+#define QEMU_MIGRATION_FD_H
+void fd_start_incoming_migration(const char *path, Error **errp);
+
+void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
+                                 Error **errp);
+#endif
diff --git a/migration/migration.c b/migration/migration.c
index 994f25f..ca5a576 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -19,6 +19,7 @@
 #include "qemu/main-loop.h"
 #include "migration/blocker.h"
 #include "exec.h"
+#include "fd.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
-- 
2.9.3
