Received: from eggs.gnu.org ([209.51.188.92]:57615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54V-0003mu-01
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54T-0005NO-Q6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:42 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:54 -0600
Message-Id: <20190114162605.5330-10-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/20] iotests: change qmp_log filters to expect
 QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

As laid out in the previous commit's message:

```
Several places in iotests deal with serializing objects into JSON
strings, but to add pretty-printing it seems desirable to localize
all of those cases.

log() seems like a good candidate for that centralized behavior.
log() can already serialize json objects, but when it does so,
it assumes filters=3D[] operates on QMP objects, not strings.

qmp_log currently operates by dumping outgoing and incoming QMP
objects into strings and filtering them assuming that filters=3D[]
are string filters.
```

Therefore:

Change qmp_log to treat filters as if they're always qmp object filters,
then change the logging call to rely on log()'s ability to serialize QMP
objects, so we're not duplicating that effort.

Add a qmp version of filter_testfiles and adjust the only caller using
it for qmp_log to use the qmp version.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20181221093529.23855-10-jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/206        |  4 ++--
 tests/qemu-iotests/iotests.py | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index e92550fa59f..5bb738bf23c 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=3D['qcow2'])

 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create',
-                        filters=3D[iotests.filter_testfiles],
+                        filters=3D[iotests.filter_qmp_testfiles],
                         job_id=3D'job0', options=3Doptions)

     if 'return' in result:
@@ -55,7 +55,7 @@ with iotests.FilePath('t.qcow2') as disk_path, \
                           'size': 0 })

     vm.qmp_log('blockdev-add',
-               filters=3D[iotests.filter_testfiles],
+               filters=3D[iotests.filter_qmp_testfiles],
                driver=3D'file', filename=3Ddisk_path,
                node_name=3D'imgfile')

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 57fe20db45a..a96a7010d49 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -246,10 +246,33 @@ def filter_qmp_event(event):
         event['timestamp']['microseconds'] =3D 'USECS'
     return event

+def filter_qmp(qmsg, filter_fn):
+    '''Given a string filter, filter a QMP object's values.
+    filter_fn takes a (key, value) pair.'''
+    # Iterate through either lists or dicts;
+    if isinstance(qmsg, list):
+        items =3D enumerate(qmsg)
+    else:
+        items =3D qmsg.items()
+
+    for k, v in items:
+        if isinstance(v, list) or isinstance(v, dict):
+            qmsg[k] =3D filter_qmp(v, filter_fn)
+        else:
+            qmsg[k] =3D filter_fn(k, v)
+    return qmsg
+
 def filter_testfiles(msg):
     prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
     return msg.replace(prefix, 'TEST_DIR/PID-')

+def filter_qmp_testfiles(qmsg):
+    def _filter(key, value):
+        if key =3D=3D 'filename' or key =3D=3D 'backing-file':
+            return filter_testfiles(value)
+        return value
+    return filter_qmp(qmsg, _filter)
+
 def filter_generated_node_ids(msg):
     return re.sub("#block[0-9]+", "NODE_NAME", msg)

@@ -465,10 +488,9 @@ class VM(qtest.QEMUQtestMachine):
             ("execute", cmd),
             ("arguments", ordered_kwargs(kwargs))
         ))
-        logmsg =3D json.dumps(full_cmd)
-        log(logmsg, filters)
+        log(full_cmd, filters)
         result =3D self.qmp(cmd, **kwargs)
-        log(json.dumps(result, sort_keys=3DTrue), filters)
+        log(result, filters)
         return result

     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse):
--=20
2.20.1
