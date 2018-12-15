Received: from eggs.gnu.org ([2001:4830:134:3::10]:34315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAO3-0004gt-Qo
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAO2-000848-QZ
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:07 -0600
Message-Id: <20181215135324.152629-6-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/22] nbd/client: More consistent error
 messages
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

Consolidate on using decimal (not hex), on outputting the
option reply name (not just value), and a consistent comma between
clauses, when the client reports protocol discrepancies from the
server.  While it won't affect normal operation, it makes
debugging additions easier.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v2: consistent use of comma [Vladimir]
---
 nbd/client.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b4d457a19ad..5d59d5ba78a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -132,8 +132,9 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
         return -1;
     }
     if (reply->option != opt) {
-        error_setg(errp, "Unexpected option type %x expected %x",
-                   reply->option, opt);
+        error_setg(errp, "Unexpected option type %u (%s), expected %u (%s)",
+                   reply->option, nbd_opt_lookup(reply->option),
+                   opt, nbd_opt_lookup(opt));
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -265,8 +266,9 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         }
         return 0;
     } else if (reply.type != NBD_REP_SERVER) {
-        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
-                   reply.type, NBD_REP_SERVER);
+        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s)",
+                   reply.type, nbd_rep_lookup(reply.type),
+                   NBD_REP_SERVER, nbd_rep_lookup(NBD_REP_SERVER));
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -378,9 +380,9 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             return 1;
         }
         if (reply.type != NBD_REP_INFO) {
-            error_setg(errp, "unexpected reply type %" PRIu32
-                       " (%s), expected %u",
-                       reply.type, nbd_rep_lookup(reply.type), NBD_REP_INFO);
+            error_setg(errp, "unexpected reply type %u (%s), expected %u (%s)",
+                       reply.type, nbd_rep_lookup(reply.type),
+                       NBD_REP_INFO, nbd_rep_lookup(NBD_REP_INFO));
             nbd_send_opt_abort(ioc);
             return -1;
         }
@@ -704,8 +706,9 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
     }

     if (reply.type != NBD_REP_ACK) {
-        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
-                   reply.type, NBD_REP_ACK);
+        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s)",
+                   reply.type, nbd_rep_lookup(reply.type),
+                   NBD_REP_ACK, nbd_rep_lookup(NBD_REP_ACK));
         nbd_send_opt_abort(ioc);
         return -1;
     }
-- 
2.17.2
