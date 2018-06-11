Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmW-0004h9-Jr
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmU-0001or-RN
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:58 +0200
Message-Id: <20180611142611.6609-17-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 16/29] iotests.py: Add qemu_io_silent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

With qemu-io now returning a useful exit code, some tests may find it
sufficient to just query that instead of logging (and filtering) the
whole output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509194302.21585-5-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index fdbdd8b300..0b204dc220 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -133,6 +133,15 @@ def qemu_io(*args):
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
2.17.1
