Received: from eggs.gnu.org ([2001:4830:134:3::10]:45226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPaMK-0003KN-Ds
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPaMG-0003w5-NW
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gPaMG-0003tv-Hv
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:28 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 21 Nov 2018 16:48:17 -0500
Message-Id: <20181121214818.22874-2-crosa@redhat.com>
In-Reply-To: <20181121214818.22874-1-crosa@redhat.com>
References: <20181121214818.22874-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] RFC: Acceptance tests: add the build
 directory to the system PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Cleber Rosa <crosa@redhat.com>

So that when binaries such as qemu-img are searched for, those in the
build tree will be favored.  As a clarification, SRC_ROOT_DIR is
dependent on the location from where tests are executed, so they are
equal to the build directory if one is being used.

The original motivation is that Avocado libraries such as
avocado.utils.vmimage.get() may use the matching binaries, but it may
also apply to any other binary that test code may eventually attempt
to execute.

Other competing alternatives would be a more explicit path or binary
registration mechanism, in which we tell the libraries such as
avocado.utils.vmimage, the binaries to use in advance.  I think the
model proposed here is simpler though, and is not inconsistent with
the general approach of favoring the built binaries, and falling back
to binaries available in the system.  I'd love to have comments on
that, though.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 1e54fd5932..3d5190cbab 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -49,6 +49,15 @@ class Test(avocado.Test):
             self.cancel("No QEMU binary defined or found in the source t=
ree")
         self.vm =3D QEMUMachine(self.qemu_bin)
=20
+        # RFC: avocado.utils.vmimage.get() uses qemu-img, from the
+        # system's PATH, to create a snapshot.  This is a transparent,
+        # but implicit way of making sure it finds the qemu-img that
+        # matches the code being tested (as tests it indirectly too).
+        # As for the cleanup, given that in the Avocado test execution
+        # model every test is started in a different process, no
+        # cleanup is needed.
+        os.environ['PATH'] =3D '%s:%s' % (SRC_ROOT_DIR, os.environ['PATH=
'])
+
     def tearDown(self):
         if self.vm is not None:
             self.vm.shutdown()
--=20
2.19.1
