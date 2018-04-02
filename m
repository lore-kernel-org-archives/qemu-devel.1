Received: from eggs.gnu.org ([2001:4830:134:3::10]:51634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f30G4-0000Li-4c
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f30G3-0004QJ-4y
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:16:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Apr 2018 09:16:13 -0500
Message-Id: <20180402141614.2008263-3-eblake@redhat.com>
In-Reply-To: <20180402141614.2008263-1-eblake@redhat.com>
References: <20180402141614.2008263-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] nbd/client: Correctly handle bad server
 REP_META_CONTEXT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

It's never a good idea to blindly read for size bytes as
returned by the server without first validating that the size
is within bounds; a malicious or buggy server could cause us
to hang or get out of sync from reading further messages.

It may be smarter to try and teach the client to cope with
unexpected context ids by silently ignoring them instead of
hanging up on the server, but for now, if the server doesn't
reply with exactly the one context we expect, it's easier to
just give up - however, if we give up for any reason other
than an I/O failure, we might as well try to politely tell
the server we are quitting rather than continuing.

Fix some typos in the process.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180329231837.1914680-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 9b9b7f0ea29..dd0174b036e 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -599,8 +599,8 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
  * Set one meta context. Simple means that reply must contain zero (not
  * negotiated) or one (negotiated) contexts. More contexts would be considered
  * as a protocol error. It's also implied that meta-data query equals queried
- * context name, so, if server replies with something different then @context,
- * it considered as error too.
+ * context name, so, if server replies with something different than @context,
+ * it is considered an error too.
  * return 1 for successful negotiation, context_id is set
  *        0 if operation is unsupported,
  *        -1 with errp set for any other error
@@ -649,25 +649,33 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,

     if (reply.type == NBD_REP_META_CONTEXT) {
         char *name;
-        size_t len;
+
+        if (reply.length != sizeof(received_id) + context_len) {
+            error_setg(errp, "Failed to negotiate meta context '%s', server "
+                       "answered with unexpected length %" PRIu32, context,
+                       reply.length);
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }

         if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
             return -1;
         }
         be32_to_cpus(&received_id);

-        len = reply.length - sizeof(received_id);
-        name = g_malloc(len + 1);
-        if (nbd_read(ioc, name, len, errp) < 0) {
+        reply.length -= sizeof(received_id);
+        name = g_malloc(reply.length + 1);
+        if (nbd_read(ioc, name, reply.length, errp) < 0) {
             g_free(name);
             return -1;
         }
-        name[len] = '\0';
+        name[reply.length] = '\0';
         if (strcmp(context, name)) {
             error_setg(errp, "Failed to negotiate meta context '%s', server "
                        "answered with different context '%s'", context,
                        name);
             g_free(name);
+            nbd_send_opt_abort(ioc);
             return -1;
         }
         g_free(name);
@@ -690,6 +698,12 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
     if (reply.type != NBD_REP_ACK) {
         error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
                    reply.type, NBD_REP_ACK);
+        nbd_send_opt_abort(ioc);
+        return -1;
+    }
+    if (reply.length) {
+        error_setg(errp, "Unexpected length to ACK response");
+        nbd_send_opt_abort(ioc);
         return -1;
     }

-- 
2.14.3
