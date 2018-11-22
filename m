Received: from eggs.gnu.org ([2001:4830:134:3::10]:57490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPqTw-0007r6-GF
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPqTt-0005Wj-9k
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:01:28 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 22 Nov 2018 17:00:26 +0200
Message-Id: <7562baab810142c29e5a1afb50c65f98bbd98833.1542898669.git.berto@igalia.com>
In-Reply-To: <cover.1542898669.git.berto@igalia.com>
References: <cover.1542898669.git.berto@igalia.com>
In-Reply-To: <cover.1542898669.git.berto@igalia.com>
References: <cover.1542898669.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/2] mirror: Release the dirty bitmap if
 mirror_start_job() fails
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

At the moment I don't see how to make this function fail after the
dirty bitmap has been created, but if that was possible then we would
hit the assert(QLIST_EMPTY(&bs->dirty_bitmaps)) in bdrv_close().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 56d9ef7474..664c452f71 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1649,6 +1649,9 @@ fail:
         g_free(s->replaces);
         blk_unref(s->target);
         bs_opaque->job = NULL;
+        if (s->dirty_bitmap) {
+            bdrv_release_dirty_bitmap(bs, s->dirty_bitmap);
+        }
         job_early_fail(&s->common.job);
     }
 
-- 
2.11.0
