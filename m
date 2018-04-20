Received: from eggs.gnu.org ([2001:4830:134:3::10]:38601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afh-00066B-MU
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afc-0001rv-O1
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9afc-0001qX-G1
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:37 -0300
Message-Id: <20180420181951.7252-11-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 10/24] avocado_qemu: Add support to request image
 for testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

Some of the tests require (usually bootable) image to be executed, let's
add a helper function which uses the default params to define the image
or provides useful default and explains what's going on in case the
image is not available.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/README.rst           | 12 ++++++-----
 tests/avocado/avocado_qemu/test.py | 44 ++++++++++++++++++++++++++++++++=
------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/tests/avocado/README.rst b/tests/avocado/README.rst
index f0e703fe06..07852e790a 100644
--- a/tests/avocado/README.rst
+++ b/tests/avocado/README.rst
@@ -59,14 +59,16 @@ file using the Avocado parameters system:
 - ``arch``: Probe the Qemu binary from a given architecture. It has no
   effect if ``qemu_bin`` is specified. If not provided, the binary probe
   will use the system architecture. Example: ``arch: x86_64``
-- ``image_path``: VMs are defined without image. If the ``image_path``
-  is specified, it will be used as the VM image. The ``-snapshot``
-  option will then be used to avoid writing into the image. Example:
-  ``image_path: /var/lib/images/fedora-25.img``
+- ``image_path``: When a test requires (usually a bootable) image, this
+  parameter is used to define where the image is located. When undefined
+  it uses ``$QEMU_ROOT/bootable_image_$arch.qcow2``. The image is added
+  to the qemu command __only__ when the test requires an image. By
+  default ``,snapshot=3Don`` is used, but it can be altered by
+  ``image_snapshot`` parameter.
 - ``image_user`` and ``image_pass``: When using a ``image_path``, if you
   want to get the console from the Guest OS you have to define the Guest
   OS credentials. Example: ``image_user: root`` and
-  ``image_pass: p4ssw0rd``
+  ``image_pass: p4ssw0rd``. By default it uses ``root`` and ``123456``.
 - ``machine_type``: Use this option to define a machine type for the VM.
   Example: ``machine_type: pc``
 - ``machine_accel``: Use this option to define a machine acceleration
diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_q=
emu/test.py
index 966936a52f..57c63b2853 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -39,8 +39,10 @@ from avocado.utils import network
 from avocado.utils import process
 from avocado.utils import path as utils_path
 from avocado.utils import wait
-sys.path.append(os.path.join(os.path.dirname(__file__),
-                             '..', '..', '..', 'scripts'))
+
+QEMU_ROOT =3D os.path.abspath(os.path.dirname(os.path.dirname(os.path.di=
rname(
+    os.path.dirname(__file__)))))
+sys.path.append(os.path.join(QEMU_ROOT, 'scripts'))
 import qemu
=20
=20
@@ -360,11 +362,6 @@ class QemuTest(Test):
                       password=3Dself.params.get('image_pass', default=3D=
"123456"),
                       qemu_dst_bin=3Dself.params.get('qemu_dst_bin'))
=20
-        self.vm.image =3D self.params.get('image_path')
-        if self.vm.image is not None:
-            self.vm.args.extend(['-drive', 'file=3D%s' % self.vm.image])
-            self.vm.args.append('-snapshot')
-
         machine_type =3D self.params.get('machine_type')
         machine_accel =3D self.params.get('machine_accel')
         machine_kvm_type =3D self.params.get('machine_kvm_type')
@@ -377,3 +374,36 @@ class QemuTest(Test):
             machine +=3D "kvm-type=3D%s," % machine_kvm_type
         if machine:
             self.vm.args.extend(['-machine', machine])
+
+    def request_image(self, path=3DNone, snapshot=3DNone, extra=3DNone):
+        """
+        Add image to the `self.vm` using params or arguments.
+
+        Unless it's overridden by arguments it uses following test param=
s
+        to specify the image:
+
+        * image_path - defines the path to the user-image. If not specif=
ied
+                       it uses "QEMU_ROOT/boot_image_$arch.qcow2"
+        * image_snapshot - whether to use "snapshot=3Don" (snapshot=3Dof=
f is not
+                           supplied)
+        * image_extra - free-form string to extend the "-drive" params
+
+        :param path: Override the path ("image_path" param is used other=
wise)
+        :param snapshot: Override the usage of snapshot
+        :param extra: Extra arguments to be added to drive definition
+        """
+        if snapshot is None:
+            snapshot =3D self.params.get("image_snapshot", default=3DTru=
e)
+        if extra is None:
+            extra =3D self.params.get("image_extra", default=3D"")
+        if path is None:
+            path =3D self.params.get("image_path")
+            if path is None:
+                arch =3D self.vm.arch
+                path =3D os.path.join(QEMU_ROOT, "boot_image_%s.qcow2" %=
 arch)
+        if not os.path.exists(path):
+            self.error("Require a bootable image, which was not found. "
+                       "Please provide one in '%s'." % path)
+        if snapshot:
+            extra +=3D ",snapshot=3Don"
+        self.vm.args.extend(['-drive', 'file=3D%s%s' % (path, extra)])
--=20
2.14.3
