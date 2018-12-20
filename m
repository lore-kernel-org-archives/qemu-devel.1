Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6l-0004QX-Ki
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6h-00080P-T4
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:43 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:49 -0500
Message-Id: <20181220022952.20493-9-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-1-jsnow@redhat.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/11] iotests: remove default filters from
 qmp_log
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

Several places in iotests deal with serializing objects into JSON
strings, but to add pretty-printing it seems desireable to localize
all of those cases.

log() seems like a good candidate for that centralized behavior.
log() can already serialize json objects, but when it does so,
it assumes filters=[] operates on QMP objects, not strings.

qmp_log currently operates by dumping outgoing and incoming QMP
objects into strings and filtering them assuming that filters=[]
are string filters.

To have qmp_log use log's serialization, qmp_log will need to
accept only qmp filters, not text filters.

However, only a single caller of qmp_log actually requires any
filters at all. I remove the default filter and add it explicitly
to the caller in preparation for refactoring qmp_log to use rich
filters instead.

test 206 is amended to name the filter explicitly and the default
is removed.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/206        | 8 ++++++--
 tests/qemu-iotests/iotests.py | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 128c334c7c..e92550fa59 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -26,7 +26,9 @@ from iotests import imgfmt
 iotests.verify_image_format(supported_fmts=['qcow2'])
 
 def blockdev_create(vm, options):
-    result = vm.qmp_log('blockdev-create', job_id='job0', options=options)
+    result = vm.qmp_log('blockdev-create',
+                        filters=[iotests.filter_testfiles],
+                        job_id='job0', options=options)
 
     if 'return' in result:
         assert result['return'] == {}
@@ -52,7 +54,9 @@ with iotests.FilePath('t.qcow2') as disk_path, \
                           'filename': disk_path,
                           'size': 0 })
 
-    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
+    vm.qmp_log('blockdev-add',
+               filters=[iotests.filter_testfiles],
+               driver='file', filename=disk_path,
                node_name='imgfile')
 
     blockdev_create(vm, { 'driver': imgfmt,
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 565eebb1ab..57fe20db45 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -460,7 +460,7 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
-    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
+    def qmp_log(self, cmd, filters=[], **kwargs):
         full_cmd = OrderedDict((
             ("execute", cmd),
             ("arguments", ordered_kwargs(kwargs))
-- 
2.17.2
