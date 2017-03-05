Received: from eggs.gnu.org ([2001:4830:134:3::10]:50648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdxf-0003ec-9a
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdxe-00051L-GQ
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:03 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  5 Mar 2017 23:44:35 +0200
Message-Id: <20170305214435.19656-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH] block: Constify data passed by pointer to
 blk_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

blk_name() is not modifying data passed to it through pointer and it
returns also a pointer to const so the argument can be made const for
code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 block/block-backend.c          | 2 +-
 include/sysemu/block-backend.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index daa7908d0151..2d2169a5dfb0 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -409,7 +409,7 @@ void monitor_remove_blk(BlockBackend *blk)
  * Return @blk's name, a non-null string.
  * Returns an empty string iff @blk is not referenced by the monitor.
  */
-const char *blk_name(BlockBackend *blk)
+const char *blk_name(const BlockBackend *blk)
 {
     return blk->name ?: "";
 }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 096c17fce064..d16c85d67b5c 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -91,7 +91,7 @@ int blk_get_refcnt(BlockBackend *blk);
 void blk_ref(BlockBackend *blk);
 void blk_unref(BlockBackend *blk);
 void blk_remove_all_bs(void);
-const char *blk_name(BlockBackend *blk);
+const char *blk_name(const BlockBackend *blk);
 BlockBackend *blk_by_name(const char *name);
 BlockBackend *blk_next(BlockBackend *blk);
 bool monitor_add_blk(BlockBackend *blk, const char *name, Error **errp);
-- 
2.9.3
