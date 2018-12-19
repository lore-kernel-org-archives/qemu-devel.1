Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2c-0000BT-Ef
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2a-0004WT-GN
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:54 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Dec 2018 20:52:28 -0500
Message-Id: <20181219015230.18652-4-jsnow@redhat.com>
In-Reply-To: <20181219015230.18652-1-jsnow@redhat.com>
References: <20181219015230.18652-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/5] iotests: change qmp_log filters to
 expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

log() treats filters as if they can always filter its primary argument.
qmp_log treats filters as if they're always text.

Change qmp_log to treat filters as if they're always qmp object filters,
then change the logging call to rely on log()'s ability to serialize QMP
objects, so we're not duplicating that effort.

Because kwargs have been sorted already, the order is preserved.

Edit the only caller who uses filters on qmp_log to use a qmp version,
also added in this patch.
---
 tests/qemu-iotests/206        |  4 ++--
 tests/qemu-iotests/iotests.py | 24 +++++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index e92550fa59..5bb738bf23 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=['qcow2'])
 
 def blockdev_create(vm, options):
     result = vm.qmp_log('blockdev-create',
-                        filters=[iotests.filter_testfiles],
+                        filters=[iotests.filter_qmp_testfiles],
                         job_id='job0', options=options)
 
     if 'return' in result:
@@ -55,7 +55,7 @@ with iotests.FilePath('t.qcow2') as disk_path, \
                           'size': 0 })
 
     vm.qmp_log('blockdev-add',
-               filters=[iotests.filter_testfiles],
+               filters=[iotests.filter_qmp_testfiles],
                driver='file', filename=disk_path,
                node_name='imgfile')
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 55fb60e039..812302538d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -246,10 +246,29 @@ def filter_qmp_event(event):
         event['timestamp']['microseconds'] = 'USECS'
     return event
 
+def filter_qmp(qmsg, filter_fn):
+    '''Given a string filter, filter a QMP object's values.
+    filter_fn takes a (key, value) pair.'''
+    for key in qmsg:
+        if isinstance(qmsg[key], list):
+            qmsg[key] = [filter_qmp(atom, filter_fn) for atom in qmsg[key]]
+        elif isinstance(qmsg[key], dict):
+            qmsg[key] = filter_qmp(qmsg[key], filter_fn)
+        else:
+            qmsg[key] = filter_fn(key, qmsg[key])
+    return qmsg
+
 def filter_testfiles(msg):
     prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
     return msg.replace(prefix, 'TEST_DIR/PID-')
 
+def filter_qmp_testfiles(qmsg):
+    def _filter(key, value):
+        if key == 'filename' or key == 'backing-file':
+            return filter_testfiles(value)
+        return value
+    return filter_qmp(qmsg, _filter)
+
 def filter_generated_node_ids(msg):
     return re.sub("#block[0-9]+", "NODE_NAME", msg)
 
@@ -462,10 +481,9 @@ class VM(qtest.QEMUQtestMachine):
     def qmp_log(self, cmd, filters=[], **kwargs):
         full_cmd = OrderedDict({"execute": cmd,
                                 "arguments": ordered_kwargs(kwargs)})
-        logmsg = json.dumps(full_cmd)
-        log(logmsg, filters)
+        log(full_cmd, filters)
         result = self.qmp(cmd, **kwargs)
-        log(json.dumps(result, sort_keys=True), filters)
+        log(result, filters)
         return result
 
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
-- 
2.17.2
