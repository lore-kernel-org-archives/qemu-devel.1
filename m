Received: from eggs.gnu.org ([2001:4830:134:3::10]:39486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBB-0002w3-Ks
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBA-0000kx-Qs
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:49 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 10:59:32 -0600
Message-Id: <20171109165939.23154-2-eblake@redhat.com>
In-Reply-To: <20171109165939.23154-1-eblake@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] nbd/server: fix nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

namelen should be here, length is unrelated, and always 0 at this
point.  Broken in introduction in commit f37708f6, but mostly
harmless (replying with '' as the name does not violate protocol,
and does not confuse qemu as the nbd client since our implementation
does not ask for the name; but might confuse some other client that
does ask for the name especially if the default export is different
than the export name being queried).

Adding an assert makes it obvious that we are not skipping any bytes
in the client's message, as well as making it obvious that we were
using the wrong variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: qemu-stable@nongnu.org
Message-Id: <20171101154204.27146-1-vsementsov@virtuozzo.com>
[eblake: improve commit message, squash in assert addition]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 70b40ed27e..bcf0cdb47c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -423,6 +423,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
             break;
         }
     }
+    assert(length == 0);

     exp = nbd_export_find(name);
     if (!exp) {
@@ -433,7 +434,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,

     /* Don't bother sending NBD_INFO_NAME unless client requested it */
     if (sendname) {
-        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, length, name,
+        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, namelen, name,
                                      errp);
         if (rc < 0) {
             return rc;
-- 
2.13.6
