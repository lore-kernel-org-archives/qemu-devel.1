Received: from eggs.gnu.org ([2001:4830:134:3::10]:46128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5p6k-0003JF-1g
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5p6h-000780-S5
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:58:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Apr 2018 10:58:09 +0200
Message-Id: <20180410085809.13313-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] commit/stream: Reset delay_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Streaming and the commit block job only want to apply throttling when
they actually copied data instead of skipping it, so they made the
calculation of delay_ns conditional. However, delay_ns isn't reset when
skipping some sectors, so instead of not waiting, the old delay is
applied again.

Properly reset delay_ns where needed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 2 ++
 block/stream.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index ab4fa3c3cf..1432baeef4 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -202,6 +202,8 @@ static void coroutine_fn commit_run(void *opaque)
 
         if (copy && s->common.speed) {
             delay_ns = ratelimit_calculate_delay(&s->limit, n);
+        } else {
+            delay_ns = 0;
         }
     }
 
diff --git a/block/stream.c b/block/stream.c
index f3b53f49e2..1a85708fcf 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -188,6 +188,8 @@ static void coroutine_fn stream_run(void *opaque)
         s->common.offset += n;
         if (copy && s->common.speed) {
             delay_ns = ratelimit_calculate_delay(&s->limit, n);
+        } else {
+            delay_ns = 0;
         }
     }
 
-- 
2.13.6
