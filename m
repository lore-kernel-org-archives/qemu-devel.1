Received: from eggs.gnu.org ([209.51.188.92]:33975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDU7-0004me-RD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDU2-0000Fx-Iz
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:50 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:57 -0600
Message-Id: <20190117193658.16413-21-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 20/21] nbd/client: Work around 3.0 bug for
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
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Commit 3d068aff forgot to advertise available qemu: contexts
when the client requests a list with 0 queries. Furthermore,
3.0 shipped with a qemu-img hack of x-dirty-bitmap (commit
216ee365) that _silently_ acts as though the entire image is
clean if a requested bitmap is not present.  Both bugs have
been recently fixed, so that a modern qemu server gives full
context output right away, and the client refuses a
connection if a requested x-dirty-bitmap was not found.

Still, it is likely that there will be users that have to
work with a mix of old and new qemu versions, depending on
which features get backported where, at which point being
able to rely on 'qemu-img --list' output to know for sure
whether a given NBD export has the desired dirty bitmap is
much nicer than blindly connecting and risking that the
entire image may appear clean.  We can make our --list code
smart enough to work around buggy servers by tracking
whether we've seen any qemu: replies in the original 0-query
list; if not, repeat with a single query on "qemu:" (which
may still have no replies, but then we know for sure we
didn't trip up on the server bug).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v4: minor rebase
---
 nbd/client.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/nbd/client.c b/nbd/client.c
index 798b82f205a..8a083c2f42c 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "nbd-internal.h"
+#include "qemu/cutils.h"

 /* Definitions for opaque data types */

@@ -828,6 +829,8 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
                                   Error **errp)
 {
     int ret;
+    int seen_any =3D false;
+    int seen_qemu =3D false;

     if (nbd_send_meta_query(ioc, NBD_OPT_LIST_META_CONTEXT,
                             info->name, NULL, errp) < 0) {
@@ -839,9 +842,25 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,

         ret =3D nbd_receive_one_meta_context(ioc, NBD_OPT_LIST_META_CONT=
EXT,
                                            &context, NULL, errp);
+        if (ret =3D=3D 0 && seen_any && !seen_qemu) {
+            /*
+             * Work around qemu 3.0 bug: the server forgot to send
+             * "qemu:" replies to 0 queries. If we saw at least one
+             * reply (probably base:allocation), but none of them were
+             * qemu:, then run a more specific query to make sure.
+             */
+            seen_qemu =3D true;
+            if (nbd_send_meta_query(ioc, NBD_OPT_LIST_META_CONTEXT,
+                                    info->name, "qemu:", errp) < 0) {
+                return -1;
+            }
+            continue;
+        }
         if (ret <=3D 0) {
             return ret;
         }
+        seen_any =3D true;
+        seen_qemu |=3D strstart(context, "qemu:", NULL);
         info->contexts =3D g_renew(char *, info->contexts, ++info->n_con=
texts);
         info->contexts[info->n_contexts - 1] =3D context;
     }
--=20
2.20.1
