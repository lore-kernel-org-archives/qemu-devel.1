Received: from eggs.gnu.org ([2001:4830:134:3::10]:42989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd5-0003AT-EZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd3-0000dB-GZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:19 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:43 +0300
Message-Id: <20180426161958.2872-3-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 02/17] iotests: iotests.py: prevent deadlock in
 subprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

A subprocess whose std{out,err} is subprocess.PIPE may block writing its
output, so .wait() should not be called on it until the pipes are read
completely on the caller's side.

Subprocess.communicate takes care of this.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b25d48a91b..e2abf0cb53 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -104,20 +104,20 @@ def qemu_img_pipe(*args):
     subp = subprocess.Popen(qemu_img_args + list(args),
                             stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)
-    exitcode = subp.wait()
-    if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
-    return subp.communicate()[0]
+    output = subp.communicate()[0]
+    if subp.returncode < 0:
+        sys.stderr.write('qemu-img received signal %i: %s\n' % (-subp.returncode, ' '.join(qemu_img_args + list(args))))
+    return output
 
 def qemu_io(*args):
     '''Run qemu-io and return the stdout data'''
     args = qemu_io_args + list(args)
     subp = subprocess.Popen(args, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)
-    exitcode = subp.wait()
-    if exitcode < 0:
-        sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode, ' '.join(args)))
-    return subp.communicate()[0]
+    output = subp.communicate()[0]
+    if subp.returncode < 0:
+        sys.stderr.write('qemu-io received signal %i: %s\n' % (-subp.returncode, ' '.join(args)))
+    return output
 
 
 class QemuIoInteractive:
-- 
2.14.3
