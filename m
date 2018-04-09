Received: from eggs.gnu.org ([2001:4830:134:3::10]:55016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5j-0007gU-Mx
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5i-0002eM-T9
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f5R5i-0002eB-PH
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:50 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  9 Apr 2018 15:19:32 +0800
Message-Id: <20180409071934.20845-3-famz@redhat.com>
In-Reply-To: <20180409071934.20845-1-famz@redhat.com>
References: <20180409071934.20845-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] tests: Fix ubuntu.i386 image initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>

The apt-get commands we run through ssh expect certain features of the
tty, and refuses to work if /dev/null is used. It is ugly, but easy to
satisfy.

Actually, there is no reason to hide the output. It just makes things
harder to diagnose. We can always redirect in the Makefile, so don't do
it conditionally here.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180322034753.6301-1-famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Eric Blake <eblake@redhat.com>
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
         ssh_cmd +=3D ["%s@127.0.0.1" % user] + list(cmd)
         logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
-        r =3D subprocess.call(ssh_cmd,
-                            stdin=3Dsys.stdin if interactive else self._=
devnull,
-                            stdout=3Dsys.stdout if interactive else self=
._stdout,
-                            stderr=3Dsys.stderr if interactive else self=
._stderr)
+        r =3D subprocess.call(ssh_cmd)
         if check and r !=3D 0:
             raise Exception("SSH command failed: %s" % cmd)
         return r
--=20
2.14.3
