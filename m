Received: from eggs.gnu.org ([2001:4830:134:3::10]:42385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1l1-0002v2-F7
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1l0-0001z3-FJ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:40 +0100
Message-Id: <20171221142251.18366-9-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/19] block: Don't block_job_pause_all() in
 bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Block jobs are already paused using the BdrvChildRole drain callbacks,
so we don't need an additionall block_job_pause_all() call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c              |  4 ----
 tests/test-bdrv-drain.c | 10 ++++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index 91a52e2d82..74d2e5278e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -338,8 +338,6 @@ void bdrv_drain_all_begin(void)
      * context. */
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
 
-    block_job_pause_all();
-
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
@@ -395,8 +393,6 @@ void bdrv_drain_all_end(void)
         aio_enable_external(aio_context);
         aio_context_release(aio_context);
     }
-
-    block_job_resume_all();
 }
 
 void bdrv_drain_all(void)
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 019fe9074d..4571137928 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -284,9 +284,8 @@ static void test_blockjob_common(enum drain_type drain_type)
     do_drain_begin(drain_type, src);
 
     if (drain_type == BDRV_DRAIN_ALL) {
-        /* bdrv_drain_all() drains both src and target, and involves an
-         * additional block_job_pause_all() */
-        g_assert_cmpint(job->pause_count, ==, 3);
+        /* bdrv_drain_all() drains both src and target */
+        g_assert_cmpint(job->pause_count, ==, 2);
     } else {
         g_assert_cmpint(job->pause_count, ==, 1);
     }
@@ -303,9 +302,8 @@ static void test_blockjob_common(enum drain_type drain_type)
     do_drain_begin(drain_type, target);
 
     if (drain_type == BDRV_DRAIN_ALL) {
-        /* bdrv_drain_all() drains both src and target, and involves an
-         * additional block_job_pause_all() */
-        g_assert_cmpint(job->pause_count, ==, 3);
+        /* bdrv_drain_all() drains both src and target */
+        g_assert_cmpint(job->pause_count, ==, 2);
     } else {
         g_assert_cmpint(job->pause_count, ==, 1);
     }
-- 
2.13.6
