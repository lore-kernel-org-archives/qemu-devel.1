Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f1Blp-0003Qu-C2
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f1Blj-0005CY-Kd
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:09:45 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 28 Mar 2018 10:09:26 -0400
Message-Id: <8172e5c57529e2275e5d8f1cbe06bd9bc88a8dd4.1522245129.git.jcody@redhat.com>
In-Reply-To: <cover.1522245129.git.jcody@redhat.com>
References: <cover.1522245129.git.jcody@redhat.com>
In-Reply-To: <cover.1522245129.git.jcody@redhat.com>
References: <cover.1522245129.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/1] blockjob: leak fix,
 remove from txn when failing early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com, kwolf@redhat.com

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This fixes leaks found by ASAN such as:
  GTESTER tests/test-blockjob
=================================================================
==31442==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f88483cba38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
    #1 0x7f8845e1bd77 in g_malloc0 ../glib/gmem.c:129
    #2 0x7f8845e1c04b in g_malloc0_n ../glib/gmem.c:360
    #3 0x5584d2732498 in block_job_txn_new /home/elmarco/src/qemu/blockjob.c:172
    #4 0x5584d2739b28 in block_job_create /home/elmarco/src/qemu/blockjob.c:973
    #5 0x5584d270ae31 in mk_job /home/elmarco/src/qemu/tests/test-blockjob.c:34
    #6 0x5584d270b1c1 in do_test_id /home/elmarco/src/qemu/tests/test-blockjob.c:57
    #7 0x5584d270b65c in test_job_ids /home/elmarco/src/qemu/tests/test-blockjob.c:118
    #8 0x7f8845e40b69 in test_case_run ../glib/gtestutils.c:2255
    #9 0x7f8845e40f29 in g_test_run_suite_internal ../glib/gtestutils.c:2339
    #10 0x7f8845e40fd2 in g_test_run_suite_internal ../glib/gtestutils.c:2351
    #11 0x7f8845e411e9 in g_test_run_suite ../glib/gtestutils.c:2426
    #12 0x7f8845e3fe72 in g_test_run ../glib/gtestutils.c:1692
    #13 0x5584d270d6e2 in main /home/elmarco/src/qemu/tests/test-blockjob.c:377
    #14 0x7f8843641f29 in __libc_start_main (/lib64/libc.so.6+0x20f29)

Add an assert to make sure that the job doesn't have associated txn before free().

[Jeff Cody: N.B., used updated patch provided by John Snow]

---
 blockjob.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index ef3ed69ff1..c510a9fde5 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -204,6 +204,15 @@ void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
     block_job_txn_ref(txn);
 }
 
+static void block_job_txn_del_job(BlockJob *job)
+{
+    if (job->txn) {
+        QLIST_REMOVE(job, txn_list);
+        block_job_txn_unref(job->txn);
+        job->txn = NULL;
+    }
+}
+
 static void block_job_pause(BlockJob *job)
 {
     job->pause_count++;
@@ -232,6 +241,7 @@ void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt == 0) {
         assert(job->status == BLOCK_JOB_STATUS_NULL);
+        assert(!job->txn);
         BlockDriverState *bs = blk_bs(job->blk);
         QLIST_REMOVE(job, job_list);
         bs->job = NULL;
@@ -392,6 +402,7 @@ static void block_job_decommission(BlockJob *job)
     job->busy = false;
     job->paused = false;
     job->deferred_to_main_loop = true;
+    block_job_txn_del_job(job);
     block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
     block_job_unref(job);
 }
@@ -481,8 +492,7 @@ static int block_job_finalize_single(BlockJob *job)
         }
     }
 
-    QLIST_REMOVE(job, txn_list);
-    block_job_txn_unref(job->txn);
+    block_job_txn_del_job(job);
     block_job_conclude(job);
     return 0;
 }
-- 
2.13.6
