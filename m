Received: from eggs.gnu.org ([2001:4830:134:3::10]:51631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f30G3-0000LD-Tv
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f30G3-0004Q4-2p
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:16:27 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Apr 2018 09:16:12 -0500
Message-Id: <20180402141614.2008263-2-eblake@redhat.com>
In-Reply-To: <20180402141614.2008263-1-eblake@redhat.com>
References: <20180402141614.2008263-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] nbd: Fix 32-bit compilation on BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

iotests 123 and 209 fail on 32-bit platforms.  The culprit:
sizeof(extent) is wrong; we want sizeof(*extent).  But since
the struct is 8 bytes, it happened to work on 64-bit platforms
where the pointer is also 8 bytes (nasty).

Fixes: 78a33ab58
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180327210517.1804242-1-eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index e64e346d690..e7caf49fbb4 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -239,7 +239,7 @@ static int nbd_parse_blockstatus_payload(NBDClientSession *client,
 {
     uint32_t context_id;

-    if (chunk->length != sizeof(context_id) + sizeof(extent)) {
+    if (chunk->length != sizeof(context_id) + sizeof(*extent)) {
         error_setg(errp, "Protocol error: invalid payload for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS");
         return -EINVAL;
-- 
2.14.3
