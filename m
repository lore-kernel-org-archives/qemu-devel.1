Received: from eggs.gnu.org ([209.51.188.92]:40336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO8-0001Rt-D8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO6-0005Ii-Mk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:52 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:56 -0600
Message-Id: <20190121224907.26634-11-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/21] nbd/client: Change signature of
 nbd_negotiate_simple_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Pass 'info' instead of three separate parameters related to info,
when requesting the server to set the meta context.  Update the
NBDExportInfo struct to rename the received id field to match the
fact that we are currently overloading the field to match whatever
context the user supplied through the x-dirty-bitmap hack, as well
as adding a TODO comment to remind future patches about a desire
to request two contexts at once.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190117193658.16413-11-eblake@redhat.com>
---
 include/block/nbd.h |  2 +-
 block/nbd-client.c  |  4 ++--
 nbd/client.c        | 53 +++++++++++++++++++++------------------------
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 00d3eb57d9c..be19aac2fc7 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -276,7 +276,7 @@ struct NBDExportInfo {
     uint32_t opt_block;
     uint32_t max_block;

-    uint32_t meta_base_allocation_id;
+    uint32_t context_id;
 };
 typedef struct NBDExportInfo NBDExportInfo;

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 3309376bc16..813539676d2 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -249,11 +249,11 @@ static int nbd_parse_blockstatus_payload(NBDClientS=
ession *client,
     }

     context_id =3D payload_advance32(&payload);
-    if (client->info.meta_base_allocation_id !=3D context_id) {
+    if (client->info.context_id !=3D context_id) {
         error_setg(errp, "Protocol error: unexpected context id %d for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated c=
ontext "
                          "id is %d", context_id,
-                         client->info.meta_base_allocation_id);
+                         client->info.context_id);
         return -EINVAL;
     }

diff --git a/nbd/client.c b/nbd/client.c
index 8227e69478a..77993890f04 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -630,26 +630,30 @@ static QIOChannel *nbd_receive_starttls(QIOChannel =
*ioc,
 }

 /* nbd_negotiate_simple_meta_context:
- * Set one meta context. Simple means that reply must contain zero (not
- * negotiated) or one (negotiated) contexts. More contexts would be cons=
idered
- * as a protocol error. It's also implied that meta-data query equals qu=
eried
- * context name, so, if server replies with something different than @co=
ntext,
- * it is considered an error too.
- * return 1 for successful negotiation, context_id is set
+ * Request the server to set the meta context for export @info->name
+ * using @info->x_dirty_bitmap with a fallback to "base:allocation",
+ * setting @info->context_id to the resulting id. Fail if the server
+ * responds with more than one context or with a context different
+ * than the query.
+ * return 1 for successful negotiation,
  *        0 if operation is unsupported,
  *        -1 with errp set for any other error
  */
 static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
-                                             const char *export,
-                                             const char *context,
-                                             uint32_t *context_id,
+                                             NBDExportInfo *info,
                                              Error **errp)
 {
+    /*
+     * TODO: Removing the x_dirty_bitmap hack will mean refactoring
+     * this function to request and store ids for multiple contexts
+     * (both base:allocation and a dirty bitmap), at which point this
+     * function should lose the term _simple.
+     */
     int ret;
     NBDOptionReply reply;
-    uint32_t received_id =3D 0;
+    const char *context =3D info->x_dirty_bitmap ?: "base:allocation";
     bool received =3D false;
-    uint32_t export_len =3D strlen(export);
+    uint32_t export_len =3D strlen(info->name);
     uint32_t context_len =3D strlen(context);
     uint32_t data_len =3D sizeof(export_len) + export_len +
                         sizeof(uint32_t) + /* number of queries */
@@ -657,9 +661,9 @@ static int nbd_negotiate_simple_meta_context(QIOChann=
el *ioc,
     char *data =3D g_malloc(data_len);
     char *p =3D data;

-    trace_nbd_opt_meta_request(context, export);
+    trace_nbd_opt_meta_request(context, info->name);
     stl_be_p(p, export_len);
-    memcpy(p +=3D sizeof(export_len), export, export_len);
+    memcpy(p +=3D sizeof(export_len), info->name, export_len);
     stl_be_p(p +=3D export_len, 1);
     stl_be_p(p +=3D sizeof(uint32_t), context_len);
     memcpy(p +=3D sizeof(context_len), context, context_len);
@@ -685,7 +689,7 @@ static int nbd_negotiate_simple_meta_context(QIOChann=
el *ioc,
     if (reply.type =3D=3D NBD_REP_META_CONTEXT) {
         char *name;

-        if (reply.length !=3D sizeof(received_id) + context_len) {
+        if (reply.length !=3D sizeof(info->context_id) + context_len) {
             error_setg(errp, "Failed to negotiate meta context '%s', ser=
ver "
                        "answered with unexpected length %" PRIu32, conte=
xt,
                        reply.length);
@@ -693,12 +697,13 @@ static int nbd_negotiate_simple_meta_context(QIOCha=
nnel *ioc,
             return -1;
         }

-        if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) =
{
+        if (nbd_read(ioc, &info->context_id, sizeof(info->context_id),
+                     errp) < 0) {
             return -1;
         }
-        received_id =3D be32_to_cpu(received_id);
+        info->context_id =3D be32_to_cpu(info->context_id);

-        reply.length -=3D sizeof(received_id);
+        reply.length -=3D sizeof(info->context_id);
         name =3D g_malloc(reply.length + 1);
         if (nbd_read(ioc, name, reply.length, errp) < 0) {
             g_free(name);
@@ -715,7 +720,7 @@ static int nbd_negotiate_simple_meta_context(QIOChann=
el *ioc,
         }
         g_free(name);

-        trace_nbd_opt_meta_reply(context, received_id);
+        trace_nbd_opt_meta_reply(context, info->context_id);
         received =3D true;

         /* receive NBD_REP_ACK */
@@ -744,12 +749,7 @@ static int nbd_negotiate_simple_meta_context(QIOChan=
nel *ioc,
         return -1;
     }

-    if (received) {
-        *context_id =3D received_id;
-        return 1;
-    }
-
-    return 0;
+    return received;
 }

 int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
@@ -848,10 +848,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTL=
SCreds *tlscreds,
             }

             if (info->structured_reply && base_allocation) {
-                result =3D nbd_negotiate_simple_meta_context(
-                        ioc, info->name,
-                        info->x_dirty_bitmap ?: "base:allocation",
-                        &info->meta_base_allocation_id, errp);
+                result =3D nbd_negotiate_simple_meta_context(ioc, info, =
errp);
                 if (result < 0) {
                     goto fail;
                 }
--=20
2.20.1
