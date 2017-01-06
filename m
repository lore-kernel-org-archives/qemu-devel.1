Received: from eggs.gnu.org ([2001:4830:134:3::10]:46896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs6-0003nD-5p
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs4-0004r8-Rc
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWs4-0004qb-JE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:00 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACE2663E09
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:00 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:02 +0000
Message-Id: <20170106155543.12827-7-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/47] trace: switch block/ directory to
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

Switch files in the block/ directory to include the
block/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs         | 2 +-
 block.c               | 2 +-
 block/Makefile.objs   | 2 ++
 block/backup.c        | 2 +-
 block/block-backend.c | 2 +-
 block/commit.c        | 2 +-
 block/dirty-bitmap.c  | 2 +-
 block/io.c            | 2 +-
 block/mirror.c        | 2 +-
 block/nfs.c           | 2 +-
 block/qcow2-cache.c   | 2 +-
 block/qcow2-cluster.c | 2 +-
 block/qcow2.c         | 2 +-
 block/qed-l2-cache.c  | 2 +-
 block/qed-table.c     | 2 +-
 block/qed.c           | 2 +-
 block/raw-posix.c     | 2 +-
 block/raw-win32.c     | 2 +-
 block/stream.c        | 2 +-
 blockdev.c            | 2 +-
 20 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 91878dd..8a6dfad 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -124,7 +124,7 @@ trace-events-subdirs += util
 trace-events-subdirs += crypto
 trace-events-subdirs += io
 trace-events-subdirs += migration
-trace-events-y += block/trace-events
+trace-events-subdirs += block
 trace-events-y += hw/block/trace-events
 trace-events-y += hw/char/trace-events
 trace-events-y += hw/intc/trace-events
diff --git a/block.c b/block.c
index 39ddea3..19b68f8 100644
--- a/block.c
+++ b/block.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/nbd.h"
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 67a036a..9f03d26 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -26,6 +26,8 @@ block-obj-y += backup.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-y += crypto.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 common-obj-y += stream.o
 
diff --git a/block/backup.c b/block/backup.c
index ea38733..9a1530d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 
-#include "trace.h"
+#include "block/trace.h"
 #include "block/block.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
diff --git a/block/block-backend.c b/block/block-backend.c
index efbf398..3e2b096 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -19,7 +19,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi-event.h"
 #include "qemu/id.h"
-#include "trace.h"
+#include "block/trace.h"
 
 /* Number of coroutines to reserve per attached device model */
 #define COROUTINE_POOL_RESERVATION 64
diff --git a/block/commit.c b/block/commit.c
index c284e85..3eb2e6c 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 519737c..e4405ff 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 
diff --git a/block/io.c b/block/io.c
index 4f00562..70e1941 100644
--- a/block/io.c
+++ b/block/io.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "sysemu/block-backend.h"
 #include "block/blockjob.h"
 #include "block/block_int.h"
diff --git a/block/mirror.c b/block/mirror.c
index 301ba92..5df7232 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
diff --git a/block/nfs.c b/block/nfs.c
index a564340..9399f4a 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -30,7 +30,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "qemu/iov.h"
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147..104fb16 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -26,7 +26,7 @@
 #include "block/block_int.h"
 #include "qemu-common.h"
 #include "qcow2.h"
-#include "trace.h"
+#include "block/trace.h"
 
 typedef struct Qcow2CachedTable {
     int64_t  offset;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 928c1e2..67e8f23 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -30,7 +30,7 @@
 #include "block/block_int.h"
 #include "block/qcow2.h"
 #include "qemu/bswap.h"
-#include "trace.h"
+#include "block/trace.h"
 
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size)
diff --git a/block/qcow2.c b/block/qcow2.c
index 96fb8a8..b9f72b4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -33,7 +33,7 @@
 #include "qapi/util.h"
 #include "qapi/qmp/types.h"
 #include "qapi-event.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
diff --git a/block/qed-l2-cache.c b/block/qed-l2-cache.c
index 5cba794..b413753 100644
--- a/block/qed-l2-cache.c
+++ b/block/qed-l2-cache.c
@@ -51,7 +51,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "qed.h"
 
 /* Each L2 holds 2GB so this let's us fully cache a 100GB disk */
diff --git a/block/qed-table.c b/block/qed-table.c
index ed443e2..eb173d6 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "qemu/sockets.h" /* for EINPROGRESS on Windows */
 #include "qed.h"
 #include "qemu/bswap.h"
diff --git a/block/qed.c b/block/qed.c
index 1a7ef0a..91ec33c 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "qed.h"
 #include "qapi/qmp/qerror.h"
 #include "migration/migration.h"
diff --git a/block/raw-posix.c b/block/raw-posix.c
index 28b47d9..1145465 100644
--- a/block/raw-posix.c
+++ b/block/raw-posix.c
@@ -29,7 +29,7 @@
 #include "qemu/log.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
diff --git a/block/raw-win32.c b/block/raw-win32.c
index 800fabd..096ca54 100644
--- a/block/raw-win32.c
+++ b/block/raw-win32.c
@@ -28,7 +28,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "block/raw-aio.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/stream.c b/block/stream.c
index 1523ba7..b82bd23 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
diff --git a/blockdev.c b/blockdev.c
index 245e1e1..db82ac9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -48,7 +48,7 @@
 #include "sysemu/sysemu.h"
 #include "block/block_int.h"
 #include "qmp-commands.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "sysemu/arch_init.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
-- 
2.9.3
