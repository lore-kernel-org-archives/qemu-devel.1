Received: from eggs.gnu.org ([2001:4830:134:3::10]:60797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3MY-0003jW-Sq
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3MT-0008JQ-Lo
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp3MT-0008In-FX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:13:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:11:57 +0800
Message-Id: <20170905021201.25684-9-famz@redhat.com>
In-Reply-To: <20170905021201.25684-1-famz@redhat.com>
References: <20170905021201.25684-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 08/12] tests: Add OpenBSD image
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
 tests/vm/openbsd | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 tests/vm/openbsd

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
new file mode 100755
index 0000000000..57b10105f7
--- /dev/null
+++ b/tests/vm/openbsd
@@ -0,0 +1,43 @@
+#!/usr/bin/env python
+#
+# OpenBSD VM image
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
+class OpenBSDVM(basevm.BaseVM):
+    name = "openbsd"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        tar -xf /dev/rsd1c;
+        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
+        gmake -j{jobs};
+        # XXX: "gmake check" seems to always hang or fail
+        #gmake check;
+    """
+
+    def build_image(self, img):
+        cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
+                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
+        img_tmp_xz = img + ".tmp.xz"
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(OpenBSDVM))
-- 
2.13.5
