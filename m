Received: from eggs.gnu.org ([2001:4830:134:3::10]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u9-00020A-KU
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u8-00066D-Qy
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2u8-00065A-HV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:26 +0800
Message-Id: <20181026141529.4305-7-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] tests/vm: Add a BaseVM::arch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The 'arch' property gives a hint on which architecture the guest image ru=
ns.

This can be use to select the correct QEMU binary path.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20181013004034.6968-6-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py   | 4 +++-
 tests/vm/centos      | 1 +
 tests/vm/freebsd     | 1 +
 tests/vm/netbsd      | 1 +
 tests/vm/openbsd     | 1 +
 tests/vm/ubuntu.i386 | 1 +
 6 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 81a1cb05dd..b2e0de2022 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -42,6 +42,8 @@ class BaseVM(object):
     BUILD_SCRIPT =3D ""
     # The guest name, to be overridden by subclasses
     name =3D "#base"
+    # The guest architecture, to be overridden by subclasses
+    arch =3D "#arch"
     def __init__(self, debug=3DFalse, vcpus=3DNone):
         self._guest =3D None
         self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
@@ -151,7 +153,7 @@ class BaseVM(object):
             "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
         args +=3D self._data_args + extra_args
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin =3D os.environ.get("QEMU", "qemu-system-x86_64")
+        qemu_bin =3D os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest =3D QEMUMachine(binary=3Dqemu_bin, args=3Dargs)
         try:
             guest.launch()
diff --git a/tests/vm/centos b/tests/vm/centos
index afd560c564..daa2dbca03 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -19,6 +19,7 @@ import time
=20
 class CentosVM(basevm.BaseVM):
     name =3D "centos"
+    arch =3D "x86_64"
     BUILD_SCRIPT =3D """
         set -e;
         cd $(mktemp -d);
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b6983127d0..19a3729172 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -18,6 +18,7 @@ import basevm
=20
 class FreeBSDVM(basevm.BaseVM):
     name =3D "freebsd"
+    arch =3D "x86_64"
     BUILD_SCRIPT =3D """
         set -e;
         rm -rf /var/tmp/qemu-test.*
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index a4e25820d5..fac6a7ce51 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -18,6 +18,7 @@ import basevm
=20
 class NetBSDVM(basevm.BaseVM):
     name =3D "netbsd"
+    arch =3D "x86_64"
     BUILD_SCRIPT =3D """
         set -e;
         rm -rf /var/tmp/qemu-test.*
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 52500ee52b..cfe0572c59 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -18,6 +18,7 @@ import basevm
=20
 class OpenBSDVM(basevm.BaseVM):
     name =3D "openbsd"
+    arch =3D "x86_64"
     BUILD_SCRIPT =3D """
         set -e;
         rm -rf /var/tmp/qemu-test.*
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3f6ed48b74..1b7e1ab8f0 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -19,6 +19,7 @@ import time
=20
 class UbuntuX86VM(basevm.BaseVM):
     name =3D "ubuntu.i386"
+    arch =3D "i386"
     BUILD_SCRIPT =3D """
         set -e;
         cd $(mktemp -d);
--=20
2.17.1
