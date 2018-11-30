Received: from eggs.gnu.org ([2001:4830:134:3::10]:51512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZa-0007SB-Cz
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZW-0006WB-C0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 30 Nov 2018 17:17:41 +0200
Message-Id: <21ebfe2fbdefe991b4d2a367410c477085c3ac05.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH v2 03/12] block: Freeze the backing chain
 for the duration of the mirror job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index f746618224..944ece83ed 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -631,6 +631,10 @@ static int mirror_exit_common(Job *job)
     }
     s->prepared = true;
 
+    if (bdrv_chain_contains(src, target_bs)) {
+        bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
+    }
+
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
 
     /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
@@ -1641,6 +1645,10 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                 goto fail;
             }
         }
+
+        if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
+            goto fail;
+        }
     }
 
     QTAILQ_INIT(&s->ops_in_flight);
-- 
2.11.0
