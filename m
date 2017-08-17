Received: from eggs.gnu.org ([2001:4830:134:3::10]:39848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diAry-0001Jd-34
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diArv-0001pE-09
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diAru-0001om-QP
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:49:10 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 17 Aug 2017 10:47:44 +0800
Message-Id: <20170817024746.5961-9-famz@redhat.com>
In-Reply-To: <20170817024746.5961-1-famz@redhat.com>
References: <20170817024746.5961-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 08/10] tests: Add OpenBSD image
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
 tests/vm/openbsd | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 tests/vm/openbsd

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
new file mode 100755
index 0000000000..b308aa252b
--- /dev/null
+++ b/tests/vm/openbsd
@@ -0,0 +1,46 @@
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
+import logging
+import subprocess
+import tempfile
+import time
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
+    def build_image(self, img, rebuild=False):
+        if os.path.exists(img) and not rebuild:
+            return
+        cimg = self._download_with_cache("http://download.patchew.org/openbsd.img.xz",
+                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
+        img_tmp_xz = img + ".tmp.xz"
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        os.rename(img_tmp, img)
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(OpenBSDVM))
-- 
2.13.4
