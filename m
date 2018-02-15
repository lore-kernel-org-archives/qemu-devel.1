Received: from eggs.gnu.org ([2001:4830:134:3::10]:51125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxU-0001q7-KQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxQ-0000z6-Dg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:20 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:43 +0300
Message-Id: <1518702707-7077-6-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/9] nbd/client: fix error messages in
 nbd_handle_reply_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

1. NBD_REP_ERR_INVALID is not only about length, so, make message more
   general

2. hex format is not very good: it's hard to read something like
   "option a (set meta context)", so switch to dec.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 89f80f9590..1f730341c0 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -180,22 +180,22 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
         goto cleanup;
 
     case NBD_REP_ERR_POLICY:
-        error_setg(errp, "Denied by server for option %" PRIx32 " (%s)",
+        error_setg(errp, "Denied by server for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_INVALID:
-        error_setg(errp, "Invalid data length for option %" PRIx32 " (%s)",
+        error_setg(errp, "Invalid parameters for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_PLATFORM:
-        error_setg(errp, "Server lacks support for option %" PRIx32 " (%s)",
+        error_setg(errp, "Server lacks support for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_TLS_REQD:
-        error_setg(errp, "TLS negotiation required before option %" PRIx32
+        error_setg(errp, "TLS negotiation required before option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
 
@@ -204,17 +204,17 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
         break;
 
     case NBD_REP_ERR_SHUTDOWN:
-        error_setg(errp, "Server shutting down before option %" PRIx32 " (%s)",
+        error_setg(errp, "Server shutting down before option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_BLOCK_SIZE_REQD:
-        error_setg(errp, "Server requires INFO_BLOCK_SIZE for option %" PRIx32
+        error_setg(errp, "Server requires INFO_BLOCK_SIZE for option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
 
     default:
-        error_setg(errp, "Unknown error code when asking for option %" PRIx32
+        error_setg(errp, "Unknown error code when asking for option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
     }
-- 
2.11.1
