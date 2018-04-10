Received: from eggs.gnu.org ([2001:4830:134:3::10]:51716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLS-0002Rc-Fr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLR-0006Fn-Cj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Apr 2018 17:37:44 +0200
Message-Id: <20180410153748.22505-4-kwolf@redhat.com>
In-Reply-To: <20180410153748.22505-1-kwolf@redhat.com>
References: <20180410153748.22505-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] iotests.py: improve verify_image_format
 helper
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Support "generic" formats like in bash tests with their
   _supported_fmt generic
The test, supporting "generic" formats will run if IMGFMT_GENERIC =
true, which is default, except for bochs and cloop. However, you can
use verify_image_format(['generic', 'bochs']), which will run for all
except cloop (for this moment).

Also, add an assert (we don't want set both arguments) and remove
duplication.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 1623257e32..97131b1f86 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -532,9 +532,17 @@ def notrun(reason):
     sys.exit(0)
 
 def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
-    if supported_fmts and (imgfmt not in supported_fmts):
-        notrun('not suitable for this image format: %s' % imgfmt)
-    if unsupported_fmts and (imgfmt in unsupported_fmts):
+    assert not (supported_fmts and unsupported_fmts)
+
+    if 'generic' in supported_fmts and \
+            os.environ.get('IMGFMT_GENERIC', 'true') == 'true':
+        # similar to
+        #   _supported_fmt generic
+        # for bash tests
+        return
+
+    not_sup = supported_fmts and (imgfmt not in supported_fmts)
+    if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
 
 def verify_platform(supported_oses=['linux']):
-- 
2.13.6
