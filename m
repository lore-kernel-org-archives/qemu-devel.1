Received: from eggs.gnu.org ([2001:4830:134:3::10]:41679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4UnE-0006xI-8E
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4UnC-0006VM-1V
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:36 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 12:31:52 -0400
Message-Id: <98b1ebe5189953527f93fa06bbdfa1bc1aaa0dff.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 07/10] qemu-iotests: run python tests in own
 subdirectories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

This adds the framework to iotests.py to run python iotests in a
subdirectory structure, structured like so:

scratch/
=E2=94=9C=E2=94=80=E2=94=80 TestNumber
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 TestClassName
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 t=
est_method_name

Prior to this patch, tests were run in a test subdirectory from
previous patches in the series, like this:

scratch/
=E2=94=9C=E2=94=80=E2=94=80 TestNumber

However, given the nature of python's unittest framework, additional
subdirectories are needed, if we want to insure that we can save
intermediate files in case of test failures (as we will do in a
subsequent patch) without running the risk of tainting other test
methods from the test file.

In python tests using iiotests.QMPTestCase, any reference to
'iotests.test_dir' should be replaced by 'self.workdir'.  This
may also require changing the scope of path name variables.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/iotests.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 6f05790..7ff400a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -262,6 +262,17 @@ index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
 class QMPTestCase(unittest.TestCase):
     '''Abstract base class for QMP test cases'''
=20
+    def __init__(self, *args):
+        super(QMPTestCase, self).__init__(*args)
+        self.workdir =3D os.path.join(test_dir, self.__class__.__name__,
+                                    self._testMethodName)
+        try:
+            os.makedirs(self.workdir)
+        except OSError, error:
+            if error.errno !=3D errno.EEXIST:
+                raise
+        os.chdir(self.workdir)
+
     def dictpath(self, d, path):
         '''Traverse a path in a nested dict'''
         for component in path.split('/'):
--=20
2.9.5
