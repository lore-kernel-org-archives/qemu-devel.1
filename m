Received: from eggs.gnu.org ([2001:4830:134:3::10]:50292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWLe1-0004Nz-9G
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWLe0-00065a-Bo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:58:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 22 Jun 2018 07:58:14 -0500
Message-Id: <20180622125814.345274-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd/server: Silence gcc false positive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The code has a while() loop that always initialized 'end', and
the loop always executes at least once (as evidenced by the assert()
just prior to the loop).  But some versions of gcc still complain
that 'end' is used uninitialized, so silence them.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Peter, do you want to apply this directly as a build fix, or shall
I submit a pull request?

 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 274604609f4..50ac8bfafc6 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1937,7 +1937,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
                                       unsigned int nb_extents,
                                       bool dont_fragment)
 {
-    uint64_t begin = offset, end;
+    uint64_t begin = offset, end = offset;
     uint64_t overall_end = offset + *length;
     unsigned int i = 0;
     BdrvDirtyBitmapIter *it;
@@ -1977,6 +1977,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,

     bdrv_dirty_bitmap_unlock(bitmap);

+    assert(offset > end);
     *length = end - offset;
     return i;
 }
-- 
2.14.4
