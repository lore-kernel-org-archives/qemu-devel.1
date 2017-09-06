Received: from eggs.gnu.org ([2001:4830:134:3::10]:53914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc91-0004FJ-NN
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8w-0007Bw-2y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  6 Sep 2017 10:21:08 -0500
Message-Id: <20170906152111.16958-3-eblake@redhat.com>
In-Reply-To: <20170906152111.16958-1-eblake@redhat.com>
References: <20170906152111.16958-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] iotests: blacklist 194 with the luks driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

The 194 test has a lot of code that assumes a simple image file. Rewriting
this to work with luks is possible, but non-trivial, so blacklist the
luks format for now.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20170901105434.3288-3-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>
[eblake: commit message typo fixed]
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/194        | 1 +
 tests/qemu-iotests/iotests.py | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 6449b9b64a..8d973b440f 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -21,6 +21,7 @@

 import iotests

+iotests.verify_image_format(unsupported_fmts=['luks'])
 iotests.verify_platform(['linux'])

 with iotests.FilePath('source.img') as source_img_path, \
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 07fa1626a0..1af117e37d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -421,9 +421,11 @@ def notrun(reason):
     print '%s not run: %s' % (seq, reason)
     sys.exit(0)

-def verify_image_format(supported_fmts=[]):
+def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
     if supported_fmts and (imgfmt not in supported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
+    if unsupported_fmts and (imgfmt in unsupported_fmts):
+        notrun('not suitable for this image format: %s' % imgfmt)

 def verify_platform(supported_oses=['linux']):
     if True not in [sys.platform.startswith(x) for x in supported_oses]:
-- 
2.13.5
