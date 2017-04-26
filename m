Received: from eggs.gnu.org ([2001:4830:134:3::10]:54277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1d3IVQ-0004Ll-NG
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1d3IVP-00030d-UM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:41:00 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed, 26 Apr 2017 11:40:46 +0300
Message-Id: <1493196046-5607-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] block: fix alignment calculations in
 bdrv_co_do_zero_pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

tail_padding_bytes is calculated wrong. F.e. for
    offset = 0
    bytes = 2048
    align = 512
we will have tail_padding_bytes = 512 which is definitely wrong. The patch
fixes that arithmetics.

Fortunately this problem is harmless, we will have 1 extra allocation and
free thus there is no need to put this into stable. The problem is here
from the very beginning.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <famz@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index a7142e0..1e1523b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1452,7 +1452,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     int ret = 0;
 
     head_padding_bytes = offset & (align - 1);
-    tail_padding_bytes = align - ((offset + bytes) & (align - 1));
+    tail_padding_bytes = (align - (offset + bytes)) & (align - 1);
 
 
     assert(flags & BDRV_REQ_ZERO_WRITE);
-- 
2.7.4
