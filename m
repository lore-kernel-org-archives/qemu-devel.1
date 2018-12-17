Received: from eggs.gnu.org ([2001:4830:134:3::10]:41943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gYwf5-0006av-B6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gYwf0-0002A5-Ij
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:26:35 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 17 Dec 2018 20:26:26 +0300
Message-Id: <20181217172626.34501-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] iotests.py: rework log and qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com

There are several problems to be solved:

1. log() may try to apply filters (which should be
   str -> str functions) to objects, which is not correct. Let's
   instead do json.dumps first and then apply filters.

2. Let's drop trailing whitespaces, if there are any. Hopefully, now
   only two tests have trailing whitespaces, both bash-based: 130, 181.

3. qmp_log() do json.dumps() separately and call log(), when log() can
   print objects too. It's obviously a duplication, let's instead pass
   objects from qmp_log to log

4. qmp_log may produce lines exceeding 998 characters, which is
   unfriendly to git send-email. To fix it, let's use pretty json
   output, by setting indent parameter of json.dumps. Note that with
   that parameter, dumps may produce lines with trailing whitespaces,
   so [2.] becomes very necessary.
   It may be a good thing (keeping in mind, that putting large objects
   to log() will lead to the same problem), to prettify all json in
   tests output, but it would be very large patch, hard to review. So,
   let's keep qmp_log_depr for old behavior and don't prettify log()
   output by default.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/206        |  4 ++--
 tests/qemu-iotests/207        |  2 +-
 tests/qemu-iotests/210        | 12 ++++++------
 tests/qemu-iotests/211        |  4 ++--
 tests/qemu-iotests/212        |  4 ++--
 tests/qemu-iotests/213        |  4 ++--
 tests/qemu-iotests/iotests.py | 28 ++++++++++++++++++++--------
 7 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 128c334c7c..cc5b5098ce 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -26,7 +26,7 @@ from iotests import imgfmt
 iotests.verify_image_format(supported_fmts=['qcow2'])
 
 def blockdev_create(vm, options):
-    result = vm.qmp_log('blockdev-create', job_id='job0', options=options)
+    result = vm.qmp_log_depr('blockdev-create', job_id='job0', options=options)
 
     if 'return' in result:
         assert result['return'] == {}
@@ -52,7 +52,7 @@ with iotests.FilePath('t.qcow2') as disk_path, \
                           'filename': disk_path,
                           'size': 0 })
 
-    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
+    vm.qmp_log_depr('blockdev-add', driver='file', filename=disk_path,
                node_name='imgfile')
 
     blockdev_create(vm, { 'driver': imgfmt,
diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index c617ee7453..f5b74e5bfb 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -31,7 +31,7 @@ def filter_hash(msg):
     return re.sub('"hash": "[0-9a-f]+"', '"hash": HASH', msg)
 
 def blockdev_create(vm, options):
-    result = vm.qmp_log('blockdev-create', job_id='job0', options=options,
+    result = vm.qmp_log_depr('blockdev-create', job_id='job0', options=options,
                         filters=[iotests.filter_testfiles, filter_hash])
 
     if 'return' in result:
diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index d142841e2b..b06232861e 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=['luks'])
 iotests.verify_protocol(supported=['file'])
 
 def blockdev_create(vm, options):
-    result = vm.qmp_log('blockdev-create', job_id='job0', options=options)
+    result = vm.qmp_log_depr('blockdev-create', job_id='job0', options=options)
 
     if 'return' in result:
         assert result['return'] == {}
@@ -52,7 +52,7 @@ with iotests.FilePath('t.luks') as disk_path, \
                           'filename': disk_path,
                           'size': 0 })
 
-    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
+    vm.qmp_log_depr('blockdev-add', driver='file', filename=disk_path,
                node_name='imgfile')
 
     blockdev_create(vm, { 'driver': imgfmt,
@@ -170,10 +170,10 @@ with iotests.FilePath('t.luks') as disk_path, \
 
     vm.add_blockdev('driver=luks,file=node0,key-secret=keysec0,node-name=node1')
     vm.launch()
-    vm.qmp_log('block_resize', node_name='node1', size=9223372036854775296)
-    vm.qmp_log('block_resize', node_name='node1', size=9223372036854775808)
-    vm.qmp_log('block_resize', node_name='node1', size=18446744073709551104)
-    vm.qmp_log('block_resize', node_name='node1', size=-9223372036854775808)
+    vm.qmp_log_depr('block_resize', node_name='node1', size=9223372036854775296)
+    vm.qmp_log_depr('block_resize', node_name='node1', size=9223372036854775808)
+    vm.qmp_log_depr('block_resize', node_name='node1', size=18446744073709551104)
+    vm.qmp_log_depr('block_resize', node_name='node1', size=-9223372036854775808)
     vm.shutdown()
 
     # TODO Proper support for images to be used with imgopts and/or protocols
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 7b7985db6c..c791499659 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=['vdi'])
 iotests.verify_protocol(supported=['file'])
 
 def blockdev_create(vm, options):
-    result = vm.qmp_log('blockdev-create', job_id='job0', options=options)
+    result = vm.qmp_log_depr('blockdev-create', job_id='job0', options=options)
 
     if 'return' in result:
         assert result['return'] == {}
@@ -50,7 +50,7 @@ with iotests.FilePath('t.vdi') as disk_path, \
                           'filename': disk_path,
                           'size': 0 })
 
-    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
+    vm.qmp_log_depr('blockdev-add', driver='file', filename=disk_path,
                node_name='imgfile')
 
     blockdev_create(vm, { 'driver': imgfmt,
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index 95c8810d83..6fbe2c278d 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=['parallels'])
 iotests.verify_protocol(supported=['file'])
 
 def blockdev_create(vm, options):
-    result = vm.qmp_log('blockdev-create', job_id='job0', options=options)
+    result = vm.qmp_log_depr('blockdev-create', job_id='job0', options=options)
 
     if 'return' in result:
         assert result['return'] == {}
@@ -50,7 +50,7 @@ with iotests.FilePath('t.parallels') as disk_path, \
                           'filename': disk_path,
                           'size': 0 })
 
-    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
+    vm.qmp_log_depr('blockdev-add', driver='file', filename=disk_path,
                node_name='imgfile')
 
     blockdev_create(vm, { 'driver': imgfmt,
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 4054439e3c..8f854417e3 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=['vhdx'])
 iotests.verify_protocol(supported=['file'])
 
 def blockdev_create(vm, options):
-    result = vm.qmp_log('blockdev-create', job_id='job0', options=options)
+    result = vm.qmp_log_depr('blockdev-create', job_id='job0', options=options)
 
     if 'return' in result:
         assert result['return'] == {}
@@ -50,7 +50,7 @@ with iotests.FilePath('t.vhdx') as disk_path, \
                           'filename': disk_path,
                           'size': 0 })
 
-    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
+    vm.qmp_log_depr('blockdev-add', driver='file', filename=disk_path,
                node_name='imgfile')
 
     blockdev_create(vm, { 'driver': imgfmt,
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index d537538ba0..8f1ea23ef7 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -251,13 +251,17 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
-def log(msg, filters=[]):
+def log(msg, filters=[], indent=None):
+    if type(msg) is dict or type(msg) is list:
+        msg = json.dumps(msg, sort_keys=True, indent=indent)
+
     for flt in filters:
         msg = flt(msg)
-    if type(msg) is dict or type(msg) is list:
-        print(json.dumps(msg, sort_keys=True))
-    else:
-        print(msg)
+
+    # drop trailing whitespaces
+    msg = re.sub(r'[ \t]+$', '', msg, flags=re.MULTILINE)
+
+    print(msg)
 
 class Timeout:
     def __init__(self, seconds, errmsg = "Timeout"):
@@ -444,7 +448,9 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
-    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
+    # qmp_log_depr is deprecated.
+    # TODO: replace all it's usage cases with qmp_log, and drop the definition.
+    def qmp_log_depr(self, cmd, filters=[filter_testfiles], **kwargs):
         logmsg = '{"execute": "%s", "arguments": %s}' % \
             (cmd, json.dumps(kwargs, sort_keys=True))
         log(logmsg, filters)
@@ -452,6 +458,12 @@ class VM(qtest.QEMUQtestMachine):
         log(json.dumps(result, sort_keys=True), filters)
         return result
 
+    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
+        log({'execute': cmd, 'arguments': kwargs}, filters, indent=2)
+        result = self.qmp(cmd, **kwargs)
+        log(result, filters, indent=2)
+        return result
+
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
         while True:
             for ev in self.get_qmp_events_filtered(wait=True):
@@ -463,9 +475,9 @@ class VM(qtest.QEMUQtestMachine):
                             if j['id'] == job:
                                 log('Job failed: %s' % (j['error']))
                     elif status == 'pending' and not auto_finalize:
-                        self.qmp_log('job-finalize', id=job)
+                        self.qmp_log_depr('job-finalize', id=job)
                     elif status == 'concluded' and not auto_dismiss:
-                        self.qmp_log('job-dismiss', id=job)
+                        self.qmp_log_depr('job-dismiss', id=job)
                     elif status == 'null':
                         return
                 else:
-- 
2.18.0
