Received: from eggs.gnu.org ([2001:4830:134:3::10]:51744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecXAe-0004Vh-GF
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecXAa-0004PS-Ic
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:28 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 19 Jan 2018 16:57:18 +0300
Message-Id: <20180119135719.24745-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180119135719.24745-1-vsementsov@virtuozzo.com>
References: <20180119135719.24745-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 4/5] iotests: implement QemuIoInteractive
 class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Implement QemuIoInteractive to test nbd-server-remove command when
there are active connections.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 44477e9295..5a10b2d534 100644
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
2.11.1
