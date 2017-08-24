Received: from eggs.gnu.org ([2001:4830:134:3::10]:53745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkmot-00041n-AR
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkmos-0007Kv-97
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dkmos-0007KZ-0l
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1977883B6
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 07:44:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Aug 2017 08:22:02 +0100
Message-Id: <20170824072202.26818-4-stefanha@redhat.com>
In-Reply-To: <20170824072202.26818-1-stefanha@redhat.com>
References: <20170824072202.26818-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] qemu-iotests: use context managers for
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
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Switch from atexit.register() to a more elegant idiom of declaring
resources in a with statement:

  with FilePath('monitor.sock') as monitor_path,
       VM() as vm:
      ...

The files and VMs will be automatically cleaned up whether the test
passes or fails.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/194 | 83 +++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8028111e21..06aea661d4 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -19,55 +19,54 @@
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
+with iotests.FilePath('source.img') as source_img_path, \
+     iotests.FilePath('dest.img') as dest_img_path, \
+     iotests.FilePath('migration.sock') as migration_sock_path, \
+     iotests.FilePath('nbd.sock') as nbd_sock_path, \
+     iotests.VM('source') as source_vm, \
+     iotests.VM('dest') as dest_vm:
 
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
+    img_size = '1G'
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, source_img_path, img_size)
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, dest_img_path, img_size)
 
-iotests.log('Launching NBD server on destination...')
-iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
-iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
+    iotests.log('Launching VMs...')
+    (source_vm.add_drive(source_img_path)
+              .launch())
+    (dest_vm.add_drive(dest_img_path)
+            .add_incoming('unix:{0}'.format(migration_sock_path))
+            .launch())
 
-iotests.log('Starting drive-mirror on source...')
-iotests.log(source_vm.qmp(
-              'drive-mirror',
-              device='drive0',
-              target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
-              sync='full',
-              format='raw', # always raw, the server handles the format
-              mode='existing'))
+    iotests.log('Launching NBD server on destination...')
+    iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
+    iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
 
-iotests.log('Waiting for drive-mirror to complete...')
-iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
-            filters=[iotests.filter_qmp_event])
+    iotests.log('Starting drive-mirror on source...')
+    iotests.log(source_vm.qmp(
+                  'drive-mirror',
+                  device='drive0',
+                  target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
+                  sync='full',
+                  format='raw', # always raw, the server handles the format
+                  mode='existing'))
 
-iotests.log('Starting migration...')
-source_vm.qmp('migrate-set-capabilities',
-              capabilities=[{'capability': 'events', 'state': True}])
-dest_vm.qmp('migrate-set-capabilities',
-            capabilities=[{'capability': 'events', 'state': True}])
-iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
+    iotests.log('Waiting for drive-mirror to complete...')
+    iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
+                filters=[iotests.filter_qmp_event])
 
-while True:
-    event = source_vm.event_wait('MIGRATION')
-    iotests.log(event, filters=[iotests.filter_qmp_event])
-    if event['data']['status'] in ('completed', 'failed'):
-        break
+    iotests.log('Starting migration...')
+    source_vm.qmp('migrate-set-capabilities',
+                  capabilities=[{'capability': 'events', 'state': True}])
+    dest_vm.qmp('migrate-set-capabilities',
+                capabilities=[{'capability': 'events', 'state': True}])
+    iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
+
+    while True:
+        event = source_vm.event_wait('MIGRATION')
+        iotests.log(event, filters=[iotests.filter_qmp_event])
+        if event['data']['status'] in ('completed', 'failed'):
+            break
-- 
2.13.5
