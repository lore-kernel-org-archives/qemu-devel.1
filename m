Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC1-0003mR-CY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWABy-0000Dc-Qb
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:49 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWABy-0000DU-Ki
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:46 -0400
Received: by mail-qk0-x243.google.com with SMTP id a195-v6so2856719qkg.3
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:44:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 21:44:30 -0300
Message-Id: <20180622004435.10291-2-f4bug@amsat.org>
In-Reply-To: <20180622004435.10291-1-f4bug@amsat.org>
References: <20180622004435.10291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 1/6] avocado: Add a Test.arch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

Tests can change this property to run tests in other
architectures than the host one.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/avocado_qemu/__init__.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 1e54fd5932..6e9601f5e9 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -13,6 +13,7 @@ import sys
 
 import avocado
 
+HOST_ARCH = os.uname()[4]
 SRC_ROOT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
 SRC_ROOT_DIR = os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
@@ -23,12 +24,11 @@ def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
 
 
-def pick_default_qemu_bin():
+def pick_default_qemu_bin(arch):
     """
     Picks the path of a QEMU binary, starting either in the current working
     directory or in the source tree root directory.
     """
-    arch = os.uname()[4]
     qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
                                           "qemu-system-%s" % arch)
     if is_readable_executable_file(qemu_bin_relative_path):
@@ -41,10 +41,19 @@ def pick_default_qemu_bin():
 
 
 class Test(avocado.Test):
+    _arch = HOST_ARCH
+
+    @property
+    def arch(self):
+        """
+        Returns the architecture required to run the current test
+        """
+        return self._arch
+
     def setUp(self):
         self.vm = None
-        self.qemu_bin = self.params.get('qemu_bin',
-                                        default=pick_default_qemu_bin())
+        qemu_bin = pick_default_qemu_bin(self.arch)
+        self.qemu_bin = self.params.get('qemu_bin', default=qemu_bin)
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source tree")
         self.vm = QEMUMachine(self.qemu_bin)
-- 
2.18.0.rc2
