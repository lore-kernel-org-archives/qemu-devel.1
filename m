Received: from eggs.gnu.org ([2001:4830:134:3::10]:35975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OX-0003N2-6Y
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OV-0000o8-TH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA1OV-0000kH-Hm
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:27 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 19:26:02 -0400
Message-Id: <20181009232607.15521-3-crosa@redhat.com>
In-Reply-To: <20181009232607.15521-1-crosa@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/7] Acceptance Tests: introduce arch
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On a number of different scenarios, such as when choosing a QEMU
binary to be used on tests (or a image to use to boot a test VM), it's
useful to define the architecture that should be used.

This introduces both a test parameter and a test instance attribute,
that will contain such a value.

The selection of the default QEMU binary, if one is not given
explicitly, has also been changed to look at the arch attribute.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst                    | 18 ++++++++++++++++++
 tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 727c4019b5..4178ae5022 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -659,6 +659,17 @@ vm
 A QEMUMachine instance, initially configured according to the given
 ``qemu_bin`` parameter.
 
+arch
+~~~~
+
+The architecture that will be used on a number of different
+scenarios.  For instance, when a QEMU binary is not explicitly given,
+the one selected will depend on this attribute.
+
+The ``arch`` attribute will be set to the test parameter of the same
+name, and if one is not given explicitly, it will default to the
+system architecture (as given by ``uname``).
+
 qemu_bin
 ~~~~~~~~
 
@@ -681,6 +692,13 @@ like the following:
 
   PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
 
+arch
+~~~~
+
+The architecture that will be used on a number of different scenarios.
+This parameter has a direct relation with the ``arch`` attribute.  If
+not given, it will default to None.
+
 qemu_bin
 ~~~~~~~~
 
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index d8d5b48dac..b8d934382d 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -23,16 +23,22 @@ def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
 
 
-def pick_default_qemu_bin():
+def pick_default_qemu_bin(arch=None):
     """
     Picks the path of a QEMU binary, starting either in the current working
     directory or in the source tree root directory.
 
+    :param arch: the arch to use when looking for a QEMU binary (the target
+                 will match the arch given).  If None (the default) arch
+                 will be the current host system arch (as given by
+                 :func:`os.uname`).
+    :type arch: str
     :returns: the path to the default QEMU binary or None if one could not
               be found
     :rtype: str or None
     """
-    arch = os.uname()[4]
+    if arch is None:
+        arch = os.uname()[4]
     qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
                                           "qemu-system-%s" % arch)
     if is_readable_executable_file(qemu_bin_relative_path):
@@ -47,8 +53,9 @@ def pick_default_qemu_bin():
 class Test(avocado.Test):
     def setUp(self):
         self.vm = None
+        self.arch = self.params.get('arch', default=os.uname()[4])
         self.qemu_bin = self.params.get('qemu_bin',
-                                        default=pick_default_qemu_bin())
+                                        default=pick_default_qemu_bin(self.arch))
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source tree")
         self.vm = QEMUMachine(self.qemu_bin)
-- 
2.17.1
