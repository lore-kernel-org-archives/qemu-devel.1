Received: from eggs.gnu.org ([2001:4830:134:3::10]:46840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWrz-0003jl-9a
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWrx-0004nV-Gt
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWrx-0004n6-8v
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:53 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56D7031B331
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:55:53 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:54:58 +0000
Message-Id: <20170106155543.12827-3-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
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

Switch files in the io/ directory to include the
io/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs        | 2 +-
 io/Makefile.objs     | 2 ++
 io/channel-buffer.c  | 2 +-
 io/channel-command.c | 2 +-
 io/channel-file.c    | 2 +-
 io/channel-socket.c  | 2 +-
 io/channel-tls.c     | 2 +-
 io/channel-websock.c | 2 +-
 io/task.c            | 2 +-
 9 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index fc398d5..c3f1e45 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -122,7 +122,7 @@ trace-events-subdirs =
 trace-events-y = trace-events
 trace-events-y += util/trace-events
 trace-events-y += crypto/trace-events
-trace-events-y += io/trace-events
+trace-events-subdirs += io
 trace-events-y += migration/trace-events
 trace-events-y += block/trace-events
 trace-events-y += hw/block/trace-events
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 9d8337d..94cb74e 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -8,3 +8,5 @@ io-obj-y += channel-watch.o
 io-obj-y += channel-websock.o
 io-obj-y += channel-util.o
 io-obj-y += task.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 43d7959..b4e50d6 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -22,7 +22,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-watch.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include "io/trace.h"
 
 QIOChannelBuffer *
 qio_channel_buffer_new(size_t capacity)
diff --git a/io/channel-command.c b/io/channel-command.c
index ad25313..7624653 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -23,7 +23,7 @@
 #include "io/channel-watch.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include "io/trace.h"
 
 
 QIOChannelCommand *
diff --git a/io/channel-file.c b/io/channel-file.c
index e1da243..7b064ef 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -23,7 +23,7 @@
 #include "io/channel-watch.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include "io/trace.h"
 
 QIOChannelFile *
 qio_channel_file_new_fd(int fd)
diff --git a/io/channel-socket.c b/io/channel-socket.c
index d7e03f6..8d81d8b 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "io/channel-socket.h"
 #include "io/channel-watch.h"
-#include "trace.h"
+#include "io/trace.h"
 #include "qapi/clone-visitor.h"
 
 #define SOCKET_MAX_FDS 16
diff --git a/io/channel-tls.c b/io/channel-tls.c
index d24dc8c..a77a6fd 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
-#include "trace.h"
+#include "io/trace.h"
 
 
 static ssize_t qio_channel_tls_write_handler(const char *buf,
diff --git a/io/channel-websock.c b/io/channel-websock.c
index f45bced..4fa5385 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -23,7 +23,7 @@
 #include "qemu/bswap.h"
 #include "io/channel-websock.h"
 #include "crypto/hash.h"
-#include "trace.h"
+#include "io/trace.h"
 
 
 /* Max amount to allow in rawinput/rawoutput buffers */
diff --git a/io/task.c b/io/task.c
index c7f97a9..d81adf2 100644
--- a/io/task.c
+++ b/io/task.c
@@ -22,7 +22,7 @@
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
-#include "trace.h"
+#include "io/trace.h"
 
 struct QIOTask {
     Object *source;
-- 
2.9.3
