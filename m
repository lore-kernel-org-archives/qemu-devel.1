Received: from eggs.gnu.org ([2001:4830:134:3::10]:36750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDXX-0008Mo-Ds
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDXW-0008Hw-Pv
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDXW-0008HO-Ih
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:18 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:31 +0800
Message-Id: <20171219084557.9801-2-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 01/27] chardev: use backend chr context when
 watch for fe
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

In commit 6bbb6c0644 ("chardev: use per-dev context for
io_add_watch_poll", 2017-09-22) all the chardev watches are converted to
use per-chardev gcontext to support chardev to be run outside default
main thread.  However that's still missing one call from the frontend
code.  Touch that up.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-fe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index ee6d596100..462c529f19 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -356,7 +356,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
     }
 
     g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
-    tag = g_source_attach(src, NULL);
+    tag = g_source_attach(src, be->chr->gcontext);
     g_source_unref(src);
 
     return tag;
-- 
2.14.3
