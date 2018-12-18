Received: from eggs.gnu.org ([2001:4830:134:3::10]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZOJ1-0004pq-LA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZOIx-0007Cw-R4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:57:37 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 18 Dec 2018 16:57:13 -0600
Message-Id: <20181218225714.284495-3-eblake@redhat.com>
In-Reply-To: <20181218225714.284495-1-eblake@redhat.com>
References: <20181218225714.284495-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] nbd/client: Trace all server option
 error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Not all servers send free-form text alongside option error replies, but
for servers that do (such as qemu), we pass the server's message as a
hint alongside our own error reporting.  However, it would also be
useful to trace such server messages, since we can't guarantee how the
hint may be consumed.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c     | 2 ++
 nbd/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/nbd/client.c b/nbd/client.c
index b4d457a19ad..0ad7147ed95 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -171,6 +171,8 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
             goto cleanup;
         }
         msg[reply->length] = '\0';
+        trace_nbd_server_error_msg(reply->type,
+                                   nbd_reply_type_lookup(reply->type), msg);
     }

     switch (reply->type) {
diff --git a/nbd/trace-events b/nbd/trace-events
index 5e1d4afe8e6..5492042acbf 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -1,6 +1,7 @@
 # nbd/client.c
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIu32" (%s), type %" PRIu32" (%s), len %" PRIu32
+nbd_server_error_msg(uint32_t err, const char *type, const char *msg) "server reported error 0x%" PRIx32 " (%s) with additional message: %s"
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIu32 " (%s), attempting fallback"
 nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
-- 
2.17.2
