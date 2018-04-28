Received: from eggs.gnu.org ([2001:4830:134:3::10]:46793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCR2k-0003um-OE
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 10:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCR2j-0004nk-Vs
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 10:41:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 28 Apr 2018 16:41:22 +0200
Message-Id: <20180428144123.30333-5-mreitz@redhat.com>
In-Reply-To: <20180428144123.30333-1-mreitz@redhat.com>
References: <20180428144123.30333-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] iotests.py: Add qemu_io_silent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

With qemu-io now returning a useful exit code, some tests may find it
sufficient to just query that instead of logging (and filtering) the
whole output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b25d48a91b..9747ca9eba 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -119,6 +119,15 @@ def qemu_io(*args):
         sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode, ' '.join(args)))
     return subp.communicate()[0]
 
+def qemu_io_silent(*args):
+    '''Run qemu-io and return the exit code, suppressing stdout'''
+    args = qemu_io_args + list(args)
+    exitcode = subprocess.call(args, stdout=open('/dev/null', 'w'))
+    if exitcode < 0:
+        sys.stderr.write('qemu-io received signal %i: %s\n' %
+                         (-exitcode, ' '.join(args)))
+    return exitcode
+
 
 class QemuIoInteractive:
     def __init__(self, *args):
-- 
2.14.3
