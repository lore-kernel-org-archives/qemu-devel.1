Received: from eggs.gnu.org ([2001:4830:134:3::10]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6c6-0001r8-TC
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6c3-00084M-2e
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:12:26 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 26 Jan 2018 10:04:08 -0600
Message-Id: <20180126160411.4033-6-eblake@redhat.com>
In-Reply-To: <20180126160411.4033-1-eblake@redhat.com>
References: <20180126160411.4033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] iotests: implement QemuIoInteractive class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Implement QemuIoInteractive to test nbd-server-remove command when
there are active connections.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180119135719.24745-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 44477e92958..5a10b2d5345 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -93,6 +93,44 @@ def qemu_io(*args):
         sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode, ' '.join(args)))
     return subp.communicate()[0]

+
+class QemuIoInteractive:
+    def __init__(self, *args):
+        self.args = qemu_io_args + list(args)
+        self._p = subprocess.Popen(self.args, stdin=subprocess.PIPE,
+                                   stdout=subprocess.PIPE,
+                                   stderr=subprocess.STDOUT)
+        assert self._p.stdout.read(9) == 'qemu-io> '
+
+    def close(self):
+        self._p.communicate('q\n')
+
+    def _read_output(self):
+        pattern = 'qemu-io> '
+        n = len(pattern)
+        pos = 0
+        s = []
+        while pos != n:
+            c = self._p.stdout.read(1)
+            # check unexpected EOF
+            assert c != ''
+            s.append(c)
+            if c == pattern[pos]:
+                pos += 1
+            else:
+                pos = 0
+
+        return ''.join(s[:-n])
+
+    def cmd(self, cmd):
+        # quit command is in close(), '\n' is added automatically
+        assert '\n' not in cmd
+        cmd = cmd.strip()
+        assert cmd != 'q' and cmd != 'quit'
+        self._p.stdin.write(cmd + '\n')
+        return self._read_output()
+
+
 def qemu_nbd(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
     return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
-- 
2.14.3
