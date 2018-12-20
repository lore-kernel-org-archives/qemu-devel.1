Received: from eggs.gnu.org ([2001:4830:134:3::10]:45374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6o-0004SE-Ov
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6n-00085u-Ln
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:46 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:50 -0500
Message-Id: <20181220022952.20493-10-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-1-jsnow@redhat.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/11] iotests: change qmp_log filters to
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
Cc: Eric Blake <eblake@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

As laid out in the previous commit's message:

```
Several places in iotests deal with serializing objects into JSON
strings, but to add pretty-printing it seems desireable to localize
all of those cases.

log() seems like a good candidate for that centralized behavior.
log() can already serialize json objects, but when it does so,
it assumes filters=[] operates on QMP objects, not strings.

qmp_log currently operates by dumping outgoing and incoming QMP
objects into strings and filtering them assuming that filters=[]
are string filters.
```

Therefore:

Change qmp_log to treat filters as if they're always qmp object filters,
then change the logging call to rely on log()'s ability to serialize QMP
objects, so we're not duplicating that effort.

Add a qmp version of filter_testfiles and adjust the only caller using
it for qmp_log to use the qmp version.

Signed-off-by: John Snow  <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
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
index 57fe20db45..dcd0c6f71d 100644
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
 
@@ -465,10 +484,9 @@ class VM(qtest.QEMUQtestMachine):
             ("execute", cmd),
             ("arguments", ordered_kwargs(kwargs))
         ))
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
