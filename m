Received: from eggs.gnu.org ([2001:4830:134:3::10]:45758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSe4-0001DT-CA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSe3-0000v7-Js
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:46:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 07:44:58 -0500
Message-Id: <20170707124459.10269-21-eblake@redhat.com>
In-Reply-To: <20170707124459.10269-1-eblake@redhat.com>
References: <20170707124459.10269-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 20/21] block: Minimize raw use of
 bds->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

bdrv_is_allocated_above() was relying on intermediate->total_sectors,
which is a field that can have stale contents depending on the value
of intermediate->has_variable_length.  An audit shows that we are safe
(we were first calling through bdrv_co_get_block_status() which in
turn calls bdrv_nb_sectors() and therefore just refreshed the current
length), but it's nicer to favor our accessor functions to avoid having
to repeat such an audit, even if it means refresh_total_sectors() is
called more frequently.

Suggested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v5: kill a confusing comment [Kevin], R-b kept
v3-v4: no change
v2: new patch
---
 block/io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/io.c b/block/io.c
index a9b34e6..77cdf6f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1951,6 +1951,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     intermediate = top;
     while (intermediate && intermediate != base) {
         int64_t pnum_inter;
+        int64_t size_inter;
         int psectors_inter;

         ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
@@ -1966,15 +1967,12 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             return 1;
         }

-        /*
-         * [sector_num, nb_sectors] is unallocated on top but intermediate
-         * might have
-         *
-         * [sector_num+x, nr_sectors] allocated.
-         */
+        size_inter = bdrv_nb_sectors(intermediate);
+        if (size_inter < 0) {
+            return size_inter;
+        }
         if (n > psectors_inter &&
-            (intermediate == top ||
-             sector_num + psectors_inter < intermediate->total_sectors)) {
+            (intermediate == top || sector_num + psectors_inter < size_inter)) {
             n = psectors_inter;
         }

-- 
2.9.4
