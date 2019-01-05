Received: from eggsout.gnu.org ([209.51.188.92]:56599 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVv-0003tw-NL
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVt-0007oU-Pp
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:23 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat,  5 Jan 2019 08:00:58 -0600
Message-Id: <20190105140100.26913-7-eblake@redhat.com>
In-Reply-To: <20190105140100.26913-1-eblake@redhat.com>
References: <20190105140100.26913-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] nbd/client: More consistent error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Consolidate on using decimal (not hex), on outputting the
option reply name (not just value), and a consistent comma between
clauses, when the client reports protocol discrepancies from the
server.  While it won't affect normal operation, it makes
debugging additions easier.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181215135324.152629-6-eblake@redhat.com>
---
 nbd/client.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 0ad7147ed95..e77414711ba 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -132,8 +132,9 @@ static int nbd_receive_option_reply(QIOChannel *ioc, =
uint32_t opt,
         return -1;
     }
     if (reply->option !=3D opt) {
-        error_setg(errp, "Unexpected option type %x expected %x",
-                   reply->option, opt);
+        error_setg(errp, "Unexpected option type %u (%s), expected %u (%=
s)",
+                   reply->option, nbd_opt_lookup(reply->option),
+                   opt, nbd_opt_lookup(opt));
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -267,8 +268,9 @@ static int nbd_receive_list(QIOChannel *ioc, const ch=
ar *want, bool *match,
         }
         return 0;
     } else if (reply.type !=3D NBD_REP_SERVER) {
-        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x"=
,
-                   reply.type, NBD_REP_SERVER);
+        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s=
)",
+                   reply.type, nbd_rep_lookup(reply.type),
+                   NBD_REP_SERVER, nbd_rep_lookup(NBD_REP_SERVER));
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -380,9 +382,9 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wa=
ntname,
             return 1;
         }
         if (reply.type !=3D NBD_REP_INFO) {
-            error_setg(errp, "unexpected reply type %" PRIu32
-                       " (%s), expected %u",
-                       reply.type, nbd_rep_lookup(reply.type), NBD_REP_I=
NFO);
+            error_setg(errp, "unexpected reply type %u (%s), expected %u=
 (%s)",
+                       reply.type, nbd_rep_lookup(reply.type),
+                       NBD_REP_INFO, nbd_rep_lookup(NBD_REP_INFO));
             nbd_send_opt_abort(ioc);
             return -1;
         }
@@ -706,8 +708,9 @@ static int nbd_negotiate_simple_meta_context(QIOChann=
el *ioc,
     }

     if (reply.type !=3D NBD_REP_ACK) {
-        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x"=
,
-                   reply.type, NBD_REP_ACK);
+        error_setg(errp, "Unexpected reply type %u (%s), expected %u (%s=
)",
+                   reply.type, nbd_rep_lookup(reply.type),
+                   NBD_REP_ACK, nbd_rep_lookup(NBD_REP_ACK));
         nbd_send_opt_abort(ioc);
         return -1;
     }
--=20
2.20.1
