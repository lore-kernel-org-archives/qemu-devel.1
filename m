Received: from eggs.gnu.org ([209.51.188.92]:54745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcQ-0002d4-81
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcJ-0003QS-NG
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:11 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  1 Feb 2019 19:55:55 -0500
Message-Id: <20190202005610.24048-6-crosa@redhat.com>
In-Reply-To: <20190202005610.24048-1-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/20] Acceptance tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

It's useful to define the architecture that should be used in
situations such as:
 * the intended target of the QEMU binary to be used on tests
 * the architecture of code to be run within the QEMU binary, such
   as a kernel image or a full blown guest OS image

This commit introduces both a test parameter and a test instance
attribute, that will contain such a value.

Now, when the "arch" test parameter is given, it will influence the
selection of the default QEMU binary, if one is not given explicitly
by means of the "qemu_img" parameter.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst                    | 17 +++++++++++++++++
 tests/acceptance/avocado_qemu/__init__.py | 14 +++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 44c9b3ae74..d37c4b0e77 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -689,6 +689,16 @@ vm
 A QEMUMachine instance, initially configured according to the given
 ``qemu_bin`` parameter.
=20
+arch
+~~~~
+
+The architecture that will be used on a number of different
+scenarios.  For instance, when a QEMU binary is not explicitly given,
+the one selected will depend on this attribute.
+
+The ``arch`` attribute will be set to the test parameter of the same
+name, and if one is not given explicitly, it will be set to ``None``.
+
 qemu_bin
 ~~~~~~~~
=20
@@ -711,6 +721,13 @@ like the following:
=20
   PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-system=
-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
=20
+arch
+~~~~
+
+The architecture that will be used on a number of different scenarios.
+This parameter has a direct relation with the ``arch`` attribute.  If
+not given, it will default to None.
+
 qemu_bin
 ~~~~~~~~
=20
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index d8d5b48dac..f580582602 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -23,16 +23,22 @@ def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
=20
=20
-def pick_default_qemu_bin():
+def pick_default_qemu_bin(arch=3DNone):
     """
     Picks the path of a QEMU binary, starting either in the current work=
ing
     directory or in the source tree root directory.
=20
+    :param arch: the arch to use when looking for a QEMU binary (the tar=
get
+                 will match the arch given).  If None (the default) arch
+                 will be the current host system arch (as given by
+                 :func:`os.uname`).
+    :type arch: str
     :returns: the path to the default QEMU binary or None if one could n=
ot
               be found
     :rtype: str or None
     """
-    arch =3D os.uname()[4]
+    if arch is None:
+        arch =3D os.uname()[4]
     qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
                                           "qemu-system-%s" % arch)
     if is_readable_executable_file(qemu_bin_relative_path):
@@ -47,8 +53,10 @@ def pick_default_qemu_bin():
 class Test(avocado.Test):
     def setUp(self):
         self.vm =3D None
+        self.arch =3D self.params.get('arch')
+        default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
-                                        default=3Dpick_default_qemu_bin(=
))
+                                        default=3Ddefault_qemu_bin)
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source t=
ree")
         self.vm =3D QEMUMachine(self.qemu_bin)
--=20
2.20.1
