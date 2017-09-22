Received: from eggs.gnu.org ([2001:4830:134:3::10]:38103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgu-00009F-Qo
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgq-0001Bs-S7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgq-0001Bc-M1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:52 +0800
Message-Id: <20170922074659.30097-30-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/36] tests: Add FreeBSD image
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

The image is prepared following instructions as in:

https://wiki.qemu.org/Hosts/BSD

Signed-off-by: Fam Zheng <famz@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/vm/freebsd | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tests/vm/freebsd

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
new file mode 100755
index 0000000000..039dad8f69
--- /dev/null
+++ b/tests/vm/freebsd
@@ -0,0 +1,42 @@
+#!/usr/bin/env python
+#
+# FreeBSD VM image
+#
+# Copyright 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import subprocess
+import basevm
+
+class FreeBSDVM(basevm.BaseVM):
+    name =3D "freebsd"
+    BUILD_SCRIPT =3D """
+        set -e;
+        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        tar -xf /dev/vtbd1;
+        ./configure {configure_opts};
+        gmake -j{jobs};
+        gmake check;
+    """
+
+    def build_image(self, img):
+        cimg =3D self._download_with_cache("http://download.patchew.org/=
freebsd-11.1-amd64.img.xz",
+                sha256sum=3D'adcb771549b37bc63826c501f05121a206ed3d9f55f=
49145908f7e1432d65891')
+        img_tmp_xz =3D img + ".tmp.xz"
+        img_tmp =3D img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+
+if __name__ =3D=3D "__main__":
+    sys.exit(basevm.main(FreeBSDVM))
--=20
2.13.5
