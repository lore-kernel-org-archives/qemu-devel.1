Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpi-0006HH-47
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpf-0004XR-3A
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Cpe-0004XL-QR
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3DD8627C8
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:01:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:37 +0200
Message-Id: <20170417200041.2451-16-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/19] migration: Export qemu-file-channel.c
 functions in its own file
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
 include/migration/qemu-file-channel.h | 22 ++++++++++++++++++++++
 include/migration/qemu-file.h         |  3 ---
 migration/channel.c                   |  2 +-
 migration/colo.c                      |  2 +-
 migration/migration.c                 |  2 +-
 migration/qemu-file-channel.c         |  2 +-
 migration/rdma.c                      |  2 +-
 migration/savevm.c                    |  1 +
 8 files changed, 28 insertions(+), 8 deletions(-)
 create mode 100644 include/migration/qemu-file-channel.h

diff --git a/include/migration/qemu-file-channel.h b/include/migration/qemu-file-channel.h
new file mode 100644
index 0000000..bbbf36d
--- /dev/null
+++ b/include/migration/qemu-file-channel.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU migration blockers
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
+#ifndef QEMU_FILE_CHANNEL_H
+#define QEMU_FILE_CHANNEL_H
+
+#include "migration/qemu-file.h"
+#include "io/channel.h"
+
+QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc);
+QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc);
+#endif
diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.h
index 0cd648a..ec73647 100644
--- a/include/migration/qemu-file.h
+++ b/include/migration/qemu-file.h
@@ -27,7 +27,6 @@
 
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
-#include "io/channel.h"
 
 
 /* Read a chunk of data from a file at the given position.  The pos argument
@@ -119,8 +118,6 @@ typedef struct QEMUFileHooks {
 } QEMUFileHooks;
 
 QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops);
-QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc);
-QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc);
 void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks);
 int qemu_get_fd(QEMUFile *f);
 int qemu_fclose(QEMUFile *f);
diff --git a/migration/channel.c b/migration/channel.c
index 04a26c5..e4a0443 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -17,7 +17,7 @@
 #include "migration/channel.h"
 #include "migration/tls.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "migration/qemu-file-channel.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
diff --git a/migration/colo.c b/migration/colo.c
index e2eaccd..150ac6a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "migration/qemu-file-channel.h"
 #include "migration/colo.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
diff --git a/migration/migration.c b/migration/migration.c
index c2c25fe..6e32be0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -24,7 +24,7 @@
 #include "migration/fd.h"
 #include "migration/socket.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "migration/qemu-file-channel.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index 45c13f1..87e44ec 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "migration/qemu-file.h"
+#include "migration/qemu-file-channel.h"
 #include "io/channel-socket.h"
 #include "qemu/iov.h"
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 94d4840..d9a2d64 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -18,7 +18,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "migration/qemu-file-channel.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index b03973a..1e6cf79 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -36,6 +36,7 @@
 #include "audio/audio.h"
 #include "migration/machine.h"
 #include "migration/migration.h"
+#include "migration/qemu-file-channel.h"
 #include "migration/postcopy-ram.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
-- 
2.9.3
