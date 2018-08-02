Received: from eggs.gnu.org ([2001:4830:134:3::10]:36369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuC-0002CO-6b
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuB-0008Vo-AZ
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:44 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  2 Aug 2018 09:48:32 -0500
Message-Id: <20180802144834.520904-3-eblake@redhat.com>
In-Reply-To: <20180802144834.520904-1-eblake@redhat.com>
References: <20180802144834.520904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] nbd/server: Advertise actual minimum block
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Both NBD_CMD_BLOCK_STATUS and structured NBD_CMD_READ will split
their reply according to bdrv_block_status() boundaries. If the
block device has a request_alignment smaller than 512, but we
advertise a block alignment of 512 to the client, then this can
result in the server reply violating client expectations by
reporting a smaller region of the export than what the client
is permitted to address.  Thus, it is imperative that we
advertise the actual minimum block limit, rather than blindly
rounding it up to 512 (bdrv_block_status() cannot return status
aligned any smaller than request_alignment).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index ea5fe0eb336..cd3c41f895b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -608,10 +608,12 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     /* Send NBD_INFO_BLOCK_SIZE always, but tweak the minimum size
      * according to whether the client requested it, and according to
      * whether this is OPT_INFO or OPT_GO. */
-    /* minimum - 1 for back-compat, or 512 if client is new enough.
-     * TODO: consult blk_bs(blk)->bl.request_alignment? */
-    sizes[0] =
-            (client->opt == NBD_OPT_INFO || blocksize) ? BDRV_SECTOR_SIZE : 1;
+    /* minimum - 1 for back-compat, or actual if client will obey it. */
+    if (client->opt == NBD_OPT_INFO || blocksize) {
+        sizes[0] = blk_get_request_alignment(exp->blk);
+    } else {
+        sizes[0] = 1;
+    }
     /* preferred - Hard-code to 4096 for now.
      * TODO: is blk_bs(blk)->bl.opt_transfer appropriate? */
     sizes[1] = 4096;
-- 
2.14.4
