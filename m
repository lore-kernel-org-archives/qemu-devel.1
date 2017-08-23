Received: from eggs.gnu.org ([2001:4830:134:3::10]:59197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWHi-0005y6-88
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWHd-0005ih-SZ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:05:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Aug 2017 15:05:06 +0100
Message-Id: <20170823140506.28723-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: add 194 non-shared storage
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Non-shared storage migration with NBD and drive-mirror is currently not
tested by qemu-iotests.  This test case covers the basic migration
scenario.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Based-on: <20170823134242.12080-1-famz@redhat.com>
---
 tests/qemu-iotests/194        | 73 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/194.out    | 13 ++++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 13 ++++++++
 4 files changed, 100 insertions(+)
 create mode 100755 tests/qemu-iotests/194
 create mode 100644 tests/qemu-iotests/194.out

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
new file mode 100755
index 0000000000..8028111e21
--- /dev/null
+++ b/tests/qemu-iotests/194
@@ -0,0 +1,73 @@
+#!/usr/bin/env python
+#
+# Copyright (C) 2017 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Creator/Owner: Stefan Hajnoczi <stefanha@redhat.com>
+#
+# Non-shared storage migration test using NBD server and drive-mirror
+
+import os
+import atexit
+import iotests
+
+iotests.verify_platform(['linux'])
+
+img_size = '1G'
+source_img_path = os.path.join(iotests.test_dir, 'source.img')
+dest_img_path = os.path.join(iotests.test_dir, 'dest.img')
+iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, source_img_path, img_size)
+iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, dest_img_path, img_size)
+
+iotests.log('Launching VMs...')
+migration_sock_path = os.path.join(iotests.test_dir, 'migration.sock')
+nbd_sock_path = os.path.join(iotests.test_dir, 'nbd.sock')
+source_vm = iotests.VM('source').add_drive(source_img_path)
+dest_vm = (iotests.VM('dest').add_drive(dest_img_path)
+                             .add_incoming('unix:{0}'.format(migration_sock_path)))
+source_vm.launch()
+atexit.register(source_vm.shutdown)
+dest_vm.launch()
+atexit.register(dest_vm.shutdown)
+
+iotests.log('Launching NBD server on destination...')
+iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
+iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
+
+iotests.log('Starting drive-mirror on source...')
+iotests.log(source_vm.qmp(
+              'drive-mirror',
+              device='drive0',
+              target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
+              sync='full',
+              format='raw', # always raw, the server handles the format
+              mode='existing'))
+
+iotests.log('Waiting for drive-mirror to complete...')
+iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
+            filters=[iotests.filter_qmp_event])
+
+iotests.log('Starting migration...')
+source_vm.qmp('migrate-set-capabilities',
+              capabilities=[{'capability': 'events', 'state': True}])
+dest_vm.qmp('migrate-set-capabilities',
+            capabilities=[{'capability': 'events', 'state': True}])
+iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
+
+while True:
+    event = source_vm.event_wait('MIGRATION')
+    iotests.log(event, filters=[iotests.filter_qmp_event])
+    if event['data']['status'] in ('completed', 'failed'):
+        break
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
new file mode 100644
index 0000000000..ae501fecac
--- /dev/null
+++ b/tests/qemu-iotests/194.out
@@ -0,0 +1,13 @@
+Launching VMs...
+Launching NBD server on destination...
+{u'return': {}}
+{u'return': {}}
+Starting drive-mirror on source...
+{u'return': {}}
+Waiting for drive-mirror to complete...
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
+Starting migration...
+{u'return': {}}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
+{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index afbdc427ea..4bd5017008 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -187,3 +187,4 @@
 189 rw auto
 190 rw auto quick
 192 rw auto quick
+194 rw auto migration quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 22439c43d3..7233983f3c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -133,6 +133,14 @@ chown_re = re.compile(r"chown [0-9]+:[0-9]+")
 def filter_chown(msg):
     return chown_re.sub("chown UID:GID", msg)
 
+def filter_qmp_event(event):
+    '''Filter a QMP event dict'''
+    event = dict(event)
+    if 'timestamp' in event:
+        event['timestamp']['seconds'] = 'SECS'
+        event['timestamp']['microseconds'] = 'USECS'
+    return event
+
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
@@ -200,6 +208,11 @@ class VM(qtest.QEMUQtestMachine):
             self._args.append(','.join(opts))
         return self
 
+    def add_incoming(self, addr):
+        self._args.append('-incoming')
+        self._args.append(addr)
+        return self
+
     def pause_drive(self, drive, event=None):
         '''Pause drive r/w operations'''
         if not event:
-- 
2.13.5
