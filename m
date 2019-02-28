Received: from eggs.gnu.org ([209.51.188.92]:36172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaV-000682-4l
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003dN-BQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:15 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:52020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003KN-1V
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:14 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 28 Feb 2019 17:34:36 +0000
Message-ID: <20190228173439.8013-2-anthony.perard@citrix.com>
In-Reply-To: <20190228173439.8013-1-anthony.perard@citrix.com>
References: <20190228173439.8013-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 1/4] dataplane/xen-block: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>

From: Paul Durrant <paul.durrant@citrix.com>

The if() statement is clearly bogus (dead code which should have been
cleaned up when grant mapping was removed).

Spotted by Coverity: CID 1398635

While in the neighbourhood, add a missing 'fall through' annotation.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190215162533.19475-2-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index c6a15da024..f1523c5b45 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -281,10 +281,6 @@ static void xen_block_complete_aio(void *opaque, int ret)
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
-        if (!request->req.nr_segments) {
-            break;
-        }
-        break;
     default:
         break;
     }
@@ -298,6 +294,7 @@ static void xen_block_complete_aio(void *opaque, int ret)
         if (!request->req.nr_segments) {
             break;
         }
+        /* fall through */
     case BLKIF_OP_READ:
         if (request->status == BLKIF_RSP_OKAY) {
             block_acct_done(blk_get_stats(dataplane->blk), &request->acct);
-- 
Anthony PERARD
