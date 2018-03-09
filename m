Received: from eggs.gnu.org ([2001:4830:134:3::10]:42017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDuo-0000PI-1p
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDuk-0000In-6v
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDuk-0000Ht-32
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:10 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 17:00:03 +0800
Message-Id: <20180309090006.10018-21-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 20/23] monitor: enable IO thread for (qmp &
 !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Start to use dedicate IO thread for QMP monitors that are not using
MUXed chardev.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index c6de5f123e..9e8ee2ed14 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
+#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -4533,8 +4534,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
+    /* Enable IOThread for QMPs that are not using MUX chardev backends. */
+    bool use_io_thr = (!CHARDEV_IS_MUX(chr)) && (flags & MONITOR_USE_CONTROL);
 
-    monitor_data_init(mon, false, false);
+    monitor_data_init(mon, false, use_io_thr);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-- 
2.14.3
