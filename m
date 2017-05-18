Received: from eggs.gnu.org ([2001:4830:134:3::10]:57576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBx-00010N-NL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBv-0006yF-HL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPBv-0006yB-C4
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60366448D99
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:37 +0200
Message-Id: <20170518172543.32694-6-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] migration: Export fd.c functions in its
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
 migration/fd.h                | 23 +++++++++++++++++++++++
 migration/migration.c         |  1 +
 4 files changed, 25 insertions(+), 4 deletions(-)
 create mode 100644 migration/fd.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index b942378..d0ce199 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -176,10 +176,6 @@ void unix_start_incoming_migration(const char *path, Error **errp);
 
 void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
 
-void fd_start_incoming_migration(const char *path, Error **errp);
-
-void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp);
-
 void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp);
diff --git a/migration/fd.c b/migration/fd.c
index 05e0a5c..0077a50 100644
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
index 0000000..a14a63c
--- /dev/null
+++ b/migration/fd.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU live migration via generic fd
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
+#ifndef QEMU_MIGRATION_FD_H
+#define QEMU_MIGRATION_FD_H
+void fd_start_incoming_migration(const char *path, Error **errp);
+
+void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
+                                 Error **errp);
+#endif
diff --git a/migration/migration.c b/migration/migration.c
index cefffac..1b99ced 100644
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
