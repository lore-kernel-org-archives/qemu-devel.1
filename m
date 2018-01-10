Received: from eggs.gnu.org ([2001:4830:134:3::10]:44884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPLg-0001bR-Q7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPLf-0004jR-Pv
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:59:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 16:59:44 -0600
Message-Id: <20180110225944.17920-3-eblake@redhat.com>
In-Reply-To: <20180110225944.17920-1-eblake@redhat.com>
References: <20180110225944.17920-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] nbd: rename nbd_option and nbd_opt_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rename nbd_option and nbd_opt_reply to NBDOption and NBDOptionReply
to correspond to Qemu coding style and other structures here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171122101958.17065-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  8 ++++----
 nbd/client.c        | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 113c707a5e..978e443366 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -28,20 +28,20 @@

 /* Handshake phase structs - this struct is passed on the wire */

-struct nbd_option {
+struct NBDOption {
     uint64_t magic; /* NBD_OPTS_MAGIC */
     uint32_t option; /* NBD_OPT_* */
     uint32_t length;
 } QEMU_PACKED;
-typedef struct nbd_option nbd_option;
+typedef struct NBDOption NBDOption;

-struct nbd_opt_reply {
+struct NBDOptionReply {
     uint64_t magic; /* NBD_REP_MAGIC */
     uint32_t option; /* NBD_OPT_* */
     uint32_t type; /* NBD_REP_* */
     uint32_t length;
 } QEMU_PACKED;
-typedef struct nbd_opt_reply nbd_opt_reply;
+typedef struct NBDOptionReply NBDOptionReply;

 /* Transmission phase structs
  *
diff --git a/nbd/client.c b/nbd/client.c
index eea236ca06..89f80f9590 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -66,7 +66,7 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
                                    uint32_t len, const char *data,
                                    Error **errp)
 {
-    nbd_option req;
+    NBDOption req;
     QEMU_BUILD_BUG_ON(sizeof(req) != 16);

     if (len == -1) {
@@ -109,7 +109,7 @@ static void nbd_send_opt_abort(QIOChannel *ioc)
  * payload. Return 0 if successful, -1 with errp set if it is
  * impossible to continue. */
 static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
-                                    nbd_opt_reply *reply, Error **errp)
+                                    NBDOptionReply *reply, Error **errp)
 {
     QEMU_BUILD_BUG_ON(sizeof(*reply) != 20);
     if (nbd_read(ioc, reply, sizeof(*reply), errp) < 0) {
@@ -146,7 +146,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
  * can fall back to other approaches), or -1 with errp set for other
  * errors.
  */
-static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
+static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
                                 Error **errp)
 {
     char *msg = NULL;
@@ -239,7 +239,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
 static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
                             Error **errp)
 {
-    nbd_opt_reply reply;
+    NBDOptionReply reply;
     uint32_t len;
     uint32_t namelen;
     char name[NBD_MAX_NAME_SIZE + 1];
@@ -325,7 +325,7 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
 static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                       NBDExportInfo *info, Error **errp)
 {
-    nbd_opt_reply reply;
+    NBDOptionReply reply;
     uint32_t len = strlen(wantname);
     uint16_t type;
     int error;
@@ -517,7 +517,7 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
  */
 static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error **errp)
 {
-    nbd_opt_reply reply;
+    NBDOptionReply reply;
     int error;

     if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
-- 
2.14.3
