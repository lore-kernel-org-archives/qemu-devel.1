Received: from eggs.gnu.org ([2001:4830:134:3::10]:53079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRx8-0006Qr-9P
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwz-0003L0-SE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:33 +0200
Message-Id: <20180509162637.15575-39-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 38/42] job: Add JOB_STATUS_CHANGE QMP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This adds a QMP event that is emitted whenever a job transitions from
one status to another. For the event, a new qapi/job.json schema file is
created which will contain all job-related definitions that aren't tied
to the block layer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       |  47 +-----------
 qapi/job.json              |  65 +++++++++++++++++
 qapi/qapi-schema.json      |   1 +
 job.c                      |  10 +++
 Makefile                   |   9 +++
 Makefile.objs              |   4 +
 tests/qemu-iotests/030     |   6 +-
 tests/qemu-iotests/040     |   2 +
 tests/qemu-iotests/041     |  17 ++++-
 tests/qemu-iotests/095     |   2 +-
 tests/qemu-iotests/095.out |   6 ++
 tests/qemu-iotests/109     |   2 +-
 tests/qemu-iotests/109.out | 178 +++++++++++++++++++++++++++++++++++++++------
 tests/qemu-iotests/124     |   8 ++
 tests/qemu-iotests/127.out |   7 ++
 tests/qemu-iotests/141     |  10 +--
 tests/qemu-iotests/141.out |  29 ++++++++
 tests/qemu-iotests/144     |   2 +-
 tests/qemu-iotests/144.out |   7 ++
 tests/qemu-iotests/156     |   2 +-
 tests/qemu-iotests/156.out |   7 ++
 tests/qemu-iotests/185     |  12 +--
 tests/qemu-iotests/185.out |  10 +++
 tests/qemu-iotests/191     |   4 +-
 tests/qemu-iotests/191.out | 132 +++++++++++++++++++++++++++++++++
 25 files changed, 492 insertions(+), 87 deletions(-)
 create mode 100644 qapi/job.json

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f86004fbc3..f2da7d696d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -6,6 +6,7 @@
 
 { 'include': 'common.json' }
 { 'include': 'crypto.json' }
+{ 'include': 'job.json' }
 { 'include': 'sockets.json' }
 
 ##
@@ -1093,52 +1094,6 @@
            'finalize' ] }
 
 ##
-# @JobStatus:
-#
-# Indicates the present state of a given job in its lifetime.
-#
-# @undefined: Erroneous, default state. Should not ever be visible.
-#
-# @created: The job has been created, but not yet started.
-#
-# @running: The job is currently running.
-#
-# @paused: The job is running, but paused. The pause may be requested by
-#          either the QMP user or by internal processes.
-#
-# @ready: The job is running, but is ready for the user to signal completion.
-#         This is used for long-running jobs like mirror that are designed to
-#         run indefinitely.
-#
-# @standby: The job is ready, but paused. This is nearly identical to @paused.
-#           The job may return to @ready or otherwise be canceled.
-#
-# @waiting: The job is waiting for other jobs in the transaction to converge
-#           to the waiting state. This status will likely not be visible for
-#           the last job in a transaction.
-#
-# @pending: The job has finished its work, but has finalization steps that it
-#           needs to make prior to completing. These changes may require
-#           manual intervention by the management process if manual was set
-#           to true. These changes may still fail.
-#
-# @aborting: The job is in the process of being aborted, and will finish with
-#            an error. The job will afterwards report that it is @concluded.
-#            This status may not be visible to the management process.
-#
-# @concluded: The job has finished all work. If manual was set to true, the job
-#             will remain in the query list until it is dismissed.
-#
-# @null: The job is in the process of being dismantled. This state should not
-#        ever be visible externally.
-#
-# Since: 2.12
-##
-{ 'enum': 'JobStatus',
-  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
-           'waiting', 'pending', 'aborting', 'concluded', 'null' ] }
-
-##
 # @BlockJobInfo:
 #
 # Information about a long-running block device operation.
diff --git a/qapi/job.json b/qapi/job.json
new file mode 100644
index 0000000000..bd88a358d0
--- /dev/null
+++ b/qapi/job.json
@@ -0,0 +1,65 @@
+# -*- Mode: Python -*-
+
+##
+# == Background jobs
+##
+
+##
+# @JobStatus:
+#
+# Indicates the present state of a given job in its lifetime.
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
+# @waiting: The job is waiting for other jobs in the transaction to converge
+#           to the waiting state. This status will likely not be visible for
+#           the last job in a transaction.
+#
+# @pending: The job has finished its work, but has finalization steps that it
+#           needs to make prior to completing. These changes may require
+#           manual intervention by the management process if manual was set
+#           to true. These changes may still fail.
+#
+# @aborting: The job is in the process of being aborted, and will finish with
+#            an error. The job will afterwards report that it is @concluded.
+#            This status may not be visible to the management process.
+#
+# @concluded: The job has finished all work. If manual was set to true, the job
+#             will remain in the query list until it is dismissed.
+#
+# @null: The job is in the process of being dismantled. This state should not
+#        ever be visible externally.
+#
+# Since: 2.12
+##
+{ 'enum': 'JobStatus',
+  'data': ['undefined', 'created', 'running', 'paused', 'ready', 'standby',
+           'waiting', 'pending', 'aborting', 'concluded', 'null' ] }
+
+##
+# @JOB_STATUS_CHANGE:
+#
+# Emitted when a job transitions to a different status.
+#
+# @id: The job identifier
+# @status: The new job status
+#
+# Since: 2.13
+##
+{ 'event': 'JOB_STATUS_CHANGE',
+  'data': { 'id': 'str',
+            'status': 'JobStatus' } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 25bce78352..65b6dc2f6f 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -84,6 +84,7 @@
 { 'include': 'crypto.json' }
 { 'include': 'block.json' }
 { 'include': 'char.json' }
+{ 'include': 'job.json' }
 { 'include': 'net.json' }
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
diff --git a/job.c b/job.c
index e45c301fcd..4dc45648e9 100644
--- a/job.c
+++ b/job.c
@@ -30,6 +30,7 @@
 #include "qemu/id.h"
 #include "qemu/main-loop.h"
 #include "trace-root.h"
+#include "qapi/qapi-events-job.h"
 
 static QLIST_HEAD(, Job) jobs = QLIST_HEAD_INITIALIZER(jobs);
 
@@ -157,6 +158,11 @@ static int job_txn_apply(JobTxn *txn, int fn(Job *), bool lock)
     return rc;
 }
 
+static bool job_is_internal(Job *job)
+{
+    return (job->id == NULL);
+}
+
 static void job_state_transition(Job *job, JobStatus s1)
 {
     JobStatus s0 = job->status;
@@ -166,6 +172,10 @@ static void job_state_transition(Job *job, JobStatus s1)
                                JobStatus_str(s0), JobStatus_str(s1));
     assert(JobSTT[s0][s1]);
     job->status = s1;
+
+    if (!job_is_internal(job) && s1 != s0) {
+        qapi_event_send_job_status_change(job->id, job->status, &error_abort);
+    }
 }
 
 int job_apply_verb(Job *job, JobVerb bv, Error **errp)
diff --git a/Makefile b/Makefile
index d71dd5bea4..1404e5d8df 100644
--- a/Makefile
+++ b/Makefile
@@ -98,6 +98,7 @@ GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
 GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
 GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
 GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
+GENERATED_FILES += qapi/qapi-types-job.h qapi/qapi-types-job.c
 GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
 GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
 GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c
@@ -116,6 +117,7 @@ GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
 GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
 GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
 GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
+GENERATED_FILES += qapi/qapi-visit-job.h qapi/qapi-visit-job.c
 GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
 GENERATED_FILES += qapi/qapi-visit-misc.h qapi/qapi-visit-misc.c
 GENERATED_FILES += qapi/qapi-visit-net.h qapi/qapi-visit-net.c
@@ -133,6 +135,7 @@ GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
 GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
 GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
 GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
+GENERATED_FILES += qapi/qapi-commands-job.h qapi/qapi-commands-job.c
 GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
 GENERATED_FILES += qapi/qapi-commands-misc.h qapi/qapi-commands-misc.c
 GENERATED_FILES += qapi/qapi-commands-net.h qapi/qapi-commands-net.c
@@ -150,6 +153,7 @@ GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
 GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
 GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
 GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
+GENERATED_FILES += qapi/qapi-events-job.h qapi/qapi-events-job.c
 GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
 GENERATED_FILES += qapi/qapi-events-misc.h qapi/qapi-events-misc.c
 GENERATED_FILES += qapi/qapi-events-net.h qapi/qapi-events-net.c
@@ -582,6 +586,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
                $(SRC_PATH)/qapi/introspect.json \
+               $(SRC_PATH)/qapi/job.json \
                $(SRC_PATH)/qapi/migration.json \
                $(SRC_PATH)/qapi/misc.json \
                $(SRC_PATH)/qapi/net.json \
@@ -601,6 +606,7 @@ qapi/qapi-types-char.c qapi/qapi-types-char.h \
 qapi/qapi-types-common.c qapi/qapi-types-common.h \
 qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
 qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
+qapi/qapi-types-job.c qapi/qapi-types-job.h \
 qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
 qapi/qapi-types-misc.c qapi/qapi-types-misc.h \
 qapi/qapi-types-net.c qapi/qapi-types-net.h \
@@ -619,6 +625,7 @@ qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
 qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
 qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
 qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
+qapi/qapi-visit-job.c qapi/qapi-visit-job.h \
 qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
 qapi/qapi-visit-misc.c qapi/qapi-visit-misc.h \
 qapi/qapi-visit-net.c qapi/qapi-visit-net.h \
@@ -636,6 +643,7 @@ qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
 qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
 qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
 qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
+qapi/qapi-commands-job.c qapi/qapi-commands-job.h \
 qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
 qapi/qapi-commands-misc.c qapi/qapi-commands-misc.h \
 qapi/qapi-commands-net.c qapi/qapi-commands-net.h \
@@ -653,6 +661,7 @@ qapi/qapi-events-char.c qapi/qapi-events-char.h \
 qapi/qapi-events-common.c qapi/qapi-events-common.h \
 qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
 qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
+qapi/qapi-events-job.c qapi/qapi-events-job.h \
 qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
 qapi/qapi-events-misc.c qapi/qapi-events-misc.h \
 qapi/qapi-events-net.c qapi/qapi-events-net.h \
diff --git a/Makefile.objs b/Makefile.objs
index 92b73fc272..3df8d58e49 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -10,6 +10,7 @@ util-obj-y += qapi/qapi-types-char.o
 util-obj-y += qapi/qapi-types-common.o
 util-obj-y += qapi/qapi-types-crypto.o
 util-obj-y += qapi/qapi-types-introspect.o
+util-obj-y += qapi/qapi-types-job.o
 util-obj-y += qapi/qapi-types-migration.o
 util-obj-y += qapi/qapi-types-misc.o
 util-obj-y += qapi/qapi-types-net.o
@@ -28,6 +29,7 @@ util-obj-y += qapi/qapi-visit-char.o
 util-obj-y += qapi/qapi-visit-common.o
 util-obj-y += qapi/qapi-visit-crypto.o
 util-obj-y += qapi/qapi-visit-introspect.o
+util-obj-y += qapi/qapi-visit-job.o
 util-obj-y += qapi/qapi-visit-migration.o
 util-obj-y += qapi/qapi-visit-misc.o
 util-obj-y += qapi/qapi-visit-net.o
@@ -45,6 +47,7 @@ util-obj-y += qapi/qapi-events-char.o
 util-obj-y += qapi/qapi-events-common.o
 util-obj-y += qapi/qapi-events-crypto.o
 util-obj-y += qapi/qapi-events-introspect.o
+util-obj-y += qapi/qapi-events-job.o
 util-obj-y += qapi/qapi-events-migration.o
 util-obj-y += qapi/qapi-events-misc.o
 util-obj-y += qapi/qapi-events-net.o
@@ -140,6 +143,7 @@ common-obj-y += qapi/qapi-commands-char.o
 common-obj-y += qapi/qapi-commands-common.o
 common-obj-y += qapi/qapi-commands-crypto.o
 common-obj-y += qapi/qapi-commands-introspect.o
+common-obj-y += qapi/qapi-commands-job.o
 common-obj-y += qapi/qapi-commands-migration.o
 common-obj-y += qapi/qapi-commands-misc.o
 common-obj-y += qapi/qapi-commands-net.o
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 640a6dfd10..03aea460c9 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -304,7 +304,7 @@ class TestParallelOps(iotests.QMPTestCase):
         result = self.vm.qmp('block-stream', device='node5', base=self.imgs[3], job_id='stream-node6')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        event = self.vm.get_qmp_event(wait=True)
+        event = self.vm.event_wait(name='BLOCK_JOB_READY')
         self.assertEqual(event['event'], 'BLOCK_JOB_READY')
         self.assert_qmp(event, 'data/device', 'commit-drive0')
         self.assert_qmp(event, 'data/type', 'commit')
@@ -751,7 +751,9 @@ class TestStreamStop(iotests.QMPTestCase):
 
         time.sleep(0.1)
         events = self.vm.get_qmp_events(wait=False)
-        self.assertEqual(events, [], 'unexpected QMP event: %s' % events)
+        for e in events:
+            if e['event'] != 'JOB_STATUS_CHANGE':
+                self.assertEqual(events, [], 'unexpected QMP event: %s' % events)
 
         self.cancel_and_wait(resume=True)
 
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 90b5b4f2ad..1beb5e6dab 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -162,6 +162,8 @@ class TestSingleDrive(ImageCommitTestCase):
                 elif event['event'] == 'BLOCK_JOB_CANCELLED':
                     self.assert_qmp(event, 'data/device', 'drive0')
                     cancelled = True
+                elif event['event'] == 'JOB_STATUS_CHANGE':
+                    self.assert_qmp(event, 'data/id', 'drive0')
                 else:
                     self.fail("Unexpected event %s" % (event['event']))
 
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index a860a31e9a..e94587950c 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -445,6 +445,8 @@ new_state = "1"
                     self.assert_qmp(event, 'data/device', 'drive0')
                     self.assert_qmp(event, 'data/error', 'Input/output error')
                     completed = True
+                elif event['event'] == 'JOB_STATUS_CHANGE':
+                    self.assert_qmp(event, 'data/id', 'drive0')
 
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
@@ -457,6 +459,10 @@ new_state = "1"
         self.assert_qmp(result, 'return', {})
 
         event = self.vm.get_qmp_event(wait=True)
+        while event['event'] == 'JOB_STATUS_CHANGE':
+            self.assert_qmp(event, 'data/id', 'drive0')
+            event = self.vm.get_qmp_event(wait=True)
+
         self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'read')
@@ -478,6 +484,10 @@ new_state = "1"
         self.assert_qmp(result, 'return', {})
 
         event = self.vm.get_qmp_event(wait=True)
+        while event['event'] == 'JOB_STATUS_CHANGE':
+            self.assert_qmp(event, 'data/id', 'drive0')
+            event = self.vm.get_qmp_event(wait=True)
+
         self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'read')
@@ -608,7 +618,7 @@ new_state = "1"
                              on_target_error='ignore')
         self.assert_qmp(result, 'return', {})
 
-        event = self.vm.get_qmp_event(wait=True)
+        event = self.vm.event_wait(name='BLOCK_JOB_ERROR')
         self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'write')
@@ -784,7 +794,12 @@ class TestGranularity(iotests.QMPTestCase):
                              sync='full', target=target_img,
                              mode='absolute-paths', granularity=8192)
         self.assert_qmp(result, 'return', {})
+
         event = self.vm.get_qmp_event(wait=60.0)
+        while event['event'] == 'JOB_STATUS_CHANGE':
+            self.assert_qmp(event, 'data/id', 'drive0')
+            event = self.vm.get_qmp_event(wait=60.0)
+
         # Failures will manifest as COMPLETED/ERROR.
         self.assert_qmp(event, 'event', 'BLOCK_JOB_READY')
         self.complete_and_wait(drive='drive0', wait_ready=False)
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 030adb22e1..72ecc22e1b 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -72,7 +72,7 @@ _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" "return"
 
 _send_qemu_cmd $h "{ 'execute': 'block-commit',
                                  'arguments': { 'device': 'test',
-                                 'top': '"${TEST_IMG}.snp1"' } }" "BLOCK_JOB_COMPLETED"
+                                 'top': '"${TEST_IMG}.snp1"' } }" '"status": "null"'
 
 _cleanup_qemu
 
diff --git a/tests/qemu-iotests/095.out b/tests/qemu-iotests/095.out
index 73875cab40..8c093dfff3 100644
--- a/tests/qemu-iotests/095.out
+++ b/tests/qemu-iotests/095.out
@@ -11,8 +11,14 @@ virtual size: 5.0M (5242880 bytes)
 === Running QEMU Live Commit Test ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "test"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "test"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "test"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "test"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "test", "len": 104857600, "offset": 104857600, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "test"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "test"}}
 
 === Base image info after commit and resize ===
 image: TEST_DIR/t.IMGFMT.base
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index d70b574d88..acbd079136 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -64,7 +64,7 @@ function run_qemu()
 
     _send_qemu_cmd $QEMU_HANDLE '' "$qmp_event"
     if test "$qmp_event" = BLOCK_JOB_ERROR; then
-        _send_qemu_cmd $QEMU_HANDLE '' "BLOCK_JOB_COMPLETED"
+        _send_qemu_cmd $QEMU_HANDLE '' '"status": "null"'
     fi
     _send_qemu_cmd $QEMU_HANDLE '{"execute":"query-block-jobs"}' "return"
     _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index 8a9b93672b..ad0ee6fb48 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -6,23 +6,35 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -32,23 +44,35 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 512, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -58,23 +82,35 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 262144, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -84,23 +120,35 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -110,23 +158,35 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -136,23 +196,35 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -161,23 +233,35 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -186,23 +270,35 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -211,23 +307,35 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -236,23 +344,35 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 
@@ -261,23 +381,37 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
 *** done
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 8e76e62f93..3ea4ac53f5 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -151,10 +151,17 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         return self.wait_qmp_backup(kwargs['device'], error)
 
 
+    def ignore_job_status_change_events(self):
+        while True:
+            e = self.vm.event_wait(name="JOB_STATUS_CHANGE")
+            if e['data']['status'] == 'null':
+                break
+
     def wait_qmp_backup(self, device, error='Input/output error'):
         event = self.vm.event_wait(name="BLOCK_JOB_COMPLETED",
                                    match={'data': {'device': device}})
         self.assertNotEqual(event, None)
+        self.ignore_job_status_change_events()
 
         try:
             failure = self.dictpath(event, 'data/error')
@@ -172,6 +179,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         event = self.vm.event_wait(name='BLOCK_JOB_CANCELLED',
                                    match={'data': {'device': device}})
         self.assertNotEqual(event, None)
+        self.ignore_job_status_change_events()
 
 
     def create_anchor_backup(self, drive=None):
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index 543d075005..83b522d4c2 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -5,10 +5,17 @@ Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=IMGFMT size=65536 backing_file=TEST
 wrote 42/42 bytes at offset 0
 42 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "mirror"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "mirror", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "mirror", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 2f9d7b9bc2..9ae23a6c63 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -107,7 +107,7 @@ test_blockjob \
                     'format': '$IMGFMT',
                     'sync': 'none'}}" \
     'return' \
-    'BLOCK_JOB_CANCELLED'
+    '"status": "null"'
 
 echo
 echo '=== Testing drive-mirror ==='
@@ -124,7 +124,7 @@ test_blockjob \
                     'format': '$IMGFMT',
                     'sync': 'none'}}" \
     'BLOCK_JOB_READY' \
-    'BLOCK_JOB_COMPLETED'
+    '"status": "null"'
 
 echo
 echo '=== Testing active block-commit ==='
@@ -138,7 +138,7 @@ test_blockjob \
     "{'execute': 'block-commit',
       'arguments': {'job-id': 'job0', 'device': 'drv0'}}" \
     'BLOCK_JOB_READY' \
-    'BLOCK_JOB_COMPLETED'
+    '"status": "null"'
 
 echo
 echo '=== Testing non-active block-commit ==='
@@ -157,7 +157,7 @@ test_blockjob \
                     'top':    '$TEST_DIR/m.$IMGFMT',
                     'speed':  1}}" \
     'return' \
-    'BLOCK_JOB_CANCELLED'
+    '"status": "null"'
 
 echo
 echo '=== Testing block-stream ==='
@@ -179,7 +179,7 @@ test_blockjob \
                     'device': 'drv0',
                     'speed': 1}}" \
     'return' \
-    'BLOCK_JOB_CANCELLED'
+    '"status": "null"'
 
 _cleanup_qemu
 
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 82e763b68d..f252c86875 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -8,31 +8,50 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/m.
 
 {"return": {}}
 Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 0, "speed": 0, "type": "backup"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
 {"return": {}}
 
 === Testing drive-mirror ===
 
 {"return": {}}
 Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
 {"return": {}}
 
 === Testing active block-commit ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
 {"return": {}}
 
 === Testing non-active block-commit ===
@@ -40,10 +59,15 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 524288, "speed": 1, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
 {"return": {}}
 
 === Testing block-stream ===
@@ -51,9 +75,14 @@ wrote 1048576/1048576 bytes at offset 0
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 524288, "speed": 1, "type": "stream"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 00de3c33cf..4b915718cd 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -93,7 +93,7 @@ _send_qemu_cmd $h "{ 'execute': 'block-job-complete',
                                 'arguments': {
                                                 'device': 'virtio0'
                                               }
-                   }" "COMPLETED"
+                   }" '"status": "null"'
 
 echo
 echo === Performing Live Snapshot 2 ===
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index 014b2817ee..55299201e4 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -12,10 +12,17 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/
 
 === Performing block-commit on active layer ===
 
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "virtio0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 {"return": {}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "virtio0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "virtio0"}}
 
 === Performing Live Snapshot 2 ===
 
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index e75dc4d743..0a9a09802e 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -119,7 +119,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 _send_qemu_cmd $QEMU_HANDLE \
     '' \
-    'BLOCK_JOB_COMPLETED'
+    '"status": "null"'
 
 # Remove the source images
 rm -f "$TEST_IMG{,.backing,.overlay}"
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index f96a564c1d..34c057b626 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -12,13 +12,20 @@ wrote 131072/131072 bytes at offset 131072
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.target
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "source"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "source"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "source", "len": 131072, "offset": 131072, "speed": 0, "type": "mirror"}}
 wrote 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "source"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "source", "len": 196608, "offset": 196608, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "source"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "source"}}
 
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 298d88d04e..9a4f54d57a 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -118,8 +118,10 @@ _send_qemu_cmd $h \
                       'speed': 65536 } }" \
     "return"
 
+# Ignore the JOB_STATUS_CHANGE events while shutting down the VM. Depending on
+# the timing, jobs may or may not transition through a paused state.
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
-wait=1 _cleanup_qemu
+wait=1 _cleanup_qemu | grep -v 'JOB_STATUS_CHANGE'
 
 echo
 echo === Start active commit job and exit qemu ===
@@ -138,7 +140,7 @@ _send_qemu_cmd $h \
     "return"
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
-wait=1 _cleanup_qemu
+wait=1 _cleanup_qemu | grep -v 'JOB_STATUS_CHANGE'
 
 echo
 echo === Start mirror job and exit qemu ===
@@ -163,7 +165,7 @@ _send_qemu_cmd $h \
 sleep 0.5
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
-wait=1 _cleanup_qemu
+wait=1 _cleanup_qemu | grep -v 'JOB_STATUS_CHANGE'
 
 echo
 echo === Start backup job and exit qemu ===
@@ -184,7 +186,7 @@ _send_qemu_cmd $h \
     "return"
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
-wait=1 _cleanup_qemu
+wait=1 _cleanup_qemu | grep -v 'JOB_STATUS_CHANGE'
 
 echo
 echo === Start streaming job and exit qemu ===
@@ -202,7 +204,7 @@ _send_qemu_cmd $h \
     "return"
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
-wait=1 _cleanup_qemu
+wait=1 _cleanup_qemu | grep -v 'JOB_STATUS_CHANGE'
 
 _check_test_img
 
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 992162f418..dd3b8c719d 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -17,6 +17,8 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 
 === Start commit job and exit qemu ===
 
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
@@ -25,6 +27,8 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 === Start active commit job and exit qemu ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
@@ -35,6 +39,8 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 
 {"return": {}}
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
@@ -45,6 +51,8 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 
 {"return": {}}
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
@@ -53,6 +61,8 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 === Start streaming job and exit qemu ===
 
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index dfad6555e4..b3629ff6e8 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -83,7 +83,7 @@ _send_qemu_cmd $h \
                       'device': 'top',
                       'base':'$TEST_IMG.base',
                       'top': '$TEST_IMG.mid' } }" \
-    "BLOCK_JOB_COMPLETED"
+    '"status": "null"'
 _send_qemu_cmd $h "" "^}"
 
 echo
@@ -131,7 +131,7 @@ _send_qemu_cmd $h \
                       'device': 'top',
                       'base':'$TEST_IMG.base',
                       'top': '$TEST_IMG.mid' } }" \
-    "BLOCK_JOB_COMPLETED"
+    '"status": "null"'
 _send_qemu_cmd $h "" "^}"
 
 echo
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 190c5f049a..31a0c7d4c4 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -16,6 +16,28 @@ wrote 65536/65536 bytes at offset 1048576
 === Perform commit job ===
 
 {
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "created",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "running",
+        "id": "commit0"
+    }
+}
+{
     "return": {
     }
 }
@@ -24,6 +46,28 @@ wrote 65536/65536 bytes at offset 1048576
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "waiting",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "pending",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
     "event": "BLOCK_JOB_COMPLETED",
     "data": {
         "device": "commit0",
@@ -33,6 +77,28 @@ wrote 65536/65536 bytes at offset 1048576
         "type": "commit"
     }
 }
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "concluded",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "null",
+        "id": "commit0"
+    }
+}
 
 === Check that both top and top2 point to base now ===
 
@@ -356,6 +422,28 @@ wrote 65536/65536 bytes at offset 1048576
 === Perform commit job ===
 
 {
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "created",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "running",
+        "id": "commit0"
+    }
+}
+{
     "return": {
     }
 }
@@ -364,6 +452,28 @@ wrote 65536/65536 bytes at offset 1048576
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "waiting",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "pending",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
     "event": "BLOCK_JOB_COMPLETED",
     "data": {
         "device": "commit0",
@@ -373,6 +483,28 @@ wrote 65536/65536 bytes at offset 1048576
         "type": "commit"
     }
 }
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "concluded",
+        "id": "commit0"
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "JOB_STATUS_CHANGE",
+    "data": {
+        "status": "null",
+        "id": "commit0"
+    }
+}
 
 === Check that both top and top2 point to base now ===
 
-- 
2.13.6
