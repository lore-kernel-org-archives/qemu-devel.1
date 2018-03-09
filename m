Received: from eggs.gnu.org ([2001:4830:134:3::10]:34340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlS-0001hV-8J
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlP-0007a2-3c
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:21:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:33 +0100
Message-Id: <20180309161933.8168-57-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 56/56] qemu-iotests: fix 203 migration
 completion race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

There is a race between the test's 'query-migrate' QMP command after the
QMP 'STOP' event and completing the migration:

The test case invokes 'query-migrate' upon receiving 'STOP'.  At this
point the migration thread may still be in the process of completing.
Therefore 'query-migrate' can return 'status': 'active' for a brief
window of time instead of 'status': 'completed'.  This results in
qemu-iotests 203 hanging.

Solve the race by enabling the 'events' migration capability, which
causes QEMU to emit migration-specific QMP events that do not suffer
from this race condition.  Wait for the QMP 'MIGRATION' event with
'status': 'completed'.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180305155926.25858-1-stefanha@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/203     | 15 +++++++++++----
 tests/qemu-iotests/203.out |  5 +++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/203 b/tests/qemu-iotests/203
index 2c811917d8..4874a1a0d8 100755
--- a/tests/qemu-iotests/203
+++ b/tests/qemu-iotests/203
@@ -49,11 +49,18 @@ with iotests.FilePath('disk0.img') as disk0_img_path, \
                        node_name='drive1-node', iothread='iothread0',
                        force=True))
 
+    iotests.log('Enabling migration QMP events...')
+    iotests.log(vm.qmp('migrate-set-capabilities', capabilities=[
+        {
+            'capability': 'events',
+            'state': True
+        }
+    ]))
+
     iotests.log('Starting migration...')
     iotests.log(vm.qmp('migrate', uri='exec:cat >/dev/null'))
     while True:
-        vm.get_qmp_event(wait=60.0)
-        result = vm.qmp('query-migrate')
-        status = result.get('return', {}).get('status', None)
-        if status == 'completed':
+        event = vm.event_wait('MIGRATION')
+        iotests.log(event, filters=[iotests.filter_qmp_event])
+        if event['data']['status'] == 'completed':
             break
diff --git a/tests/qemu-iotests/203.out b/tests/qemu-iotests/203.out
index 3f1ff900e4..1a11f0975c 100644
--- a/tests/qemu-iotests/203.out
+++ b/tests/qemu-iotests/203.out
@@ -2,5 +2,10 @@ Launching VM...
 Setting IOThreads...
 {u'return': {}}
 {u'return': {}}
+Enabling migration QMP events...
+{u'return': {}}
 Starting migration...
 {u'return': {}}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
-- 
2.13.6
