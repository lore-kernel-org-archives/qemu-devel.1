Received: from eggs.gnu.org ([2001:4830:134:3::10]:50564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebzud-0005ZM-JV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebzuc-000167-9E
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:26:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 17 Jan 2018 20:26:22 -0600
Message-Id: <20180118022625.6462-4-eblake@redhat.com>
In-Reply-To: <20180118022625.6462-1-eblake@redhat.com>
References: <20180118022625.6462-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] nbd/server: Better error for
 NBD_OPT_EXPORT_NAME failure
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

When a client abruptly disconnects before we've finished reading
the name sent with NBD_OPT_EXPORT_NAME, we are better off logging
the failure as EIO (we can't communicate with the client), rather
than EINVAL (the client sent bogus data).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180110230825.18321-4-eblake@redhat.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index b9efdcc605d..31c1d324297 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -299,7 +299,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client,
     }
     if (nbd_read(client->ioc, name, client->optlen, errp) < 0) {
         error_prepend(errp, "read failed: ");
-        return -EINVAL;
+        return -EIO;
     }
     name[client->optlen] = '\0';
     client->optlen = 0;
-- 
2.14.3
