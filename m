Received: from eggs.gnu.org ([209.51.188.92]:46552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE7I-000560-Nx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE78-00046A-Jk
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE73-0003w9-11
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:06 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:41 -0200
Message-Id: <20190117201743.20470-8-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] Acceptance tests: add Linux initrd checking
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

QEMU used to exits with a not accurate error message when
an initrd > 2GiB was passed. That was fixed on patch:

	commit f3839fda5771596152b75dd1e1a6d050e6e6e380
	Author: Li Zhijian <lizhijian@cn.fujitsu.com>
	Date:   Thu Sep 13 18:07:13 2018 +0800

    	change get_image_size return type to int64_t

This change adds a regression test for that fix. It starts
QEMU with a 2GiB dummy initrd, and checks that it evaluates the
file size correctly and prints an accurate message.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20181109182153.5390-1-wainersm@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/linux_initrd.py | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 tests/acceptance/linux_initrd.py

diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
new file mode 100644
index 0000000000..737355c2ef
--- /dev/null
+++ b/tests/acceptance/linux_initrd.py
@@ -0,0 +1,48 @@
+# Linux initrd acceptance test.
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Wainer dos Santos Moschetta <wainersm@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import tempfile
+from avocado.utils.process import run
+
+from avocado_qemu import Test
+
+
+class LinuxInitrd(Test):
+    """
+    Checks QEMU evaluates correctly the initrd file passed as -initrd op=
tion.
+
+    :avocado: enable
+    :avocado: tags=3Dx86_64
+    """
+
+    timeout =3D 60
+
+    def test_with_2gib_file_should_exit_error_msg(self):
+        """
+        Pretends to boot QEMU with an initrd file with size of 2GiB
+        and expect it exits with error message.
+        """
+        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28/'
+                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+        max_size =3D 2 * (1024 ** 3) - 1
+
+        with tempfile.NamedTemporaryFile() as initrd:
+            initrd.seek(max_size)
+            initrd.write(b'\0')
+            initrd.flush()
+            cmd =3D "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_=
path,
+                                                initrd.name)
+            res =3D run(cmd, ignore_status=3DTrue)
+            self.assertEqual(res.exit_status, 1)
+            expected_msg =3D r'.*initrd is too large.*max: \d+, need %s.=
*' % (
+                max_size + 1)
+            self.assertRegex(res.stderr_text, expected_msg)
--=20
2.18.0.rc1.1.g3f1ff2140
