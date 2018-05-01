Received: from eggs.gnu.org ([2001:4830:134:3::10]:46210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcav-0006lx-PY
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcau-0001Zr-RZ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  1 May 2018 16:13:34 -0500
Message-Id: <20180501211336.986372-3-eblake@redhat.com>
In-Reply-To: <20180501211336.986372-1-eblake@redhat.com>
References: <20180501211336.986372-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] nbd/client: Refactor in preparation for
 more limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>

The next patch will ask the server for more items of NBD_INFO.
However, the server is free to respond with INFO items in a
different order than what we request, so performing any sanity
checks about constraints that occur between multiple INFO items
must be done after all items have been received.  Make it easier
to see that such checks are last by sinking the final processing
after the while loop, rather than embedded in the NBD_REP_ACK
processing that occurs textually within the loop before other
INFO processing.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 232ff4f46da..0abb195b856 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2017 Red Hat, Inc.
+ *  Copyright (C) 2016-2018 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -365,17 +365,12 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,

         if (reply.type == NBD_REP_ACK) {
             /* Server is done sending info and moved into transmission
-               phase, but make sure it sent flags */
+               phase */
             if (len) {
                 error_setg(errp, "server sent invalid NBD_REP_ACK");
                 return -1;
             }
-            if (!info->flags) {
-                error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
-                return -1;
-            }
-            trace_nbd_opt_go_success();
-            return 1;
+            break;
         }
         if (reply.type != NBD_REP_INFO) {
             error_setg(errp, "unexpected reply type %" PRIu32
@@ -482,6 +477,14 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             break;
         }
     }
+
+    /* Sanity check that server's responses make sense */
+    if (!info->flags) {
+        error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
+        return -1;
+    }
+    trace_nbd_opt_go_success();
+    return 1;
 }

 /* Return -1 on failure, 0 if wantname is an available export. */
-- 
2.14.3
