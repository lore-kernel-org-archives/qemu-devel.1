Received: from eggs.gnu.org ([2001:4830:134:3::10]:58732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmIF9-0008Pf-JH
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmIF5-0005mv-Br
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:30:11 -0400
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Mon, 28 Aug 2017 13:29:52 +0200
Message-Id: <20170828112952.22965-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: Extend non-shared storage
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

  - Issue `block-job-cancel` command on the source QEMU to gracefully
    complete the mirroring operation.

  - Stop the NBD server on the destination QEMU.

  - Finally, exit once the event BLOCK_JOB_COMPLETED is emitted.

With the above, the test will also be (almost) in sync with the
procedure outlined in the document live-block-operations.rst[+]
(section: "QMP invocation for live storage migration with
``drive-mirror`` + NBD").

[*] https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04820.html
    -- qemu-iotests: add 194 non-shared storage migration test
[+] https://git.qemu.org/gitweb.cgi?p=qemu.git;a=blob;f=docs/interop/live-block-operations.rst

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
I wonder:
  - Is it worth printing the MIGRATION event state change?
  - Since we're not checking on the MIGRATION event anymore, can
    the migration state change events related code (that is triggerred
    by setting 'migrate-set-capabilities') be simply removed?
---
 tests/qemu-iotests/194     | 17 ++++++++++++-----
 tests/qemu-iotests/194.out | 14 ++++++++------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8028111e21bed5cf4a2e8e32dc04aa5a9ea9caca..8d746be9d0033f478f11886ee93f95b0fa55bab0 100755
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
 
@@ -66,8 +67,14 @@ dest_vm.qmp('migrate-set-capabilities',
             capabilities=[{'capability': 'events', 'state': True}])
 iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
 
+iotests.log('Gracefully ending the `drive-mirror` job on source...')
+iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
+
+iotests.log('Stopping the NBD server on destination...')
+iotests.log(dest_vm.qmp('nbd-server-stop'))
+
 while True:
-    event = source_vm.event_wait('MIGRATION')
+    event = source_vm.event_wait('BLOCK_JOB_COMPLETED')
     iotests.log(event, filters=[iotests.filter_qmp_event])
-    if event['data']['status'] in ('completed', 'failed'):
+    if event['event'] == 'BLOCK_JOB_COMPLETED':
         break
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index ae501fecacb706b1851cb9063ce9c9d5a28bb7ea..3a0e3a26e5342b0e3f0373623efd9d2b3ee8d2be 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -2,12 +2,14 @@ Launching VMs...
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
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
+Gracefully ending the `drive-mirror` job on source...
+{u'return': {}}
+Stopping the NBD server on destination...
+{u'return': {}}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_COMPLETED'}
-- 
2.9.5
