Received: from eggs.gnu.org ([209.51.188.92]:39240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGi9-00041I-3e
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGi8-0008Jg-3p
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:17 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 22 Feb 2019 14:41:45 -0500
Message-Id: <20190222194146.13102-7-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-1-crosa@redhat.com>
References: <20190222194146.13102-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] Acceptance tests: use linux-3.6 and set vm
 memory to 4GiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

From: Li Zhijian <lizhijian@cn.fujitsu.com>

QEMU have already supported to load up to 4G initrd if the sepcified memo=
ry is
enough and XLF_CAN_BE_LOADED_ABOVE_4G is set by guest kernel

linux-3.6 kernel shipped by Fedora-18 cannot support xldflags so that it
cannot support loading more than 2GiB initrd

CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
CC: Caio Carrara <ccarrara@redhat.com>
CC: Cleber Rosa <crosa@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <1548638112-31101-1-git-send-email-lizhijian@cn.fujitsu.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/linux_initrd.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
index 5a15fc4347..e33b5dcec0 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -23,14 +23,16 @@ class LinuxInitrd(Test):
=20
     timeout =3D 60
=20
-    def test_with_2gib_file_should_exit_error_msg(self):
+    def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
         """
         Pretends to boot QEMU with an initrd file with size of 2GiB
         and expect it exits with error message.
+        Fedora-18 shipped with linux-3.6 which have not supported xloadf=
lags
+        cannot support more than 2GiB initrd.
         """
-        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28/'
-                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
-        kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
+        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora/li'
+                      'nux/releases/18/Fedora/x86_64/os/images/pxeboot/v=
mlinuz')
+        kernel_hash =3D '41464f68efe42b9991250bed86c7081d2ccdbb21'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
         max_size =3D 2 * (1024 ** 3) - 1
=20
@@ -38,8 +40,8 @@ class LinuxInitrd(Test):
             initrd.seek(max_size)
             initrd.write(b'\0')
             initrd.flush()
-            cmd =3D "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_=
path,
-                                                initrd.name)
+            cmd =3D "%s -kernel %s -initrd %s -m 4096" % (
+                  self.qemu_bin, kernel_path, initrd.name)
             res =3D run(cmd, ignore_status=3DTrue)
             self.assertEqual(res.exit_status, 1)
             expected_msg =3D r'.*initrd is too large.*max: \d+, need %s.=
*' % (
--=20
2.20.1
