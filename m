Received: from eggs.gnu.org ([2001:4830:134:3::10]:34786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOy-0005WH-67
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOx-0000Ou-2B
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:23 -0600
Message-Id: <20181215135324.152629-22-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 21/22] nbd/client: Work around 3.0 bug for
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
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

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

v2: rebase on top of earlier patch splits
---
 nbd/client.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/nbd/client.c b/nbd/client.c
index d392b5e8bee..48fa6e10b92 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "nbd-internal.h"
+#include "qemu/cutils.h"

 /* Definitions for opaque data types */

@@ -819,6 +820,8 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
                                   Error **errp)
 {
     int ret;
+    int seen_any = false;
+    int seen_qemu = false;

     if (nbd_send_one_meta_context(ioc, NBD_OPT_LIST_META_CONTEXT,
                                   info->name, NULL, errp) < 0) {
@@ -830,9 +833,25 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,

         ret = nbd_receive_one_meta_context(ioc, NBD_OPT_LIST_META_CONTEXT,
                                            &context, NULL, errp);
+        if (ret == 0 && seen_any && !seen_qemu) {
+            /*
+             * Work around qemu 3.0 bug: the server forgot to send
+             * "qemu:" replies to 0 queries. If we saw at least one
+             * reply (probably base:allocation), but none of them were
+             * qemu:, then run a more specific query to make sure.
+             */
+            seen_qemu = true;
+            if (nbd_send_one_meta_context(ioc, NBD_OPT_LIST_META_CONTEXT,
+                                          info->name, "qemu:", errp) < 0) {
+                return -1;
+            }
+            continue;
+        }
         if (ret <= 0) {
             return ret;
         }
+        seen_any = true;
+        seen_qemu |= strstart(context, "qemu:", NULL);
         info->contexts = g_renew(char *, info->contexts, ++info->n_contexts);
         info->contexts[info->n_contexts - 1] = context;
     }
-- 
2.17.2
