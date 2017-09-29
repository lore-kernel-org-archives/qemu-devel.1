Received: from eggs.gnu.org ([2001:4830:134:3::10]:36242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAM-0006g3-0N
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAL-0007NA-6I
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmAL-0007Mw-0S
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:41 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:38 +0800
Message-Id: <20170929033844.26935-17-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 16/22] monitor: enable IO thread for (qmp &
 !mux) typed
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Start to use dedicate IO thread for QMP monitors that are not using
MUXed chardev.

We excluded MUXed chardev because when mux is used, frontend can be the
monitor plus something else.  The only thing we know would be safe to be
run outside main thread is the monitor frontend, all the rest of the
frontends should still be run in main thread only.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index d9bed31248..847468ecb0 100644
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
@@ -4262,7 +4263,7 @@ void monitor_init(Chardev *chr, int flags)
     Monitor *mon = g_malloc(sizeof(*mon));
     GMainContext *context;
 
-    monitor_data_init(mon, false, false);
+    monitor_data_init(mon, false, !CHARDEV_IS_MUX(chr));
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-- 
2.13.5
