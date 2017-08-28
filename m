Received: from eggs.gnu.org ([2001:4830:134:3::10]:33273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmO8b-0006jy-LR
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmO8a-0002Hi-4J
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmO8Z-0002HJ-UD
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 29 Aug 2017 01:47:02 +0800
Message-Id: <20170828174707.20786-6-famz@redhat.com>
In-Reply-To: <20170828174707.20786-1-famz@redhat.com>
References: <20170828174707.20786-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/10] tests: Add FreeBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

The image is prepared following instructions as in:

https://wiki.qemu.org/Hosts/BSD

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/freebsd | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tests/vm/freebsd

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
new file mode 100755
index 0000000000..6840da0bf0
--- /dev/null
+++ b/tests/vm/freebsd
@@ -0,0 +1,42 @@
+#!/usr/bin/env python
+#
+# FreeBSD VM image
+#
+# Copyright (C) 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import subprocess
+import basevm
+
+class FreeBSDVM(basevm.BaseVM):
+    name = "freebsd"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        tar -xf /dev/vtbd1;
+        ./configure {configure_opts};
+        gmake -j{jobs};
+        gmake check;
+    """
+
+    def build_image(self, img):
+        cimg = self._download_with_cache("http://download.patchew.org/freebsd-11.1-amd64.img.xz",
+                sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
+        img_tmp_xz = img + ".tmp.xz"
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(FreeBSDVM))
-- 
2.13.5
