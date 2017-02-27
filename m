Received: from eggs.gnu.org ([2001:4830:134:3::10]:59236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciOrS-00083p-Tl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciOrR-00079v-TW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:13:22 -0500
From: John Snow <jsnow@redhat.com>
Date: Mon, 27 Feb 2017 12:13:14 -0500
Message-Id: <20170227171314.9518-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] block/mirror: fix broken sparseness detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

int64_t is in all likelihood the actual scalar type we want.
Yep, really.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1219541

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index ca8547b..7b4cfbd 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -386,7 +386,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
                             nb_chunks * sectors_per_chunk);
     bitmap_set(s->in_flight_bitmap, sector_num / sectors_per_chunk, nb_chunks);
     while (nb_chunks > 0 && sector_num < end) {
-        int ret;
+        int64_t ret;
         int io_sectors, io_sectors_acct;
         BlockDriverState *file;
         enum MirrorMethod {
-- 
2.9.3
