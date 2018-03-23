Received: from eggs.gnu.org ([2001:4830:134:3::10]:58510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNT-0007Hy-No
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNP-00058N-2y
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezNNO-00057z-V2
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:03 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Mar 2018 22:08:18 +0800
Message-Id: <20180323140821.28957-2-peterx@redhat.com>
In-Reply-To: <20180323140821.28957-1-peterx@redhat.com>
References: <20180323140821.28957-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 1/4] Revert "monitor: enable IO thread
 for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This reverts commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6ccd2fc089..77f4c41cfa 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,7 +36,6 @@
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
-#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -4537,10 +4536,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
-    /* Enable IOThread for QMPs that are not using MUX chardev backends. */
-    bool use_io_thr = (!CHARDEV_IS_MUX(chr)) && (flags & MONITOR_USE_CONTROL);
 
-    monitor_data_init(mon, false, use_io_thr);
+    monitor_data_init(mon, false, false);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-- 
2.14.3
