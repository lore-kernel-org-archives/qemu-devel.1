Received: from eggs.gnu.org ([209.51.188.92]:59690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b2A-0004g4-6J
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1t-00069J-QE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:38 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:03 +0200
Message-Id: <b1afcba91982296161b9807a9310790c24b13cef.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 03/13] block: Freeze the backing chain for
 the duration of the mirror job
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

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 726d3c27fb..010fdafd79 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -630,6 +630,10 @@ static int mirror_exit_common(Job *job)
     }
     s->prepared = true;
 
+    if (bdrv_chain_contains(src, target_bs)) {
+        bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
+    }
+
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
 
     /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
@@ -1639,6 +1643,10 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
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
