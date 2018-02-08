Received: from eggs.gnu.org ([2001:4830:134:3::10]:37380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjVb-00079v-VO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjVb-0005pn-3V
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ejjVa-0005pT-W0
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:51 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu,  8 Feb 2018 18:31:28 +0800
Message-Id: <20180208103132.28452-25-peterx@redhat.com>
In-Reply-To: <20180208103132.28452-1-peterx@redhat.com>
References: <20180208103132.28452-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 24/28] io: let watcher of the channel run in
 same ctx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Per-thread gcontext is only used in IOThread (please refer to callers of
g_main_context_push_thread_default), so this patch only affects anything
that will be run in an IOThread.  It lets the watcher object be run in
the same context as the caller that added the watcher.

This patch is critical to make sure that migration stream accept()
procedure will also be run in the monitor IOThread rather than the
default main thread, so it can survive even if main thread hangs.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel.c b/io/channel.c
index ec4b86de7c..d6018ddfb6 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -312,7 +312,7 @@ guint qio_channel_add_watch(QIOChannel *ioc,
 
     g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
 
-    id = g_source_attach(source, NULL);
+    id = g_source_attach(source, g_main_context_get_thread_default());
     g_source_unref(source);
 
     return id;
-- 
2.14.3
