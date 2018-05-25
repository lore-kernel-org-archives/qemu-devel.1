Received: from eggs.gnu.org ([2001:4830:134:3::10]:54434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfN-0000xf-VP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfJ-0002sA-Ll
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 25 May 2018 18:33:20 +0200
Message-Id: <20180525163327.23097-8-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-1-kwolf@redhat.com>
References: <20180525163327.23097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] qemu-iotests: Add iotests.img_info_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This adds a filter function to postprocess 'qemu-img info' input
(similar to what _img_info does), and an img_info_log() function that
calls 'qemu-img info' and logs the filtered output.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 319d898172..20ce5a0cf0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -109,6 +109,10 @@ def qemu_img_pipe(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return subp.communicate()[0]
 
+def img_info_log(filename):
+    output = qemu_img_pipe('info', '-f', imgfmt, filename)
+    log(filter_img_info(output, filename))
+
 def qemu_io(*args):
     '''Run qemu-io and return the stdout data'''
     args = qemu_io_args + list(args)
@@ -210,6 +214,18 @@ def filter_testfiles(msg):
     prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
     return msg.replace(prefix, 'TEST_DIR/')
 
+def filter_img_info(output, filename):
+    lines = []
+    for line in output.split('\n'):
+        if 'disk size' in line or 'actual size' in line:
+            continue
+        line = line.replace(filename, 'TEST_DIR/t.IMGFMT') \
+                   .replace(imgfmt, 'IMGFMT')
+        line = re.sub('iters: [0-9]+', 'iters: XXX', line)
+        line = re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', line)
+        lines.append(line)
+    return '\n'.join(lines)
+
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
-- 
2.13.6
