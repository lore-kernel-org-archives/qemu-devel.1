Received: from eggs.gnu.org ([2001:4830:134:3::10]:52746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BQY-0007qK-LU
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BQS-0002IA-Ps
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:03:22 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  5 Oct 2017 14:02:44 -0500
Message-Id: <20171005190248.5537-3-eblake@redhat.com>
In-Reply-To: <20171005190248.5537-1-eblake@redhat.com>
References: <20171005190248.5537-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/6] block: Uniform handling of 0-length
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Handle a 0-length block status request up front, with a uniform
return value claiming the area is not allocated.

Most callers don't pass a length of 0 to bdrv_get_block_status()
and friends; but it definitely happens with a 0-length read when
copy-on-read is enabled.  While we could audit all callers to
ensure that they never make a 0-length request, and then assert
that fact, it was just as easy to fix things to always report
success (as long as the callers are careful to not go into an
infinite loop).  However, we had inconsistent behavior on whether
the status is reported as allocated or defers to the backing
layer, depending on what callbacks the driver implements, and
possibly wasting quite a few CPU cycles to get to that answer.
Consistently reporting unallocated up front doesn't really hurt
anything, and makes it easier both for callers (0-length requests
now have well-defined behavior) and for drivers (drivers don't
have to deal with 0-length requests).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---
v3: split into two conditionals [Stefan], simple enough to keep R-b
v2: new patch
---
 block/io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/io.c b/block/io.c
index e0f904583f..94f74703b7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1777,6 +1777,10 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         *pnum = 0;
         return BDRV_BLOCK_EOF;
     }
+    if (!nb_sectors) {
+        *pnum = 0;
+        return 0;
+    }

     n = total_sectors - sector_num;
     if (n < nb_sectors) {
-- 
2.13.6
