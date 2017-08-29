Received: from eggs.gnu.org ([2001:4830:134:3::10]:49152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmjjQ-00056A-9u
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmjjP-0001AK-0E
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:51:16 -0400
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Tue, 29 Aug 2017 18:50:58 +0200
Message-Id: <20170829165058.8229-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH v3] qemu-iotests: Extend non-shared storage
 migration test (194)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, kwolf@redhat.com, dgilbert@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

This is the follow-up patch that was discussed[*] as part of feedback to
qemu-iotest 194.

Changes in this patch:

  - Supply 'job-id' parameter to `drive-mirror` invocation.

  - Once migration completes, issue QMP `block-job-cancel` command on
    the source QEMU to gracefully complete `drive-mirror` operation.

  - Once the BLOCK_JOB_COMPLETED event is emitted, stop the NBD server
    on the destination QEMU.

  - Check for both the events: MIGRATION and BLOCK_JOB_COMPLETED.

With the above, the test will also be (almost) in sync with the
procedure outlined in the document 'live-block-operations.rst'[+]
(section: "QMP invocation for live storage migration with
``drive-mirror`` + NBD").

[*] https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04820.html
    -- qemu-iotests: add 194 non-shared storage migration test
[+] https://git.qemu.org/gitweb.cgi?p=qemu.git;a=blob;f=docs/interop/live-block-operations.rst

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
Changes in v3:
 - Wait for migration to complete before issuing `block-job-cancel`
   (StefanH)
 - Wait for the event BLOCK_JOB_COMPLETED on the source before stopping
   the NBD server on the destination (StefanH)

Changes in v2:
 - Check for both the events: MIGRATION and BLOCK_JOB_COMPLETED (EricB)
---
 tests/qemu-iotests/194     | 23 +++++++++++++++++------
 tests/qemu-iotests/194.out | 11 ++++++++---
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8028111e21bed5cf4a2e8e32dc04aa5a9ea9caca..a3e3bad664b9d6aada7fbcbe7db907408a7c06de 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -46,16 +46,17 @@ iotests.log('Launching NBD server on destination...')
 iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
 iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
 
-iotests.log('Starting drive-mirror on source...')
+iotests.log('Starting `drive-mirror` on source...')
 iotests.log(source_vm.qmp(
               'drive-mirror',
               device='drive0',
               target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
               sync='full',
               format='raw', # always raw, the server handles the format
-              mode='existing'))
+              mode='existing',
+              job_id='mirror-job0'))
 
-iotests.log('Waiting for drive-mirror to complete...')
+iotests.log('Waiting for `drive-mirror` to complete...')
 iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
             filters=[iotests.filter_qmp_event])
 
@@ -67,7 +68,17 @@ dest_vm.qmp('migrate-set-capabilities',
 iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
 
 while True:
-    event = source_vm.event_wait('MIGRATION')
-    iotests.log(event, filters=[iotests.filter_qmp_event])
-    if event['data']['status'] in ('completed', 'failed'):
+    event1 = source_vm.event_wait('MIGRATION')
+    iotests.log(event1, filters=[iotests.filter_qmp_event])
+    if event1['data']['status'] in ('completed', 'failed'):
+        iotests.log('Gracefully ending the `drive-mirror` job on source...')
+        iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
+        break
+
+while True:
+    event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
+    iotests.log(event2, filters=[iotests.filter_qmp_event])
+    if event2['event'] == 'BLOCK_JOB_COMPLETED':
+        iotests.log('Stopping the NBD server on destination...')
+        iotests.log(dest_vm.qmp('nbd-server-stop'))
         break
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index ae501fecacb706b1851cb9063ce9c9d5a28bb7ea..50ac50da5e7736912cbbc1825ae5629b15f0e3fe 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -2,12 +2,17 @@ Launching VMs...
 Launching NBD server on destination...
 {u'return': {}}
 {u'return': {}}
-Starting drive-mirror on source...
+Starting `drive-mirror` on source...
 {u'return': {}}
-Waiting for drive-mirror to complete...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
+Waiting for `drive-mirror` to complete...
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
 Starting migration...
 {u'return': {}}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
+Gracefully ending the `drive-mirror` job on source...
+{u'return': {}}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_COMPLETED'}
+Stopping the NBD server on destination...
+{u'return': {}}
-- 
2.9.5
