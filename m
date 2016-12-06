Received: from eggs.gnu.org ([2001:4830:134:3::10]:35294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cEDc6-0006uP-WE
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cEDc6-0004l3-2G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:08:46 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Dec 2016 12:08:36 +0100
Message-Id: <20161206110836.21687-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: fix in-flight count for qemu-img
 bench
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org

With aio=native (qemu-img bench -n) one or more requests can be completed
when a new request is submitted.  This in turn can cause bench_cb to
recurse before b->in_flight is updated.  The blk_aio_pwritev coroutines
are never freed, and qemu-img aborts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-img.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6949b73..607dbe5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3559,6 +3559,9 @@ static void bench_cb(void *opaque, int ret)
     }
 
     while (b->n > b->in_flight && b->in_flight < b->nrreq) {
+        b->in_flight++;
+        b->offset += b->step;
+        b->offset %= b->image_size;
         if (b->write) {
             acb = blk_aio_pwritev(b->blk, b->offset, b->qiov, 0,
                                   bench_cb, b);
@@ -3570,9 +3573,6 @@ static void bench_cb(void *opaque, int ret)
             error_report("Failed to issue request");
             exit(EXIT_FAILURE);
         }
-        b->in_flight++;
-        b->offset += b->step;
-        b->offset %= b->image_size;
     }
 }
 
-- 
2.9.3
