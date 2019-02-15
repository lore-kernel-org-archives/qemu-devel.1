Received: from eggs.gnu.org ([209.51.188.92]:54505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJR-0001TU-Bm
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJQ-0007Gn-EX
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:05 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 15 Feb 2019 16:25:31 +0000
Message-ID: <20190215162533.19475-2-paul.durrant@citrix.com>
In-Reply-To: <20190215162533.19475-1-paul.durrant@citrix.com>
References: <20190215162533.19475-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] dataplane/xen-block: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The if() statement is clearly bogus (dead code which should have been
cleaned up when grant mapping was removed).

Spotted by Coverity: CID 1398635

While in the neighbourhood, add a missing 'fall through' annotation.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
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
2.20.1.2.gb21ebb6
