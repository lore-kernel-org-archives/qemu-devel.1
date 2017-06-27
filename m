Received: from eggs.gnu.org ([2001:4830:134:3::10]:42845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw7c-0006bE-NH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw7b-00070K-Qd
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:26:00 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Jun 2017 14:24:57 -0500
Message-Id: <20170627192458.15519-20-eblake@redhat.com>
In-Reply-To: <20170627192458.15519-1-eblake@redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 19/20] block: Minimize raw use of
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

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

---
v2: new patch
---
 block/io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 0545180..5bbf153 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1924,6 +1924,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     intermediate = top;
     while (intermediate && intermediate != base) {
         int64_t pnum_inter;
+        int64_t size_inter;
         int psectors_inter;

         ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
@@ -1941,13 +1942,14 @@ int bdrv_is_allocated_above(BlockDriverState *top,

         /*
          * [sector_num, nb_sectors] is unallocated on top but intermediate
-         * might have
-         *
-         * [sector_num+x, nr_sectors] allocated.
+         * might have [sector_num+x, nb_sectors-x] allocated.
          */
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
