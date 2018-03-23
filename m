Received: from eggs.gnu.org ([2001:4830:134:3::10]:57092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1ezDcm-0001L6-UY
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1ezDcj-0004OI-0S
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:44:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56536
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1ezDci-0004Nd-Ry
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:44:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2N3hjhv041251
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 23:44:11 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gvheps8kb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 23:44:11 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Fri, 23 Mar 2018 03:44:08 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 04:43:56 +0100
In-Reply-To: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
References: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
Message-Id: <20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_shutdown()".
It's because of the newly introduced function vm_shutdown calls bdrv_drain_all,
which is called later by bdrv_close_all. bdrv_drain_all resumes the jobs
that doubles the speed and offset is doubled.
Some jobs' status are changed as well.

The fix is to not resume the jobs that are already yielded and also change
185.out accordingly.

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
---
 blockjob.c                 | 10 +++++++++-
 include/block/blockjob.h   |  5 +++++
 tests/qemu-iotests/185.out | 11 +++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index ef3ed69ff1..fa9838ac97 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -206,11 +206,16 @@ void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
 
 static void block_job_pause(BlockJob *job)
 {
-    job->pause_count++;
+    if (!job->yielded) {
+        job->pause_count++;
+    }
 }
 
 static void block_job_resume(BlockJob *job)
 {
+    if (job->yielded) {
+        return;
+    }
     assert(job->pause_count > 0);
     job->pause_count--;
     if (job->pause_count) {
@@ -371,6 +376,7 @@ static void block_job_sleep_timer_cb(void *opaque)
     BlockJob *job = opaque;
 
     block_job_enter(job);
+    job->yielded = false;
 }
 
 void block_job_start(BlockJob *job)
@@ -935,6 +941,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->cb            = cb;
     job->opaque        = opaque;
     job->busy          = false;
+    job->yielded       = false;
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
@@ -1034,6 +1041,7 @@ static void block_job_do_yield(BlockJob *job, uint64_t ns)
         timer_mod(&job->sleep_timer, ns);
     }
     job->busy = false;
+    job->yielded = true;
     block_job_unlock();
     qemu_coroutine_yield();
 
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index fc645dac68..f8f208bbcf 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -99,6 +99,11 @@ typedef struct BlockJob {
     bool ready;
 
     /**
+     * Set to true when the job is yielded.
+     */
+    bool yielded;
+
+    /**
      * Set to true when the job has deferred work to the main loop.
      */
     bool deferred_to_main_loop;
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 57eaf8d699..798282e196 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -7,6 +7,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 
 === Creating backing chain ===
 
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
 Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 wrote 4194304/4194304 bytes at offset 0
@@ -25,23 +26,28 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 === Start active commit job and exit qemu ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
 
 === Start mirror job and exit qemu ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
 
 === Start backup job and exit qemu ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 {"return": {}}
@@ -51,6 +57,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 === Start streaming job and exit qemu ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-- 
2.13.5
