Received: from eggs.gnu.org ([2001:4830:134:3::10]:52995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Od-0001ny-2O
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Ob-0001Yv-LL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:01 -0500
Message-Id: <20170830180711.7974-2-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 01/11] qemu-iotests: Extend non-shared storage
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Kashyap Chamarthy <kchamart@redhat.com>

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
Message-Id: <20170829165058.8229-1-kchamart@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/194     | 23 +++++++++++++++++------
 tests/qemu-iotests/194.out | 11 ++++++++---
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8028111e21..a3e3bad664 100755
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
index ae501fecac..50ac50da5e 100644
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
2.13.5
