Received: from eggs.gnu.org ([2001:4830:134:3::10]:33932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8Z-0001N8-8f
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8U-0004lq-31
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:11 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:2285 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eHS8T-0004k3-HE
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 22 Nov 2017 13:19:57 +0300
Message-Id: <20171122101958.17065-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-1-vsementsov@virtuozzo.com>
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/5] nbd: rename nbd_option and nbd_opt_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Rename nbd_optino and nbd_opt_reply to NBDOption and NBDOptionReply
to correspond to Qemu coding style and other structures here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.11.1
