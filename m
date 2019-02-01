Received: from eggs.gnu.org ([209.51.188.92]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboB-0007s7-63
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbo7-00008f-MJ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:50 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:34:58 +0100
Message-Id: <20190201163518.31157-8-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/27] iotests: Make 234 stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

This test waits for a MIGRATION event with status=3Dcompleted on the
source VM before querying the migration status on both source and
destination.  However, just because the source says migration has
completed does not mean the destination thinks the same.  Therefore, in
some cases, the destination VM may still report "active" instead of
"completed" when asked for its migration status.

Fix this by enabling migration events on both VMs and waiting until both
source and destination emit a status=3Dcompleted MIGRATION event.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/234     | 56 ++++++++++++++++++++------------------
 tests/qemu-iotests/234.out | 10 +++++--
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index a8185b4360..c4c26bc21e 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -26,6 +26,22 @@ import os
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
 iotests.verify_platform(['linux'])
=20
+def enable_migration_events(vm, name):
+    iotests.log('Enabling migration QMP events on %s...' % name)
+    iotests.log(vm.qmp('migrate-set-capabilities', capabilities=3D[
+        {
+            'capability': 'events',
+            'state': True
+        }
+    ]))
+
+def wait_migration(vm):
+    while True:
+        event =3D vm.event_wait('MIGRATION')
+        iotests.log(event, filters=3D[iotests.filter_qmp_event])
+        if event['data']['status'] =3D=3D 'completed':
+            break
+
 with iotests.FilePath('img') as img_path, \
      iotests.FilePath('backing') as backing_path, \
      iotests.FilePath('mig_fifo_a') as fifo_a, \
@@ -46,6 +62,8 @@ with iotests.FilePath('img') as img_path, \
          .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddrive0=
-backing' % (iotests.imgfmt))
          .launch())
=20
+    enable_migration_events(vm_a, 'A')
+
     iotests.log('Launching destination VM...')
     (vm_b.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % (i=
mg_path))
          .add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0' % (iot=
ests.imgfmt))
@@ -54,6 +72,8 @@ with iotests.FilePath('img') as img_path, \
          .add_incoming("exec: cat '%s'" % (fifo_a))
          .launch())
=20
+    enable_migration_events(vm_b, 'B')
+
     # Add a child node that was created after the parent node. The rever=
se case
     # is covered by the -blockdev options above.
     iotests.log(vm_a.qmp('blockdev-snapshot', node=3D'drive0-backing',
@@ -61,22 +81,13 @@ with iotests.FilePath('img') as img_path, \
     iotests.log(vm_b.qmp('blockdev-snapshot', node=3D'drive0-backing',
                          overlay=3D'drive0'))
=20
-    iotests.log('Enabling migration QMP events on A...')
-    iotests.log(vm_a.qmp('migrate-set-capabilities', capabilities=3D[
-        {
-            'capability': 'events',
-            'state': True
-        }
-    ]))
-
     iotests.log('Starting migration to B...')
     iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_a)))
     with iotests.Timeout(3, 'Migration does not complete'):
-        while True:
-            event =3D vm_a.event_wait('MIGRATION')
-            iotests.log(event, filters=3D[iotests.filter_qmp_event])
-            if event['data']['status'] =3D=3D 'completed':
-                break
+        # Wait for the source first (which includes setup=3Dsetup)
+        wait_migration(vm_a)
+        # Wait for the destination second (which does not)
+        wait_migration(vm_b)
=20
     iotests.log(vm_a.qmp('query-migrate')['return']['status'])
     iotests.log(vm_b.qmp('query-migrate')['return']['status'])
@@ -94,25 +105,18 @@ with iotests.FilePath('img') as img_path, \
          .add_incoming("exec: cat '%s'" % (fifo_b))
          .launch())
=20
+    enable_migration_events(vm_a, 'A')
+
     iotests.log(vm_a.qmp('blockdev-snapshot', node=3D'drive0-backing',
                          overlay=3D'drive0'))
=20
-    iotests.log('Enabling migration QMP events on B...')
-    iotests.log(vm_b.qmp('migrate-set-capabilities', capabilities=3D[
-        {
-            'capability': 'events',
-            'state': True
-        }
-    ]))
-
     iotests.log('Starting migration back to A...')
     iotests.log(vm_b.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_b)))
     with iotests.Timeout(3, 'Migration does not complete'):
-        while True:
-            event =3D vm_b.event_wait('MIGRATION')
-            iotests.log(event, filters=3D[iotests.filter_qmp_event])
-            if event['data']['status'] =3D=3D 'completed':
-                break
+        # Wait for the source first (which includes setup=3Dsetup)
+        wait_migration(vm_b)
+        # Wait for the destination second (which does not)
+        wait_migration(vm_a)
=20
     iotests.log(vm_a.qmp('query-migrate')['return']['status'])
     iotests.log(vm_b.qmp('query-migrate')['return']['status'])
diff --git a/tests/qemu-iotests/234.out b/tests/qemu-iotests/234.out
index b9ed910b1a..692976d1c6 100644
--- a/tests/qemu-iotests/234.out
+++ b/tests/qemu-iotests/234.out
@@ -1,14 +1,18 @@
 Launching source VM...
+Enabling migration QMP events on A...
+{"return": {}}
 Launching destination VM...
+Enabling migration QMP events on B...
 {"return": {}}
 {"return": {}}
-Enabling migration QMP events on A...
 {"return": {}}
 Starting migration to B...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
 completed
 completed
 {"return": {"running": false, "singlestep": false, "status": "postmigrat=
e"}}
@@ -16,14 +20,16 @@ completed
 Add a second parent to drive0-file...
 {"return": {}}
 Restart A with -incoming and second parent...
+Enabling migration QMP events on A...
 {"return": {}}
-Enabling migration QMP events on B...
 {"return": {}}
 Starting migration back to A...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
 completed
 completed
 {"return": {"running": true, "singlestep": false, "status": "running"}}
--=20
2.20.1
