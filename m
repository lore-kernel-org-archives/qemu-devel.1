Received: from eggs.gnu.org ([2001:4830:134:3::10]:53400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmm-00050S-NM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNml-00020T-5w
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:08 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:26:05 +0200
Message-Id: <20180611142611.6609-24-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 23/29] iotests: Fix 219's timing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

219 has two issues that may lead to sporadic failure, both of which are
the result of issuing query-jobs too early after a job has been
modified.  This can then lead to different results based on whether the
modification has taken effect already or not.

First, query-jobs is issued right after the job has been created.
Besides its current progress possibly being in any random state (which
has already been taken care of), its total progress too is basically
arbitrary, because the job may not yet have been able to determine it.
This patch addresses this by just filtering the total progress, like
what has been done for the current progress already.  However, for more
clarity, the filtering is changed to replace the values by a string
'FILTERED' instead of deleting them.

Secondly, query-jobs is issued right after a job has been resumed.  The
job may or may not yet have had the time to actually perform any I/O,
and thus its current progress may or may not have advanced.  To make
sure it has indeed advanced (which is what the reference output already
assumes), keep querying it until it has.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180606190628.8170-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/219     | 26 ++++++++++++++++++++------
 tests/qemu-iotests/219.out | 10 +++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index 898a26eef0..c03bbdb294 100755
--- a/tests/qemu-iotests/219
+++ b/tests/qemu-iotests/219
@@ -42,11 +42,24 @@ def test_pause_resume(vm):
             iotests.log(vm.qmp(pause_cmd, **{pause_arg: 'job0'}))
             pause_wait(vm, 'job0')
             iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHANGE')))
-            iotests.log(vm.qmp('query-jobs'))
+            result = vm.qmp('query-jobs')
+            iotests.log(result)
+
+            old_progress = result['return'][0]['current-progress']
+            total_progress = result['return'][0]['total-progress']
 
             iotests.log(vm.qmp(resume_cmd, **{resume_arg: 'job0'}))
             iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHANGE')))
-            iotests.log(vm.qmp('query-jobs'))
+            if old_progress < total_progress:
+                # Wait for the job to advance
+                while result['return'][0]['current-progress'] == old_progress:
+                    result = vm.qmp('query-jobs')
+                iotests.log(result)
+            else:
+                # Already reached the end, so the job cannot advance
+                # any further; therefore, the query-jobs result can be
+                # logged immediately
+                iotests.log(vm.qmp('query-jobs'))
 
 def test_job_lifecycle(vm, job, job_args, has_ready=False):
     iotests.log('')
@@ -58,12 +71,13 @@ def test_job_lifecycle(vm, job, job_args, has_ready=False):
     iotests.log(vm.qmp(job, job_id='job0', **job_args))
 
     # Depending on the storage, the first request may or may not have completed
-    # yet, so filter out the progress. Later query-job calls don't need the
-    # filtering because the progress is made deterministic by the block job
-    # speed
+    # yet (and the total progress may not have been fully determined yet), so
+    # filter out the progress. Later query-job calls don't need the filtering
+    # because the progress is made deterministic by the block job speed
     result = vm.qmp('query-jobs')
     for j in result['return']:
-        del j['current-progress']
+        j['current-progress'] = 'FILTERED'
+        j['total-progress'] = 'FILTERED'
     iotests.log(result)
 
     # undefined -> created -> running
diff --git a/tests/qemu-iotests/219.out b/tests/qemu-iotests/219.out
index 346801b655..6dc07bc41e 100644
--- a/tests/qemu-iotests/219.out
+++ b/tests/qemu-iotests/219.out
@@ -3,7 +3,7 @@ Launching VM...
 
 Starting block job: drive-mirror (auto-finalize: True; auto-dismiss: True)
 {u'return': {}}
-{u'return': [{u'status': u'running', u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'mirror'}]}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 
@@ -93,7 +93,7 @@ Waiting for PENDING state...
 
 Starting block job: drive-backup (auto-finalize: True; auto-dismiss: True)
 {u'return': {}}
-{u'return': [{u'status': u'running', u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 
@@ -144,7 +144,7 @@ Waiting for PENDING state...
 
 Starting block job: drive-backup (auto-finalize: True; auto-dismiss: False)
 {u'return': {}}
-{u'return': [{u'status': u'running', u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 
@@ -203,7 +203,7 @@ Waiting for PENDING state...
 
 Starting block job: drive-backup (auto-finalize: False; auto-dismiss: True)
 {u'return': {}}
-{u'return': [{u'status': u'running', u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 
@@ -262,7 +262,7 @@ Waiting for PENDING state...
 
 Starting block job: drive-backup (auto-finalize: False; auto-dismiss: False)
 {u'return': {}}
-{u'return': [{u'status': u'running', u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
 
-- 
2.17.1
