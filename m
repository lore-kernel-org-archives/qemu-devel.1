Received: from eggs.gnu.org ([2001:4830:134:3::10]:36192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5VDk-00067q-SV
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5VDh-0001Cc-RV
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:44:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Apr 2018 14:44:17 +0300
Message-Id: <20180409114418.16615-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180409114418.16615-1-vsementsov@virtuozzo.com>
References: <20180409114418.16615-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/2] iotests.py: improve verify_image_format
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com

Support "generic" formats like in bash tests with their
   _supported_fmt generic
The test, supporting "generic" formats will run if IMGFMT_GENERIC =
true, which is default, except for bochs and cloop. However, you can
use verify_image_format(['generic', 'bochs']), which will run for all
except cloop (for this moment).

Also, add an assert (we don't want set both arguments) and remove
duplication.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b5d7945af8..1a2b83893c 100644
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
2.11.1
