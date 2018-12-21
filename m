Received: from eggs.gnu.org ([2001:4830:134:3::10]:47609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gaUWN-00059T-7W
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 18:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gaUWM-0004pe-GJ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 18:47:59 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 22 Dec 2018 00:47:48 +0100
Message-Id: <20181221234750.23577-2-mreitz@redhat.com>
In-Reply-To: <20181221234750.23577-1-mreitz@redhat.com>
References: <20181221234750.23577-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] iotests.py: Add qemu_nbd_pipe()
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

In some cases, we may want to deal with qemu-nbd errors (e.g. by
launching it in a different configuration until it no longer throws
any).  In that case, we do not want its output ending up in the test
output.

It may still be useful for handling the error, though, so add a new
function that works basically like qemu_nbd(), only that it returns the
qemu-nbd output instead of making it end up in the log.  In contrast to
qemu_img_pipe(), it does still return the exit code as well, though,
because that is even more important for error handling.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index d537538ba0..9c3eb9e2f8 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -190,6 +190,20 @@ def qemu_nbd(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
     return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
=20
+def qemu_nbd_pipe(*args):
+    '''Run qemu-nbd in daemon mode and return both the parent's exit cod=
e
+       and its output'''
+    subp =3D subprocess.Popen(qemu_nbd_args + ['--fork'] + list(args),
+                            stdout=3Dsubprocess.PIPE,
+                            stderr=3Dsubprocess.STDOUT,
+                            universal_newlines=3DTrue)
+    exitcode =3D subp.wait()
+    if exitcode < 0:
+        sys.stderr.write('qemu-nbd received signal %i: %s\n' %
+                         (-exitcode,
+                          ' '.join(qemu_nbd_args + ['--fork'] + list(arg=
s))))
+    return exitcode, subp.communicate()[0]
+
 def compare_images(img1, img2, fmt1=3Dimgfmt, fmt2=3Dimgfmt):
     '''Return True if two image files are identical'''
     return qemu_img('compare', '-f', fmt1,
--=20
2.19.2
