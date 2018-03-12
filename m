Received: from eggs.gnu.org ([2001:4830:134:3::10]:45488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJe-0000uX-5g
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJd-00065C-By
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJd-00064s-7s
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0B514000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:22 -0500
Message-Id: <20180312183628.394722-32-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 31/36] monitor: enable IO thread for (qmp &
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
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

Start to use dedicate IO thread for QMP monitors that are not using
MUXed chardev.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-21-peterx@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 905d5efc6fa..dea4111e693 100644
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
