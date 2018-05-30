Received: from eggs.gnu.org ([2001:4830:134:3::10]:55568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3TF-0007fy-4Y
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3TE-0006u4-Bg
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 30 May 2018 17:56:40 +0200
Message-Id: <20180530155647.14090-11-kwolf@redhat.com>
In-Reply-To: <20180530155647.14090-1-kwolf@redhat.com>
References: <20180530155647.14090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/17] qemu-iotests: iotests.py helper for
 non-file protocols
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This adds two helper functions that are useful for test cases that make
use of a non-file protocol (specifically ssh).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/iotests.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8b612cb891..bc8f404ac2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -303,6 +303,13 @@ def file_path(*names):
 
     return paths[0] if len(paths) == 1 else paths
 
+def remote_filename(path):
+    if imgproto == 'file':
+        return path
+    elif imgproto == 'ssh':
+        return "ssh://127.0.0.1%s" % (path)
+    else:
+        raise Exception("Protocol %s not supported" % (imgproto))
 
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
@@ -601,6 +608,16 @@ def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
 
+def verify_protocol(supported=[], unsupported=[]):
+    assert not (supported and unsupported)
+
+    if 'generic' in supported:
+        return
+
+    not_sup = supported and (imgproto not in supported)
+    if not_sup or (imgproto in unsupported):
+        notrun('not suitable for this protocol: %s' % imgproto)
+
 def verify_platform(supported_oses=['linux']):
     if True not in [sys.platform.startswith(x) for x in supported_oses]:
         notrun('not suitable for this OS: %s' % sys.platform)
-- 
2.13.6
