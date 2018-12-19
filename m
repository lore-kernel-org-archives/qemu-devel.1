Received: from eggs.gnu.org ([2001:4830:134:3::10]:43286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2X-00007E-CE
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2W-0004TQ-Ei
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:49 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Dec 2018 20:52:27 -0500
Message-Id: <20181219015230.18652-3-jsnow@redhat.com>
In-Reply-To: <20181219015230.18652-1-jsnow@redhat.com>
References: <20181219015230.18652-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/5] iotests: remove default filters from
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
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Only test 206 uses it, so remove it.
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
index 9aec03c7a3..55fb60e039 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -459,7 +459,7 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
-    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
+    def qmp_log(self, cmd, filters=[], **kwargs):
         full_cmd = OrderedDict({"execute": cmd,
                                 "arguments": ordered_kwargs(kwargs)})
         logmsg = json.dumps(full_cmd)
-- 
2.17.2
