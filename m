Received: from eggs.gnu.org ([2001:4830:134:3::10]:48206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHO-00037T-P4
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHI-00075h-Sr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:18 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 14 Nov 2017 13:16:49 +0300
Message-Id: <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/5] qcow2: reject unaligned offsets in write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Misaligned compressed write is not supported.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 92cb9f9..45c5651 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3349,6 +3349,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
     }
 
+    if (offset_into_cluster(s, offset)) {
+        return -EINVAL;
+    }
+
     buf = qemu_blockalign(bs, s->cluster_size);
     if (bytes != s->cluster_size) {
         if (bytes > s->cluster_size ||
-- 
2.7.4
