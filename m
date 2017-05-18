Received: from eggs.gnu.org ([2001:4830:134:3::10]:57603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPC1-00014D-Iv
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPC0-0006zA-76
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPBz-0006z3-UN
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E579561E4C
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:39 +0200
Message-Id: <20170518172543.32694-8-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 07/11] migration: Export tls.c functions in its
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
 migration/tls.h               | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 36 insertions(+), 11 deletions(-)
 create mode 100644 migration/tls.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 7a0a50b..f125961 100644
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
@@ -157,15 +156,6 @@ void migration_fd_process_incoming(QEMUFile *f);
 
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
index fed8563..4972045 100644
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
index efdb9bb..90f0521 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -43,7 +43,6 @@
 #include "exec/address-spaces.h"
 #include "exec/target_page.h"
 #include "io/channel-buffer.h"
-#include "io/channel-tls.h"
 #include "migration/colo.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
diff --git a/migration/tls.c b/migration/tls.c
index 34ad121..bae9aca 100644
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
index 0000000..cdd7000
--- /dev/null
+++ b/migration/tls.h
@@ -0,0 +1,34 @@
+/*
+ * QEMU migration TLS support
+ *
+ * Copyright (c) 2015 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
