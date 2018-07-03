Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAGG-0004kN-Sm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAGF-0005Ae-Qw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:44 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Jul 2018 20:37:25 -0500
Message-Id: <20180703013730.55375-2-eblake@redhat.com>
In-Reply-To: <20180703013730.55375-1-eblake@redhat.com>
References: <20180703013730.55375-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] nbd/server: Fix dirty bitmap logic
 regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

In my hurry to fix a build failure, I introduced a logic bug.
The assertion conditional is backwards, meaning that qemu will
now abort instead of reporting dirty bitmap status.

The bug can only be tickled by an NBD client using an exported
dirty bitmap (which is still an experimental QMP command), so
it's not the end of the world for supported usage (and neither
'make check' nor qemu-iotests fails); but it also shows that we
really want qemu-io support for reading dirty bitmaps if only
so that I can add iotests coverage to prevent future
brown-bag-of-shame events like this one.

Fixes: 45eb6fb6
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180622153509.375130-1-eblake@redhat.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 50ac8bfafc6..e52b76bd1a4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1977,7 +1977,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,

     bdrv_dirty_bitmap_unlock(bitmap);

-    assert(offset > end);
+    assert(offset < end);
     *length = end - offset;
     return i;
 }
-- 
2.14.4
