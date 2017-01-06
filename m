Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs4-0003kS-50
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWrz-0004od-DD
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWrz-0004nv-4f
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:55 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34902C01B7E7
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:55:55 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:54:59 +0000
Message-Id: <20170106155543.12827-4-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/47] trace: switch util/ directory to
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

Switch files in the util/ directory to include the
util/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs              | 2 +-
 util/Makefile.objs         | 2 ++
 util/buffer.c              | 2 +-
 util/hbitmap.c             | 2 +-
 util/oslib-posix.c         | 2 +-
 util/oslib-win32.c         | 2 +-
 util/qemu-coroutine-lock.c | 2 +-
 util/qemu-coroutine.c      | 2 +-
 8 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index c3f1e45..e8f060e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -120,7 +120,7 @@ ivshmem-server-obj-y = contrib/ivshmem-server/
 ######################################################################
 trace-events-subdirs =
 trace-events-y = trace-events
-trace-events-y += util/trace-events
+trace-events-subdirs += util
 trace-events-y += crypto/trace-events
 trace-events-subdirs += io
 trace-events-y += migration/trace-events
diff --git a/util/Makefile.objs b/util/Makefile.objs
index ad0f9c7..d196876 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -36,3 +36,5 @@ util-obj-y += log.o
 util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/util/buffer.c b/util/buffer.c
index d8bb874..f59aef9 100644
--- a/util/buffer.c
+++ b/util/buffer.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/buffer.h"
-#include "trace.h"
+#include "util/trace.h"
 
 #define BUFFER_MIN_INIT_SIZE     4096
 #define BUFFER_MIN_SHRINK_SIZE  65536
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 9f691b7..32bb356 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/hbitmap.h"
 #include "qemu/host-utils.h"
-#include "trace.h"
+#include "util/trace.h"
 
 /* HBitmaps provides an array of bits.  The bits are stored as usual in an
  * array of unsigned longs, but HBitmap is also optimized to provide fast
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f631464..155309e 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -32,7 +32,7 @@
 #include <glib/gprintf.h>
 
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "util/trace.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
 #include <libgen.h>
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index d09863c..6ae1681 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -34,7 +34,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include "util/trace.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 14cf9ce..9e24b66 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -27,7 +27,7 @@
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/queue.h"
-#include "trace.h"
+#include "util/trace.h"
 
 void qemu_co_queue_init(CoQueue *queue)
 {
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 737bffa..8f67487 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "util/trace.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
-- 
2.9.3
