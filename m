Received: from eggs.gnu.org ([2001:4830:134:3::10]:44616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangxinxin.wang@huawei.com>) id 1f9nZb-0007X8-1L
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 04:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangxinxin.wang@huawei.com>) id 1f9nZW-0004LE-WB
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 04:08:42 -0400
Received: from [45.249.212.35] (port=34199 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangxinxin.wang@huawei.com>)
	id 1f9nZW-0004IB-KM
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 04:08:38 -0400
From: Wang Xin <wangxinxin.wang@huawei.com>
Date: Sat, 21 Apr 2018 15:22:05 +0800
Message-ID: <1524295325-18136-1-git-send-email-wangxinxin.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] migration/fd: abort migration if receive
 POLLHUP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, arei.gonglei@huawei.com, Wang Xin <wangxinxin.wang@huawei.com>

If the fd socket peer closed shortly, ppoll may receive a POLLHUP
event before the expected POLLIN event, and qemu will do nothing
but goes into an infinite loop of the POLLHUP event.

So, abort the migration if we receive a POLLHUP event.

Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>

diff --git a/migration/fd.c b/migration/fd.c
index cd06182..5932c87 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "channel.h"
 #include "fd.h"
 #include "monitor/monitor.h"
@@ -46,6 +47,11 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
                                              GIOCondition condition,
                                              gpointer opaque)
 {
+    if (condition & G_IO_HUP) {
+        error_report("The migration peer closed, job abort");
+        exit(EXIT_FAILURE);
+    }
+
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
     return G_SOURCE_REMOVE;
@@ -67,7 +73,7 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
 
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-incoming");
     qio_channel_add_watch(ioc,
-                          G_IO_IN,
+                          G_IO_IN | G_IO_HUP,
                           fd_accept_incoming_migration,
                           NULL,
                           NULL);
-- 
2.8.1.windows.1
