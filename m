Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyrCw-0000pt-4u
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyrCt-0003x7-2D
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:48:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eyrCs-0003x1-Sq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:48:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 22 Mar 2018 11:47:53 +0800
Message-Id: <20180322034753.6301-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Fix ubuntu.i386 image initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The apt-get commands we run through ssh expect certain features of the
tty, and refuses to work if /dev/null is used. It is ugly, but easy to
satisfy.

Actually, there is no reason to hide the output. It just makes things
harder to diagnose. We can always redirect in the Makefile, so don't do
it conditionally here.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 686d88decf..3a2d508c35 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -107,10 +107,7 @@ class BaseVM(object):
         assert not isinstance(cmd, str)
         ssh_cmd += ["%s@127.0.0.1" % user] + list(cmd)
         logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
-        r = subprocess.call(ssh_cmd,
-                            stdin=sys.stdin if interactive else self._devnull,
-                            stdout=sys.stdout if interactive else self._stdout,
-                            stderr=sys.stderr if interactive else self._stderr)
+        r = subprocess.call(ssh_cmd)
         if check and r != 0:
             raise Exception("SSH command failed: %s" % cmd)
         return r
-- 
2.14.3
