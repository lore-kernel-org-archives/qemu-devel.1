Received: from eggs.gnu.org ([2001:4830:134:3::10]:52148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u7-0001yR-JU
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u6-00062x-Jm
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2u6-0005qV-9c
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:22 +0800
Message-Id: <20181026141529.4305-3-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] tests/vm: Extract the kvm_available() handy
 function
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20181013004034.6968-2-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scripts/qemu.py    | 4 ++++
 tests/vm/basevm.py | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f099ce7278..9fc0be4828 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -26,6 +26,10 @@ import tempfile
 LOG =3D logging.getLogger(__name__)
=20
=20
+def kvm_available(target_arch=3DNone):
+    return os.access("/dev/kvm", os.R_OK | os.W_OK)
+
+
 #: Maps machine types to the preferred console device types
 CONSOLE_DEV_TYPES =3D {
     r'^clipper$': 'isa-serial',
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index cafbc6b3a5..834bc90cc1 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -18,7 +18,7 @@ import logging
 import time
 import datetime
 sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scr=
ipts"))
-from qemu import QEMUMachine
+from qemu import QEMUMachine, kvm_available
 import subprocess
 import hashlib
 import optparse
@@ -72,7 +72,7 @@ class BaseVM(object):
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.ou=
t")]
         if vcpus:
             self._args +=3D ["-smp", str(vcpus)]
-        if os.access("/dev/kvm", os.R_OK | os.W_OK):
+        if kvm_available():
             self._args +=3D ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
--=20
2.17.1
