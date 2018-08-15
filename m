Received: from eggs.gnu.org ([2001:4830:134:3::10]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmF2-0006vF-7m
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmF1-0000dr-8d
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmF1-0000dV-0k
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:12:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:32 +0800
Message-Id: <20180815031248.14908-2-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/17] tests/vm: Only use -cpu 'host' if KVM is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

If KVM is not available, then use the 'max' cpu.

This fixes:

  ERROR:root:Log:
  ERROR:root:qemu-system-x86_64: CPU model 'host' requires KVM
  Failed to prepare guest environment
  error: [Errno 104] Connection reset by peer
  source/qemu/tests/vm/Makefile.include:25: recipe for target 'tests/vm/u=
buntu.i386.img' failed
  make: *** [tests/vm/ubuntu.i386.img] Error 2

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180628153535.1411-4-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3643117816..d80cc8ab85 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -65,7 +65,6 @@ class BaseVM(object):
             self._stdout =3D self._devnull
         self._args =3D [ \
             "-nodefaults", "-m", "2G",
-            "-cpu", "host",
             "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=3Dvnet",
             "-vnc", "127.0.0.1:0,to=3D20",
@@ -73,9 +72,11 @@ class BaseVM(object):
         if vcpus:
             self._args +=3D ["-smp", str(vcpus)]
         if os.access("/dev/kvm", os.R_OK | os.W_OK):
+            self._args +=3D ["-cpu", "host"]
             self._args +=3D ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
+            self._args +=3D ["-cpu", "max"]
         self._data_args =3D []
=20
     def _download_with_cache(self, url, sha256sum=3DNone):
--=20
2.17.1
