Received: from eggs.gnu.org ([209.51.188.92]:50807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gudsn-00037N-8Q
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gudse-0006xn-Pt
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:50:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Feb 2019 15:49:32 +0200
Message-Id: <20190215134932.14492-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] commit: Replace commit_top_bs on failure after
 deleting the block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

If there's an error in commit_start() then the block job must be
deleted before replacing commit_top_bs, otherwise it will fail because
of lack of permissions. This happens since the permission system was
introduced in 8dfba2797761d8a43744e4e6571c8175e448a478.

Fortunately this bug doesn't seem to be possible to reproduce at the
moment without changing the code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 53148e610b..5deb05925b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -374,10 +374,12 @@ fail:
     if (s->top) {
         blk_unref(s->top);
     }
+    job_early_fail(&s->common.job);
+    /* commit_top_bs has to be replaced after deleting the block job,
+     * otherwise this would fail because of lack of permissions. */
     if (commit_top_bs) {
         bdrv_replace_node(commit_top_bs, top, &error_abort);
     }
-    job_early_fail(&s->common.job);
 }
 
 
-- 
2.11.0
