Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z4-0001wK-Lc
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z3-0000UJ-TG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z3-0000U0-MX
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id y140-v6so19022129wmd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:26 +0200
Message-Id: <20181013004034.6968-2-f4bug@amsat.org>
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/8] tests/vm: Extract the kvm_available()
 handy function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py    | 4 ++++
 tests/vm/basevm.py | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f099ce7278..9fc0be4828 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -26,6 +26,10 @@ import tempfile
 LOG = logging.getLogger(__name__)
 
 
+def kvm_available(target_arch=None):
+    return os.access("/dev/kvm", os.R_OK | os.W_OK)
+
+
 #: Maps machine types to the preferred console device types
 CONSOLE_DEV_TYPES = {
     r'^clipper$': 'isa-serial',
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index cafbc6b3a5..834bc90cc1 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -18,7 +18,7 @@ import logging
 import time
 import datetime
 sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scripts"))
-from qemu import QEMUMachine
+from qemu import QEMUMachine, kvm_available
 import subprocess
 import hashlib
 import optparse
@@ -72,7 +72,7 @@ class BaseVM(object):
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
         if vcpus:
             self._args += ["-smp", str(vcpus)]
-        if os.access("/dev/kvm", os.R_OK | os.W_OK):
+        if kvm_available():
             self._args += ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
-- 
2.19.1
