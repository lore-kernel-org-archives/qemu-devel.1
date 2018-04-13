Received: from eggs.gnu.org ([2001:4830:134:3::10]:37415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74Ky-000593-Lf
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74Kx-0001v1-Ki
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:20 -0400
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 13 Apr 2018 22:26:04 +0300
Message-Id: <20180413192605.2145-3-nirsof@gmail.com>
In-Reply-To: <20180413192605.2145-1-nirsof@gmail.com>
References: <20180413192605.2145-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] iotests.py: Add helper for running commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

Add few helpers for running external commands:

- CommandFailed: exception, keeping all the info related to a failed
  command, and providing a useful error message. (Unfortunately
  subprocess.CalledProcessError does not).

- run(): run a command collecting output from the underlying process
  stdout and stderr, returning the command output or raising
  CommandFailed.

These helpers will be used by new qemu-nbd tests. And later can be used
to cleanup helpers for running qemu-* tools in iotests.py.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 tests/qemu-iotests/iotests.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b25d48a91b..0f8abf99cb 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -64,6 +64,24 @@ luks_default_secret_object = 'secret,id=keysec0,data=' + \
                              os.environ['IMGKEYSECRET']
 luks_default_key_secret_opt = 'key-secret=keysec0'
 
+class CommandFailed(Exception):
+
+    def __init__(self, cmd, rc, out, err):
+        self.cmd = cmd
+        self.rc = rc
+        self.out = out
+        self.err = err
+
+    def __str__(self):
+        return ("Command {self.cmd} failed: rc={self.rc}, out={self.out!r}, "
+                "err={self.err!r}").format(self=self)
+
+def run(*args):
+    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    out, err = p.communicate()
+    if p.returncode != 0:
+        raise CommandFailed(args, p.returncode, out, err)
+    return out
 
 def qemu_img(*args):
     '''Run qemu-img and return the exit code'''
-- 
2.14.3
