Received: from eggs.gnu.org ([2001:4830:134:3::10]:45375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLF1L-0006xE-1k
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLF1F-00056s-5p
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:12:51 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 17:12:12 -0500
Message-Id: <20181109221213.7310-2-crosa@redhat.com>
In-Reply-To: <20181109221213.7310-1-crosa@redhat.com>
References: <20181109221213.7310-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 1/2] Acceptance Tests: add QemuImgTest base
 class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Testing other utilities such as qemu-img do not require the same
infrastructure that testing QEMU itself does.  Let's add a base class
that just sets the suitable qemu-img binary to be used during test.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 1e54fd5932..dfd147b7e2 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -40,6 +40,20 @@ def pick_default_qemu_bin():
         return qemu_bin_from_src_dir_path
=20
=20
+def pick_default_qemu_img_bin():
+    """
+    Picks the path of a QEMU binary, starting either in the current work=
ing
+    directory or in the source tree root directory.
+    """
+    qemu_img_bin_local =3D os.path.abspath("qemu-img")
+    if is_readable_executable_file(qemu_img_bin_local):
+        return qemu_img_bin_local
+
+    qemu_img_bin_from_src_dir_path =3D os.path.join(SRC_ROOT_DIR, "qemu-=
img")
+    if is_readable_executable_file(qemu_img_bin_from_src_dir_path):
+        return qemu_img_bin_from_src_dir_path
+
+
 class Test(avocado.Test):
     def setUp(self):
         self.vm =3D None
@@ -52,3 +66,9 @@ class Test(avocado.Test):
     def tearDown(self):
         if self.vm is not None:
             self.vm.shutdown()
+
+
+class QemuImgTest(avocado.Test):
+    def setUp(self):
+        self.qemu_img_bin =3D self.params.get('qemu_img_bin',
+                                            default=3Dpick_default_qemu_=
img_bin())
--=20
2.19.1
