Received: from eggs.gnu.org ([2001:4830:134:3::10]:56121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtQ-0004Um-5a
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtP-00053y-9N
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:12 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:41 -0600
Message-Id: <20181130220344.3350618-13-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] nbd/client: Work around 3.0 bug for
 listing meta contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Commit 3d068aff forgot to advertise available qemu: contexts
when the client requests a list with 0 queries. Furthermore,
3.0 shipped with a qemu-img hack of x-dirty-bitmap (commit
216ee365) that _silently_ acts as though the entire image is
clean if a requested bitmap is not present.  Both bugs have
been recently fixed to give full output from the start, and
to refuse a connection if a requested x-dirty-bitmap was not
found.

Still, it is likely that there will be users that have to
work with a mix of old and new qemu versions, depending on
which features get backported where, at which point being
able to rely on 'qemu-img --list' output to know for sure
whether a given NBD export has the desired dirty bitmap is
much nicer than blindly connecting and risking that the
entire image may appear clean.  We can make our --list code
smart enough to work around buggy servers by tracking
whether we've seen any qemu: replies in the original 0-query
list; if not, recurse to a single query on "qemu:" (which
may still have no replies, but then we know for sure we
didn't trip up on the server bug).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
Done as a separate patch to make it easier to revert when we no
longer care about 3.0 servers
---
 nbd/client.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index 6292de560ee..928ecabd420 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "nbd-internal.h"
+#include "qemu/cutils.h"

 /* Definitions for opaque data types */

@@ -736,12 +737,13 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
                 return -1;
             }
             g_free(name);
+            received = true;
         } else {
             info->contexts = g_renew(char *, info->contexts,
                                      ++info->n_contexts);
             info->contexts[info->n_contexts - 1] = name;
+            received |= strstart(name, "qemu:", NULL);
         }
-        received = true;

         /* receive NBD_REP_ACK */
         if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
@@ -771,6 +773,13 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         info->meta_base_allocation_id = received_id;
     }

+    /* Recurse to work around qemu 3.0 bug - the server forgot to send
+     * "qemu:" replies to 0 queries. */
+    if (!context && !received) {
+        return nbd_negotiate_simple_meta_context(ioc, opt, "qemu:", info,
+                                                 errp);
+    }
+
     return received || opt == NBD_OPT_LIST_META_CONTEXT;
 }

-- 
2.17.2
