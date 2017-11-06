Received: from eggs.gnu.org ([2001:4830:134:3::10]:50002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe40-0006za-J1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe3w-0005bk-Rn
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:51:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBe3w-0005bB-Ll
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:51:24 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:40 +0800
Message-Id: <20171106094643.14881-25-peterx@redhat.com>
In-Reply-To: <20171106094643.14881-1-peterx@redhat.com>
References: <20171106094643.14881-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v3 24/27] monitor: enable IO thread for (qmp &
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
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Start to use dedicate IO thread for QMP monitors that are not using
MUXed chardev.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index a2550d79a8..be6b3a914f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "net/net.h"
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -4454,7 +4455,7 @@ void monitor_init(Chardev *chr, int flags)
     Monitor *mon = g_malloc(sizeof(*mon));
     GMainContext *context;
 
-    monitor_data_init(mon, false, false);
+    monitor_data_init(mon, false, !CHARDEV_IS_MUX(chr));
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-- 
2.13.5
