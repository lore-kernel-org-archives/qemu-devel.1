Received: from eggs.gnu.org ([2001:4830:134:3::10]:60647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1goo-0004lo-Mn
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 19:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1gon-0002ZP-Pr
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 19:18:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 29 Mar 2018 18:18:37 -0500
Message-Id: <20180329231837.1914680-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] nbd/client: Correctly handle bad
 server REP_META_CONTEXT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

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
---
 nbd/client.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 9b9b7f0ea29..4ee1d9a4a2c 100644
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
@@ -651,6 +651,14 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         char *name;
         size_t len;

+        if (reply.length != sizeof(received_id) + context_len) {
+            error_setg(errp, "Failed to negotiate meta context '%s', server "
+                       "answered with unexpected length %u", context,
+                       reply.length);
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
+
         if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
             return -1;
         }
@@ -668,6 +676,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
                        "answered with different context '%s'", context,
                        name);
             g_free(name);
+            nbd_send_opt_abort(ioc);
             return -1;
         }
         g_free(name);
@@ -690,6 +699,12 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
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
