Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUzd-0002Q4-6h
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUzc-0004S1-Fp
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:43:17 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 21:43:01 +0200
Message-Id: <20180509194302.21585-5-mreitz@redhat.com>
In-Reply-To: <20180509194302.21585-1-mreitz@redhat.com>
References: <20180509194302.21585-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] iotests.py: Add qemu_io_silent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

With qemu-io now returning a useful exit code, some tests may find it
sufficient to just query that instead of logging (and filtering) the
whole output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
