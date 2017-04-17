Received: from eggs.gnu.org ([2001:4830:134:3::10]:52147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpS-0005zs-13
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpR-0004OA-4t
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpQ-0004Nj-Vf
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB2ED8124F
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:28 +0200
Message-Id: <20170417200041.2451-7-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/19] migration: Export fd.c functions in its
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/fd.h        | 20 ++++++++++++++++++++
 include/migration/migration.h |  4 ----
 migration/fd.c                |  2 +-
 migration/migration.c         |  1 +
 4 files changed, 22 insertions(+), 5 deletions(-)
 create mode 100644 include/migration/fd.h

diff --git a/include/migration/fd.h b/include/migration/fd.h
new file mode 100644
index 0000000..4ec3298
--- /dev/null
+++ b/include/migration/fd.h
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
diff --git a/include/migration/migration.h b/include/migration/migration.h
index eb0150b..077b75b 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -202,10 +202,6 @@ void unix_start_incoming_migration(const char *path, Error **errp);
 
 void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
 
-void fd_start_incoming_migration(const char *path, Error **errp);
-
-void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp);
-
 void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp);
diff --git a/migration/fd.c b/migration/fd.c
index fba3852..78ebd5b 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "migration/channel.h"
-#include "migration/migration.h"
+#include "migration/fd.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
 #include "trace.h"
diff --git a/migration/migration.c b/migration/migration.c
index 076c42a..a608faa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -22,6 +22,7 @@
 #include "migration/state.h"
 #include "migration/init.h"
 #include "migration/exec.h"
+#include "migration/fd.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "sysemu/sysemu.h"
-- 
2.9.3
