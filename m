Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs5-0003mn-Dv
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs4-0004qh-3M
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWs3-0004po-Rh
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:00 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D585E63147
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:55:58 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:01 +0000
Message-Id: <20170106155543.12827-6-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/47] trace: switch migration/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the migration/ directory to include the
migration/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs            | 2 +-
 migration/Makefile.objs  | 2 ++
 migration/exec.c         | 2 +-
 migration/fd.c           | 2 +-
 migration/migration.c    | 2 +-
 migration/postcopy-ram.c | 2 +-
 migration/qemu-file.c    | 2 +-
 migration/ram.c          | 2 +-
 migration/rdma.c         | 2 +-
 migration/savevm.c       | 2 +-
 migration/socket.c       | 2 +-
 migration/tls.c          | 2 +-
 migration/vmstate.c      | 2 +-
 13 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 735c4a9..91878dd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -123,7 +123,7 @@ trace-events-y = trace-events
 trace-events-subdirs += util
 trace-events-subdirs += crypto
 trace-events-subdirs += io
-trace-events-y += migration/trace-events
+trace-events-subdirs += migration
 trace-events-y += block/trace-events
 trace-events-y += hw/block/trace-events
 trace-events-y += hw/char/trace-events
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 3f3e237..d0330f0 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -12,3 +12,5 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 
 common-obj-y += block.o
 
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/migration/exec.c b/migration/exec.c
index 9157721..f8f6ccf 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -22,7 +22,7 @@
 #include "qemu-common.h"
 #include "migration/migration.h"
 #include "io/channel-command.h"
-#include "trace.h"
+#include "migration/trace.h"
 
 
 void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
diff --git a/migration/fd.c b/migration/fd.c
index 58cb51a..695373b 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -20,7 +20,7 @@
 #include "migration/migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
-#include "trace.h"
+#include "migration/trace.h"
 
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
diff --git a/migration/migration.c b/migration/migration.c
index f498ab8..4bcf46d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -29,7 +29,7 @@
 #include "migration/postcopy-ram.h"
 #include "qemu/thread.h"
 #include "qmp-commands.h"
-#include "trace.h"
+#include "migration/trace.h"
 #include "qapi-event.h"
 #include "qom/cpu.h"
 #include "exec/memory.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a40dddb..bf5ef8f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -24,7 +24,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "migration/trace.h"
 
 /* Arbitrary limit on size of each discard command,
  * keeps them around ~200 bytes
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e9fae31..b2240cb 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -30,7 +30,7 @@
 #include "qemu/coroutine.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
-#include "trace.h"
+#include "migration/trace.h"
 
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
diff --git a/migration/ram.c b/migration/ram.c
index a1c8089..3c20acb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -40,7 +40,7 @@
 #include "exec/address-spaces.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "migration/trace.h"
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index 674ccab..defc2f9 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -29,7 +29,7 @@
 #include <netdb.h>
 #include <arpa/inet.h>
 #include <rdma/rdma_cma.h>
-#include "trace.h"
+#include "migration/trace.h"
 
 /*
  * Print and error on both the Monitor and the Log file.
diff --git a/migration/savevm.c b/migration/savevm.c
index 0363372..5b2f7bb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -46,7 +46,7 @@
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
 #include "qmp-commands.h"
-#include "trace.h"
+#include "migration/trace.h"
 #include "qemu/bitops.h"
 #include "qemu/iov.h"
 #include "block/snapshot.h"
diff --git a/migration/socket.c b/migration/socket.c
index 11f80b1..be70428 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -22,7 +22,7 @@
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "io/channel-socket.h"
-#include "trace.h"
+#include "migration/trace.h"
 
 
 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
diff --git a/migration/tls.c b/migration/tls.c
index 49ca9a8..3f2d094 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -24,7 +24,7 @@
 #include "crypto/tlscreds.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "migration/trace.h"
 
 static QCryptoTLSCreds *
 migration_tls_get_creds(MigrationState *s,
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0bc9f35..737fcb6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -5,7 +5,7 @@
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "migration/trace.h"
 
 static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                     void *opaque, QJSON *vmdesc);
-- 
2.9.3
