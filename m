Received: from eggs.gnu.org ([2001:4830:134:3::10]:51285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDux-0000mL-02
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDur-0003ti-Vf
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dpDur-0003t2-Ln
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Sep 2017 14:29:07 +0100
Message-Id: <20170905132908.30931-4-stefanha@redhat.com>
In-Reply-To: <20170905132908.30931-1-stefanha@redhat.com>
References: <20170905132908.30931-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] qemu-iotests: use context managers for
 resource cleanup in 194
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Switch from atexit.register() to a more elegant idiom of declaring
resources in a with statement:

  with FilePath('monitor.sock') as monitor_path,
       VM() as vm:
      ...

The files and VMs will be automatically cleaned up whether the test
passes or fails.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170824072202.26818-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/194 | 117 ++++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 59 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index a3e3bad664..6449b9b64a 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -19,66 +19,65 @@
 #
 # Non-shared storage migration test using NBD server and drive-mirror
 
-import os
-import atexit
 import iotests
 
 iotests.verify_platform(['linux'])
 
-img_size = '1G'
-source_img_path = os.path.join(iotests.test_dir, 'source.img')
-dest_img_path = os.path.join(iotests.test_dir, 'dest.img')
-iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, source_img_path, img_size)
-iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, dest_img_path, img_size)
-
-iotests.log('Launching VMs...')
-migration_sock_path = os.path.join(iotests.test_dir, 'migration.sock')
-nbd_sock_path = os.path.join(iotests.test_dir, 'nbd.sock')
-source_vm = iotests.VM('source').add_drive(source_img_path)
-dest_vm = (iotests.VM('dest').add_drive(dest_img_path)
-                             .add_incoming('unix:{0}'.format(migration_sock_path)))
-source_vm.launch()
-atexit.register(source_vm.shutdown)
-dest_vm.launch()
-atexit.register(dest_vm.shutdown)
-
-iotests.log('Launching NBD server on destination...')
-iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
-iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
-
-iotests.log('Starting `drive-mirror` on source...')
-iotests.log(source_vm.qmp(
-              'drive-mirror',
-              device='drive0',
-              target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
-              sync='full',
-              format='raw', # always raw, the server handles the format
-              mode='existing',
-              job_id='mirror-job0'))
-
-iotests.log('Waiting for `drive-mirror` to complete...')
-iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
-            filters=[iotests.filter_qmp_event])
-
-iotests.log('Starting migration...')
-source_vm.qmp('migrate-set-capabilities',
-              capabilities=[{'capability': 'events', 'state': True}])
-dest_vm.qmp('migrate-set-capabilities',
-            capabilities=[{'capability': 'events', 'state': True}])
-iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
-
-while True:
-    event1 = source_vm.event_wait('MIGRATION')
-    iotests.log(event1, filters=[iotests.filter_qmp_event])
-    if event1['data']['status'] in ('completed', 'failed'):
-        iotests.log('Gracefully ending the `drive-mirror` job on source...')
-        iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
-        break
-
-while True:
-    event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
-    iotests.log(event2, filters=[iotests.filter_qmp_event])
-    if event2['event'] == 'BLOCK_JOB_COMPLETED':
-        iotests.log('Stopping the NBD server on destination...')
-        iotests.log(dest_vm.qmp('nbd-server-stop'))
-        break
+with iotests.FilePath('source.img') as source_img_path, \
+     iotests.FilePath('dest.img') as dest_img_path, \
+     iotests.FilePath('migration.sock') as migration_sock_path, \
+     iotests.FilePath('nbd.sock') as nbd_sock_path, \
+     iotests.VM('source') as source_vm, \
+     iotests.VM('dest') as dest_vm:
+
+    img_size = '1G'
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, source_img_path, img_size)
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, dest_img_path, img_size)
+
+    iotests.log('Launching VMs...')
+    (source_vm.add_drive(source_img_path)
+              .launch())
+    (dest_vm.add_drive(dest_img_path)
+            .add_incoming('unix:{0}'.format(migration_sock_path))
+            .launch())
+
+    iotests.log('Launching NBD server on destination...')
+    iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
+    iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
+
+    iotests.log('Starting `drive-mirror` on source...')
+    iotests.log(source_vm.qmp(
+                  'drive-mirror',
+                  device='drive0',
+                  target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
+                  sync='full',
+                  format='raw', # always raw, the server handles the format
+                  mode='existing',
+                  job_id='mirror-job0'))
+
+    iotests.log('Waiting for `drive-mirror` to complete...')
+    iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
+                filters=[iotests.filter_qmp_event])
+
+    iotests.log('Starting migration...')
+    source_vm.qmp('migrate-set-capabilities',
+                  capabilities=[{'capability': 'events', 'state': True}])
+    dest_vm.qmp('migrate-set-capabilities',
+                capabilities=[{'capability': 'events', 'state': True}])
+    iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
+
+    while True:
+        event1 = source_vm.event_wait('MIGRATION')
+        iotests.log(event1, filters=[iotests.filter_qmp_event])
+        if event1['data']['status'] in ('completed', 'failed'):
+            iotests.log('Gracefully ending the `drive-mirror` job on source...')
+            iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
+            break
+
+    while True:
+        event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
+        iotests.log(event2, filters=[iotests.filter_qmp_event])
+        if event2['event'] == 'BLOCK_JOB_COMPLETED':
+            iotests.log('Stopping the NBD server on destination...')
+            iotests.log(dest_vm.qmp('nbd-server-stop'))
+            break
-- 
2.13.5
