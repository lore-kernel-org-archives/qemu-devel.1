Received: from eggs.gnu.org ([2001:4830:134:3::10]:34487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOF-0004qf-Na
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOE-0008E2-Lc
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:59 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:14 -0600
Message-Id: <20181215135324.152629-13-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/22] nbd/client: Improve error handling in
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
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Always allocate space for the reply returned by the server and
hoist the trace earlier, as it is more interesting to trace the
server's reply (even if it is unexpected) than parroting our
request only on success.  After all, skipping the allocation
for a wrong size was merely a micro-optimization that only
benefitted a broken server, rather than the common case of a
compliant server that meets our expectations.

Then turn the reply handling into a loop (even though we still
never iterate more than once), to make this code easier to use
when later patches do support multiple server replies.  This
changes the error message for a server with two replies (a
corner case we are unlikely to hit in practice) from:

Unexpected reply type 4 (meta context), expected 0 (ack)

to:

Server replied with more than one context

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: split patch into easier-to-review pieces [Rich, Vladimir]
---
 nbd/client.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index bcccd5f555e..b6a85fc3ef8 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -684,10 +684,11 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         return ret;
     }

-    if (reply.type == NBD_REP_META_CONTEXT) {
+    while (reply.type == NBD_REP_META_CONTEXT) {
         char *name;

-        if (reply.length != sizeof(info->context_id) + context_len) {
+        if (reply.length <= sizeof(info->context_id) ||
+            reply.length > NBD_MAX_BUFFER_SIZE) {
             error_setg(errp, "Failed to negotiate meta context '%s', server "
                        "answered with unexpected length %" PRIu32, context,
                        reply.length);
@@ -708,6 +709,15 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
             return -1;
         }
         name[reply.length] = '\0';
+        trace_nbd_opt_meta_reply(name, info->context_id);
+
+        if (received) {
+            error_setg(errp, "Server replied with more than one context");
+            g_free(name);
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
+
         if (strcmp(context, name)) {
             error_setg(errp, "Failed to negotiate meta context '%s', server "
                        "answered with different context '%s'", context,
@@ -717,8 +727,6 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
             return -1;
         }
         g_free(name);
-
-        trace_nbd_opt_meta_reply(context, info->context_id);
         received = true;

         /* receive NBD_REP_ACK */
-- 
2.17.2
