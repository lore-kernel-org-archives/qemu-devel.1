Received: from eggs.gnu.org ([2001:4830:134:3::10]:46579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl1-0001xX-Tm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl1-00066I-BF
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:28 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:44 -0500
Message-Id: <20180119205847.7141-11-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/13] block/mirror: condense cancellation
 and relax calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

We can count on the relax call to check cancellation for us, so
condense these concurrent calls.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 3c73caed5e..a0e0044de2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -610,9 +610,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             int bytes = MIN(s->bdev_length - offset,
                             QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-            block_job_relax(&s->common, 0);
-
-            if (block_job_is_cancelled(&s->common)) {
+            if (block_job_relax(&s->common, 0)) {
                 s->initial_zeroing_ongoing = false;
                 return 0;
             }
@@ -638,9 +636,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         int bytes = MIN(s->bdev_length - offset,
                         QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-        block_job_relax(&s->common, 0);
-
-        if (block_job_is_cancelled(&s->common)) {
+        if (block_job_relax(&s->common, 0)) {
             return 0;
         }
 
-- 
2.14.3
