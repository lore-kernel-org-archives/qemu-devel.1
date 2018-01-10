Received: from eggs.gnu.org ([2001:4830:134:3::10]:50463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPUC-0006J9-ND
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPU9-00069H-AQ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 17:08:22 -0600
Message-Id: <20180110230825.18321-4-eblake@redhat.com>
In-Reply-To: <20180110230825.18321-1-eblake@redhat.com>
References: <20180110230825.18321-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] nbd/server: Better error for
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
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>

When a client abruptly disconnects before we've finished reading
the name sent with NBD_OPT_EXPORT_NAME, we are better off logging
the failure as EIO (we can't communicate with the client), rather
than EINVAL (the client sent bogus data).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 08a24b56f4..9943a911c3 100644
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
