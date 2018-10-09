Received: from eggs.gnu.org ([2001:4830:134:3::10]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xn5-0001WM-Q2
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xn3-0007Ds-9B
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  9 Oct 2018 21:35:21 +0200
Message-Id: <20181009193524.19052-2-kwolf@redhat.com>
In-Reply-To: <20181009193524.19052-1-kwolf@redhat.com>
References: <20181009193524.19052-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] block: Update flags in bdrv_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

To fully change the read-only state of a node, we must not only change
bs->read_only, but also update bs->open_flags.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block.c b/block.c
index 0d6e5f1a76..d7bd6d29b4 100644
--- a/block.c
+++ b/block.c
@@ -281,6 +281,13 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
     }
 
     bs->read_only = read_only;
+
+    if (read_only) {
+        bs->open_flags &= ~BDRV_O_RDWR;
+    } else {
+        bs->open_flags |= BDRV_O_RDWR;
+    }
+
     return 0;
 }
 
-- 
2.13.6
