Received: from eggs.gnu.org ([2001:4830:134:3::10]:53831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrR-0002Yb-W8
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrP-0000Fo-25
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:13 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:29 -0500
Message-Id: <20180310082746.24198-5-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 04/21] blockjobs: add status enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

We're about to add several new states, and booleans are becoming
unwieldly and difficult to reason about. It would help to have a
more explicit bookkeeping of the state of blockjobs. To this end,
add a new "status" field and add our existing states in a redundant
manner alongside the bools they are replacing:

UNDEFINED: Placeholder, default state. Not currently visible to QMP
           unless changes occur in the future to allow creating jobs
           without starting them via QMP.
CREATED:   replaces !!job->co && paused && !busy
RUNNING:   replaces effectively (!paused && busy)
PAUSED:    Nearly redundant with info->paused, which shows pause_count.
           This reports the actual status of the job, which almost always
           matches the paused request status. It differs in that it is
           strictly only true when the job has actually gone dormant.
READY:     replaces job->ready.
STANDBY:   Paused, but job->ready is true.

New state additions in coming commits will not be quite so redundant:

WAITING:   Waiting on transaction. This job has finished all the work
           it can until the transaction converges, fails, or is canceled.
PENDING:   Pending authorization from user. This job has finished all the
           work it can until the job or transaction is finalized via
           block_job_finalize. This implies the transaction has converged
           and left the WAITING phase.
ABORTING:  Job has encountered an error condition and is in the process
           of aborting.
CONCLUDED: Job has ceased all operations and has a return code available
           for query and may be dismissed via block_job_dismiss.
NULL:      Job has been dismissed and (should) be destroyed. Should never
           be visible to QMP.

Some of these states appear somewhat superfluous, but it helps define the
expected flow of a job; so some of the states wind up being synchronous
empty transitions. Importantly, jobs can be in only one of these states
at any given time, which helps code and external users alike reason about
the current condition of a job unambiguously.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c                 |  9 +++++++++
 include/block/blockjob.h   |  3 +++
 qapi/block-core.json       | 31 ++++++++++++++++++++++++++++++-
 tests/qemu-iotests/109.out | 24 ++++++++++++------------
 4 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index ecc5fcbdf8..719169cccd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -320,6 +320,7 @@ void block_job_start(BlockJob *job)
     job->pause_count--;
     job->busy = true;
     job->paused = false;
+    job->status = BLOCK_JOB_STATUS_RUNNING;
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
@@ -598,6 +599,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->speed     = job->speed;
     info->io_status = job->iostatus;
     info->ready     = job->ready;
+    info->status    = job->status;
     return info;
 }
 
@@ -700,6 +702,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    job->status        = BLOCK_JOB_STATUS_CREATED;
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
                    QEMU_CLOCK_REALTIME, SCALE_NS,
                    block_job_sleep_timer_cb, job);
@@ -813,9 +816,14 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
     }
 
     if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
+        BlockJobStatus status = job->status;
+        job->status = status == BLOCK_JOB_STATUS_READY ? \
+                                BLOCK_JOB_STATUS_STANDBY : \
+                                BLOCK_JOB_STATUS_PAUSED;
         job->paused = true;
         block_job_do_yield(job, -1);
         job->paused = false;
+        job->status = status;
     }
 
     if (job->driver->resume) {
@@ -921,6 +929,7 @@ void block_job_iostatus_reset(BlockJob *job)
 
 void block_job_event_ready(BlockJob *job)
 {
+    job->status = BLOCK_JOB_STATUS_READY;
     job->ready = true;
 
     if (block_job_is_internal(job)) {
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index b77fac118d..b39a2f9521 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -139,6 +139,9 @@ typedef struct BlockJob {
      */
     QEMUTimer sleep_timer;
 
+    /** Current state; See @BlockJobStatus for details. */
+    BlockJobStatus status;
+
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
 } BlockJob;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 00475f08d4..8dfed5c7da 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -955,6 +955,32 @@
 { 'enum': 'BlockJobType',
   'data': ['commit', 'stream', 'mirror', 'backup'] }
 
+##
+# @BlockJobStatus:
+#
+# Indicates the present state of a given blockjob in its lifetime.
+#
+# @undefined: Erroneous, default state. Should not ever be visible.
+#
+# @created: The job has been created, but not yet started.
+#
+# @running: The job is currently running.
+#
+# @paused: The job is running, but paused. The pause may be requested by
+#          either the QMP user or by internal processes.
+#
+# @ready: The job is running, but is ready for the user to signal completion.
+#         This is used for long-running jobs like mirror that are designed to
+#         run indefinitely.
+#
+# @standby: The job is ready, but paused. This is nearly identical to @paused.
+#           The job may return to @ready or otherwise be canceled.
+#
+# Since: 2.12
+##
+{ 'enum': 'BlockJobStatus',
+  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby'] }
+
 ##
 # @BlockJobInfo:
 #
@@ -981,12 +1007,15 @@
 #
 # @ready: true if the job may be completed (since 2.2)
 #
+# @status: Current job state/status (since 2.12)
+#
 # Since: 1.1
 ##
 { 'struct': 'BlockJobInfo',
   'data': {'type': 'str', 'device': 'str', 'len': 'int',
            'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
-           'io-status': 'BlockDeviceIoStatus', 'ready': 'bool'} }
+           'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
+           'status': 'BlockJobStatus' } }
 
 ##
 # @query-block-jobs:
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index c189e2833d..d288f2eef6 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -19,7 +19,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 1024, "offset": 1024, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -45,7 +45,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 197120, "offset": 197120, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
@@ -71,7 +71,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 327680, "offset": 327680, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -97,7 +97,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 1024, "offset": 1024, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -123,7 +123,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 65536, "offset": 65536, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
@@ -149,7 +149,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2560, "offset": 2560, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -174,7 +174,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2560, "offset": 2560, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -199,7 +199,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 31457280, "offset": 31457280, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
@@ -224,7 +224,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 327680, "offset": 327680, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -249,7 +249,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2048, "offset": 2048, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
@@ -265,7 +265,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 512, "offset": 512, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
@@ -274,7 +274,7 @@ Images are identical.
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 512, "offset": 512, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
-- 
2.14.3
