Received: from eggs.gnu.org ([2001:4830:134:3::10]:55743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cb7-0001xX-AZ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cb6-0001LA-Cz
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:27 +0200
Message-Id: <1493411622-5343-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/34] block: fix alignment calculations in
 bdrv_co_do_zero_pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 80d6c62..40bd94f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1444,7 +1444,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     int ret = 0;
 
     head_padding_bytes = offset & (align - 1);
-    tail_padding_bytes = align - ((offset + bytes) & (align - 1));
+    tail_padding_bytes = (align - (offset + bytes)) & (align - 1);
 
 
     assert(flags & BDRV_REQ_ZERO_WRITE);
-- 
1.8.3.1
