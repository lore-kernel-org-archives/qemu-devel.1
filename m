Received: from eggs.gnu.org ([2001:4830:134:3::10]:47239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySW-0003bo-W3
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySU-0008BI-0z
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:36 -0500
Received: from [195.214.232.25] (port=27764 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eMyST-00087I-JI
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:33 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Dec 2017 18:51:01 +0300
Message-Id: <20171207155102.66622-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-1-vsementsov@virtuozzo.com>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 5/6] iotests: implement QemuIoInteractive
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
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6f057904a9..a9f312db83 100644
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
+            #check unexpected EOF
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
